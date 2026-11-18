#include "engine/Engine.h"
#include <cmath>
#include <cstdio>
#include <stdexcept>
#include <vector>

TorchTensorView host(std::vector<float>& values, std::vector<int64_t> shape) {
    return {(uint64_t)(uintptr_t)values.data(),4,std::move(shape)};
}

int main() {
    try {
        engine_reset();
        std::vector<float> mean{0,0,3}, quat{1,0,0,0}, scale(3,std::log(.1f)), opacity{3};
        std::vector<float> dc(3,0), sh(9,0);
        sh[6] = 1;
        engine_scene_set_data_3dgs(0,1,host(mean,{1,3}),host(quat,{1,4}),host(scale,{1,3}),
                                   host(opacity,{1,1}),host(dc,{1,3}),host(sh,{1,3,3}),0);
        const float black[3] = {};
        engine_init_background_color(black,0,false);
        for (float shear : {-0.3f,0.0f,0.3f}) {
            const float eye = shear*3;
            std::vector<float> view{1,0,shear,-eye, 0,1,0,0, 0,0,1,0, 0,0,0,1};
            std::vector<float> intr{80,80,32.5f,32.5f}, dist(8,0);
            set_camera_params(65,65,"ORTHOGRAPHIC","NONE",host(view,{1,4,4}),host(intr,{1,4}),host(dist,{1,8}));
            forward_3dgs("3dgs",1,true,false,0);
            std::vector<float> rgb(65*65*3), transmittance(65*65);
            const TorchTensorView empty{0,4,{0}};
            engine_copy_render_to_host(host(rgb,{1,65,65,3}),empty,host(transmittance,{1,65,65,1}),empty,empty);
            const int pixel = 32*65+32;
            const float coverage = 1-transmittance[pixel];
            if (!(coverage > .1f)) throw std::runtime_error("test splat missed the zero-plane pixel");
            const double expected = .5 + .48860251190292 * eye / std::sqrt(eye*eye+9);
            const double actual = rgb[3*pixel]/coverage;
            std::printf("shear=%g eye=%g red=%g expected=%g\n",shear,eye,actual,expected);
            if (std::abs(actual-expected) > 2e-4 || std::abs(rgb[3*pixel+1]/coverage-.5) > 2e-4)
                throw std::runtime_error("SH colour used an affine transpose as a camera inverse");
        }
        engine_reset();
    } catch (const std::exception& e) { std::fprintf(stderr,"affine_camera: %s\n",e.what());return 1; }
    std::puts("affine_camera: OK");
}
