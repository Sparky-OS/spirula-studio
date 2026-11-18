#include "app/webviewer/RenderWorker.h"
#include "checkpoint/SplatPly.h"
#include "engine/Engine.h"
#include "core/HostMemory.h"
#include <algorithm>
#include <chrono>
#include <cmath>
#include <cstdio>
#include <mutex>
#include <stdexcept>

namespace {
TorchTensorView host(std::vector<float>& data, std::vector<int64_t> shape) {
    return {(uint64_t)(uintptr_t)data.data(),4,std::move(shape)};
}
size_t pool_bytes() {
    size_t bytes = engine_get_scratch_bytes();
    for (const auto& item : engine_get_pool_breakdown()) bytes += std::get<2>(item);
    return bytes;
}
}

int main(int argc, char** argv) {
    try {
        if (argc != 2) throw std::runtime_error("usage: stereo_pair_cost own-scene.ply");
        auto cloud = spirula::read_splat_ply(argv[1]);
        if (cloud.num <= 0) throw std::runtime_error("empty scene");
        engine_reset();
        engine_scene_set_data_3dgs(0,cloud.num,host(cloud.means,{cloud.num,3}),host(cloud.quats,{cloud.num,4}),
            host(cloud.scales,{cloud.num,3}),host(cloud.opacities,{cloud.num,1}),host(cloud.features_dc,{cloud.num,3}),
            host(cloud.features_sh,{cloud.num,cloud.coeffs(),3}),cloud.sb_lobes);
        engine_scene_activate(0);
        float low[3] = {INFINITY,INFINITY,INFINITY}, high[3] = {-INFINITY,-INFINITY,-INFINITY};
        for (int64_t i = 0; i < cloud.num; ++i) for (int k = 0; k < 3; ++k) {
            low[k] = std::min(low[k],cloud.means[3*i+k]); high[k] = std::max(high[k],cloud.means[3*i+k]);
        }
        float centre[3];
        for (int k = 0; k < 3; ++k) centre[k] = (low[k]+high[k])/2;
        const double radius = std::max({high[0]-low[0],high[1]-low[1],high[2]-low[2],1e-3f});
        const double distance = 2.5*radius;
        ViewRequest q;
        q.W = 400; q.H = 300; q.fx = q.fy = 320; q.cx = 200; q.cy = 150;
        q.sh_degree = cloud.sh_degree;
        const double norm = std::sqrt(2.2*2.2+1.2*1.2);
        for (int k = 0; k < 3; ++k) q.c2w[4*k+3] = centre[k];
        q.c2w[0] = 1; q.c2w[5] = 1.2/norm; q.c2w[6] = -2.2/norm;
        q.c2w[9] = 2.2/norm; q.c2w[10] = 1.2/norm;
        q.c2w[7] -= 2.2/norm*distance; q.c2w[11] += 1.2/norm*distance;
        std::mutex mutex;
        ViewerHooks hooks; hooks.engine_mutex = &mutex; hooks.current_step = [] { return 300; };
        ViewerRenderConfig config; config.scene_slot = 0; config.packed = true;
        config.primitive = cloud.primitive.empty() ? "3dgs" : cloud.primitive;
        RenderWorker worker; worker.start(config,hooks);
        std::vector<double> samples[2]; size_t bytes[2] = {};
        size_t rss = spirula::processRamBytes();
        for (int round = 0; round < 30; ++round) for (int kind = 0; kind < 2; ++kind) {
            const auto start = std::chrono::steady_clock::now();
            const auto id = kind ? worker.submit_stereo(q,distance,spirula::stereo::DepthLimits{10,4}) : worker.submit(q);
            ViewResult result;
            if (!worker.wait_result(id,result,120) || !result.error.empty()) throw std::runtime_error("render failed");
            if (kind && result.pair_state != spirula::stereo::CameraPair::State::Ready)
                throw std::runtime_error("the measured scene did not produce a real camera pair");
            const double ms = std::chrono::duration<double,std::milli>(std::chrono::steady_clock::now()-start).count();
            if (round >= 5) samples[kind].push_back(ms);
            bytes[kind] = pool_bytes();
            rss = std::max(rss,spirula::processRamBytes());
        }
        worker.stop();
        std::printf("PAIR_COST_JSON {\"splats\":%lld,\"width\":400,\"height\":300,\"rss_sampled_peak_bytes\":%zu,\"samples_ms\":[",
                    (long long)cloud.num,rss);
        for (int kind = 0; kind < 2; ++kind) {
            std::printf("%s[",kind ? "," : "");
            for (size_t i = 0; i < samples[kind].size(); ++i) std::printf("%s%.9g",i ? "," : "",samples[kind][i]);
            std::printf("]");
        }
        std::printf("],\"pool_and_scratch_cap_bytes\":[%zu,%zu]}\n",bytes[0],bytes[1]);
        engine_reset();
    } catch (const std::exception& error) { std::fprintf(stderr,"stereo_pair_cost: %s\n",error.what()); return 1; }
}
