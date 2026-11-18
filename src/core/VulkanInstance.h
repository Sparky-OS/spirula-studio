#pragma once

#include <vulkan/vulkan.h>
#include <stdexcept>
#ifdef __linux__
#include <dlfcn.h>
#endif

namespace spirula {

inline void destroy_vulkan_instance(VkInstance instance, const VkAllocationCallbacks* alloc) {
#ifdef __linux__
    void* library = dlopen("libEGL.so.1", RTLD_LAZY | RTLD_NOLOAD);
    using GetContext = void* (*)();
    using GetSurface = void* (*)(unsigned);
    using MakeCurrent = unsigned (*)(void*, void*, void*, void*);
    using QueryApi = unsigned (*)();
    using BindApi = unsigned (*)(unsigned);
    auto get_context = library ? (GetContext)dlsym(library, "eglGetCurrentContext") : nullptr;
    auto get_display = library ? (GetContext)dlsym(library, "eglGetCurrentDisplay") : nullptr;
    auto get_surface = library ? (GetSurface)dlsym(library, "eglGetCurrentSurface") : nullptr;
    auto make_current = library ? (MakeCurrent)dlsym(library, "eglMakeCurrent") : nullptr;
    auto query_api = library ? (QueryApi)dlsym(library, "eglQueryAPI") : nullptr;
    auto bind_api = library ? (BindApi)dlsym(library, "eglBindAPI") : nullptr;
    void* context = get_context ? get_context() : nullptr;
    void* display = get_display ? get_display() : nullptr;
    void* draw = get_surface ? get_surface(0x3059) : nullptr;
    void* read = get_surface ? get_surface(0x305A) : nullptr;
    unsigned api = query_api ? query_api() : 0;
#endif
    vkDestroyInstance(instance, alloc);
#ifdef __linux__
    // NVIDIA's Vulkan-instance teardown also releases this thread's EGL context.
    bool restored = true;
    if (context && get_context() != context) {
        restored = bind_api && make_current && bind_api(api) &&
                   make_current(display, draw, read, context);
    }
    if (library) dlclose(library);
    if (!restored) throw std::runtime_error("Could not restore EGL context after Vulkan teardown");
#endif
}

}  // namespace spirula
