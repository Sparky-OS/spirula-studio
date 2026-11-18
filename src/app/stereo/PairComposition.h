#pragma once
#include <algorithm>
#include <array>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <stdexcept>
#include <vector>

namespace spirula::stereo {

inline std::array<double,4> wipe_rect(size_t index, size_t count, const std::vector<float>& splits) {
    if (index >= count || count < 2 || splits.size() != (count == 4 ? 2 : count-1))
        throw std::invalid_argument("invalid comparison slices");
    if (count == 4)
        return {index&1 ? splits[0] : 0.,index&2 ? splits[1] : 0.,
                index&1 ? 1. : splits[0],index&2 ? 1. : splits[1]};
    return {index ? splits[index-1] : 0.,0.,index+1 == count ? 1. : splits[index],1.};
}

struct PairRegion {
    const std::vector<uint8_t>* pixels;
    std::array<double,4> rect;
};

inline std::vector<uint8_t> compose_pair(const std::vector<PairRegion>& regions, int W, int H) {
    if (W <= 0 || H <= 0) throw std::invalid_argument("invalid comparison raster");
    std::vector<uint8_t> result((size_t)W*H*6);
    for (const auto& region : regions) {
        if (!region.pixels || region.pixels->size() != result.size())
            throw std::invalid_argument("incompatible comparison pair");
        int bounds[4];
        for (int i = 0; i < 4; ++i) {
            if (!std::isfinite(region.rect[i])) throw std::invalid_argument("invalid comparison rectangle");
            bounds[i] = (int)std::lround(std::clamp(region.rect[i],0.,1.)*(i&1 ? H : W));
        }
        if (bounds[0] > bounds[2] || bounds[1] > bounds[3])
            throw std::invalid_argument("reversed comparison rectangle");
        for (int y = bounds[1]; y < bounds[3]; ++y) for (int eye = 0; eye < 2; ++eye) {
            const size_t at = ((size_t)y*2*W+eye*W+bounds[0])*3;
            std::memcpy(result.data()+at,region.pixels->data()+at,(bounds[2]-bounds[0])*3);
        }
    }
    return result;
}

}  // namespace spirula::stereo
