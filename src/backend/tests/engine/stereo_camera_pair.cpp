#include "app/stereo/CameraPair.h"
#include <array>
#include <cmath>
#include <cstdio>
#include <stdexcept>

using namespace spirula::stereo;

void close(double actual, double expected) {
    if (std::abs(actual - expected) > 1e-9) throw std::runtime_error("camera prediction differs");
}

int main(int argc, char**) {
    try {
        for (int width : {960,1200,1920}) for (bool orthographic : {false,true}) {
            for (DepthLimits limits : {DepthLimits{10,4},DepthLimits{24,9.5}}) {
                const double focal = 0.8 * width, convergence = 3;
                const auto pair = camera_pair(limits,{1.5,6},convergence,focal,width,orthographic);
                for (double depth : {1.5,3.,6.}) {
                    std::array<double,2> pixel;
                    int i = 0;
                    for (const auto eye : {pair.left,pair.right}) {
                        const double x = .17 - eye.offset + eye.shear * depth;
                        pixel[i++] = width / 2. + focal * x / (orthographic ? 1 : depth) + eye.principal;
                    }
                    const double d = argc > 1 ? pixel[0] - pixel[1] : pixel[1] - pixel[0];
                    const double predicted = orthographic
                        ? 2 * focal * pair.right.shear * (depth - convergence)
                        : 2 * focal * pair.right.offset * (1 / convergence - 1 / depth);
                    close(d,predicted);
                    if (d < -limits.popped * width / 1920. - 1e-9 ||
                        d > limits.sunk * width / 1920. + 1e-9)
                        throw std::runtime_error("depth exceeds compositor limits");
                    if (depth == convergence) close(d,0);
                }
            }
            for (auto limits : {std::optional<DepthLimits>{},std::optional<DepthLimits>{{0,0}}}) {
                auto pair = camera_pair(limits,{1.5,6},3,0.8*width,width,orthographic);
                close(pair.left.offset,0);close(pair.right.offset,0);
                close(pair.left.principal,0);close(pair.right.principal,0);
                close(pair.left.shear,0);close(pair.right.shear,0);
                if (pair.state == CameraPair::State::Ready) throw std::runtime_error("missing flat explanation");
            }
        }
        const DepthLimits limits{10,4};
        const double focal = 1000, convergence = 3, z = 1, radius = 2;
        const ParallaxRange gaussian{1/convergence-1/z+radius/(z*z),1/z-1/convergence+radius/(z*z),true};
        const auto fitted = fit_camera_pair(limits,gaussian,convergence,focal,1200,false);
        if (!(fitted.right.offset > 0)) throw std::runtime_error("finite projected Gaussian was flattened");
        for (double dz : {-radius,radius}) {
            double pixels[2]; int i = 0;
            for (auto eye : {fitted.left,fitted.right}) {
                const double x = .2-eye.offset;
                pixels[i++] = focal*x/z+eye.principal-focal*x*dz/(z*z);
            }
            const double disparity = pixels[1]-pixels[0];
            if (disparity < -limits.popped*1200/1920.-1e-9 || disparity > limits.sunk*1200/1920.+1e-9)
                throw std::runtime_error("projected Gaussian support exceeds the limits");
        }
    } catch (const std::exception& e) {
        std::fprintf(stderr,"stereo_camera_pair: %s\n",e.what());return 1;
    }
    std::puts("stereo_camera_pair: OK");
}
