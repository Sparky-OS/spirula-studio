#pragma once
#include "app/stereo/CameraPair.h"
#include <limits>

namespace spirula::stereo {

struct SceneSupport {
    double z_min = INFINITY, z_max = -INFINITY;
    void sphere(double x, double y, double z, double radius,
                double left, double right, double top, double bottom, double lateral_sweep) {
        const double high = z + radius;
        double low = z - radius;
        if (!(high > 0 && std::isfinite(high) && std::isfinite(radius))) return;
        if (x > radius + lateral_sweep) low = std::max(low,(x-radius-lateral_sweep)/right);
        if (-x > radius + lateral_sweep) low = std::max(low,(-x-radius-lateral_sweep)/left);
        if (y > radius) low = std::max(low,(y-radius)/bottom);
        if (-y > radius) low = std::max(low,(-y-radius)/top);
        if (low > high) return;
        z_min = std::min(z_min,low);
        z_max = std::max(z_max,high);
    }
    DepthRange range() const { return {z_min,z_max}; }
};

}  // namespace spirula::stereo
