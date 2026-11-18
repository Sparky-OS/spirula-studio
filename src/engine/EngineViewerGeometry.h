#pragma once
#include <mutex>
#include <vector>

struct EngineViewerGeometry {
    std::vector<float> capsules;  // endpoint xyzr pairs
    std::vector<float> triangles; // three xyz vertices
};
EngineViewerGeometry engine_viewer_geometry(float camera_size, bool cameras, bool grid,
                                             float distance, const float target[3]);

struct EngineViewerGeometryOps {
    std::mutex* mutex;
    void (*build_grid)(float distance, const float target[3]);
    void (*build_bvh)();
};
const EngineViewerGeometryOps& engine_viewer_geometry_ops();
