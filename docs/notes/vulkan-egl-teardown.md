# Vulkan probes and the current EGL context

On Linux with NVIDIA 615.71.09, destroying a temporary Vulkan instance after device enumeration releases the calling thread's current EGL context.
The GUI then has a live GLFW window but its GL calls draw nothing; opening a model at startup gives ImGui shader errors, while opening it later leaves the welcome pixels frozen.
The same failure occurs with the Mesa stereo layer disabled.
A trace of eglGetCurrentContext, eglGetCurrentDisplay and glGetString before and after each Vulkan operation identifies vkDestroyInstance as the transition.
Restoring the saved EGL display, draw/read surfaces, API and context makes the unchanged model draw again.

core/VulkanInstance.h owns that boundary for the engine, inference and SfM contexts.
It looks up EGL only when already loaded, so command-line Vulkan work gains no EGL dependency or context.
The guard preserves the caller's context without selecting a GPU or keeping a probe device alive.
Failure to restore is an error rather than an invisible rendering failure.
