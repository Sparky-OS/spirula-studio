#pragma once

#include "core/Env.h"
#include <cstdio>
#include <cstdint>
#include <stdexcept>
#include <string>
#include <vector>

namespace spirula::stereo {

inline const char* pair_trace_directory() {
    return env_on("GUI_AUTOMATION") ? env("GUI_PAIR_CAPTURE") : nullptr;
}

inline void trace_bytes(const std::string& path, const void* data, size_t size) {
    FILE* out = std::fopen(path.c_str(),"wb");
    if (!out) throw std::runtime_error("viewer trace: cannot open " + path);
    const bool written = std::fwrite(data,1,size,out) == size;
    const bool closed = std::fclose(out) == 0;
    if (!written || !closed) throw std::runtime_error("viewer trace: cannot write " + path);
}

inline void write_pair_trace(const char* directory, uint64_t id, int step, int width, int height,
                             double convergence, double scale, double focal, double cx, double cy,
                             double offset, const float* view, const std::vector<float>& depth,
                             const std::vector<float>& transmittance,
                             const std::vector<uint8_t>& centre, const std::vector<uint8_t>& pair,
                             const std::vector<float>& centre_projection,
                             const std::vector<float>& left_projection,
                             const std::vector<float>& right_projection) {
    const std::string base = std::string(directory) + "/pair-" + std::to_string(id%4);
    trace_bytes(base+".depth",depth.data(),depth.size()*sizeof(float));
    trace_bytes(base+".transmittance",transmittance.data(),transmittance.size()*sizeof(float));
    trace_bytes(base+".centre",centre.data(),centre.size());
    trace_bytes(base+".rgb",pair.data(),pair.size());
    trace_bytes(base+".centre-projection",centre_projection.data(),centre_projection.size()*sizeof(float));
    trace_bytes(base+".left-projection",left_projection.data(),left_projection.size()*sizeof(float));
    trace_bytes(base+".right-projection",right_projection.data(),right_projection.size()*sizeof(float));
    FILE* out = std::fopen((base+".json").c_str(),"w");
    if (!out) throw std::runtime_error("viewer trace: cannot open " + base + ".json");
    std::fprintf(out,"{\"request\":%llu,\"step\":%d,\"width\":%d,\"height\":%d,"
        "\"convergence\":%.17g,\"scale\":%.17g,\"focal\":%.17g,\"cx\":%.17g,\"cy\":%.17g,"
        "\"right_offset\":%.17g,\"view\":[",(unsigned long long)id,step,width,height,
        convergence,scale,focal,cx,cy,offset);
    for (int i=0;i<12;++i) std::fprintf(out,"%s%.9g",i ? "," : "",view[i]);
    std::fprintf(out,"]}\n");
    if (std::fclose(out)) throw std::runtime_error("viewer trace: cannot close " + base + ".json");
    std::fprintf(stderr,"[stereo-trace] request=%llu step=%d path=%s\n",
                 (unsigned long long)id,step,base.c_str());
}

}  // namespace spirula::stereo
