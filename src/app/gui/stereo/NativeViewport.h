#pragma once

#include <cstdint>
#include <memory>
#include <optional>
#include <string>

struct GLFWwindow;

namespace gui::stereo {

enum class ViewError { NoError, Allocation, Declaration, Session, Placement, PixelFormat };

struct Limits { double sunk = 0, popped = 0; };

void initialize(GLFWwindow* window);
void shutdown();
void begin_frame();
void end_frame();

class NativeViewport {
public:
    NativeViewport();
    ~NativeViewport();
    NativeViewport(const NativeViewport&) = delete;
    NativeViewport& operator=(const NativeViewport&) = delete;
    std::optional<Limits> limits();
    // The person's limits in the pixels of an eye buffer of buffer_width pixels that Stereo KWin shows shown_width pixels wide:
    // libstereo-declare's conversion with the output the window is on (the one source; this adds no rule).
    std::optional<Limits> buffer_limits(double buffer_width, double shown_width);
    bool present(const uint8_t* rgb, int eye_width, int height, uint64_t revision,
                 int x, int y, int width, int logical_height);
    void hide();
    const std::string& error() const;
    ViewError error_code() const;
private:
    friend void end_frame();
    struct Impl;
    std::unique_ptr<Impl> _impl;
};

}  // namespace gui::stereo
