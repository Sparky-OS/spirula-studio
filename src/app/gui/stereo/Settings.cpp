#include "app/gui/stereo/Settings.h"
#include "app/gui/stereo/NativeViewport.h"
#include "app/gui/Ui.h"
#include "app/gui/Subprocess.h"
#include "core/Env.h"
#include "i18n/Locale.h"
#include "i18n/catalog/Stereo.h"
#include <algorithm>
#include <cstdlib>
#include <cstring>

namespace gui::stereo {
namespace {
bool use_polish = false;
bool settings_failed = false;
}
void init_language(const char* saved) {
    const char* locale = spirula::i18n::lang_arg();
    if (!locale || !*locale) locale = spirula::env("LANG");
    if ((!locale || !*locale) && saved && *saved) locale = saved;
    for (const char* variable : {"LC_ALL","LC_MESSAGES","LANG"})
        if (!locale || !*locale) locale = std::getenv(variable);
    use_polish = locale && locale[0]=='p' && locale[1]=='l' &&
        (!locale[2] || locale[2]=='_' || locale[2]=='-' || locale[2]=='.');
}
void explicit_language() { use_polish = false; }
bool polish() { return use_polish; }
const spirula::i18n::Msg& translated(const spirula::i18n::Msg& message, const spirula::i18n::Msg& polish_message) {
    return use_polish && spirula::i18n::current()==spirula::i18n::Lang::en ? polish_message : message;
}
const spirula::i18n::Msg& viewport_error(ViewError error) {
    namespace msg = spirula::i18n::msg::stereo;
    switch (error) {
    case ViewError::Allocation: return translated(msg::allocation_failed,msg::allocation_failed_pl);
    case ViewError::Session: return translated(msg::session_required,msg::session_required_pl);
    case ViewError::Placement: return translated(msg::placement_failed,msg::placement_failed_pl);
    case ViewError::PixelFormat: return translated(msg::pixel_format,msg::pixel_format_pl);
    default: return translated(msg::declaration_failed,msg::declaration_failed_pl);
    }
}

bool draw_settings() {
    auto& state = settings();
    namespace msg = spirula::i18n::msg::stereo;
    bool changed = ui::MenuItem(translated(msg::enable,msg::enable_pl),nullptr,&state.enabled);
    if (state.enabled) {
        ImGui::SetNextItemWidth(180);
        changed |= ui::InputInt(translated(msg::resolution,msg::resolution_pl),&state.eye_width,128,512);
        state.eye_width = std::clamp(state.eye_width,256,4096);
        if (ui::MenuItem(translated(msg::display_settings,msg::display_settings_pl)))
            settings_failed = !launch_detached({"systemsettings","kcm_kscreen"});
        if (settings_failed) ui::TextDisabled(translated(msg::settings_failed,msg::settings_failed_pl));
    }
    if (changed) ++state.revision;
    return changed;
}
}  // namespace gui::stereo
