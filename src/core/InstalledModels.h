#pragma once

#ifdef SS_EDITION_PACKAGE
#include "core/Sha256.h"
#include "core/Env.h"
#include "i18n/Locale.h"
#include "edition_model_files.h"
#include "edition_model_messages.h"
#include <filesystem>
#include <mutex>
#include <stdexcept>
#include <unordered_map>

namespace spirula::installed_models {
namespace fs = std::filesystem;
inline std::string root() { return "/var/lib/spirula-studio/models"; }
inline const EditionModelFile* entry(const std::string& name) {
    for (const auto& f : kEditionModelFiles) if (name == f.file) return &f;
    return nullptr;
}
inline std::string name_of(const std::string& path) {
    const fs::path p(path);
    const auto rel = p.lexically_relative(root()).generic_string();
    return entry(rel) ? rel : p.filename().string();
}
inline std::string path(const std::string& name) { return (fs::path(root()) / name).string(); }
inline std::string package(const std::string& name) {
    const auto* f = entry(name_of(name));
    return f ? f->package : "spirula-studio-model-marigold-depth";
}
inline std::string language() {
    std::string lang = i18n::code(i18n::current());
    const char* requested = i18n::lang_arg();
    if (!requested || !*requested) requested = spirula::env("LANG");
    for (const char* key : {"LC_ALL", "LC_MESSAGES", "LANG"})
        if (!requested || !*requested) requested = std::getenv(key);
    if (lang == "en" && requested && std::string(requested).rfind("pl",0) == 0) lang = "pl";
    if (lang == "pt") lang = "pt_BR";
    if (lang == "zh-Hans") lang = "zh_CN";
    if (lang == "zh-Hant") lang = "zh_TW";
    return lang;
}
template<std::size_t N> inline const char* translated(const EditionModelMessage (&messages)[N]) {
    const auto lang = language();
    for (const auto& m : messages) if (lang == m.language) return m.text;
    return messages[0].text;
}
inline std::string graphics_message() { return translated(kEditionGraphicsMessages); }
inline std::string message(const std::string& name) {
    std::string text = translated(kEditionModelMessages);
    for (const auto& item : {std::pair<std::string,std::string>{"{file}",name_of(name)}, {"{package}",package(name)}})
        for (size_t at = 0; (at = text.find(item.first,at)) != std::string::npos; at += item.second.size())
            text.replace(at,item.first.size(),item.second);
    return text;
}
inline bool verified(const std::string& name) {
    const auto* f = entry(name);
    if (!f) return false;
    const fs::path p = path(name);
    std::error_code ec;
    if (!fs::is_regular_file(p,ec) || fs::is_symlink(p,ec) || fs::file_size(p,ec) != f->bytes) return false;
    const auto stamp = fs::last_write_time(p,ec); if (ec) return false;
    static std::mutex mutex;
    static std::unordered_map<std::string,fs::file_time_type> valid;
    std::lock_guard<std::mutex> lock(mutex);
    if (valid.count(name) && valid[name] == stamp) return true;
    if (spirula::sha256_file(p.string()) != f->sha256) return false;
    valid[name] = stamp;
    return true;
}
inline std::string require(const std::string& name) {
    if (!verified(name)) throw std::runtime_error(message(name));
    return path(name);
}
inline std::string installation_url(const std::string& name) {
    return "aptus://graedi_" + package(name);
}
}  // namespace spirula::installed_models
#endif
