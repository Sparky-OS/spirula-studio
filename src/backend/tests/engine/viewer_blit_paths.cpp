// RenderWorker's device-side blit (engine_blit_render) against its host
// round trip: same bytes, same double-click pick. relative_scale = 1 changes
// nothing but forces the host path.
#include "engine/Engine.h"
#include "app/webviewer/RenderWorker.h"

#include <algorithm>
#include <atomic>
#include <chrono>
#include <cmath>
#include <cstdio>
#include <mutex>
#include <random>
#include <stdexcept>
#include <string>
#include <thread>
#include <vector>

namespace {
void require(bool ok, const std::string& message) {
    if (!ok) throw std::runtime_error(message);
}

TorchTensorView tvf(std::vector<float>& v, std::vector<int64_t> s) {
    return {(uint64_t)(uintptr_t)v.data(), 4, std::move(s)};
}
TorchTensorView tvi(std::vector<int32_t>& v, std::vector<int64_t> s) {
    return {(uint64_t)(uintptr_t)v.data(), 4, std::move(s)};
}

ViewRequest request(bool grid) {
    ViewRequest q;
    const float eye[3] = {0.0f, -2.2f, 1.2f};
    // Looking at the origin, z up (OpenGL camera axes in the columns).
    const float f[3] = {0.0f, 2.2f / std::sqrt(2.2f * 2.2f + 1.44f),
                        -1.2f / std::sqrt(2.2f * 2.2f + 1.44f)};
    const float x[3] = {1.0f, 0.0f, 0.0f};
    const float y[3] = {0.0f, -f[2], f[1]};
    for (int r = 0; r < 3; r++) {
        q.c2w[r * 4 + 0] = x[r];
        q.c2w[r * 4 + 1] = y[r];
        q.c2w[r * 4 + 2] = -f[r];
        q.c2w[r * 4 + 3] = eye[r];
    }
    q.W = 320;
    q.H = 240;
    q.fx = q.fy = 260.0f;
    q.cx = 160.0f;
    q.cy = 120.0f;
    q.show_grid = grid;
    q.grid_dist = 2.5f;
    q.pick_px = 160;
    q.pick_py = 120;
    return q;
}

ViewResult render(RenderWorker& w, bool grid) {
    ViewResult r;
    require(w.wait_result(w.submit(request(grid)), r, 120.0), "render timed out");
    require(r.error.empty(), "render failed: " + r.error);
    return r;
}
void check_limits(RenderWorker& worker) {
    for (const char* model : {"PINHOLE","ORTHOGRAPHIC"})
        for (const char* primitive : {"3dgs","mip","3dgut"}) for (bool grid : {false,true}) {
            auto q = request(grid);
            q.model = model; q.primitive = primitive;
            ViewResult mono;
            require(worker.wait_result(worker.submit(q),mono,120) && mono.error.empty(),"mono control failed");
            for (auto limits : {std::optional<spirula::stereo::DepthLimits>{},
                                std::optional<spirula::stereo::DepthLimits>{{0,0}}}) {
                ViewResult pair;
                require(worker.wait_result(worker.submit_stereo(q,2.5,limits),pair,120) && pair.error.empty(),
                        "flat pair failed");
                require(pair.views == 2 && pair.pair_state != spirula::stereo::CameraPair::State::Ready,
                        "flat pair has no explanation");
                const size_t row = (size_t)q.W*3;
                for (int y = 0; y < q.H; ++y) for (int eye = 0; eye < 2; ++eye)
                    require(std::equal(mono.rgb8.begin()+y*row,mono.rgb8.begin()+(y+1)*row,
                                       pair.rgb8.begin()+(2*y+eye)*row),"flat eye differs from 2D pixels");
            }
            for (spirula::stereo::DepthLimits limits : {spirula::stereo::DepthLimits{10,4},{24,9.5}}) {
                ViewResult pair;
                require(worker.wait_result(worker.submit_stereo(q,2.5,limits),pair,120) && pair.error.empty(),
                        "compositor-limited pair failed");
                require(pair.views == 2 && pair.pair_state == spirula::stereo::CameraPair::State::Ready,
                        "finite scene did not produce a camera pair");
                require(pair.W == q.W && pair.H == q.H &&
                        pair.rgb8.size() == (size_t)q.W*q.H*6,
                        "fitted pair lost its dimensions or storage");
                require(pair.pick_hit == mono.pick_hit &&
                        std::equal(pair.pick_point,pair.pick_point+3,mono.pick_point),
                        "fitted pair lost the centre-camera pick");
                const size_t row = (size_t)q.W*3;
                bool different = false;
                for (int y = 0; y < q.H; ++y)
                    different |= !std::equal(pair.rgb8.begin()+2*y*row,pair.rgb8.begin()+(2*y+1)*row,
                                             pair.rgb8.begin()+(2*y+1)*row);
                require(different,"a finite scene was flattened");
                auto envelope = pair.cameras.support;
                envelope.sunk *= 2; envelope.popped *= 2;
                ViewResult capped;
                require(worker.wait_result(worker.submit_stereo(q,2.5,limits,envelope),capped,120) &&
                        capped.error.empty(),"comparison envelope failed");
                const double coefficient = q.model == "ORTHOGRAPHIC"
                    ? 2*q.fx/2.5 : 2*q.fx;
                require(capped.cameras.right.offset < pair.cameras.right.offset &&
                        coefficient*capped.cameras.right.offset*envelope.sunk <= limits.sunk*q.W/1920.+1e-6 &&
                        coefficient*capped.cameras.right.offset*envelope.popped <= limits.popped*q.W/1920.+1e-6,
                        "comparison envelope did not cap the cameras");
                require(capped.cameras.support.sunk == pair.cameras.support.sunk &&
                        capped.cameras.support.popped == pair.cameras.support.popped,
                        "comparison envelope replaced the scene's own support");
                ViewRequest eyes[2] = {q,q};
                const spirula::stereo::EyeCamera cameras[2] = {capped.cameras.left,capped.cameras.right};
                for (int eye = 0; eye < 2; ++eye) {
                    for (int r = 0; r < 3; ++r)
                        eyes[eye].c2w[4*r+3] += eyes[eye].c2w[4*r]*cameras[eye].offset;
                    eyes[eye].cx += cameras[eye].principal; eyes[eye].view_shear = cameras[eye].shear;
                }
                ViewResult independent;
                require(worker.wait_result(worker.submit_pair(eyes[0],eyes[1]),independent,120) &&
                        independent.error.empty() && independent.rgb8 == capped.rgb8,
                        "comparison pair differs from independent eye requests");
            }
        }
}

void check_pair(RenderWorker& worker, std::mutex& mutex, std::atomic<int>& step) {
    ViewRequest left = request(false), right = left;
    right.c2w[3] += 0.08f;
    ViewResult reference[2], pair;
    require(worker.wait_result(worker.submit(left), reference[0], 120), "left timed out");
    require(worker.wait_result(worker.submit(right), reference[1], 120), "right timed out");
    std::atomic<bool> first_done{false}, attempting{false};
    const int initial_step = step.load();
    left.after_render = [&] {
        first_done = true;
        while (!attempting.load()) std::this_thread::yield();
    };
    right.before_render = [&] {
        require(step.load() == initial_step, "training advanced between eyes");
    };
    std::thread trainer([&] {
        const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds(120);
        while (!first_done.load() && std::chrono::steady_clock::now() < deadline)
            std::this_thread::yield();
        if (!first_done.load()) return;
        attempting = true;
        std::lock_guard<std::mutex> lock(mutex);
        ++step;
    });
    const bool ready = worker.wait_result(worker.submit_pair(left, right), pair, 120);
    trainer.join();
    require(ready && pair.error.empty(), "pair failed: " + pair.error);
    require(pair.views == 2 && pair.W == left.W && pair.H == left.H &&
            pair.step == initial_step, "pair dimensions or revision changed");
    require(pair.rgb8.size() == 2 * reference[0].rgb8.size(), "pair storage has wrong size");
    const size_t row = (size_t)pair.W * 3;
    for (int y = 0; y < pair.H; ++y)
        for (int eye = 0; eye < 2; ++eye)
            require(std::equal(reference[eye].rgb8.begin() + y * row,
                               reference[eye].rgb8.begin() + (y + 1) * row,
                               pair.rgb8.begin() + (2 * y + eye) * row),
                    "pair is not the two independently rendered cameras");
    require(reference[0].rgb8 != reference[1].rgb8, "fixture has no camera disparity");
    require(step == initial_step + 1, "trainer did not resume after the pair");
}
}  // namespace

