#pragma once

#include <algorithm>
#include <cmath>
#include <optional>

namespace spirula::stereo {

struct DepthLimits { double sunk, popped; };
struct DepthRange { double near, far; };
struct EyeCamera { double offset = 0, principal = 0, shear = 0; };
struct CameraPair {
    EyeCamera left, right;
    enum class State { Ready, NoLimits, ZeroLimits, NoSupport } state = State::Ready;
};

inline CameraPair camera_pair(std::optional<DepthLimits> limits, DepthRange support,
                               double convergence, double focal, int width, bool orthographic) {
    CameraPair pair;
    if (!limits) { pair.state = CameraPair::State::NoLimits; return pair; }
    if (!(std::isfinite(limits->sunk) && std::isfinite(limits->popped) &&
          limits->sunk >= 0 && limits->popped >= 0)) {
        pair.state = CameraPair::State::NoLimits; return pair;
    }
    if (limits->sunk == 0 && limits->popped == 0) {
        pair.state = CameraPair::State::ZeroLimits; return pair;
    }
    if (!(convergence > 0 && focal > 0 && width > 0 && support.near > 0 &&
          support.far >= support.near && std::isfinite(support.far))) {
        pair.state = CameraPair::State::NoSupport; return pair;
    }
    const double sunk = limits->sunk * width / 1920.0;
    const double popped = limits->popped * width / 1920.0;
    if (orthographic) {
        double slope = INFINITY;
        if (support.near < convergence) slope = popped / (convergence - support.near);
        if (support.far > convergence) slope = std::min(slope, sunk / (support.far - convergence));
        if (!std::isfinite(slope)) slope = 0;
        pair.left.shear = -slope / (2 * focal);
        pair.right.shear = -pair.left.shear;
        pair.left.principal = slope * convergence / 2;
        pair.right.principal = -pair.left.principal;
    } else {
        // Infinity remains bounded too, including a view-dependent environment.
        double baseline = sunk * convergence / focal;
        if (support.near < convergence)
            baseline = std::min(baseline, popped / (focal * (1 / support.near - 1 / convergence)));
        pair.left.offset = -baseline / 2;
        pair.right.offset = baseline / 2;
        pair.left.principal = -focal * baseline / (2 * convergence);
        pair.right.principal = -pair.left.principal;
    }
    return pair;
}

}  // namespace spirula::stereo
