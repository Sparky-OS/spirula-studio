#pragma once
#include "app/stereo/CameraPair.h"
#include <array>
#include <vector>

namespace spirula::stereo {

class VisibleDepth {
public:
    using Point = std::array<double,3>;
    VisibleDepth(double left, double right, double top, double bottom,
                 double sweep, double near_z, double far_z, bool orthographic) {
        planes = {{{1,0,orthographic ? 0 : left,orthographic ? left+sweep : sweep},
                   {-1,0,orthographic ? 0 : right,orthographic ? right+sweep : sweep},
                   {0,1,orthographic ? 0 : top,orthographic ? top : 0},
                   {0,-1,orthographic ? 0 : bottom,orthographic ? bottom : 0},
                   {0,0,1,-near_z},{0,0,-1,far_z}}};
    }
    void segment(Point a, Point b, double radius = 0) {
        double lo = 0, hi = 1;
        for (const auto& plane : planes) {
            const double margin = radius*std::sqrt(plane[0]*plane[0]+plane[1]*plane[1]+plane[2]*plane[2]);
            const double da = distance(plane,a)+margin, db = distance(plane,b)+margin;
            if (da < 0 && db < 0) return;
            if (da < 0) lo = std::max(lo,da/(da-db));
            if (db < 0) hi = std::min(hi,da/(da-db));
        }
        if (lo > hi) return;
        const double z0 = a[2]+lo*(b[2]-a[2]), z1 = a[2]+hi*(b[2]-a[2]);
        low = std::min(low,std::max(-planes[4][3],std::min(z0,z1)-radius));
        high = std::max(high,std::min(planes[5][3],std::max(z0,z1)+radius));
    }
    void triangle(Point a, Point b, Point c) {
        std::vector<Point> polygon{a,b,c};
        for (const auto& plane : planes) {
            std::vector<Point> next;
            if (polygon.empty()) return;
            Point previous = polygon.back();
            double dp = distance(plane,previous);
            for (const Point& current : polygon) {
                const double dc = distance(plane,current);
                if ((dp < 0) != (dc < 0)) {
                    Point intersection;
                    const double t = dp/(dp-dc);
                    for (int i = 0; i < 3; ++i) intersection[i] = previous[i]+t*(current[i]-previous[i]);
                    next.push_back(intersection);
                }
                if (dc >= 0) next.push_back(current);
                previous = current; dp = dc;
            }
            polygon = std::move(next);
        }
        for (const auto& point : polygon) { low = std::min(low,point[2]); high = std::max(high,point[2]); }
    }
    DepthRange range() const { return {low,high}; }
private:
    std::array<std::array<double,4>,6> planes;
    double low = INFINITY, high = -INFINITY;
    static double distance(const std::array<double,4>& plane, const Point& p) {
        return plane[0]*p[0]+plane[1]*p[1]+plane[2]*p[2]+plane[3];
    }
};

}  // namespace spirula::stereo
