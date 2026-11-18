#include "app/gui/PreviewRenderer.h"
#include "app/gui/GlLoader.h"
#include "app/stereo/VisibleDepth.h"
#include "app/webviewer/RegionOverlay.h"
#include <algorithm>

namespace gui {

spirula::stereo::CameraPair PreviewRenderer::stereo_cameras(
    std::optional<spirula::stereo::DepthLimits> limits, const float view[16],
    PreviewProjection projection, double focal, double fy, int W, int H,
    float radius, float distance, const float target[3],
    bool cameras, float frustum_scale, bool grid) {
    using namespace spirula::stereo;
    const bool ortho = projection == PreviewProjection::Orthographic;
    if (!limits || (limits->sunk == 0 && limits->popped == 0))
        return camera_pair(limits,{},distance,focal,W,ortho);
    if (projection != PreviewProjection::Pinhole && !ortho) {
        CameraPair pair; pair.state = CameraPair::State::NoSupport; return pair;
    }
    if (grid) ensure_grid(radius,distance,target);
    if (_ov_visible && _ov && _ov != _ov_uploaded) upload_overlay();
    const double near_z = std::max(1e-7f,0.002f*std::min(radius,distance));
    const double far_z = std::max({10.0*near_z,500.0*radius,20.0*distance});
    const double sweep = limits->sunk*W/1920.*(ortho ? 1 : distance)/focal/2;
    const double principal = ortho ? 0 : focal*sweep/distance;
    VisibleDepth visible((W/2.+principal)/focal,(W/2.+principal)/focal,
                         H/2./fy,H/2./fy,sweep,near_z,far_z,ortho);
    auto camera_point = [&](const float* p) {
        VisibleDepth::Point result;
        for (int r = 0; r < 3; ++r)
            result[r] = (r == 0 ? 1 : -1)*(view[4*r]*p[0]+view[4*r+1]*p[1]+view[4*r+2]*p[2]+view[4*r+3]);
        return result;
    };
    if (_mesh_indices.empty()) {
        for (size_t i = 0; i+3 <= _pick_xyz.size(); i += 3) {
            const auto p = camera_point(&_pick_xyz[i]);
            visible.segment(p,p);
        }
    } else {
        for (size_t i = 0; i+3 <= _mesh_indices.size(); i += 3)
            visible.triangle(camera_point(&_pick_xyz[3*_mesh_indices[i]]),
                             camera_point(&_pick_xyz[3*_mesh_indices[i+1]]),
                             camera_point(&_pick_xyz[3*_mesh_indices[i+2]]));
    }
    if (grid) for (size_t i = 0; i+6 <= _grid_xyz.size(); i += 6)
        visible.segment(camera_point(&_grid_xyz[i]),camera_point(&_grid_xyz[i+3]));
    if (cameras) for (size_t i = 0; i+12 <= _camera_vertices.size(); i += 12) {
        float endpoints[6];
        for (int end = 0; end < 2; ++end) for (int k = 0; k < 3; ++k)
            endpoints[3*end+k] = _camera_vertices[i+6*end+k]+
                _camera_vertices[i+6*end+3+k]*_base_cam_size*std::max(frustum_scale,1e-3f);
        visible.segment(camera_point(endpoints),camera_point(endpoints+3));
    }
    if (_ov_visible && _ov_local) for (const auto& layer : _ov_local->layers)
        for (size_t i = 0; i+3 <= layer.tri.size(); i += 3)
            visible.triangle(camera_point(&layer.xyz[3*layer.tri[i]]),
                             camera_point(&layer.xyz[3*layer.tri[i+1]]),
                             camera_point(&layer.xyz[3*layer.tri[i+2]]));
    return camera_pair(limits,visible.range(),distance,focal,W,ortho);
}

std::vector<uint8_t> PreviewRenderer::read_rgb() const {
    std::vector<uint8_t> result((size_t)_fbo_w*_fbo_h*3), row((size_t)_fbo_w*3);
    glx::BindFramebuffer(GL_FRAMEBUFFER,_fbo);
    glPixelStorei(GL_PACK_ALIGNMENT,1);
    glReadPixels(0,0,_fbo_w,_fbo_h,GL_RGB,GL_UNSIGNED_BYTE,result.data());
    glx::BindFramebuffer(GL_FRAMEBUFFER,0);
    for (int y = 0; y < _fbo_h/2; ++y) {
        auto* a = result.data()+y*row.size();
        auto* b = result.data()+(_fbo_h-1-y)*row.size();
        std::copy(a,a+row.size(),row.data());
        std::copy(b,b+row.size(),a);
        std::copy(row.begin(),row.end(),b);
    }
    return result;
}

}  // namespace gui
