#pragma once
#include <vector>
#include <cstddef>

struct EngineViewerProjection {
    // id, world xyz, screen xy, conic abc, opacity, centre distance, rgb.
    static constexpr int stride = 14;
    std::vector<float> rows;
};
EngineViewerProjection engine_viewer_projection();

struct EngineViewerDepthMeans {
    double minimum = 0, maximum = 0;
    size_t covered_pixels = 0;
};
// One-shot contribution map, blended in the same GPU raster as the image.
void engine_viewer_depth_prepare(const void* coefficients, void* output);
EngineViewerDepthMeans engine_viewer_depth_means(const void* output);
