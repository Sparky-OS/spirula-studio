#include "engine/Engine.h"
#include "engine/EngineState.h"
#include "engine/EngineViewerTrace.h"
#include "shaders/screen_layout.h"
#include <stdexcept>

EngineViewerProjection engine_viewer_projection() {
    EngineViewerProjection result;
    const auto& fwd = engine().fwd;
    if (fwd.splats_s.empty()) return result;
    const auto& source = fwd.splats_s[0];
    const size_t count = fwd.gaussian_ids.data_ptr() ? (size_t)fwd.gaussian_ids.size() :
        (size_t)engine_get_cur_num_splats();
    if (source.numel() != count*SCR2_STRIDE)
        throw std::runtime_error("viewer trace: requires a single linear Gaussian projection");
    std::vector<float> screen(count*SCR2_STRIDE);
    std::vector<int32_t> ids(count);
    backend::memcpy_sync(screen.data(),source.data_ptr(),screen.size()*sizeof(float),backend::MemcpyKind::DeviceToHost);
    if (fwd.gaussian_ids.data_ptr())
        backend::memcpy_sync(ids.data(),fwd.gaussian_ids.data_ptr(),count*sizeof(int32_t),backend::MemcpyKind::DeviceToHost);
    else for (size_t i=0;i<count;++i) ids[i] = (int32_t)i;
    const int64_t maximum = engine_get_max_num_splats();
    std::vector<float> means((size_t)maximum*3);
    engine_copy_splats_to_host({(uint64_t)(uintptr_t)means.data(),4,{maximum,3}},
                              {0,0,{}},{0,0,{}},{0,0,{}},{0,0,{}},{0,0,{}});
    result.rows.reserve(count*EngineViewerProjection::stride);
    for (size_t i=0;i<count;++i) {
        const int32_t id = ids[i];
        if (id<0 || id>=maximum || id>16777215)
            throw std::runtime_error("viewer trace: invalid Gaussian identity");
        result.rows.push_back((float)id);
        result.rows.insert(result.rows.end(),means.begin()+3*id,means.begin()+3*id+3);
        result.rows.insert(result.rows.end(),screen.begin()+i*SCR2_STRIDE,screen.begin()+(i+1)*SCR2_STRIDE);
    }
    return result;
}
