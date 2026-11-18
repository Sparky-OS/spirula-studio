#pragma once
#include "i18n/Message.h"
#include <cstdint>
#include <cstdio>
#include <string>

namespace gui::stereo {
enum class ViewError;
const spirula::i18n::Msg& viewport_error(ViewError error);

struct Settings { bool enabled = false; int eye_width = 1024; uint64_t revision = 0; };
Settings& settings();
bool read_setting(const std::string& key, const std::string& value);
void write_settings(FILE* file);
void init_language(const char* saved);
void explicit_language();
bool polish();
const spirula::i18n::Msg& translated(const spirula::i18n::Msg& message, const spirula::i18n::Msg& polish_message);
bool draw_settings();
}  // namespace gui::stereo
