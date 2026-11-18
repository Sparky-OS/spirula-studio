#pragma once

#ifdef SS_EDITION_PACKAGE
#include "core/Sha256.h"
#include "core/Env.h"
#include "i18n/Locale.h"
#include "edition_model_files.h"
#include "edition_model_messages.h"
#include <filesystem>
#include <fstream>
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
inline const EditionGeneratedModel* generated_entry(const std::string& name) {
    for (const auto& f : kEditionGeneratedModels) if (name == f.file) return &f;
    return nullptr;
}
inline std::string name_of(const std::string& path) {
    const fs::path p(path);
    const auto rel = p.lexically_relative(root()).generic_string();
    return entry(rel) || generated_entry(rel) ? rel : p.filename().string();
}
inline std::string path(const std::string& name) { return (fs::path(root()) / name).string(); }
inline std::string package(const std::string& name) {
    const auto* f = entry(name_of(name));
    if (f) return f->package;
    const auto* generated = generated_entry(name_of(name));
    return generated ? generated->package : "spirula-studio";
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
    if (!f && !generated_entry(name)) return false;
    const fs::path p = path(name);
    std::error_code ec;
    if (!fs::is_regular_file(p,ec) || fs::is_symlink(p,ec)) return false;
    std::string expected;
    if (f) {
        if (fs::file_size(p,ec) != f->bytes) return false;
        expected = f->sha256;
    } else {
        const fs::path sidecar = p.string()+".sha256";
        if (!fs::is_regular_file(sidecar,ec) || fs::is_symlink(sidecar,ec) || fs::file_size(sidecar,ec) != 65) return false;
        std::ifstream input(sidecar); input >> expected;
        if (expected.size()!=64 || expected.find_first_not_of("0123456789abcdef")!=std::string::npos) return false;
    }
    const auto stamp = fs::last_write_time(p,ec); if (ec) return false;
    static std::mutex mutex;
    static std::unordered_map<std::string,std::pair<fs::file_time_type,std::string>> valid;
    std::lock_guard<std::mutex> lock(mutex);
    if (valid.count(name) && valid[name] == std::make_pair(stamp,expected)) return true;
    if (spirula::sha256_file(p.string()) != expected) return false;
    valid[name] = {stamp,expected};
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
