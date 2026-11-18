#include "app/gui/stereo/Settings.h"
#include "config/TrainConfigJson.h"
#include <cstdio>
#include <stdexcept>
#include <string>

namespace {
void require(bool ok, const char* message) { if (!ok) throw std::runtime_error(message); }
}

int main() {
    try {
        const char* forbidden[] = {"separation","stereo_separation","eye_distance","ipd","baseline",
            "eye_swap","stereo_eye_swap","stereo_output_mode","stereo_sunk","stereo_popped","screen_plane"};
        auto& settings = gui::stereo::settings();
        require(gui::stereo::read_setting("stereo_enabled","1"),"enable 3D was rejected");
        require(gui::stereo::read_setting("stereo_eye_width","1920"),"eye resolution was rejected");
        const auto revision = settings.revision;
        TrainConfig config;
        const auto before = train_config_json_pairs(config);
        for (const char* key : forbidden) {
            require(!gui::stereo::read_setting(key,"100"),"a forbidden GUI setting became writable");
            const auto root = json_parse("{\""+std::string(key)+"\":100}");
            train_config_from_json(root,config);
            require(!train_config_json_has_fields(root),"a forbidden key is in the generic field schema");
            require(train_config_json_pairs(config) == before,"preset or generic fields changed the config");
        }
        require(settings.enabled && settings.eye_width == 1920 && settings.revision == revision,
                "unknown settings changed the stereo state");
        FILE* file = std::tmpfile();
        require(file,"settings temporary file failed");
        gui::stereo::write_settings(file); std::rewind(file);
        char text[256] = {}; const auto bytes = std::fread(text,1,sizeof(text)-1,file); std::fclose(file);
        require(std::string(text,bytes) == "stereo_enabled=1\nstereo_eye_width=1920\n",
                "the persisted stereo surface contains another setting");
        train_config_from_json(json_parse("{\"num_iterations\":101}"),config);
        require(config.num_iterations == 101,"the generic-field positive control failed");
        std::puts("stereo_options_test: two persisted keys; no separation, swap or output-mode route");
    } catch (const std::exception& error) { std::fprintf(stderr,"stereo_options_test: %s\n",error.what()); return 1; }
}
