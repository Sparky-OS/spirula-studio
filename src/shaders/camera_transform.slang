#ifndef _CAMERA_TRANSFORM_SLANG_INC
#define _CAMERA_TRANSFORM_SLANG_INC

[ForceInline]
bool camera_transform_is_rigid(float3x3 R) {
    float3x3 gram = mul(R,transpose(R));
    float error = 0;
    [ForceUnroll] for (int r = 0; r < 3; ++r)
        [ForceUnroll] for (int c = 0; c < 3; ++c)
            error = max(error,abs(gram[r][c]-(r==c ? 1.f : 0.f)));
    return error <= 1e-6f;
}

[ForceInline]
[Differentiable]
float3x3 camera_transform_inverse(float3x3 R) {
    // Float rotations retain the original arithmetic; an oblique projection needs the inverse.
    if (camera_transform_is_rigid(detach<float3x3>(R))) return transpose(R);
    float3 a = cross(R[1],R[2]);
    float3 b = cross(R[2],R[0]);
    float3 c = cross(R[0],R[1]);
    return transpose(float3x3(a,b,c)) / dot(R[0],a);
}

#endif
