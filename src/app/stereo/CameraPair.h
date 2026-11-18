#pragma once

#include <algorithm>
#include <cmath>
#include <optional>

namespace spirula::stereo {

struct DepthLimits { double sunk, popped; };
struct DepthRange { double z_min, z_max; };
struct ParallaxRange { double sunk = 0, popped = 0; bool valid = false; };
struct EyeCamera { double offset = 0, principal = 0, shear = 0; };
struct CameraPair {
    EyeCamera left, right;
    ParallaxRange support;
    enum class State { Ready, NoLimits, ZeroLimits, NoSupport } state = State::Ready;
};

inline ParallaxRange projected_gaussian_range(double z, double radius, double convergence) {
    if (!(z > 0 && radius >= 0 && convergence > 0 &&
          std::isfinite(z) && std::isfinite(radius) && std::isfinite(convergence))) return {};
    const double spread = radius*std::max(1/(z*z),1/(convergence*z));
    return {std::max(0.,1/convergence-1/z+spread),std::max(0.,1/z-1/convergence+spread),true};
}

inline CameraPair fit_camera_pair(std::optional<DepthLimits> limits, ParallaxRange support,
                                   double convergence, double focal, int width, bool orthographic,
                                   std::optional<ParallaxRange> envelope = {}) {
    CameraPair pair;
    pair.support = support;
    if (envelope) {
        support.valid &= envelope->valid && std::isfinite(envelope->sunk) && std::isfinite(envelope->popped) &&
                         envelope->sunk >= 0 && envelope->popped >= 0;
        support.sunk = std::max(support.sunk,envelope->sunk);
        support.popped = std::max(support.popped,envelope->popped);
    }
    if (!limits) { pair.state = CameraPair::State::NoLimits; return pair; }
    if (!(std::isfinite(limits->sunk) && std::isfinite(limits->popped) &&
          limits->sunk >= 0 && limits->popped >= 0)) {
        pair.state = CameraPair::State::NoLimits; return pair;
    }
    if (limits->sunk == 0 && limits->popped == 0) {
        pair.state = CameraPair::State::ZeroLimits; return pair;
    }
    if (!(convergence > 0 && focal > 0 && std::isfinite(convergence) && std::isfinite(focal) &&
          width > 0 && support.valid && std::isfinite(support.sunk) && std::isfinite(support.popped) &&
          support.sunk >= 0 && support.popped >= 0)) {
        pair.state = CameraPair::State::NoSupport; return pair;
    }
    const double factor = orthographic ? 1 : focal;
    double amplitude = INFINITY;
    if (support.sunk > 0) amplitude = limits->sunk * width / (1920. * factor * support.sunk);
    if (support.popped > 0)
        amplitude = std::min(amplitude,limits->popped * width / (1920. * factor * support.popped));
    if (!std::isfinite(amplitude)) amplitude = 0;
    if (orthographic) {
        pair.left.shear = -amplitude / (2 * focal);
        pair.right.shear = -pair.left.shear;
        pair.left.offset = pair.left.shear * convergence;
        pair.right.offset = -pair.left.offset;
    } else {
        pair.left.offset = -amplitude / 2;
        pair.right.offset = amplitude / 2;
        pair.left.principal = -focal * amplitude / (2 * convergence);
        pair.right.principal = -pair.left.principal;
    }
    return pair;
}

inline CameraPair camera_pair(std::optional<DepthLimits> limits, DepthRange range,
                               double convergence, double focal, int width, bool orthographic,
                               std::optional<ParallaxRange> envelope = {}) {
    ParallaxRange support;
    support.valid = std::isfinite(range.z_min) && std::isfinite(range.z_max) &&
                    range.z_max >= range.z_min && (orthographic || range.z_min > 0);
    if (support.valid && convergence > 0) {
        if (orthographic) {
            support.sunk = std::max(0.,range.z_max-convergence);
            support.popped = std::max(0.,convergence-range.z_min);
        } else {
            support.sunk = 1/convergence;
            support.popped = std::max(0.,1/range.z_min-1/convergence);
        }
    }
    return fit_camera_pair(limits,support,convergence,focal,width,orthographic,envelope);
}

}  // namespace spirula::stereo