int main() {
    try {
        engine_reset();
        const int64_t n = 30000;
        std::mt19937 rng(3);
        std::uniform_real_distribution<float> u(-1.f, 1.f);
        std::vector<float> means(n * 3), quats(n * 4, 0.f), scales(n * 3), op(n), dc(n * 3),
            sh(n * 3 * 3);
        for (int64_t i = 0; i < n; i++) {
            for (int a = 0; a < 3; a++) means[3 * i + a] = 0.6f * u(rng);
            quats[4 * i] = 1;
            for (int a = 0; a < 3; a++) scales[3 * i + a] = -3.5f + 0.5f * u(rng);
            op[i] = 2.0f * u(rng);
            for (int a = 0; a < 3; a++) dc[3 * i + a] = u(rng);
        }
        for (auto& v : sh) v = 0.2f * u(rng);
        engine_scene_set_data_3dgs(0, n, tvf(means, {n, 3}), tvf(quats, {n, 4}),
                                   tvf(scales, {n, 3}), tvf(op, {n, 1}), tvf(dc, {n, 3}),
                                   tvf(sh, {n, 3, 3}), 0);
        std::vector<float> intrins{32, 32, 32, 32}, dist(kCameraDistortionParams, 0.f),
            c2w{1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0};
        std::vector<int32_t> models{0}, ws{64}, hs{64}, tiers{0};
        engine_viewer_init(tvi(models, {1}), tvf(intrins, {1, 4}),
                           tvf(dist, {1, kCameraDistortionParams}), tvi(tiers, {1}),
                           tvf(c2w, {1, 3, 4}), tvi(ws, {1}), tvi(hs, {1}), 1e-3f);
        engine_viewer_set_grid(1.0f, 2.5f);

        std::mutex mu;
        ViewerHooks hooks;
        hooks.engine_mutex = &mu;
        std::atomic<int> step{1 << 20};
        hooks.current_step = [&] { return step.load(); };
        hooks.set_render_pending = [](bool) {};
        ViewerRenderConfig cfg;
        cfg.primitive = "3dgs";
        cfg.packed = true;
        cfg.sh_degree_warmup_every = 1;
        cfg.scene_slot = 0;
        ViewerRenderConfig host_cfg = cfg;
        host_cfg.relative_scale = 1.0f;
        RenderWorker device_w, host_w;
        device_w.start(cfg, hooks);
        host_w.start(host_cfg, hooks);

        const ViewResult d = render(device_w, true);
        const ViewResult h = render(host_w, true);
        require(render(device_w, false).rgb8 != d.rgb8, "the grid drew nothing");
        size_t diff = 0;
        for (size_t i = 0; i < d.rgb8.size(); i++) diff += d.rgb8[i] != h.rgb8[i];
        require(d.rgb8.size() == h.rgb8.size() && diff == 0,
                std::to_string(diff) + " bytes differ between the device and host blits");
        require(d.pick_hit && h.pick_hit, "the pick missed the model");
        for (int k = 0; k < 3; k++)
            require(std::fabs(d.pick_point[k] - h.pick_point[k]) <= 1e-6f,
                    "the device pick differs from the host pick");
        check_pair(device_w, mu, step);
        check_pair(host_w, mu, step);
        check_limits(device_w);
        check_limits(host_w);
        device_w.stop();
        host_w.stop();
        engine_reset();
    } catch (const std::exception& e) {
        std::fprintf(stderr, "viewer_blit_paths: %s\n", e.what());
        return 1;
    }
    std::puts("viewer_blit_paths: OK");
}
