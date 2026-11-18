#include "app/gui/stereo/Settings.h"
#include <algorithm>
#include <cstdlib>

namespace gui::stereo {

Settings& settings() { static Settings state; return state; }
bool read_setting(const std::string& key, const std::string& value) {
    auto& state = settings();
    if (key == "stereo_enabled") state.enabled = value == "1";
    else if (key == "stereo_eye_width") state.eye_width = std::clamp(std::atoi(value.c_str()),256,4096);
    else return false;
    ++state.revision;
    return true;
}
void write_settings(FILE* file) {
    const auto& state = settings();
    std::fprintf(file,"stereo_enabled=%d\nstereo_eye_width=%d\n",state.enabled,state.eye_width);
}

}  // namespace gui::stereo
