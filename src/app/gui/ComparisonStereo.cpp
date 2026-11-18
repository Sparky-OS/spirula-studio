#include "app/gui/ViewportPanel.h"
#include "app/gui/stereo/Settings.h"
#include "app/stereo/PairComposition.h"
#include "core/Env.h"
#include <cstdio>
#include <algorithm>
#include <cmath>
#include <cstring>

namespace gui {

void ViewportPanel::clear_stereo_support() {
    if (_stereo_envelope) { _stereo_envelope.reset(); _dirty = true; }
    _comparison_pixels.clear(); _comparison_stamp.clear();
}

void ViewportPanel::share_stereo_support(const std::vector<ViewportPanel*>& panels) {
    if (panels.empty()) return;
    if (!stereo::settings().enabled) {
        for (auto* panel : panels) panel->clear_stereo_support();
        return;
    }
    for (const auto* panel : panels) if (panel->_pair_pixels.empty()) return;
    const bool ortho = panels.front()->_ortho;
    spirula::stereo::ParallaxRange shared{0,0,true};
    for (const auto* panel : panels) {
        const auto& support = panel->_stereo_cameras.support;
        const double scale = panel->_m2s_scale;
        shared.valid &= support.valid && std::isfinite(scale) && scale > 0 && panel->_ortho == ortho;
        if (!(scale > 0)) continue;
        const double factor = ortho ? scale : 1/scale;
        shared.sunk = std::max(shared.sunk,support.sunk*factor);
        shared.popped = std::max(shared.popped,support.popped*factor);
    }
    if (!std::isfinite(shared.sunk) || !std::isfinite(shared.popped)) shared = {};
    for (auto* panel : panels) {
        auto local = shared;
        const double factor = ortho ? 1/panel->_m2s_scale : panel->_m2s_scale;
        local.sunk *= factor; local.popped *= factor;
        if (!std::isfinite(local.sunk) || !std::isfinite(local.popped)) local = {};
        const auto& old = panel->_stereo_envelope;
        const auto equal = [](double a, double b) { return std::abs(a-b) <= 1e-10*std::max(std::abs(a),std::abs(b)); };
        if (!old || old->valid != local.valid || !equal(old->sunk,local.sunk) || !equal(old->popped,local.popped)) {
            panel->_stereo_envelope = local;
            panel->_dirty = true;
        }
    }
}

const std::vector<uint8_t>* ViewportPanel::stereo_pixels() {
    if (!_wipe_splits) return &_pair_pixels;
    const double offset = _stereo_cameras.right.offset*_m2s_scale;
    bool coherent = true;
    std::vector<uint64_t> stamp;
    std::vector<spirula::stereo::PairRegion> regions;
    for (size_t i = 0; i < _wipe_sources.size(); ++i) {
        const auto* panel = _wipe_sources[i].panel;
        const double other = panel->_stereo_cameras.right.offset*panel->_m2s_scale;
        const bool same_limits = bool(_stereo_limits) == bool(panel->_stereo_limits) &&
            (!_stereo_limits || (_stereo_limits->sunk == panel->_stereo_limits->sunk &&
                                _stereo_limits->popped == panel->_stereo_limits->popped));
        coherent &= !panel->_pair_pixels.empty() && panel->_tex_w == _tex_w && panel->_tex_h == _tex_h &&
            panel->_stereo_image_epoch == panel->_stereo_epoch && same_limits &&
            std::abs(offset-other) <= 1e-6*std::max(std::abs(offset),std::abs(other)) &&
            std::equal(_image_stereo_pose,_image_stereo_pose+13,panel->_image_stereo_pose);
        stamp.push_back(panel->_pair_revision); stamp.push_back(panel->_stereo_epoch);
        regions.push_back({&panel->_pair_pixels,spirula::stereo::wipe_rect(i,_wipe_sources.size(),*_wipe_splits)});
    }
    for (float split : *_wipe_splits) {
        uint32_t bits; std::memcpy(&bits,&split,sizeof bits); stamp.push_back(bits);
    }
    if (coherent && stamp != _comparison_stamp) {
        _comparison_pixels = spirula::stereo::compose_pair(regions,_tex_w,_tex_h);
        _comparison_stamp = std::move(stamp);
        ++_comparison_revision;
        if (spirula::env_on("GUI_AUTOMATION"))
            std::fprintf(stderr,"[stereo-comparison] sources=%zu revision=%llu shared_eye=%.9g\n",
                         _wipe_sources.size(),(unsigned long long)_comparison_revision,offset);
    }
    return _comparison_pixels.empty() ? nullptr : &_comparison_pixels;
}

}  // namespace gui
