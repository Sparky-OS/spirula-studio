#pragma once
#include <vector>

struct EngineViewerProjection {
    // id, world xyz, screen xy, conic abc, opacity, centre distance, rgb.
    static constexpr int stride = 14;
    std::vector<float> rows;
};
EngineViewerProjection engine_viewer_projection();
