#include "engine/Engine.h"
#include "engine/EngineState.h"
#include "engine/EngineViewerGeometry.h"
#include <algorithm>

EngineViewerGeometry engine_viewer_geometry(float camera_size, bool cameras, bool grid,
                                             float distance, const float target[3]) {
    EngineViewerGeometry result;
    const auto& ops = engine_viewer_geometry_ops();
    std::lock_guard<std::mutex> lock(*ops.mutex);
    auto& viewer = engine().viewer;
    if (!viewer.initialized || (!cameras && !grid)) return result;
    if (camera_size > 0) viewer.camera_size = camera_size;
    if (grid && distance > 0) ops.build_grid(distance,target);
    if (!viewer.bvh_built || viewer.bvh_camera_size != viewer.camera_size) ops.build_bvh();
    std::vector<float> capsules((size_t)viewer.bvh_num_lss*8);
    if (!capsules.empty()) backend::memcpy_sync(capsules.data(),DevicePool::global().acquire<float>(PoolSlot::ViewerLss,capsules.size()),
                                               capsules.size()*sizeof(float),backend::MemcpyKind::DeviceToHost);
    const size_t split = (size_t)viewer.bvh_num_cam_lss*8;
    if (cameras) result.capsules.insert(result.capsules.end(),capsules.begin(),capsules.begin()+split);
    if (grid) result.capsules.insert(result.capsules.end(),capsules.begin()+split,capsules.end());
    if (cameras && viewer.bvh_num_tri > 0) {
        std::vector<float> triangles((size_t)viewer.bvh_num_tri*16);
        backend::memcpy_sync(triangles.data(),DevicePool::global().acquire<float>(PoolSlot::ViewerTri,triangles.size()),triangles.size()*sizeof(float),
                             backend::MemcpyKind::DeviceToHost);
        result.triangles.reserve((size_t)viewer.bvh_num_tri*9);
        for (int i = 0; i < viewer.bvh_num_tri; ++i)
            result.triangles.insert(result.triangles.end(),triangles.begin()+16*i,triangles.begin()+16*i+9);
    }
    return result;
}
