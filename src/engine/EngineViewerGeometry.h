#pragma once
#include <mutex>

struct EngineViewerGeometryOps {
    std::mutex* mutex;
    void (*build_grid)(float distance, const float target[3]);
    void (*build_bvh)();
};
const EngineViewerGeometryOps& engine_viewer_geometry_ops();
