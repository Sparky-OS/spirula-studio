#include "app/gui/stereo/NativeViewport.h"
#include "core/Env.h"
#include <cstdio>

#ifdef __linux__
#define GLFW_EXPOSE_NATIVE_X11
#define GLFW_EXPOSE_NATIVE_WAYLAND
#include <GLFW/glfw3.h>
#include <GLFW/glfw3native.h>
#include <X11/extensions/shape.h>
#include <X11/Xutil.h>
#include <stereo-declare.h>
#include <wayland-client.h>
#include "app_generated/viewporter-client-protocol.h"
#include <sys/mman.h>
#include <sys/syscall.h>
#include <unistd.h>
#endif

#include <algorithm>
#include <cstring>
#include <cstdlib>
#include <stdexcept>
#include <vector>

namespace gui::stereo {
namespace {
struct Host {
    GLFWwindow* window = nullptr;
    uint64_t frame = 0, limits_revision = 0;
    std::string error;
#ifdef __linux__
    wl_display* display = nullptr;
    wl_registry* registry = nullptr;
    wl_compositor* compositor = nullptr;
    wl_subcompositor* subcompositor = nullptr;
    wl_shm* shm = nullptr;
    wp_viewporter* viewporter = nullptr;
    wl_surface* parent = nullptr;
    Display* xdisplay = nullptr;
    Window xparent = 0;
#endif
} host;
std::vector<NativeViewport*> viewports;

#ifdef __linux__
void global(void*, wl_registry* registry, uint32_t name, const char* interface, uint32_t version) {
    if (!std::strcmp(interface, "wl_compositor"))
        host.compositor = (wl_compositor*)wl_registry_bind(registry,name,&wl_compositor_interface,std::min(version,4u));
    else if (!std::strcmp(interface, "wl_subcompositor"))
        host.subcompositor = (wl_subcompositor*)wl_registry_bind(registry,name,&wl_subcompositor_interface,1);
    else if (!std::strcmp(interface, "wl_shm"))
        host.shm = (wl_shm*)wl_registry_bind(registry,name,&wl_shm_interface,1);
    else if (!std::strcmp(interface, "wp_viewporter"))
        host.viewporter = (wp_viewporter*)wl_registry_bind(registry,name,&wp_viewporter_interface,1);
}
void removed(void*, wl_registry*, uint32_t) {}
const wl_registry_listener registry_listener{global,removed};
void limits_changed(void*, wl_surface*, const stereo_depth_limits*) { ++host.limits_revision; }

struct Buffer {
    wl_buffer* object = nullptr;
    void* pixels = MAP_FAILED;
    size_t bytes = 0;
    int width = 0, height = 0;
    bool busy = false;
    ~Buffer() {
        if (object) wl_buffer_destroy(object);
        if (pixels != MAP_FAILED) munmap(pixels,bytes);
    }
};
void release(void* data, wl_buffer*) { ((Buffer*)data)->busy = false; }
const wl_buffer_listener buffer_listener{release};
std::unique_ptr<Buffer> make_buffer(int width, int height) {
    auto buffer = std::make_unique<Buffer>();
    buffer->width = width; buffer->height = height;
    buffer->bytes = (size_t)width * height * 4;
    int fd = syscall(SYS_memfd_create,"spirula-stereo",1u);
    if (fd < 0) throw std::runtime_error("Cannot allocate stereo buffer");
    if (ftruncate(fd,buffer->bytes)) { close(fd); throw std::runtime_error("Cannot size stereo buffer"); }
    buffer->pixels = mmap(nullptr,buffer->bytes,PROT_READ|PROT_WRITE,MAP_SHARED,fd,0);
    if (buffer->pixels == MAP_FAILED) { close(fd); throw std::runtime_error("Cannot map stereo buffer"); }
    wl_shm_pool* pool = wl_shm_create_pool(host.shm,fd,buffer->bytes);
    buffer->object = wl_shm_pool_create_buffer(pool,0,width,height,width*4,WL_SHM_FORMAT_XRGB8888);
    wl_shm_pool_destroy(pool); close(fd);
    wl_buffer_add_listener(buffer->object,&buffer_listener,buffer.get());
    return buffer;
}
void pack(uint32_t* out, const uint8_t* rgb, size_t pixels) {
    for (size_t i = 0; i < pixels; ++i)
        out[i] = 0xff000000u | uint32_t(rgb[3*i])<<16 | uint32_t(rgb[3*i+1])<<8 | rgb[3*i+2];
}
#endif
}  // namespace

struct NativeViewport::Impl {
    uint64_t seen = 0, revision = 0;
    bool shown = false;
    std::string error;
    ViewError error_kind = ViewError::NoError;
#ifdef __linux__
    wl_surface* surface = nullptr;
    wl_subsurface* subsurface = nullptr;
    wp_viewport* viewport = nullptr;
    std::vector<std::unique_ptr<Buffer>> buffers;
    Window child = 0;
    Pixmap pending = 0;
    GC gc = nullptr;
    int raster_width = 0, raster_height = 0;
    bool ensure() {
        if (!error.empty()) return false;
        if (!host.error.empty()) { error = host.error; error_kind = ViewError::Session; return false; }
        if (host.display && !surface) {
            surface = wl_compositor_create_surface(host.compositor);
            subsurface = wl_subcompositor_get_subsurface(host.subcompositor,surface,host.parent);
            wl_subsurface_place_below(subsurface,host.parent);
            wl_region* region = wl_compositor_create_region(host.compositor);
            wl_surface_set_input_region(surface,region);
            wl_region_destroy(region);
            viewport = wp_viewporter_get_viewport(host.viewporter,surface);
            if (stereo_declare_wayland(surface,STEREO_SBS_FULL,STEREO_CLASS_GAME,STEREO_GAME_3D)) {
                error_kind = ViewError::Declaration; error = "The compositor cannot declare this stereo viewport"; return false;
            }
        } else if (host.xdisplay && !child) {
            XWindowAttributes parent;
            XGetWindowAttributes(host.xdisplay,host.xparent,&parent);
            XSetWindowAttributes attributes{};
            attributes.colormap = parent.colormap;
            attributes.background_pixel = 0;
            attributes.event_mask = ExposureMask | PropertyChangeMask;
            child = XCreateWindow(host.xdisplay,host.xparent,0,0,2,1,0,parent.depth,
                                  InputOutput,parent.visual,CWColormap|CWBackPixel|CWEventMask,&attributes);
            XShapeCombineRectangles(host.xdisplay,child,ShapeInput,0,0,nullptr,0,ShapeSet,Unsorted);
            gc = XCreateGC(host.xdisplay,child,0,nullptr);
            XSetGraphicsExposures(host.xdisplay,gc,False);
            if (stereo_declare_x11_child(host.xdisplay,host.xparent,child,STEREO_SBS_FULL,
                                         STEREO_CLASS_GAME,STEREO_GAME_3D,1,1)) {
                error_kind = ViewError::Declaration; error = "The compositor cannot declare this stereo child"; return false;
            }
        }
        return surface || child;
    }
#endif
};

void initialize(GLFWwindow* window) {
    host.window = window;
#ifdef __linux__
    if (glfwGetPlatform() == GLFW_PLATFORM_WAYLAND) {
        host.display = glfwGetWaylandDisplay(); host.parent = glfwGetWaylandWindow(window);
        host.registry = wl_display_get_registry(host.display);
        wl_registry_add_listener(host.registry,&registry_listener,nullptr);
        stereo_declare_wayland_init(host.display,nullptr);
        wl_display_roundtrip(host.display);
        if (!host.compositor || !host.subcompositor || !host.shm || !host.viewporter || !stereo_supported_wayland())
            host.error = "The compositor cannot present a declared stereo viewport";
        else {
            stereo_depth_wayland_watch_limits(host.parent,limits_changed,nullptr);
            wl_display_roundtrip(host.display);
        }
    } else if (glfwGetPlatform() == GLFW_PLATFORM_X11) {
        host.xdisplay = glfwGetX11Display(); host.xparent = glfwGetX11Window(window);
        if (stereo_supported_x11(host.xdisplay) < 8)
            host.error = "The compositor cannot place a stereo child below the controls";
    } else host.error = "This window system cannot present a declared stereo viewport";
#else
    host.error = "This build requires Stereo KWin for 3D";
#endif
}
void shutdown() {
#ifdef __linux__
    if (host.display) {
        stereo_depth_wayland_unwatch(host.parent);
        stereo_declare_wayland_finish();
        if (host.viewporter) wp_viewporter_destroy(host.viewporter);
        if (host.shm) wl_shm_destroy(host.shm);
        if (host.subcompositor) wl_subcompositor_destroy(host.subcompositor);
        if (host.compositor) wl_compositor_destroy(host.compositor);
        if (host.registry) wl_registry_destroy(host.registry);
    }
#endif
    host = Host{};
}
void begin_frame() { ++host.frame; }
void end_frame() {
    for (auto* viewport : viewports) {
        if (viewport->_impl->seen != host.frame) viewport->hide();
    }
}
NativeViewport::NativeViewport() : _impl(std::make_unique<Impl>()) { viewports.push_back(this); }
NativeViewport::~NativeViewport() {
    hide();
#ifdef __linux__
    if (_impl->surface) {
        stereo_remove_wayland(_impl->surface);
        wp_viewport_destroy(_impl->viewport);
        wl_subsurface_destroy(_impl->subsurface);
        wl_surface_destroy(_impl->surface);
    }
    if (_impl->child) {
        stereo_remove_x11_child(host.xdisplay,host.xparent,_impl->child);
        if (_impl->pending) XFreePixmap(host.xdisplay,_impl->pending);
        XFreeGC(host.xdisplay,_impl->gc); XDestroyWindow(host.xdisplay,_impl->child);
    }
#endif
    viewports.erase(std::remove(viewports.begin(),viewports.end(),this),viewports.end());
}
std::optional<Limits> NativeViewport::limits() {
#ifdef __linux__
    if (!_impl->ensure()) return {};
    stereo_depth_limits limits;
    int result = host.display ? stereo_depth_wayland_get_limits(host.parent,&limits) :
                               stereo_depth_x11_get_limits(host.xdisplay,_impl->child,&limits);
    if (result == 0) return Limits{limits.sunk,limits.popped};
#endif
    return {};
}
std::optional<Limits> NativeViewport::buffer_limits(double buffer_width, double shown_width) {
#ifdef __linux__
    if (!_impl->ensure()) return {};
    stereo_depth_limits limits;
    int result = host.display ? stereo_depth_wayland_get_buffer_limits(host.parent,buffer_width,shown_width,&limits) :
                               stereo_depth_x11_get_buffer_limits(host.xdisplay,_impl->child,buffer_width,shown_width,&limits);
    if (result == 0) return Limits{limits.sunk,limits.popped};
#endif
    return {};
}
uint64_t NativeViewport::limits_revision() const { return host.limits_revision; }
const std::string& NativeViewport::error() const { return _impl->error.empty() ? host.error : _impl->error; }
ViewError NativeViewport::error_code() const {
    return _impl->error.empty() && !host.error.empty() ? ViewError::Session : _impl->error_kind;
}
void NativeViewport::hide() {
#ifdef __linux__
    if (_impl->shown) {
        if (_impl->surface) { wl_surface_attach(_impl->surface,nullptr,0,0); wl_surface_commit(_impl->surface); }
        if (_impl->child) XUnmapWindow(host.xdisplay,_impl->child);
    }
#endif
    _impl->shown = false;
}
bool NativeViewport::present(const uint8_t* rgb, int eye_width, int height, uint64_t revision,
                             int x, int y, int width, int logical_height) {
    _impl->seen = host.frame;
    try {
#ifdef __linux__
        if (!_impl->ensure() || !rgb || eye_width <= 0 || height <= 0 || width <= 0 || logical_height <= 0) return false;
        if (spirula::env_on("GUI_AUTOMATION") && spirula::env("GUI_PAIR_CAPTURE") &&
            (!_impl->shown || _impl->revision != revision))
            std::fprintf(stderr,"[stereo-place] x=%d y=%d width=%d height=%d raster_width=%d raster_height=%d\n",
                         x,y,width,logical_height,eye_width,height);
        if (host.display) {
            wl_subsurface_set_position(_impl->subsurface,x,y);
            wp_viewport_set_destination(_impl->viewport,width,logical_height);
            if (!_impl->shown || _impl->revision != revision) {
                auto& buffers = _impl->buffers;
                buffers.erase(std::remove_if(buffers.begin(),buffers.end(),[&](const auto& b) {
                    return !b->busy && (b->width != 2*eye_width || b->height != height);
                }),buffers.end());
                Buffer* available = nullptr;
                for (auto& buffer : buffers) if (!buffer->busy) { available = buffer.get(); break; }
                if (!available && buffers.size() < 4) {
                    buffers.push_back(make_buffer(2*eye_width,height)); available = buffers.back().get();
                }
                if (!available) return _impl->shown;
                pack((uint32_t*)available->pixels,rgb,(size_t)eye_width*2*height);
                available->busy = true;
                wl_surface_attach(_impl->surface,available->object,0,0);
                wl_surface_damage(_impl->surface,0,0,INT32_MAX,INT32_MAX);
                _impl->revision = revision;
            }
            wl_surface_commit(_impl->surface);
        } else if (host.xdisplay) {
            XMoveResizeWindow(host.xdisplay,_impl->child,x,y,2*eye_width,height);
            stereo_declare_x11_one_view_size(host.xdisplay,_impl->child,eye_width,height);
            stereo_x11_child_place place{x,y,(unsigned)width,(unsigned)logical_height,1};
            if (stereo_declare_x11_child_place(host.xdisplay,_impl->child,&place)) {
                _impl->error_kind = ViewError::Placement;
                _impl->error = "The compositor rejected stereo viewport placement"; return false;
            }
            XMapWindow(host.xdisplay,_impl->child);
            if (!_impl->shown || _impl->revision != revision) {
                XWindowAttributes attributes;
                XGetWindowAttributes(host.xdisplay,_impl->child,&attributes);
                XImage* image = XCreateImage(host.xdisplay,attributes.visual,attributes.depth,ZPixmap,0,
                                             nullptr,2*eye_width,height,32,0);
                if (!image || image->bits_per_pixel != 32) {
                    _impl->error_kind = image ? ViewError::PixelFormat : ViewError::Allocation;
                    if (image) XDestroyImage(image);
                    _impl->error = "The X11 stereo viewport needs 32-bit pixels"; return false;
                }
                image->data = (char*)std::calloc(height,image->bytes_per_line);
                if (!image->data) { XDestroyImage(image); throw std::bad_alloc(); }
                for (int row = 0; row < height; ++row)
                    pack((uint32_t*)(image->data+row*image->bytes_per_line),rgb+row*eye_width*6,(size_t)eye_width*2);
                if (!_impl->pending || _impl->raster_width!=2*eye_width || _impl->raster_height!=height) {
                    if (_impl->pending) XFreePixmap(host.xdisplay,_impl->pending);
                    _impl->pending = XCreatePixmap(host.xdisplay,_impl->child,2*eye_width,height,attributes.depth);
                    if (!_impl->pending) { XDestroyImage(image); throw std::bad_alloc(); }
                    _impl->raster_width = 2*eye_width; _impl->raster_height = height;
                }
                XPutImage(host.xdisplay,_impl->pending,_impl->gc,image,0,0,0,0,2*eye_width,height);
                XCopyArea(host.xdisplay,_impl->pending,_impl->child,_impl->gc,0,0,2*eye_width,height,0,0);
                XDestroyImage(image);
                _impl->revision = revision;
            }
            XFlush(host.xdisplay);
        } else return false;
        _impl->shown = true;
        return true;
#else
        return false;
#endif
    } catch (const std::exception& exception) {
        _impl->error = exception.what();
        _impl->error_kind = ViewError::Allocation;
        return false;
    }
}

}  // namespace gui::stereo
