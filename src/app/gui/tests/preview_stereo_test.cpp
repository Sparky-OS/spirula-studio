#include "app/gui/PreviewRenderer.h"
#include "app/gui/GlLoader.h"
#include "external/stb_image_write.h"
#define GLFW_INCLUDE_NONE
#include <GLFW/glfw3.h>
#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstring>
#include <filesystem>
#include <stdexcept>

namespace {
void require(bool ok, const char* message) { if (!ok) throw std::runtime_error(message); }
std::array<double,2> centroid(const std::vector<uint8_t>& pixels, int W, int H, int colour) {
    double x = 0, y = 0, n = 0;
    for (int row = 0; row < H; ++row) for (int column = 0; column < W; ++column) {
        const auto* p = &pixels[3*((size_t)row*W+column)];
        if (p[colour] < 128 || p[(colour+1)%3] > 64 || p[(colour+2)%3] > 64) continue;
        x += column+.5; y += row+.5; ++n;
    }
    require(n > 3,"a coloured depth marker disappeared");
    return {x/n,y/n};
}
}

int main(int argc, char** argv) {
    const bool swap = argc > 1 && std::strcmp(argv[1],"--swap") == 0;
    GLFWwindow* window = nullptr;
    try {
        require(glfwInit(),"GLFW initialization failed");
        glfwWindowHint(GLFW_VISIBLE,GLFW_FALSE);
        glfwWindowHint(GLFW_CONTEXT_CREATION_API,GLFW_EGL_CONTEXT_API);
        glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR,3);
        glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR,2);
        glfwWindowHint(GLFW_OPENGL_PROFILE,GLFW_OPENGL_CORE_PROFILE);
        window = glfwCreateWindow(320,240,"Stereo preview regression",nullptr,nullptr);
        require(window,"OpenGL test context unavailable");
        glfwMakeContextCurrent(window);
        std::printf("GL_RENDERER=%s\n",glGetString(GL_RENDERER));
        const float view[16] = {1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1};
        const float target[3] = {0,0,-3};
        const float depths[3] = {1.5f,3,6};
        const float xs[3] = {-.35f,0,.35f}, ys[3] = {-.3f,0,.3f};
        for (bool mesh : {false,true}) {
            gui::PreviewRenderer renderer;
            if (mesh) {
                meshing::MeshData data;
                for (int i = 0; i < 3; ++i) {
                    for (auto corner : {std::array<float,2>{-1,-1},{1,-1},{1,1},{-1,1}}) {
                        data.V.push_back({xs[i]+.045f*corner[0],ys[i]+.045f*corner[1],-depths[i]});
                        std::array<unsigned char,3> colour{}; colour[i] = 255; data.C.push_back(colour);
                    }
                    data.F.push_back({4*i,4*i+1,4*i+2});
                    data.F.push_back({4*i,4*i+2,4*i+3});
                }
                require(renderer.build(data,nullptr),"mesh build failed");
                renderer.set_mesh_display(false,false,true);
            } else {
                ParsedDataset data; PostSplitCameras post;
                for (int i = 0; i < 3; ++i) {
                    data.points.xyz.insert(data.points.xyz.end(),{xs[i],ys[i],-depths[i]});
                    for (int c = 0; c < 3; ++c) data.points.rgb.push_back(c == i ? 255 : 0);
                }
                require(renderer.build(data,post),"point build failed");
            }
            for (int W : {960,1200}) for (bool ortho : {false,true}) {
                const int H = W*2/3;
                const double focal = .8*W;
                const auto projection = ortho ? gui::PreviewProjection::Orthographic : gui::PreviewProjection::Pinhole;
                gui::PreviewStyle style; style.point_px = 12;
                auto render = [&](const spirula::stereo::EyeCamera* eye) {
                    require(renderer.render(W,H,view,projection,2*focal/W,2*focal/H,6,3,target,
                                            false,1,false,&style,eye),"preview render failed");
                    return renderer.read_rgb();
                };
                const auto mono = render(nullptr);
                for (auto limits : {std::optional<spirula::stereo::DepthLimits>{},
                                    std::optional<spirula::stereo::DepthLimits>{{0,0}}}) {
                    const auto flat = renderer.stereo_cameras(limits,view,projection,focal,focal,W,H,6,3,target,false,1,false);
                    require(flat.state != spirula::stereo::CameraPair::State::Ready,"flat pair has no explanation");
                    require(render(&flat.left) == mono && render(&flat.right) == mono,"flat pair differs from 2D pixels");
                }
                for (spirula::stereo::DepthLimits limits : {spirula::stereo::DepthLimits{10,4},{24,9.5}}) {
                    const auto pair = renderer.stereo_cameras(limits,view,projection,focal,focal,W,H,6,3,target,false,1,false);
                    require(pair.state == spirula::stereo::CameraPair::State::Ready,"finite markers did not fit");
                    auto left = render(&pair.left), right = render(&pair.right);
                    if (swap) std::swap(left,right);
                    if (argc > 1 && !swap) {
                        std::vector<uint8_t> packed(2*left.size());
                        const size_t row = (size_t)W*3;
                        for (int y = 0; y < H; ++y) {
                            std::copy_n(left.data()+y*row,row,packed.data()+2*y*row);
                            std::copy_n(right.data()+y*row,row,packed.data()+(2*y+1)*row);
                        }
                        const std::string name = "preview-"+std::to_string(mesh)+"-"+std::to_string(ortho)+
                            "-"+std::to_string(W)+"-"+std::to_string((int)limits.sunk)+".png";
                        const auto path = std::filesystem::path(argv[1])/name;
                        require(stbi_write_png(path.string().c_str(),2*W,H,3,packed.data(),2*W*3),"capture write failed");
                    }
                    for (int i = 0; i < 3; ++i) {
                        const auto a = centroid(left,W,H,i), b = centroid(right,W,H,i);
                        const double predicted = ortho ? 2*focal*pair.right.shear*(depths[i]-3) :
                            2*focal*pair.right.offset*(1./3-1./depths[i]);
                        std::printf("mesh=%d ortho=%d W=%d limits=%g,%g z=%g predicted=%.9g measured=%.9g vertical=%.9g\n",
                                    mesh,ortho,W,limits.sunk,limits.popped,depths[i],predicted,b[0]-a[0],b[1]-a[1]);
                        require(std::abs(b[0]-a[0]-predicted) <= 1.01,"captured disparity differs from prediction");
                        require(std::abs(b[1]-a[1]) < .01,"captured pair has vertical disparity");
                    }
                }
            }
            renderer.destroy_gl();
        }
        glfwDestroyWindow(window); glfwTerminate();
        std::puts("preview_stereo_test: OK");
    } catch (const std::exception& error) {
        std::fprintf(stderr,"preview_stereo_test: %s\n",error.what());
        if (window) glfwDestroyWindow(window);
        glfwTerminate(); return 1;
    }
}
