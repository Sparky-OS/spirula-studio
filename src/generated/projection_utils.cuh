#pragma once

#include "generated/slang.cuh"

inline __device__ Matrix<float, 3, 3>  transpose_0(Matrix<float, 3, 3>  x_0)
{
    Matrix<float, 3, 3>  result_0;
    int r_0 = int(0);
    for(;;)
    {
        if(r_0 < int(3))
        {
        }
        else
        {
            break;
        }
        int c_0 = int(0);
        for(;;)
        {
            if(c_0 < int(3))
            {
            }
            else
            {
                break;
            }
            *_slang_vector_get_element_ptr(((&result_0)->rows + (r_0)), c_0) = _slang_vector_get_element(x_0.rows[c_0], r_0);
            c_0 = c_0 + int(1);
        }
        r_0 = r_0 + int(1);
    }
    return result_0;
}

inline __device__ Matrix<float, 2, 2>  transpose_1(Matrix<float, 2, 2>  x_1)
{
    Matrix<float, 2, 2>  result_1;
    int r_1 = int(0);
    for(;;)
    {
        if(r_1 < int(2))
        {
        }
        else
        {
            break;
        }
        int c_1 = int(0);
        for(;;)
        {
            if(c_1 < int(2))
            {
            }
            else
            {
                break;
            }
            *_slang_vector_get_element_ptr(((&result_1)->rows + (r_1)), c_1) = _slang_vector_get_element(x_1.rows[c_1], r_1);
            c_1 = c_1 + int(1);
        }
        r_1 = r_1 + int(1);
    }
    return result_1;
}

inline __device__ Matrix<float, 3, 3>  normalized_quat_to_rotmat(float4  quat_0)
{
    float x_2 = quat_0.y;
    float x2_0 = x_2 * x_2;
    float y2_0 = quat_0.z * quat_0.z;
    float z2_0 = quat_0.w * quat_0.w;
    float xy_0 = quat_0.y * quat_0.z;
    float xz_0 = quat_0.y * quat_0.w;
    float yz_0 = quat_0.z * quat_0.w;
    float wx_0 = quat_0.x * quat_0.y;
    float wy_0 = quat_0.x * quat_0.z;
    float wz_0 = quat_0.x * quat_0.w;
    return transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_0 + z2_0), 2.0f * (xy_0 + wz_0), 2.0f * (xz_0 - wy_0), 2.0f * (xy_0 - wz_0), 1.0f - 2.0f * (x2_0 + z2_0), 2.0f * (yz_0 + wx_0), 2.0f * (xz_0 + wy_0), 2.0f * (yz_0 - wx_0), 1.0f - 2.0f * (x2_0 + y2_0)));
}

struct DiffPair_matrixx3Cfloatx2C3x2C3x3E_0
{
    Matrix<float, 3, 3>  primal_0;
    Matrix<float, 3, 3>  differential_0;
};

inline __device__ void mul_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * left_0, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * right_0, Matrix<float, 3, 3>  dOut_0)
{
    Matrix<float, 3, 3>  left_d_result_0;
    *&(((&left_d_result_0)->rows + (int(0)))->x) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(0)))->y) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(0)))->z) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(1)))->x) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(1)))->y) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(1)))->z) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(2)))->x) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(2)))->y) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(2)))->z) = 0.0f;
    Matrix<float, 3, 3>  right_d_result_0;
    *&(((&right_d_result_0)->rows + (int(0)))->x) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(0)))->y) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(0)))->z) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(1)))->x) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(1)))->y) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(1)))->z) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(2)))->x) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(2)))->y) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(2)))->z) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(0)))->x) = *&(((&left_d_result_0)->rows + (int(0)))->x) + (*right_0).primal_0.rows[int(0)].x * dOut_0.rows[int(0)].x;
    *&(((&right_d_result_0)->rows + (int(0)))->x) = *&(((&right_d_result_0)->rows + (int(0)))->x) + (*left_0).primal_0.rows[int(0)].x * dOut_0.rows[int(0)].x;
    *&(((&left_d_result_0)->rows + (int(0)))->y) = *&(((&left_d_result_0)->rows + (int(0)))->y) + (*right_0).primal_0.rows[int(1)].x * dOut_0.rows[int(0)].x;
    *&(((&right_d_result_0)->rows + (int(1)))->x) = *&(((&right_d_result_0)->rows + (int(1)))->x) + (*left_0).primal_0.rows[int(0)].y * dOut_0.rows[int(0)].x;
    *&(((&left_d_result_0)->rows + (int(0)))->z) = *&(((&left_d_result_0)->rows + (int(0)))->z) + (*right_0).primal_0.rows[int(2)].x * dOut_0.rows[int(0)].x;
    *&(((&right_d_result_0)->rows + (int(2)))->x) = *&(((&right_d_result_0)->rows + (int(2)))->x) + (*left_0).primal_0.rows[int(0)].z * dOut_0.rows[int(0)].x;
    *&(((&left_d_result_0)->rows + (int(0)))->x) = *&(((&left_d_result_0)->rows + (int(0)))->x) + (*right_0).primal_0.rows[int(0)].y * dOut_0.rows[int(0)].y;
    *&(((&right_d_result_0)->rows + (int(0)))->y) = *&(((&right_d_result_0)->rows + (int(0)))->y) + (*left_0).primal_0.rows[int(0)].x * dOut_0.rows[int(0)].y;
    *&(((&left_d_result_0)->rows + (int(0)))->y) = *&(((&left_d_result_0)->rows + (int(0)))->y) + (*right_0).primal_0.rows[int(1)].y * dOut_0.rows[int(0)].y;
    *&(((&right_d_result_0)->rows + (int(1)))->y) = *&(((&right_d_result_0)->rows + (int(1)))->y) + (*left_0).primal_0.rows[int(0)].y * dOut_0.rows[int(0)].y;
    *&(((&left_d_result_0)->rows + (int(0)))->z) = *&(((&left_d_result_0)->rows + (int(0)))->z) + (*right_0).primal_0.rows[int(2)].y * dOut_0.rows[int(0)].y;
    *&(((&right_d_result_0)->rows + (int(2)))->y) = *&(((&right_d_result_0)->rows + (int(2)))->y) + (*left_0).primal_0.rows[int(0)].z * dOut_0.rows[int(0)].y;
    *&(((&left_d_result_0)->rows + (int(0)))->x) = *&(((&left_d_result_0)->rows + (int(0)))->x) + (*right_0).primal_0.rows[int(0)].z * dOut_0.rows[int(0)].z;
    *&(((&right_d_result_0)->rows + (int(0)))->z) = *&(((&right_d_result_0)->rows + (int(0)))->z) + (*left_0).primal_0.rows[int(0)].x * dOut_0.rows[int(0)].z;
    *&(((&left_d_result_0)->rows + (int(0)))->y) = *&(((&left_d_result_0)->rows + (int(0)))->y) + (*right_0).primal_0.rows[int(1)].z * dOut_0.rows[int(0)].z;
    *&(((&right_d_result_0)->rows + (int(1)))->z) = *&(((&right_d_result_0)->rows + (int(1)))->z) + (*left_0).primal_0.rows[int(0)].y * dOut_0.rows[int(0)].z;
    *&(((&left_d_result_0)->rows + (int(0)))->z) = *&(((&left_d_result_0)->rows + (int(0)))->z) + (*right_0).primal_0.rows[int(2)].z * dOut_0.rows[int(0)].z;
    *&(((&right_d_result_0)->rows + (int(2)))->z) = *&(((&right_d_result_0)->rows + (int(2)))->z) + (*left_0).primal_0.rows[int(0)].z * dOut_0.rows[int(0)].z;
    *&(((&left_d_result_0)->rows + (int(1)))->x) = *&(((&left_d_result_0)->rows + (int(1)))->x) + (*right_0).primal_0.rows[int(0)].x * dOut_0.rows[int(1)].x;
    *&(((&right_d_result_0)->rows + (int(0)))->x) = *&(((&right_d_result_0)->rows + (int(0)))->x) + (*left_0).primal_0.rows[int(1)].x * dOut_0.rows[int(1)].x;
    *&(((&left_d_result_0)->rows + (int(1)))->y) = *&(((&left_d_result_0)->rows + (int(1)))->y) + (*right_0).primal_0.rows[int(1)].x * dOut_0.rows[int(1)].x;
    *&(((&right_d_result_0)->rows + (int(1)))->x) = *&(((&right_d_result_0)->rows + (int(1)))->x) + (*left_0).primal_0.rows[int(1)].y * dOut_0.rows[int(1)].x;
    *&(((&left_d_result_0)->rows + (int(1)))->z) = *&(((&left_d_result_0)->rows + (int(1)))->z) + (*right_0).primal_0.rows[int(2)].x * dOut_0.rows[int(1)].x;
    *&(((&right_d_result_0)->rows + (int(2)))->x) = *&(((&right_d_result_0)->rows + (int(2)))->x) + (*left_0).primal_0.rows[int(1)].z * dOut_0.rows[int(1)].x;
    *&(((&left_d_result_0)->rows + (int(1)))->x) = *&(((&left_d_result_0)->rows + (int(1)))->x) + (*right_0).primal_0.rows[int(0)].y * dOut_0.rows[int(1)].y;
    *&(((&right_d_result_0)->rows + (int(0)))->y) = *&(((&right_d_result_0)->rows + (int(0)))->y) + (*left_0).primal_0.rows[int(1)].x * dOut_0.rows[int(1)].y;
    *&(((&left_d_result_0)->rows + (int(1)))->y) = *&(((&left_d_result_0)->rows + (int(1)))->y) + (*right_0).primal_0.rows[int(1)].y * dOut_0.rows[int(1)].y;
    *&(((&right_d_result_0)->rows + (int(1)))->y) = *&(((&right_d_result_0)->rows + (int(1)))->y) + (*left_0).primal_0.rows[int(1)].y * dOut_0.rows[int(1)].y;
    *&(((&left_d_result_0)->rows + (int(1)))->z) = *&(((&left_d_result_0)->rows + (int(1)))->z) + (*right_0).primal_0.rows[int(2)].y * dOut_0.rows[int(1)].y;
    *&(((&right_d_result_0)->rows + (int(2)))->y) = *&(((&right_d_result_0)->rows + (int(2)))->y) + (*left_0).primal_0.rows[int(1)].z * dOut_0.rows[int(1)].y;
    *&(((&left_d_result_0)->rows + (int(1)))->x) = *&(((&left_d_result_0)->rows + (int(1)))->x) + (*right_0).primal_0.rows[int(0)].z * dOut_0.rows[int(1)].z;
    *&(((&right_d_result_0)->rows + (int(0)))->z) = *&(((&right_d_result_0)->rows + (int(0)))->z) + (*left_0).primal_0.rows[int(1)].x * dOut_0.rows[int(1)].z;
    *&(((&left_d_result_0)->rows + (int(1)))->y) = *&(((&left_d_result_0)->rows + (int(1)))->y) + (*right_0).primal_0.rows[int(1)].z * dOut_0.rows[int(1)].z;
    *&(((&right_d_result_0)->rows + (int(1)))->z) = *&(((&right_d_result_0)->rows + (int(1)))->z) + (*left_0).primal_0.rows[int(1)].y * dOut_0.rows[int(1)].z;
    *&(((&left_d_result_0)->rows + (int(1)))->z) = *&(((&left_d_result_0)->rows + (int(1)))->z) + (*right_0).primal_0.rows[int(2)].z * dOut_0.rows[int(1)].z;
    *&(((&right_d_result_0)->rows + (int(2)))->z) = *&(((&right_d_result_0)->rows + (int(2)))->z) + (*left_0).primal_0.rows[int(1)].z * dOut_0.rows[int(1)].z;
    *&(((&left_d_result_0)->rows + (int(2)))->x) = *&(((&left_d_result_0)->rows + (int(2)))->x) + (*right_0).primal_0.rows[int(0)].x * dOut_0.rows[int(2)].x;
    *&(((&right_d_result_0)->rows + (int(0)))->x) = *&(((&right_d_result_0)->rows + (int(0)))->x) + (*left_0).primal_0.rows[int(2)].x * dOut_0.rows[int(2)].x;
    *&(((&left_d_result_0)->rows + (int(2)))->y) = *&(((&left_d_result_0)->rows + (int(2)))->y) + (*right_0).primal_0.rows[int(1)].x * dOut_0.rows[int(2)].x;
    *&(((&right_d_result_0)->rows + (int(1)))->x) = *&(((&right_d_result_0)->rows + (int(1)))->x) + (*left_0).primal_0.rows[int(2)].y * dOut_0.rows[int(2)].x;
    *&(((&left_d_result_0)->rows + (int(2)))->z) = *&(((&left_d_result_0)->rows + (int(2)))->z) + (*right_0).primal_0.rows[int(2)].x * dOut_0.rows[int(2)].x;
    *&(((&right_d_result_0)->rows + (int(2)))->x) = *&(((&right_d_result_0)->rows + (int(2)))->x) + (*left_0).primal_0.rows[int(2)].z * dOut_0.rows[int(2)].x;
    *&(((&left_d_result_0)->rows + (int(2)))->x) = *&(((&left_d_result_0)->rows + (int(2)))->x) + (*right_0).primal_0.rows[int(0)].y * dOut_0.rows[int(2)].y;
    *&(((&right_d_result_0)->rows + (int(0)))->y) = *&(((&right_d_result_0)->rows + (int(0)))->y) + (*left_0).primal_0.rows[int(2)].x * dOut_0.rows[int(2)].y;
    *&(((&left_d_result_0)->rows + (int(2)))->y) = *&(((&left_d_result_0)->rows + (int(2)))->y) + (*right_0).primal_0.rows[int(1)].y * dOut_0.rows[int(2)].y;
    *&(((&right_d_result_0)->rows + (int(1)))->y) = *&(((&right_d_result_0)->rows + (int(1)))->y) + (*left_0).primal_0.rows[int(2)].y * dOut_0.rows[int(2)].y;
    *&(((&left_d_result_0)->rows + (int(2)))->z) = *&(((&left_d_result_0)->rows + (int(2)))->z) + (*right_0).primal_0.rows[int(2)].y * dOut_0.rows[int(2)].y;
    *&(((&right_d_result_0)->rows + (int(2)))->y) = *&(((&right_d_result_0)->rows + (int(2)))->y) + (*left_0).primal_0.rows[int(2)].z * dOut_0.rows[int(2)].y;
    *&(((&left_d_result_0)->rows + (int(2)))->x) = *&(((&left_d_result_0)->rows + (int(2)))->x) + (*right_0).primal_0.rows[int(0)].z * dOut_0.rows[int(2)].z;
    *&(((&right_d_result_0)->rows + (int(0)))->z) = *&(((&right_d_result_0)->rows + (int(0)))->z) + (*left_0).primal_0.rows[int(2)].x * dOut_0.rows[int(2)].z;
    *&(((&left_d_result_0)->rows + (int(2)))->y) = *&(((&left_d_result_0)->rows + (int(2)))->y) + (*right_0).primal_0.rows[int(1)].z * dOut_0.rows[int(2)].z;
    *&(((&right_d_result_0)->rows + (int(1)))->z) = *&(((&right_d_result_0)->rows + (int(1)))->z) + (*left_0).primal_0.rows[int(2)].y * dOut_0.rows[int(2)].z;
    *&(((&left_d_result_0)->rows + (int(2)))->z) = *&(((&left_d_result_0)->rows + (int(2)))->z) + (*right_0).primal_0.rows[int(2)].z * dOut_0.rows[int(2)].z;
    *&(((&right_d_result_0)->rows + (int(2)))->z) = *&(((&right_d_result_0)->rows + (int(2)))->z) + (*left_0).primal_0.rows[int(2)].z * dOut_0.rows[int(2)].z;
    left_0->primal_0 = (*left_0).primal_0;
    left_0->differential_0 = left_d_result_0;
    right_0->primal_0 = (*right_0).primal_0;
    right_0->differential_0 = right_d_result_0;
    return;
}

inline __device__ Matrix<float, 3, 3>  mul_1(Matrix<float, 3, 3>  left_1, Matrix<float, 3, 3>  right_1)
{
    Matrix<float, 3, 3>  result_2;
    int r_2 = int(0);
    for(;;)
    {
        if(r_2 < int(3))
        {
        }
        else
        {
            break;
        }
        int c_2 = int(0);
        for(;;)
        {
            if(c_2 < int(3))
            {
            }
            else
            {
                break;
            }
            int i_0 = int(0);
            float sum_0 = 0.0f;
            for(;;)
            {
                if(i_0 < int(3))
                {
                }
                else
                {
                    break;
                }
                float sum_1 = sum_0 + _slang_vector_get_element(left_1.rows[r_2], i_0) * _slang_vector_get_element(right_1.rows[i_0], c_2);
                i_0 = i_0 + int(1);
                sum_0 = sum_1;
            }
            *_slang_vector_get_element_ptr(((&result_2)->rows + (r_2)), c_2) = sum_0;
            c_2 = c_2 + int(1);
        }
        r_2 = r_2 + int(1);
    }
    return result_2;
}

inline __device__ void quat_scale_to_covar(float4  quat_1, float3  scale_0, Matrix<float, 3, 3>  * covar_0)
{
    float x_3 = quat_1.y;
    float x2_1 = x_3 * x_3;
    float y2_1 = quat_1.z * quat_1.z;
    float z2_1 = quat_1.w * quat_1.w;
    float xy_1 = quat_1.y * quat_1.z;
    float xz_1 = quat_1.y * quat_1.w;
    float yz_1 = quat_1.z * quat_1.w;
    float wx_1 = quat_1.x * quat_1.y;
    float wy_1 = quat_1.x * quat_1.z;
    float wz_1 = quat_1.x * quat_1.w;
    Matrix<float, 3, 3>  M_0 = mul_1(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_1 + z2_1), 2.0f * (xy_1 + wz_1), 2.0f * (xz_1 - wy_1), 2.0f * (xy_1 - wz_1), 1.0f - 2.0f * (x2_1 + z2_1), 2.0f * (yz_1 + wx_1), 2.0f * (xz_1 + wy_1), 2.0f * (yz_1 - wx_1), 1.0f - 2.0f * (x2_1 + y2_1))), makeMatrix<float, 3, 3> (scale_0.x, 0.0f, 0.0f, 0.0f, scale_0.y, 0.0f, 0.0f, 0.0f, scale_0.z));
    *covar_0 = mul_1(M_0, transpose_0(M_0));
    return;
}

inline __device__ void quat_scale_to_sqrt_covar(float4  quat_2, float3  scale_1, Matrix<float, 3, 3>  * M_1)
{
    float x_4 = quat_2.y;
    float x2_2 = x_4 * x_4;
    float y2_2 = quat_2.z * quat_2.z;
    float z2_2 = quat_2.w * quat_2.w;
    float xy_2 = quat_2.y * quat_2.z;
    float xz_2 = quat_2.y * quat_2.w;
    float yz_2 = quat_2.z * quat_2.w;
    float wx_2 = quat_2.x * quat_2.y;
    float wy_2 = quat_2.x * quat_2.z;
    float wz_2 = quat_2.x * quat_2.w;
    *M_1 = mul_1(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_2 + z2_2), 2.0f * (xy_2 + wz_2), 2.0f * (xz_2 - wy_2), 2.0f * (xy_2 - wz_2), 1.0f - 2.0f * (x2_2 + z2_2), 2.0f * (yz_2 + wx_2), 2.0f * (xz_2 + wy_2), 2.0f * (yz_2 - wx_2), 1.0f - 2.0f * (x2_2 + y2_2))), makeMatrix<float, 3, 3> (scale_1.x, 0.0f, 0.0f, 0.0f, scale_1.y, 0.0f, 0.0f, 0.0f, scale_1.z));
    return;
}

struct DiffPair_vectorx3Cfloatx2C3x3E_0
{
    float3  primal_0;
    float3  differential_0;
};

inline __device__ void _d_mul_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * left_2, DiffPair_vectorx3Cfloatx2C3x3E_0 * right_2, float3  dOut_1)
{
    float _S1 = (*left_2).primal_0.rows[int(0)].x * dOut_1.x;
    Matrix<float, 3, 3>  left_d_result_1;
    *&(((&left_d_result_1)->rows + (int(0)))->x) = (*right_2).primal_0.x * dOut_1.x;
    float sum_2 = _S1 + (*left_2).primal_0.rows[int(1)].x * dOut_1.y;
    *&(((&left_d_result_1)->rows + (int(1)))->x) = (*right_2).primal_0.x * dOut_1.y;
    float sum_3 = sum_2 + (*left_2).primal_0.rows[int(2)].x * dOut_1.z;
    *&(((&left_d_result_1)->rows + (int(2)))->x) = (*right_2).primal_0.x * dOut_1.z;
    float3  right_d_result_1;
    *&((&right_d_result_1)->x) = sum_3;
    float _S2 = (*left_2).primal_0.rows[int(0)].y * dOut_1.x;
    *&(((&left_d_result_1)->rows + (int(0)))->y) = (*right_2).primal_0.y * dOut_1.x;
    float sum_4 = _S2 + (*left_2).primal_0.rows[int(1)].y * dOut_1.y;
    *&(((&left_d_result_1)->rows + (int(1)))->y) = (*right_2).primal_0.y * dOut_1.y;
    float sum_5 = sum_4 + (*left_2).primal_0.rows[int(2)].y * dOut_1.z;
    *&(((&left_d_result_1)->rows + (int(2)))->y) = (*right_2).primal_0.y * dOut_1.z;
    *&((&right_d_result_1)->y) = sum_5;
    float _S3 = (*left_2).primal_0.rows[int(0)].z * dOut_1.x;
    *&(((&left_d_result_1)->rows + (int(0)))->z) = (*right_2).primal_0.z * dOut_1.x;
    float sum_6 = _S3 + (*left_2).primal_0.rows[int(1)].z * dOut_1.y;
    *&(((&left_d_result_1)->rows + (int(1)))->z) = (*right_2).primal_0.z * dOut_1.y;
    float sum_7 = sum_6 + (*left_2).primal_0.rows[int(2)].z * dOut_1.z;
    *&(((&left_d_result_1)->rows + (int(2)))->z) = (*right_2).primal_0.z * dOut_1.z;
    *&((&right_d_result_1)->z) = sum_7;
    left_2->primal_0 = (*left_2).primal_0;
    left_2->differential_0 = left_d_result_1;
    right_2->primal_0 = (*right_2).primal_0;
    right_2->differential_0 = right_d_result_1;
    return;
}

inline __device__ float3  mul_2(Matrix<float, 3, 3>  left_3, float3  right_3)
{
    float3  result_3;
    int i_1 = int(0);
    for(;;)
    {
        if(i_1 < int(3))
        {
        }
        else
        {
            break;
        }
        int j_0 = int(0);
        float sum_8 = 0.0f;
        for(;;)
        {
            if(j_0 < int(3))
            {
            }
            else
            {
                break;
            }
            float sum_9 = sum_8 + _slang_vector_get_element(left_3.rows[i_1], j_0) * _slang_vector_get_element(right_3, j_0);
            j_0 = j_0 + int(1);
            sum_8 = sum_9;
        }
        *_slang_vector_get_element_ptr(&result_3, i_1) = sum_8;
        i_1 = i_1 + int(1);
    }
    return result_3;
}

inline __device__ float3  apply_sqrt_covar_to_vec(float4  quat_3, float3  scale_2, float3  vec_0)
{
    float x_5 = quat_3.y;
    float x2_3 = x_5 * x_5;
    float y2_3 = quat_3.z * quat_3.z;
    float z2_3 = quat_3.w * quat_3.w;
    float xy_3 = quat_3.y * quat_3.z;
    float xz_3 = quat_3.y * quat_3.w;
    float yz_3 = quat_3.z * quat_3.w;
    float wx_3 = quat_3.x * quat_3.y;
    float wy_3 = quat_3.x * quat_3.z;
    float wz_3 = quat_3.x * quat_3.w;
    return mul_2(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_3 + z2_3), 2.0f * (xy_3 + wz_3), 2.0f * (xz_3 - wy_3), 2.0f * (xy_3 - wz_3), 1.0f - 2.0f * (x2_3 + z2_3), 2.0f * (yz_3 + wx_3), 2.0f * (xz_3 + wy_3), 2.0f * (yz_3 - wx_3), 1.0f - 2.0f * (x2_3 + y2_3))), scale_2 * vec_0);
}

inline __device__ float3  apply_covar_to_vec(float4  quat_4, float3  scale_3, float3  vec_1)
{
    float x_6 = quat_4.y;
    float x2_4 = x_6 * x_6;
    float y2_4 = quat_4.z * quat_4.z;
    float z2_4 = quat_4.w * quat_4.w;
    float xy_4 = quat_4.y * quat_4.z;
    float xz_4 = quat_4.y * quat_4.w;
    float yz_4 = quat_4.z * quat_4.w;
    float wx_4 = quat_4.x * quat_4.y;
    float wy_4 = quat_4.x * quat_4.z;
    float wz_4 = quat_4.x * quat_4.w;
    Matrix<float, 3, 3>  M_2 = mul_1(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_4 + z2_4), 2.0f * (xy_4 + wz_4), 2.0f * (xz_4 - wy_4), 2.0f * (xy_4 - wz_4), 1.0f - 2.0f * (x2_4 + z2_4), 2.0f * (yz_4 + wx_4), 2.0f * (xz_4 + wy_4), 2.0f * (yz_4 - wx_4), 1.0f - 2.0f * (x2_4 + y2_4))), makeMatrix<float, 3, 3> (scale_3.x, 0.0f, 0.0f, 0.0f, scale_3.y, 0.0f, 0.0f, 0.0f, scale_3.z));
    return mul_2(mul_1(M_2, transpose_0(M_2)), vec_1);
}

struct DiffPair_float_0
{
    float primal_0;
    float differential_0;
};

inline __device__ DiffPair_float_0 _d_atan2_0(DiffPair_float_0 * dpy_0, DiffPair_float_0 * dpx_0)
{
    float _S4 = dpx_0->primal_0 * dpx_0->primal_0 + dpy_0->primal_0 * dpy_0->primal_0;
    DiffPair_float_0 _S5 = { (F32_atan2((dpy_0->primal_0), (dpx_0->primal_0))), - dpy_0->primal_0 / _S4 * dpx_0->differential_0 + dpx_0->primal_0 / _S4 * dpy_0->differential_0 };
    return _S5;
}

inline __device__ void _d_max_0(DiffPair_float_0 * dpx_1, DiffPair_float_0 * dpy_1, float dOut_2)
{
    DiffPair_float_0 _S6 = *dpx_1;
    float _S7;
    if(((*dpx_1).primal_0) > ((*dpy_1).primal_0))
    {
        _S7 = dOut_2;
    }
    else
    {
        if(((*dpx_1).primal_0) < ((*dpy_1).primal_0))
        {
            _S7 = 0.0f;
        }
        else
        {
            _S7 = 0.5f * dOut_2;
        }
    }
    dpx_1->primal_0 = _S6.primal_0;
    dpx_1->differential_0 = _S7;
    DiffPair_float_0 _S8 = *dpy_1;
    if(((*dpy_1).primal_0) > (_S6.primal_0))
    {
        _S7 = dOut_2;
    }
    else
    {
        if(((*dpy_1).primal_0) < ((*dpx_1).primal_0))
        {
            _S7 = 0.0f;
        }
        else
        {
            _S7 = 0.5f * dOut_2;
        }
    }
    dpy_1->primal_0 = _S8.primal_0;
    dpy_1->differential_0 = _S7;
    return;
}

inline __device__ DiffPair_float_0 _d_sqrt_0(DiffPair_float_0 * dpx_2)
{
    DiffPair_float_0 _S9 = { (F32_sqrt((dpx_2->primal_0))), 0.5f / (F32_sqrt(((F32_max((1.00000001168609742e-07f), (dpx_2->primal_0)))))) * dpx_2->differential_0 };
    return _S9;
}

inline __device__ void _d_dot_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dpx_3, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpy_2, float dOut_3)
{
    float3  x_d_result_0;
    *&((&x_d_result_0)->x) = (*dpy_2).primal_0.x * dOut_3;
    float3  y_d_result_0;
    *&((&y_d_result_0)->x) = (*dpx_3).primal_0.x * dOut_3;
    *&((&x_d_result_0)->y) = (*dpy_2).primal_0.y * dOut_3;
    *&((&y_d_result_0)->y) = (*dpx_3).primal_0.y * dOut_3;
    *&((&x_d_result_0)->z) = (*dpy_2).primal_0.z * dOut_3;
    *&((&y_d_result_0)->z) = (*dpx_3).primal_0.z * dOut_3;
    dpx_3->primal_0 = (*dpx_3).primal_0;
    dpx_3->differential_0 = x_d_result_0;
    dpy_2->primal_0 = (*dpy_2).primal_0;
    dpy_2->differential_0 = y_d_result_0;
    return;
}

inline __device__ float dot_0(float2  x_7, float2  y_0)
{
    int i_2 = int(0);
    float result_4 = 0.0f;
    for(;;)
    {
        if(i_2 < int(2))
        {
        }
        else
        {
            break;
        }
        float result_5 = result_4 + _slang_vector_get_element(x_7, i_2) * _slang_vector_get_element(y_0, i_2);
        i_2 = i_2 + int(1);
        result_4 = result_5;
    }
    return result_4;
}

inline __device__ float dot_1(float3  x_8, float3  y_1)
{
    int i_3 = int(0);
    float result_6 = 0.0f;
    for(;;)
    {
        if(i_3 < int(3))
        {
        }
        else
        {
            break;
        }
        float result_7 = result_6 + _slang_vector_get_element(x_8, i_3) * _slang_vector_get_element(y_1, i_3);
        i_3 = i_3 + int(1);
        result_6 = result_7;
    }
    return result_6;
}

inline __device__ float length_0(float2  x_9)
{
    return (F32_sqrt((dot_0(x_9, x_9))));
}

inline __device__ float length_1(float3  x_10)
{
    return (F32_sqrt((dot_1(x_10, x_10))));
}

inline __device__ bool equirect_proj_nav(float3  p_view_0, float4  intrins_0, float2  * uv_0)
{
    *uv_0 = make_float2 (intrins_0.x * (F32_atan2((p_view_0.x), (p_view_0.z))) + intrins_0.z, intrins_0.y * (F32_atan2((p_view_0.y), (length_0(float2 {p_view_0.x, p_view_0.z})))) + intrins_0.w);
    return true;
}

struct DiffPair_vectorx3Cfloatx2C2x3E_0
{
    float2  primal_0;
    float2  differential_0;
};

inline __device__ DiffPair_float_0 s_fwd_length_impl_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpx_4)
{
    float _S10 = *&((&dpx_4->differential_0)->x) * *&((&dpx_4->primal_0)->x);
    float _S11 = *&((&dpx_4->differential_0)->y) * *&((&dpx_4->primal_0)->y);
    float s_diff_len_0 = _S10 + _S10 + (_S11 + _S11);
    DiffPair_float_0 _S12;
    (&_S12)->primal_0 = *&((&dpx_4->primal_0)->x) * *&((&dpx_4->primal_0)->x) + *&((&dpx_4->primal_0)->y) * *&((&dpx_4->primal_0)->y);
    (&_S12)->differential_0 = s_diff_len_0;
    DiffPair_float_0 _S13 = _d_sqrt_0(&_S12);
    DiffPair_float_0 _S14 = { _S13.primal_0, _S13.differential_0 };
    return _S14;
}

inline __device__ Matrix<float, 2, 3>  equirect_proj_jac(float3  p_view_1, float4  intrins_1)
{
    float _S15 = p_view_1.x;
    float _S16 = p_view_1.z;
    DiffPair_float_0 _S17;
    (&_S17)->primal_0 = _S15;
    (&_S17)->differential_0 = 1.0f;
    DiffPair_float_0 _S18;
    (&_S18)->primal_0 = _S16;
    (&_S18)->differential_0 = 0.0f;
    DiffPair_float_0 _S19 = _d_atan2_0(&_S17, &_S18);
    float _S20 = p_view_1.y;
    float2  _S21 = float2 {p_view_1.x, p_view_1.z};
    float2  _S22 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S23;
    (&_S23)->primal_0 = _S21;
    (&_S23)->differential_0 = _S22;
    DiffPair_float_0 _S24 = s_fwd_length_impl_0(&_S23);
    DiffPair_float_0 _S25;
    (&_S25)->primal_0 = _S20;
    (&_S25)->differential_0 = 0.0f;
    DiffPair_float_0 _S26;
    (&_S26)->primal_0 = _S24.primal_0;
    (&_S26)->differential_0 = _S24.differential_0;
    DiffPair_float_0 _S27 = _d_atan2_0(&_S25, &_S26);
    float fx_0 = intrins_1.x;
    float fy_0 = intrins_1.y;
    float _S28 = _S27.differential_0 * fy_0;
    Matrix<float, 2, 3>  J_0;
    *&(((&J_0)->rows + (int(0)))->x) = _S19.differential_0 * fx_0;
    *&(((&J_0)->rows + (int(1)))->x) = _S28;
    DiffPair_float_0 _S29;
    (&_S29)->primal_0 = _S15;
    (&_S29)->differential_0 = 0.0f;
    DiffPair_float_0 _S30;
    (&_S30)->primal_0 = _S16;
    (&_S30)->differential_0 = 0.0f;
    DiffPair_float_0 _S31 = _d_atan2_0(&_S29, &_S30);
    float2  _S32 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S33;
    (&_S33)->primal_0 = _S21;
    (&_S33)->differential_0 = _S32;
    DiffPair_float_0 _S34 = s_fwd_length_impl_0(&_S33);
    DiffPair_float_0 _S35;
    (&_S35)->primal_0 = _S20;
    (&_S35)->differential_0 = 1.0f;
    DiffPair_float_0 _S36;
    (&_S36)->primal_0 = _S34.primal_0;
    (&_S36)->differential_0 = _S34.differential_0;
    DiffPair_float_0 _S37 = _d_atan2_0(&_S35, &_S36);
    float _S38 = _S37.differential_0 * fy_0;
    *&(((&J_0)->rows + (int(0)))->y) = _S31.differential_0 * fx_0;
    *&(((&J_0)->rows + (int(1)))->y) = _S38;
    DiffPair_float_0 _S39;
    (&_S39)->primal_0 = _S15;
    (&_S39)->differential_0 = 0.0f;
    DiffPair_float_0 _S40;
    (&_S40)->primal_0 = _S16;
    (&_S40)->differential_0 = 1.0f;
    DiffPair_float_0 _S41 = _d_atan2_0(&_S39, &_S40);
    float2  _S42 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S43;
    (&_S43)->primal_0 = _S21;
    (&_S43)->differential_0 = _S42;
    DiffPair_float_0 _S44 = s_fwd_length_impl_0(&_S43);
    DiffPair_float_0 _S45;
    (&_S45)->primal_0 = _S20;
    (&_S45)->differential_0 = 0.0f;
    DiffPair_float_0 _S46;
    (&_S46)->primal_0 = _S44.primal_0;
    (&_S46)->differential_0 = _S44.differential_0;
    DiffPair_float_0 _S47 = _d_atan2_0(&_S45, &_S46);
    float _S48 = _S47.differential_0 * fy_0;
    *&(((&J_0)->rows + (int(0)))->z) = _S41.differential_0 * fx_0;
    *&(((&J_0)->rows + (int(1)))->z) = _S48;
    return J_0;
}

inline __device__ float determinant_0(Matrix<float, 2, 2>  m_0)
{
    return m_0.rows[int(0)].x * m_0.rows[int(1)].y - m_0.rows[int(0)].y * m_0.rows[int(1)].x;
}

inline __device__ bool is_valid_distortion_none(float2  uv_1, FixedArray<float, 1>  dist_coeffs_0)
{
    return true;
}

inline __device__ float2  DistNone_distort_0(float2  uv_2, FixedArray<float, 1>  * coeffs_0)
{
    return uv_2;
}

inline __device__ bool persp_proj_nav_none(float3  p_view_2, float4  intrins_2, FixedArray<float, 1>  dist_coeffs_1, float2  * uv_3)
{
    bool _S49;
    for(;;)
    {
        float2  _S50 = float2 {p_view_2.x, p_view_2.y};
        float _S51 = p_view_2.z;
        float2  uv0_0 = _S50 / make_float2 (_S51);
        bool _S52 = _S51 < 0.0f;
        if(_S52)
        {
            *uv_3 = uv0_0;
            _S49 = false;
            break;
        }
        float2  uv_4 = _S50 / make_float2 (_S51);
        FixedArray<float, 1>  _S53 = dist_coeffs_1;
        float2  _S54 = DistNone_distort_0(uv_4, &_S53);
        *uv_3 = make_float2 (intrins_2.x * _S54.x + intrins_2.z, intrins_2.y * _S54.y + intrins_2.w);
        _S49 = true;
        break;
    }
    return _S49;
}

inline __device__ bool fisheye_proj_nav_none(float3  p_view_3, float4  intrins_3, FixedArray<float, 1>  dist_coeffs_2, float2  * uv_5)
{
    float2  _S55 = float2 {p_view_3.x, p_view_3.y};
    float r_3 = length_0(_S55);
    float _S56 = p_view_3.z;
    float theta_0 = (F32_atan2((r_3), (_S56)));
    float k_0;
    if(theta_0 < 0.00100000004749745f)
    {
        k_0 = (1.0f - theta_0 * theta_0 / 3.0f) / _S56;
    }
    else
    {
        k_0 = theta_0 / r_3;
    }
    float2  _S57 = _S55 * make_float2 (k_0);
    FixedArray<float, 1>  _S58 = dist_coeffs_2;
    float2  _S59 = DistNone_distort_0(_S57, &_S58);
    *uv_5 = make_float2 (intrins_3.x * _S59.x + intrins_3.z, intrins_3.y * _S59.y + intrins_3.w);
    return true;
}

inline __device__ DiffPair_float_0 _d_sin_0(DiffPair_float_0 * dpx_5)
{
    DiffPair_float_0 _S60 = { (F32_sin((dpx_5->primal_0))), (F32_cos((dpx_5->primal_0))) * dpx_5->differential_0 };
    return _S60;
}

inline __device__ bool equisolid_proj_nav_none(float3  p_view_4, float4  intrins_4, FixedArray<float, 1>  dist_coeffs_3, float2  * uv_6)
{
    float2  _S61 = float2 {p_view_4.x, p_view_4.y};
    float r_4 = length_0(_S61);
    float _S62 = p_view_4.z;
    float theta_1 = (F32_atan2((r_4), (_S62)));
    float k_1;
    if(r_4 < 9.99999997475242708e-07f)
    {
        k_1 = (1.0f - theta_1 * theta_1 / 24.0f) / _S62;
    }
    else
    {
        k_1 = 2.0f * (F32_sin((0.5f * theta_1))) / r_4;
    }
    float2  _S63 = _S61 * make_float2 (k_1);
    FixedArray<float, 1>  _S64 = dist_coeffs_3;
    float2  _S65 = DistNone_distort_0(_S63, &_S64);
    *uv_6 = make_float2 (intrins_4.x * _S65.x + intrins_4.z, intrins_4.y * _S65.y + intrins_4.w);
    return true;
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistNone_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_0, FixedArray<float, 1>  * coeffs_1)
{
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S66 = { dpuv_0->primal_0, dpuv_0->differential_0 };
    return _S66;
}

inline __device__ Matrix<float, 2, 3>  persp_proj_jac_none(float3  p_view_5, float4  intrins_5, FixedArray<float, 1>  dist_coeffs_4)
{
    float2  _S67 = float2 {p_view_5.x, p_view_5.y};
    float _S68 = p_view_5.z;
    float2  _S69 = _S67 * make_float2 (0.0f);
    float _S70 = _S68 * _S68;
    float2  s_diff_uv_0 = (make_float2 (1.0f, 0.0f) * make_float2 (_S68) - _S69) / make_float2 (_S70);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S71;
    (&_S71)->primal_0 = _S67 / make_float2 (_S68);
    (&_S71)->differential_0 = s_diff_uv_0;
    FixedArray<float, 1>  _S72 = dist_coeffs_4;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S73 = s_fwd_DistNone_distort_0(&_S71, &_S72);
    float fx_1 = intrins_5.x;
    float fy_1 = intrins_5.y;
    float _S74 = _S73.differential_0.y * fy_1;
    Matrix<float, 2, 3>  J_1;
    *&(((&J_1)->rows + (int(0)))->x) = _S73.differential_0.x * fx_1;
    *&(((&J_1)->rows + (int(1)))->x) = _S74;
    float2  s_diff_uv_1 = (make_float2 (0.0f, 1.0f) * make_float2 (_S68) - _S69) / make_float2 (_S70);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S75;
    (&_S75)->primal_0 = _S67 / make_float2 (_S68);
    (&_S75)->differential_0 = s_diff_uv_1;
    FixedArray<float, 1>  _S76 = dist_coeffs_4;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S77 = s_fwd_DistNone_distort_0(&_S75, &_S76);
    float _S78 = _S77.differential_0.y * fy_1;
    *&(((&J_1)->rows + (int(0)))->y) = _S77.differential_0.x * fx_1;
    *&(((&J_1)->rows + (int(1)))->y) = _S78;
    float2  s_diff_uv_2 = (make_float2 (0.0f, 0.0f) * make_float2 (_S68) - _S67) / make_float2 (_S70);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S79;
    (&_S79)->primal_0 = _S67 / make_float2 (_S68);
    (&_S79)->differential_0 = s_diff_uv_2;
    FixedArray<float, 1>  _S80 = dist_coeffs_4;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S81 = s_fwd_DistNone_distort_0(&_S79, &_S80);
    float _S82 = _S81.differential_0.y * fy_1;
    *&(((&J_1)->rows + (int(0)))->z) = _S81.differential_0.x * fx_1;
    *&(((&J_1)->rows + (int(1)))->z) = _S82;
    return J_1;
}

inline __device__ Matrix<float, 2, 3>  fisheye_proj_jac_none(float3  p_view_6, float4  intrins_6, FixedArray<float, 1>  dist_coeffs_5)
{
    Matrix<float, 2, 3>  J_2;
    float2  _S83 = float2 {p_view_6.x, p_view_6.y};
    float2  _S84 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S85;
    (&_S85)->primal_0 = _S83;
    (&_S85)->differential_0 = _S84;
    DiffPair_float_0 _S86 = s_fwd_length_impl_0(&_S85);
    float _S87 = p_view_6.z;
    DiffPair_float_0 _S88;
    (&_S88)->primal_0 = _S86.primal_0;
    (&_S88)->differential_0 = _S86.differential_0;
    DiffPair_float_0 _S89;
    (&_S89)->primal_0 = _S87;
    (&_S89)->differential_0 = 0.0f;
    DiffPair_float_0 _S90 = _d_atan2_0(&_S88, &_S89);
    float k_2;
    float s_diff_k_0;
    if((_S90.primal_0) < 0.00100000004749745f)
    {
        float _S91 = _S90.differential_0 * _S90.primal_0;
        float _S92 = 1.0f - _S90.primal_0 * _S90.primal_0 / 3.0f;
        float _S93 = ((0.0f - (_S91 + _S91) * 0.3333333432674408f) * _S87 - _S92 * 0.0f) / (_S87 * _S87);
        k_2 = _S92 / _S87;
        s_diff_k_0 = _S93;
    }
    else
    {
        float _S94 = (_S90.differential_0 * _S86.primal_0 - _S90.primal_0 * _S86.differential_0) / (_S86.primal_0 * _S86.primal_0);
        k_2 = _S90.primal_0 / _S86.primal_0;
        s_diff_k_0 = _S94;
    }
    float2  _S95 = _S83 * make_float2 (k_2);
    float2  _S96 = _S84 * make_float2 (k_2) + make_float2 (s_diff_k_0) * _S83;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S97;
    (&_S97)->primal_0 = _S95;
    (&_S97)->differential_0 = _S96;
    FixedArray<float, 1>  _S98 = dist_coeffs_5;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S99 = s_fwd_DistNone_distort_0(&_S97, &_S98);
    float fx_2 = intrins_6.x;
    float fy_2 = intrins_6.y;
    float _S100 = _S99.differential_0.y * fy_2;
    *&(((&J_2)->rows + (int(0)))->x) = _S99.differential_0.x * fx_2;
    *&(((&J_2)->rows + (int(1)))->x) = _S100;
    float2  _S101 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S102;
    (&_S102)->primal_0 = _S83;
    (&_S102)->differential_0 = _S101;
    DiffPair_float_0 _S103 = s_fwd_length_impl_0(&_S102);
    DiffPair_float_0 _S104;
    (&_S104)->primal_0 = _S103.primal_0;
    (&_S104)->differential_0 = _S103.differential_0;
    DiffPair_float_0 _S105;
    (&_S105)->primal_0 = _S87;
    (&_S105)->differential_0 = 0.0f;
    DiffPair_float_0 _S106 = _d_atan2_0(&_S104, &_S105);
    if((_S106.primal_0) < 0.00100000004749745f)
    {
        float _S107 = _S106.differential_0 * _S106.primal_0;
        float _S108 = 1.0f - _S106.primal_0 * _S106.primal_0 / 3.0f;
        float _S109 = ((0.0f - (_S107 + _S107) * 0.3333333432674408f) * _S87 - _S108 * 0.0f) / (_S87 * _S87);
        k_2 = _S108 / _S87;
        s_diff_k_0 = _S109;
    }
    else
    {
        float _S110 = (_S106.differential_0 * _S103.primal_0 - _S106.primal_0 * _S103.differential_0) / (_S103.primal_0 * _S103.primal_0);
        k_2 = _S106.primal_0 / _S103.primal_0;
        s_diff_k_0 = _S110;
    }
    float2  _S111 = _S83 * make_float2 (k_2);
    float2  _S112 = _S101 * make_float2 (k_2) + make_float2 (s_diff_k_0) * _S83;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S113;
    (&_S113)->primal_0 = _S111;
    (&_S113)->differential_0 = _S112;
    FixedArray<float, 1>  _S114 = dist_coeffs_5;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S115 = s_fwd_DistNone_distort_0(&_S113, &_S114);
    float _S116 = _S115.differential_0.y * fy_2;
    *&(((&J_2)->rows + (int(0)))->y) = _S115.differential_0.x * fx_2;
    *&(((&J_2)->rows + (int(1)))->y) = _S116;
    float2  _S117 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S118;
    (&_S118)->primal_0 = _S83;
    (&_S118)->differential_0 = _S117;
    DiffPair_float_0 _S119 = s_fwd_length_impl_0(&_S118);
    DiffPair_float_0 _S120;
    (&_S120)->primal_0 = _S119.primal_0;
    (&_S120)->differential_0 = _S119.differential_0;
    DiffPair_float_0 _S121;
    (&_S121)->primal_0 = _S87;
    (&_S121)->differential_0 = 1.0f;
    DiffPair_float_0 _S122 = _d_atan2_0(&_S120, &_S121);
    if((_S122.primal_0) < 0.00100000004749745f)
    {
        float _S123 = _S122.differential_0 * _S122.primal_0;
        float _S124 = 1.0f - _S122.primal_0 * _S122.primal_0 / 3.0f;
        float _S125 = ((0.0f - (_S123 + _S123) * 0.3333333432674408f) * _S87 - _S124) / (_S87 * _S87);
        k_2 = _S124 / _S87;
        s_diff_k_0 = _S125;
    }
    else
    {
        float _S126 = (_S122.differential_0 * _S119.primal_0 - _S122.primal_0 * _S119.differential_0) / (_S119.primal_0 * _S119.primal_0);
        k_2 = _S122.primal_0 / _S119.primal_0;
        s_diff_k_0 = _S126;
    }
    float2  _S127 = _S83 * make_float2 (k_2);
    float2  _S128 = _S117 * make_float2 (k_2) + make_float2 (s_diff_k_0) * _S83;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S129;
    (&_S129)->primal_0 = _S127;
    (&_S129)->differential_0 = _S128;
    FixedArray<float, 1>  _S130 = dist_coeffs_5;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S131 = s_fwd_DistNone_distort_0(&_S129, &_S130);
    float _S132 = _S131.differential_0.y * fy_2;
    *&(((&J_2)->rows + (int(0)))->z) = _S131.differential_0.x * fx_2;
    *&(((&J_2)->rows + (int(1)))->z) = _S132;
    return J_2;
}

inline __device__ Matrix<float, 2, 3>  equisolid_proj_jac_none(float3  p_view_7, float4  intrins_7, FixedArray<float, 1>  dist_coeffs_6)
{
    Matrix<float, 2, 3>  J_3;
    float2  _S133 = float2 {p_view_7.x, p_view_7.y};
    float2  _S134 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S135;
    (&_S135)->primal_0 = _S133;
    (&_S135)->differential_0 = _S134;
    DiffPair_float_0 _S136 = s_fwd_length_impl_0(&_S135);
    float _S137 = p_view_7.z;
    DiffPair_float_0 _S138;
    (&_S138)->primal_0 = _S136.primal_0;
    (&_S138)->differential_0 = _S136.differential_0;
    DiffPair_float_0 _S139;
    (&_S139)->primal_0 = _S137;
    (&_S139)->differential_0 = 0.0f;
    DiffPair_float_0 _S140 = _d_atan2_0(&_S138, &_S139);
    float k_3;
    float s_diff_k_1;
    if((_S136.primal_0) < 9.99999997475242708e-07f)
    {
        float _S141 = _S140.differential_0 * _S140.primal_0;
        float _S142 = 1.0f - _S140.primal_0 * _S140.primal_0 / 24.0f;
        float _S143 = ((0.0f - (_S141 + _S141) * 0.0416666679084301f) * _S137 - _S142 * 0.0f) / (_S137 * _S137);
        k_3 = _S142 / _S137;
        s_diff_k_1 = _S143;
    }
    else
    {
        float _S144 = _S140.differential_0 * 0.5f;
        DiffPair_float_0 _S145;
        (&_S145)->primal_0 = 0.5f * _S140.primal_0;
        (&_S145)->differential_0 = _S144;
        DiffPair_float_0 _S146 = _d_sin_0(&_S145);
        float _S147 = 2.0f * _S146.primal_0;
        float _S148 = (_S146.differential_0 * 2.0f * _S136.primal_0 - _S147 * _S136.differential_0) / (_S136.primal_0 * _S136.primal_0);
        k_3 = _S147 / _S136.primal_0;
        s_diff_k_1 = _S148;
    }
    float2  _S149 = _S133 * make_float2 (k_3);
    float2  _S150 = _S134 * make_float2 (k_3) + make_float2 (s_diff_k_1) * _S133;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S151;
    (&_S151)->primal_0 = _S149;
    (&_S151)->differential_0 = _S150;
    FixedArray<float, 1>  _S152 = dist_coeffs_6;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S153 = s_fwd_DistNone_distort_0(&_S151, &_S152);
    float fx_3 = intrins_7.x;
    float fy_3 = intrins_7.y;
    float _S154 = _S153.differential_0.y * fy_3;
    *&(((&J_3)->rows + (int(0)))->x) = _S153.differential_0.x * fx_3;
    *&(((&J_3)->rows + (int(1)))->x) = _S154;
    float2  _S155 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S156;
    (&_S156)->primal_0 = _S133;
    (&_S156)->differential_0 = _S155;
    DiffPair_float_0 _S157 = s_fwd_length_impl_0(&_S156);
    DiffPair_float_0 _S158;
    (&_S158)->primal_0 = _S157.primal_0;
    (&_S158)->differential_0 = _S157.differential_0;
    DiffPair_float_0 _S159;
    (&_S159)->primal_0 = _S137;
    (&_S159)->differential_0 = 0.0f;
    DiffPair_float_0 _S160 = _d_atan2_0(&_S158, &_S159);
    if((_S157.primal_0) < 9.99999997475242708e-07f)
    {
        float _S161 = _S160.differential_0 * _S160.primal_0;
        float _S162 = 1.0f - _S160.primal_0 * _S160.primal_0 / 24.0f;
        float _S163 = ((0.0f - (_S161 + _S161) * 0.0416666679084301f) * _S137 - _S162 * 0.0f) / (_S137 * _S137);
        k_3 = _S162 / _S137;
        s_diff_k_1 = _S163;
    }
    else
    {
        float _S164 = _S160.differential_0 * 0.5f;
        DiffPair_float_0 _S165;
        (&_S165)->primal_0 = 0.5f * _S160.primal_0;
        (&_S165)->differential_0 = _S164;
        DiffPair_float_0 _S166 = _d_sin_0(&_S165);
        float _S167 = 2.0f * _S166.primal_0;
        float _S168 = (_S166.differential_0 * 2.0f * _S157.primal_0 - _S167 * _S157.differential_0) / (_S157.primal_0 * _S157.primal_0);
        k_3 = _S167 / _S157.primal_0;
        s_diff_k_1 = _S168;
    }
    float2  _S169 = _S133 * make_float2 (k_3);
    float2  _S170 = _S155 * make_float2 (k_3) + make_float2 (s_diff_k_1) * _S133;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S171;
    (&_S171)->primal_0 = _S169;
    (&_S171)->differential_0 = _S170;
    FixedArray<float, 1>  _S172 = dist_coeffs_6;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S173 = s_fwd_DistNone_distort_0(&_S171, &_S172);
    float _S174 = _S173.differential_0.y * fy_3;
    *&(((&J_3)->rows + (int(0)))->y) = _S173.differential_0.x * fx_3;
    *&(((&J_3)->rows + (int(1)))->y) = _S174;
    float2  _S175 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S176;
    (&_S176)->primal_0 = _S133;
    (&_S176)->differential_0 = _S175;
    DiffPair_float_0 _S177 = s_fwd_length_impl_0(&_S176);
    DiffPair_float_0 _S178;
    (&_S178)->primal_0 = _S177.primal_0;
    (&_S178)->differential_0 = _S177.differential_0;
    DiffPair_float_0 _S179;
    (&_S179)->primal_0 = _S137;
    (&_S179)->differential_0 = 1.0f;
    DiffPair_float_0 _S180 = _d_atan2_0(&_S178, &_S179);
    if((_S177.primal_0) < 9.99999997475242708e-07f)
    {
        float _S181 = _S180.differential_0 * _S180.primal_0;
        float _S182 = 1.0f - _S180.primal_0 * _S180.primal_0 / 24.0f;
        float _S183 = ((0.0f - (_S181 + _S181) * 0.0416666679084301f) * _S137 - _S182) / (_S137 * _S137);
        k_3 = _S182 / _S137;
        s_diff_k_1 = _S183;
    }
    else
    {
        float _S184 = _S180.differential_0 * 0.5f;
        DiffPair_float_0 _S185;
        (&_S185)->primal_0 = 0.5f * _S180.primal_0;
        (&_S185)->differential_0 = _S184;
        DiffPair_float_0 _S186 = _d_sin_0(&_S185);
        float _S187 = 2.0f * _S186.primal_0;
        float _S188 = (_S186.differential_0 * 2.0f * _S177.primal_0 - _S187 * _S177.differential_0) / (_S177.primal_0 * _S177.primal_0);
        k_3 = _S187 / _S177.primal_0;
        s_diff_k_1 = _S188;
    }
    float2  _S189 = _S133 * make_float2 (k_3);
    float2  _S190 = _S175 * make_float2 (k_3) + make_float2 (s_diff_k_1) * _S133;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S191;
    (&_S191)->primal_0 = _S189;
    (&_S191)->differential_0 = _S190;
    FixedArray<float, 1>  _S192 = dist_coeffs_6;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S193 = s_fwd_DistNone_distort_0(&_S191, &_S192);
    float _S194 = _S193.differential_0.y * fy_3;
    *&(((&J_3)->rows + (int(0)))->z) = _S193.differential_0.x * fx_3;
    *&(((&J_3)->rows + (int(1)))->z) = _S194;
    return J_3;
}

inline __device__ float2  distort_point_none(float2  uv_7, int camera_model_0, FixedArray<float, 1>  dist_coeffs_7)
{
    float2  _S195;
    for(;;)
    {
        if(camera_model_0 == int(3))
        {
            _S195 = uv_7;
            break;
        }
        float k_4;
        if(camera_model_0 == int(1))
        {
            float r_5 = length_0(uv_7);
            float theta_2 = (F32_atan((r_5)));
            if(r_5 < 0.00100000004749745f)
            {
                k_4 = 1.0f - theta_2 * theta_2 / 6.0f;
            }
            else
            {
                k_4 = theta_2 / r_5;
            }
            _S195 = uv_7 * make_float2 (k_4);
        }
        else
        {
            if(camera_model_0 == int(2))
            {
                float r_6 = length_0(uv_7);
                float theta_3 = (F32_atan((r_6)));
                if(r_6 < 0.00100000004749745f)
                {
                    k_4 = 1.0f - theta_3 * theta_3 / 24.0f;
                }
                else
                {
                    k_4 = 2.0f * (F32_sin((0.5f * theta_3))) / r_6;
                }
                _S195 = uv_7 * make_float2 (k_4);
            }
            else
            {
                _S195 = uv_7;
            }
        }
        FixedArray<float, 1>  _S196 = dist_coeffs_7;
        float2  _S197 = DistNone_distort_0(_S195, &_S196);
        _S195 = _S197;
        break;
    }
    return _S195;
}

inline __device__ bool undistort_point_0(float2  uv_8, FixedArray<float, 1>  * dist_coeffs_8, int maxiter_0, float2  * uv_undist_0)
{
    *uv_undist_0 = uv_8;
    return true;
}

inline __device__ float2  DistOpenCV_distort_0(float2  uv_9, FixedArray<float, 4>  * coeffs_2)
{
    float u_0 = uv_9.x;
    float v_0 = uv_9.y;
    float r2_0 = u_0 * u_0 + v_0 * v_0;
    return uv_9 * make_float2 (1.0f + r2_0 * ((*coeffs_2)[int(0)] + r2_0 * (*coeffs_2)[int(1)])) + make_float2 (2.0f * (*coeffs_2)[int(2)] * u_0 * v_0 + (*coeffs_2)[int(3)] * (r2_0 + 2.0f * u_0 * u_0), 2.0f * (*coeffs_2)[int(3)] * u_0 * v_0 + (*coeffs_2)[int(2)] * (r2_0 + 2.0f * v_0 * v_0));
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistOpenCV_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_1, FixedArray<float, 4>  * coeffs_3)
{
    float u_1 = dpuv_1->primal_0.x;
    float s_diff_u_0 = dpuv_1->differential_0.x;
    float v_1 = dpuv_1->primal_0.y;
    float s_diff_v_0 = dpuv_1->differential_0.y;
    float _S198 = s_diff_u_0 * u_1;
    float _S199 = s_diff_v_0 * v_1;
    float r2_1 = u_1 * u_1 + v_1 * v_1;
    float s_diff_r2_0 = _S198 + _S198 + (_S199 + _S199);
    float _S200 = (*coeffs_3)[int(0)] + r2_1 * (*coeffs_3)[int(1)];
    float radial_0 = 1.0f + r2_1 * _S200;
    float _S201 = 2.0f * (*coeffs_3)[int(2)];
    float _S202 = _S201 * u_1;
    float _S203 = 2.0f * u_1;
    float _S204 = 2.0f * (*coeffs_3)[int(3)];
    float _S205 = _S204 * u_1;
    float _S206 = 2.0f * v_1;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S207 = { dpuv_1->primal_0 * make_float2 (radial_0) + make_float2 (_S202 * v_1 + (*coeffs_3)[int(3)] * (r2_1 + _S203 * u_1), _S205 * v_1 + (*coeffs_3)[int(2)] * (r2_1 + _S206 * v_1)), dpuv_1->differential_0 * make_float2 (radial_0) + make_float2 (s_diff_r2_0 * _S200 + s_diff_r2_0 * (*coeffs_3)[int(1)] * r2_1) * dpuv_1->primal_0 + make_float2 (s_diff_u_0 * _S201 * v_1 + s_diff_v_0 * _S202 + (s_diff_r2_0 + (s_diff_u_0 * 2.0f * u_1 + s_diff_u_0 * _S203)) * (*coeffs_3)[int(3)], s_diff_u_0 * _S204 * v_1 + s_diff_v_0 * _S205 + (s_diff_r2_0 + (s_diff_v_0 * 2.0f * v_1 + s_diff_v_0 * _S206)) * (*coeffs_3)[int(2)]) };
    return _S207;
}

inline __device__ bool undistort_point_1(float2  uv_10, FixedArray<float, 4>  * dist_coeffs_9, int maxiter_1, float2  * uv_undist_1)
{
    int i_4 = int(0);
    float2  q_0 = uv_10;
    for(;;)
    {
        if(i_4 < maxiter_1)
        {
        }
        else
        {
            break;
        }
        float2  _S208 = DistOpenCV_distort_0(q_0, dist_coeffs_9);
        float2  r_7 = _S208 - uv_10;
        float2  _S209 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S210;
        (&_S210)->primal_0 = q_0;
        (&_S210)->differential_0 = _S209;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S211 = s_fwd_DistOpenCV_distort_0(&_S210, dist_coeffs_9);
        float2  _S212 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S213;
        (&_S213)->primal_0 = q_0;
        (&_S213)->differential_0 = _S212;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S214 = s_fwd_DistOpenCV_distort_0(&_S213, dist_coeffs_9);
        Matrix<float, 2, 2>  _S215 = transpose_1(makeMatrix<float, 2, 2> (_S211.differential_0, _S214.differential_0));
        float inv_det_0 = 1.0f / (_S215.rows[int(0)].x * _S215.rows[int(1)].y - _S215.rows[int(0)].y * _S215.rows[int(1)].x);
        float _S216 = r_7.x;
        float _S217 = r_7.y;
        float2  q_1 = q_0 - make_float2 ((_S216 * _S215.rows[int(1)].y - _S217 * _S215.rows[int(0)].y) * inv_det_0, (- _S216 * _S215.rows[int(1)].x + _S217 * _S215.rows[int(0)].x) * inv_det_0);
        i_4 = i_4 + int(1);
        q_0 = q_1;
    }
    *uv_undist_1 = q_0;
    float2  _S218 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S219;
    (&_S219)->primal_0 = q_0;
    (&_S219)->differential_0 = _S218;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S220 = s_fwd_DistOpenCV_distort_0(&_S219, dist_coeffs_9);
    float2  _S221 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S222;
    (&_S222)->primal_0 = q_0;
    (&_S222)->differential_0 = _S221;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S223 = s_fwd_DistOpenCV_distort_0(&_S222, dist_coeffs_9);
    Matrix<float, 2, 2>  _S224 = transpose_1(makeMatrix<float, 2, 2> (_S220.differential_0, _S223.differential_0));
    float _S225 = (F32_min((determinant_0(_S224)), ((F32_min((_S224.rows[int(0)].x), (_S224.rows[int(1)].y))))));
    bool _S226;
    if(_S225 > 0.25f)
    {
        _S226 = _S225 < 4.0f;
    }
    else
    {
        _S226 = false;
    }
    if(_S226)
    {
        float2  _S227 = DistOpenCV_distort_0(q_0, dist_coeffs_9);
        _S226 = (dot_0(q_0, _S227)) >= 0.0f;
    }
    else
    {
        _S226 = false;
    }
    if(_S226)
    {
        float2  _S228 = DistOpenCV_distort_0(*uv_undist_1, dist_coeffs_9);
        _S226 = (length_0(_S228 - uv_10)) < 0.00999999977648258f;
    }
    else
    {
        _S226 = false;
    }
    return _S226;
}

inline __device__ float2  DistThinPrism_distort_0(float2  uv_11, FixedArray<float, 8>  * coeffs_4)
{
    float u_2 = uv_11.x;
    float v_2 = uv_11.y;
    float r2_2 = u_2 * u_2 + v_2 * v_2;
    return uv_11 * make_float2 (1.0f + r2_2 * ((*coeffs_4)[int(0)] + r2_2 * ((*coeffs_4)[int(1)] + r2_2 * ((*coeffs_4)[int(2)] + r2_2 * (*coeffs_4)[int(3)])))) + make_float2 (2.0f * (*coeffs_4)[int(4)] * u_2 * v_2 + (*coeffs_4)[int(5)] * (r2_2 + 2.0f * u_2 * u_2) + (*coeffs_4)[int(6)] * r2_2, 2.0f * (*coeffs_4)[int(5)] * u_2 * v_2 + (*coeffs_4)[int(4)] * (r2_2 + 2.0f * v_2 * v_2) + (*coeffs_4)[int(7)] * r2_2);
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistThinPrism_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_2, FixedArray<float, 8>  * coeffs_5)
{
    float u_3 = dpuv_2->primal_0.x;
    float s_diff_u_1 = dpuv_2->differential_0.x;
    float v_3 = dpuv_2->primal_0.y;
    float s_diff_v_1 = dpuv_2->differential_0.y;
    float _S229 = s_diff_u_1 * u_3;
    float _S230 = s_diff_v_1 * v_3;
    float r2_3 = u_3 * u_3 + v_3 * v_3;
    float s_diff_r2_1 = _S229 + _S229 + (_S230 + _S230);
    float _S231 = (*coeffs_5)[int(2)] + r2_3 * (*coeffs_5)[int(3)];
    float _S232 = (*coeffs_5)[int(1)] + r2_3 * _S231;
    float _S233 = (*coeffs_5)[int(0)] + r2_3 * _S232;
    float radial_1 = 1.0f + r2_3 * _S233;
    float _S234 = 2.0f * (*coeffs_5)[int(4)];
    float _S235 = _S234 * u_3;
    float _S236 = 2.0f * u_3;
    float _S237 = 2.0f * (*coeffs_5)[int(5)];
    float _S238 = _S237 * u_3;
    float _S239 = 2.0f * v_3;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S240 = { dpuv_2->primal_0 * make_float2 (radial_1) + make_float2 (_S235 * v_3 + (*coeffs_5)[int(5)] * (r2_3 + _S236 * u_3) + (*coeffs_5)[int(6)] * r2_3, _S238 * v_3 + (*coeffs_5)[int(4)] * (r2_3 + _S239 * v_3) + (*coeffs_5)[int(7)] * r2_3), dpuv_2->differential_0 * make_float2 (radial_1) + make_float2 (s_diff_r2_1 * _S233 + (s_diff_r2_1 * _S232 + (s_diff_r2_1 * _S231 + s_diff_r2_1 * (*coeffs_5)[int(3)] * r2_3) * r2_3) * r2_3) * dpuv_2->primal_0 + make_float2 (s_diff_u_1 * _S234 * v_3 + s_diff_v_1 * _S235 + (s_diff_r2_1 + (s_diff_u_1 * 2.0f * u_3 + s_diff_u_1 * _S236)) * (*coeffs_5)[int(5)] + s_diff_r2_1 * (*coeffs_5)[int(6)], s_diff_u_1 * _S237 * v_3 + s_diff_v_1 * _S238 + (s_diff_r2_1 + (s_diff_v_1 * 2.0f * v_3 + s_diff_v_1 * _S239)) * (*coeffs_5)[int(4)] + s_diff_r2_1 * (*coeffs_5)[int(7)]) };
    return _S240;
}

inline __device__ bool undistort_point_2(float2  uv_12, FixedArray<float, 8>  * dist_coeffs_10, int maxiter_2, float2  * uv_undist_2)
{
    int i_5 = int(0);
    float2  q_2 = uv_12;
    for(;;)
    {
        if(i_5 < maxiter_2)
        {
        }
        else
        {
            break;
        }
        float2  _S241 = DistThinPrism_distort_0(q_2, dist_coeffs_10);
        float2  r_8 = _S241 - uv_12;
        float2  _S242 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S243;
        (&_S243)->primal_0 = q_2;
        (&_S243)->differential_0 = _S242;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S244 = s_fwd_DistThinPrism_distort_0(&_S243, dist_coeffs_10);
        float2  _S245 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S246;
        (&_S246)->primal_0 = q_2;
        (&_S246)->differential_0 = _S245;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S247 = s_fwd_DistThinPrism_distort_0(&_S246, dist_coeffs_10);
        Matrix<float, 2, 2>  _S248 = transpose_1(makeMatrix<float, 2, 2> (_S244.differential_0, _S247.differential_0));
        float inv_det_1 = 1.0f / (_S248.rows[int(0)].x * _S248.rows[int(1)].y - _S248.rows[int(0)].y * _S248.rows[int(1)].x);
        float _S249 = r_8.x;
        float _S250 = r_8.y;
        float2  q_3 = q_2 - make_float2 ((_S249 * _S248.rows[int(1)].y - _S250 * _S248.rows[int(0)].y) * inv_det_1, (- _S249 * _S248.rows[int(1)].x + _S250 * _S248.rows[int(0)].x) * inv_det_1);
        i_5 = i_5 + int(1);
        q_2 = q_3;
    }
    *uv_undist_2 = q_2;
    float2  _S251 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S252;
    (&_S252)->primal_0 = q_2;
    (&_S252)->differential_0 = _S251;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S253 = s_fwd_DistThinPrism_distort_0(&_S252, dist_coeffs_10);
    float2  _S254 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S255;
    (&_S255)->primal_0 = q_2;
    (&_S255)->differential_0 = _S254;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S256 = s_fwd_DistThinPrism_distort_0(&_S255, dist_coeffs_10);
    Matrix<float, 2, 2>  _S257 = transpose_1(makeMatrix<float, 2, 2> (_S253.differential_0, _S256.differential_0));
    float _S258 = (F32_min((determinant_0(_S257)), ((F32_min((_S257.rows[int(0)].x), (_S257.rows[int(1)].y))))));
    bool _S259;
    if(_S258 > 0.25f)
    {
        _S259 = _S258 < 4.0f;
    }
    else
    {
        _S259 = false;
    }
    if(_S259)
    {
        float2  _S260 = DistThinPrism_distort_0(q_2, dist_coeffs_10);
        _S259 = (dot_0(q_2, _S260)) >= 0.0f;
    }
    else
    {
        _S259 = false;
    }
    if(_S259)
    {
        float2  _S261 = DistThinPrism_distort_0(*uv_undist_2, dist_coeffs_10);
        _S259 = (length_0(_S261 - uv_12)) < 0.00999999977648258f;
    }
    else
    {
        _S259 = false;
    }
    return _S259;
}

inline __device__ bool undistort_point_none(float2  uv_13, int camera_model_1, FixedArray<float, 1>  dist_coeffs_11, float2  * uv_undist_3)
{
    bool _S262;
    for(;;)
    {
        *uv_undist_3 = make_float2 (0.0f);
        if(camera_model_1 == int(3))
        {
            float lon_0 = uv_13.x;
            float lat_0 = uv_13.y;
            float cl_0 = (F32_cos((lat_0)));
            *uv_undist_3 = make_float2 (cl_0 * (F32_sin((lon_0))), (F32_sin((lat_0)))) / make_float2 ((F32_max((cl_0 * (F32_cos((lon_0)))), (9.999999960041972e-13f))));
            _S262 = true;
            break;
        }
        FixedArray<float, 1>  _S263 = dist_coeffs_11;
        float2  uv_u_0;
        bool _S264 = undistort_point_0(uv_13, &_S263, int(8), &uv_u_0);
        if(!_S264)
        {
            _S262 = false;
            break;
        }
        float2  _S265 = uv_u_0;
        float3  raydir_0;
        if(camera_model_1 == int(1))
        {
            float r_9 = length_0(_S265);
            float s_0;
            if(r_9 < 0.00100000004749745f)
            {
                s_0 = 1.0f - r_9 * r_9 / 6.0f;
            }
            else
            {
                s_0 = (F32_sin((r_9))) / r_9;
            }
            raydir_0 = make_float3 ((_S265 * make_float2 (s_0)).x, (_S265 * make_float2 (s_0)).y, (F32_cos((r_9))));
        }
        else
        {
            if(camera_model_1 == int(2))
            {
                float r_10 = length_0(_S265);
                raydir_0 = make_float3 ((_S265 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_10 * r_10)))))))).x, (_S265 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_10 * r_10)))))))).y, 1.0f - 0.5f * r_10 * r_10);
            }
            else
            {
                raydir_0 = make_float3 (_S265.x, _S265.y, 1.0f);
            }
        }
        *uv_undist_3 = float2 {raydir_0.x, raydir_0.y} / make_float2 ((F32_max((raydir_0.z), (9.999999960041972e-13f))));
        _S262 = true;
        break;
    }
    return _S262;
}

inline __device__ bool unproject_point_none(float2  uv_14, int camera_model_2, FixedArray<float, 1>  dist_coeffs_12, float3  * raydir_1)
{
    bool _S266;
    for(;;)
    {
        if(camera_model_2 == int(4))
        {
            *raydir_1 = make_float3 (0.0f, 0.0f, 1.0f);
            _S266 = true;
            break;
        }
        int3  _S267 = make_int3 (int(0));
        float3  _S268 = make_float3 ((float)_S267.x, (float)_S267.y, (float)_S267.z);
        *raydir_1 = _S268;
        if(camera_model_2 == int(3))
        {
            float lon_1 = uv_14.x;
            float lat_1 = uv_14.y;
            float cl_1 = (F32_cos((lat_1)));
            *raydir_1 = make_float3 (cl_1 * (F32_sin((lon_1))), (F32_sin((lat_1))), cl_1 * (F32_cos((lon_1))));
            _S266 = true;
            break;
        }
        FixedArray<float, 1>  _S269 = dist_coeffs_12;
        float2  uv_u_1;
        bool _S270 = undistort_point_0(uv_14, &_S269, int(8), &uv_u_1);
        if(!_S270)
        {
            _S266 = false;
            break;
        }
        float2  _S271 = uv_u_1;
        if(camera_model_2 == int(1))
        {
            float r_11 = length_0(_S271);
            float s_1;
            if(r_11 < 0.00100000004749745f)
            {
                s_1 = 1.0f - r_11 * r_11 / 6.0f;
            }
            else
            {
                s_1 = (F32_sin((r_11))) / r_11;
            }
            *raydir_1 = make_float3 ((_S271 * make_float2 (s_1)).x, (_S271 * make_float2 (s_1)).y, (F32_cos((r_11))));
        }
        else
        {
            if(camera_model_2 == int(2))
            {
                float r_12 = length_0(_S271);
                *raydir_1 = make_float3 ((_S271 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_12 * r_12)))))))).x, (_S271 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_12 * r_12)))))))).y, 1.0f - 0.5f * r_12 * r_12);
            }
            else
            {
                *raydir_1 = make_float3 (_S271.x, _S271.y, 1.0f);
            }
        }
        _S266 = true;
        break;
    }
    return _S266;
}

inline __device__ void _d_abs_0(DiffPair_float_0 * dpx_6, float dOut_4)
{
    float _S272 = _slang_select(((*dpx_6).primal_0) > 0.0f, 1.0f,_slang_select(((*dpx_6).primal_0) == 0.0f, 0.0f,-1.0f)) * dOut_4;
    dpx_6->primal_0 = (*dpx_6).primal_0;
    dpx_6->differential_0 = _S272;
    return;
}

inline __device__ float3  normalize_0(float3  x_11)
{
    return x_11 / make_float3 (length_1(x_11));
}

inline __device__ bool generate_ray_none(float2  uv_15, int camera_model_3, FixedArray<float, 1>  dist_coeffs_13, float3  * raydir_2)
{
    bool _S273;
    for(;;)
    {
        if(camera_model_3 == int(4))
        {
            *raydir_2 = make_float3 (0.0f, 0.0f, 1.0f);
            _S273 = true;
            break;
        }
        if(camera_model_3 == int(3))
        {
            float _S274 = uv_15.x;
            if((F32_abs((_S274))) > 3.14159274101257324f)
            {
                _S273 = true;
            }
            else
            {
                _S273 = (F32_abs((uv_15.y))) > 1.57079637050628662f;
            }
            if(_S273)
            {
                int3  _S275 = make_int3 (int(0));
                float3  _S276 = make_float3 ((float)_S275.x, (float)_S275.y, (float)_S275.z);
                *raydir_2 = _S276;
                _S273 = false;
                break;
            }
            float lat_2 = uv_15.y;
            float cl_2 = (F32_cos((lat_2)));
            *raydir_2 = make_float3 (cl_2 * (F32_sin((_S274))), (F32_sin((lat_2))), cl_2 * (F32_cos((_S274))));
            _S273 = true;
            break;
        }
        FixedArray<float, 1>  _S277 = dist_coeffs_13;
        float2  uv_u_2;
        bool _S278 = undistort_point_0(uv_15, &_S277, int(8), &uv_u_2);
        if(!_S278)
        {
            int3  _S279 = make_int3 (int(0));
            float3  _S280 = make_float3 ((float)_S279.x, (float)_S279.y, (float)_S279.z);
            *raydir_2 = _S280;
            _S273 = false;
            break;
        }
        float2  _S281 = uv_u_2;
        if(camera_model_3 == int(1))
        {
            float r_13 = length_0(_S281);
            if(r_13 >= 3.14159274101257324f)
            {
                int3  _S282 = make_int3 (int(0));
                float3  _S283 = make_float3 ((float)_S282.x, (float)_S282.y, (float)_S282.z);
                *raydir_2 = _S283;
                _S273 = false;
                break;
            }
            float s_2;
            if(r_13 < 0.00100000004749745f)
            {
                s_2 = 1.0f - r_13 * r_13 / 6.0f;
            }
            else
            {
                s_2 = (F32_sin((r_13))) / r_13;
            }
            *raydir_2 = make_float3 ((_S281 * make_float2 (s_2)).x, (_S281 * make_float2 (s_2)).y, (F32_cos((r_13))));
        }
        else
        {
            if(camera_model_3 == int(2))
            {
                float r_14 = length_0(_S281);
                if(r_14 >= 2.0f)
                {
                    int3  _S284 = make_int3 (int(0));
                    float3  _S285 = make_float3 ((float)_S284.x, (float)_S284.y, (float)_S284.z);
                    *raydir_2 = _S285;
                    _S273 = false;
                    break;
                }
                *raydir_2 = make_float3 ((_S281 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_14 * r_14)))))))).x, (_S281 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_14 * r_14)))))))).y, 1.0f - 0.5f * r_14 * r_14);
            }
            else
            {
                *raydir_2 = make_float3 (_S281.x, _S281.y, 1.0f);
            }
        }
        *raydir_2 = normalize_0(*raydir_2);
        _S273 = true;
        break;
    }
    return _S273;
}

inline __device__ bool is_valid_distortion_opencv(float2  uv_16, FixedArray<float, 4>  dist_coeffs_14)
{
    float2  _S286 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S287;
    (&_S287)->primal_0 = uv_16;
    (&_S287)->differential_0 = _S286;
    FixedArray<float, 4>  _S288 = dist_coeffs_14;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S289 = s_fwd_DistOpenCV_distort_0(&_S287, &_S288);
    float2  _S290 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S291;
    (&_S291)->primal_0 = uv_16;
    (&_S291)->differential_0 = _S290;
    FixedArray<float, 4>  _S292 = dist_coeffs_14;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S293 = s_fwd_DistOpenCV_distort_0(&_S291, &_S292);
    Matrix<float, 2, 2>  _S294 = transpose_1(makeMatrix<float, 2, 2> (_S289.differential_0, _S293.differential_0));
    float _S295 = (F32_min((determinant_0(_S294)), ((F32_min((_S294.rows[int(0)].x), (_S294.rows[int(1)].y))))));
    bool _S296;
    if(_S295 > 0.25f)
    {
        _S296 = _S295 < 4.0f;
    }
    else
    {
        _S296 = false;
    }
    if(_S296)
    {
        FixedArray<float, 4>  _S297 = dist_coeffs_14;
        float2  _S298 = DistOpenCV_distort_0(uv_16, &_S297);
        _S296 = (dot_0(uv_16, _S298)) >= 0.0f;
    }
    else
    {
        _S296 = false;
    }
    return _S296;
}

inline __device__ bool persp_proj_nav_opencv(float3  p_view_8, float4  intrins_8, FixedArray<float, 4>  dist_coeffs_15, float2  * uv_17)
{
    bool _S299;
    for(;;)
    {
        float2  _S300 = float2 {p_view_8.x, p_view_8.y};
        float _S301 = p_view_8.z;
        float2  uv0_1 = _S300 / make_float2 (_S301);
        if(_S301 < 0.0f)
        {
            _S299 = true;
        }
        else
        {
            float2  _S302 = make_float2 (1.0f, 0.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S303;
            (&_S303)->primal_0 = uv0_1;
            (&_S303)->differential_0 = _S302;
            FixedArray<float, 4>  _S304 = dist_coeffs_15;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S305 = s_fwd_DistOpenCV_distort_0(&_S303, &_S304);
            float2  _S306 = make_float2 (0.0f, 1.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S307;
            (&_S307)->primal_0 = uv0_1;
            (&_S307)->differential_0 = _S306;
            FixedArray<float, 4>  _S308 = dist_coeffs_15;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S309 = s_fwd_DistOpenCV_distort_0(&_S307, &_S308);
            Matrix<float, 2, 2>  _S310 = transpose_1(makeMatrix<float, 2, 2> (_S305.differential_0, _S309.differential_0));
            float _S311 = (F32_min((determinant_0(_S310)), ((F32_min((_S310.rows[int(0)].x), (_S310.rows[int(1)].y))))));
            if(_S311 > 0.25f)
            {
                _S299 = _S311 < 4.0f;
            }
            else
            {
                _S299 = false;
            }
            if(_S299)
            {
                FixedArray<float, 4>  _S312 = dist_coeffs_15;
                float2  _S313 = DistOpenCV_distort_0(uv0_1, &_S312);
                _S299 = (dot_0(uv0_1, _S313)) >= 0.0f;
            }
            else
            {
                _S299 = false;
            }
            _S299 = !_S299;
        }
        if(_S299)
        {
            *uv_17 = uv0_1;
            _S299 = false;
            break;
        }
        float2  uv_18 = _S300 / make_float2 (_S301);
        FixedArray<float, 4>  _S314 = dist_coeffs_15;
        float2  _S315 = DistOpenCV_distort_0(uv_18, &_S314);
        *uv_17 = make_float2 (intrins_8.x * _S315.x + intrins_8.z, intrins_8.y * _S315.y + intrins_8.w);
        _S299 = true;
        break;
    }
    return _S299;
}

inline __device__ bool fisheye_proj_nav_opencv(float3  p_view_9, float4  intrins_9, FixedArray<float, 4>  dist_coeffs_16, float2  * uv_19)
{
    bool _S316;
    for(;;)
    {
        float2  _S317 = float2 {p_view_9.x, p_view_9.y};
        float r_15 = length_0(_S317);
        float _S318 = p_view_9.z;
        float theta_4 = (F32_atan2((r_15), (_S318)));
        bool _S319 = theta_4 < 0.00100000004749745f;
        float k_5;
        if(_S319)
        {
            k_5 = (1.0f - theta_4 * theta_4 / 3.0f) / _S318;
        }
        else
        {
            k_5 = theta_4 / r_15;
        }
        float2  _S320 = _S317 * make_float2 (k_5);
        float2  _S321 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S322;
        (&_S322)->primal_0 = _S320;
        (&_S322)->differential_0 = _S321;
        FixedArray<float, 4>  _S323 = dist_coeffs_16;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S324 = s_fwd_DistOpenCV_distort_0(&_S322, &_S323);
        float2  _S325 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S326;
        (&_S326)->primal_0 = _S320;
        (&_S326)->differential_0 = _S325;
        FixedArray<float, 4>  _S327 = dist_coeffs_16;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S328 = s_fwd_DistOpenCV_distort_0(&_S326, &_S327);
        Matrix<float, 2, 2>  _S329 = transpose_1(makeMatrix<float, 2, 2> (_S324.differential_0, _S328.differential_0));
        float _S330 = (F32_min((determinant_0(_S329)), ((F32_min((_S329.rows[int(0)].x), (_S329.rows[int(1)].y))))));
        if(_S330 > 0.25f)
        {
            _S316 = _S330 < 4.0f;
        }
        else
        {
            _S316 = false;
        }
        if(_S316)
        {
            FixedArray<float, 4>  _S331 = dist_coeffs_16;
            float2  _S332 = DistOpenCV_distort_0(_S320, &_S331);
            _S316 = (dot_0(_S320, _S332)) >= 0.0f;
        }
        else
        {
            _S316 = false;
        }
        if(!_S316)
        {
            *uv_19 = _S320;
            _S316 = false;
            break;
        }
        if(_S319)
        {
            k_5 = (1.0f - theta_4 * theta_4 / 3.0f) / _S318;
        }
        else
        {
            k_5 = theta_4 / r_15;
        }
        float2  _S333 = _S317 * make_float2 (k_5);
        FixedArray<float, 4>  _S334 = dist_coeffs_16;
        float2  _S335 = DistOpenCV_distort_0(_S333, &_S334);
        *uv_19 = make_float2 (intrins_9.x * _S335.x + intrins_9.z, intrins_9.y * _S335.y + intrins_9.w);
        _S316 = true;
        break;
    }
    return _S316;
}

inline __device__ bool equisolid_proj_nav_opencv(float3  p_view_10, float4  intrins_10, FixedArray<float, 4>  dist_coeffs_17, float2  * uv_20)
{
    bool _S336;
    for(;;)
    {
        float2  _S337 = float2 {p_view_10.x, p_view_10.y};
        float r_16 = length_0(_S337);
        float _S338 = p_view_10.z;
        float theta_5 = (F32_atan2((r_16), (_S338)));
        bool _S339 = r_16 < 9.99999997475242708e-07f;
        float k_6;
        if(_S339)
        {
            k_6 = (1.0f - theta_5 * theta_5 / 24.0f) / _S338;
        }
        else
        {
            k_6 = 2.0f * (F32_sin((0.5f * theta_5))) / r_16;
        }
        float2  _S340 = _S337 * make_float2 (k_6);
        float2  _S341 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S342;
        (&_S342)->primal_0 = _S340;
        (&_S342)->differential_0 = _S341;
        FixedArray<float, 4>  _S343 = dist_coeffs_17;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S344 = s_fwd_DistOpenCV_distort_0(&_S342, &_S343);
        float2  _S345 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S346;
        (&_S346)->primal_0 = _S340;
        (&_S346)->differential_0 = _S345;
        FixedArray<float, 4>  _S347 = dist_coeffs_17;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S348 = s_fwd_DistOpenCV_distort_0(&_S346, &_S347);
        Matrix<float, 2, 2>  _S349 = transpose_1(makeMatrix<float, 2, 2> (_S344.differential_0, _S348.differential_0));
        float _S350 = (F32_min((determinant_0(_S349)), ((F32_min((_S349.rows[int(0)].x), (_S349.rows[int(1)].y))))));
        if(_S350 > 0.25f)
        {
            _S336 = _S350 < 4.0f;
        }
        else
        {
            _S336 = false;
        }
        if(_S336)
        {
            FixedArray<float, 4>  _S351 = dist_coeffs_17;
            float2  _S352 = DistOpenCV_distort_0(_S340, &_S351);
            _S336 = (dot_0(_S340, _S352)) >= 0.0f;
        }
        else
        {
            _S336 = false;
        }
        if(!_S336)
        {
            *uv_20 = _S340;
            _S336 = false;
            break;
        }
        if(_S339)
        {
            k_6 = (1.0f - theta_5 * theta_5 / 24.0f) / _S338;
        }
        else
        {
            k_6 = 2.0f * (F32_sin((0.5f * theta_5))) / r_16;
        }
        float2  _S353 = _S337 * make_float2 (k_6);
        FixedArray<float, 4>  _S354 = dist_coeffs_17;
        float2  _S355 = DistOpenCV_distort_0(_S353, &_S354);
        *uv_20 = make_float2 (intrins_10.x * _S355.x + intrins_10.z, intrins_10.y * _S355.y + intrins_10.w);
        _S336 = true;
        break;
    }
    return _S336;
}

inline __device__ Matrix<float, 2, 3>  persp_proj_jac_opencv(float3  p_view_11, float4  intrins_11, FixedArray<float, 4>  dist_coeffs_18)
{
    float2  _S356 = float2 {p_view_11.x, p_view_11.y};
    float _S357 = p_view_11.z;
    float2  _S358 = _S356 * make_float2 (0.0f);
    float _S359 = _S357 * _S357;
    float2  s_diff_uv_3 = (make_float2 (1.0f, 0.0f) * make_float2 (_S357) - _S358) / make_float2 (_S359);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S360;
    (&_S360)->primal_0 = _S356 / make_float2 (_S357);
    (&_S360)->differential_0 = s_diff_uv_3;
    FixedArray<float, 4>  _S361 = dist_coeffs_18;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S362 = s_fwd_DistOpenCV_distort_0(&_S360, &_S361);
    float fx_4 = intrins_11.x;
    float fy_4 = intrins_11.y;
    float _S363 = _S362.differential_0.y * fy_4;
    Matrix<float, 2, 3>  J_4;
    *&(((&J_4)->rows + (int(0)))->x) = _S362.differential_0.x * fx_4;
    *&(((&J_4)->rows + (int(1)))->x) = _S363;
    float2  s_diff_uv_4 = (make_float2 (0.0f, 1.0f) * make_float2 (_S357) - _S358) / make_float2 (_S359);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S364;
    (&_S364)->primal_0 = _S356 / make_float2 (_S357);
    (&_S364)->differential_0 = s_diff_uv_4;
    FixedArray<float, 4>  _S365 = dist_coeffs_18;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S366 = s_fwd_DistOpenCV_distort_0(&_S364, &_S365);
    float _S367 = _S366.differential_0.y * fy_4;
    *&(((&J_4)->rows + (int(0)))->y) = _S366.differential_0.x * fx_4;
    *&(((&J_4)->rows + (int(1)))->y) = _S367;
    float2  s_diff_uv_5 = (make_float2 (0.0f, 0.0f) * make_float2 (_S357) - _S356) / make_float2 (_S359);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S368;
    (&_S368)->primal_0 = _S356 / make_float2 (_S357);
    (&_S368)->differential_0 = s_diff_uv_5;
    FixedArray<float, 4>  _S369 = dist_coeffs_18;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S370 = s_fwd_DistOpenCV_distort_0(&_S368, &_S369);
    float _S371 = _S370.differential_0.y * fy_4;
    *&(((&J_4)->rows + (int(0)))->z) = _S370.differential_0.x * fx_4;
    *&(((&J_4)->rows + (int(1)))->z) = _S371;
    return J_4;
}

inline __device__ Matrix<float, 2, 3>  fisheye_proj_jac_opencv(float3  p_view_12, float4  intrins_12, FixedArray<float, 4>  dist_coeffs_19)
{
    Matrix<float, 2, 3>  J_5;
    float2  _S372 = float2 {p_view_12.x, p_view_12.y};
    float2  _S373 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S374;
    (&_S374)->primal_0 = _S372;
    (&_S374)->differential_0 = _S373;
    DiffPair_float_0 _S375 = s_fwd_length_impl_0(&_S374);
    float _S376 = p_view_12.z;
    DiffPair_float_0 _S377;
    (&_S377)->primal_0 = _S375.primal_0;
    (&_S377)->differential_0 = _S375.differential_0;
    DiffPair_float_0 _S378;
    (&_S378)->primal_0 = _S376;
    (&_S378)->differential_0 = 0.0f;
    DiffPair_float_0 _S379 = _d_atan2_0(&_S377, &_S378);
    float k_7;
    float s_diff_k_2;
    if((_S379.primal_0) < 0.00100000004749745f)
    {
        float _S380 = _S379.differential_0 * _S379.primal_0;
        float _S381 = 1.0f - _S379.primal_0 * _S379.primal_0 / 3.0f;
        float _S382 = ((0.0f - (_S380 + _S380) * 0.3333333432674408f) * _S376 - _S381 * 0.0f) / (_S376 * _S376);
        k_7 = _S381 / _S376;
        s_diff_k_2 = _S382;
    }
    else
    {
        float _S383 = (_S379.differential_0 * _S375.primal_0 - _S379.primal_0 * _S375.differential_0) / (_S375.primal_0 * _S375.primal_0);
        k_7 = _S379.primal_0 / _S375.primal_0;
        s_diff_k_2 = _S383;
    }
    float2  _S384 = _S372 * make_float2 (k_7);
    float2  _S385 = _S373 * make_float2 (k_7) + make_float2 (s_diff_k_2) * _S372;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S386;
    (&_S386)->primal_0 = _S384;
    (&_S386)->differential_0 = _S385;
    FixedArray<float, 4>  _S387 = dist_coeffs_19;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S388 = s_fwd_DistOpenCV_distort_0(&_S386, &_S387);
    float fx_5 = intrins_12.x;
    float fy_5 = intrins_12.y;
    float _S389 = _S388.differential_0.y * fy_5;
    *&(((&J_5)->rows + (int(0)))->x) = _S388.differential_0.x * fx_5;
    *&(((&J_5)->rows + (int(1)))->x) = _S389;
    float2  _S390 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S391;
    (&_S391)->primal_0 = _S372;
    (&_S391)->differential_0 = _S390;
    DiffPair_float_0 _S392 = s_fwd_length_impl_0(&_S391);
    DiffPair_float_0 _S393;
    (&_S393)->primal_0 = _S392.primal_0;
    (&_S393)->differential_0 = _S392.differential_0;
    DiffPair_float_0 _S394;
    (&_S394)->primal_0 = _S376;
    (&_S394)->differential_0 = 0.0f;
    DiffPair_float_0 _S395 = _d_atan2_0(&_S393, &_S394);
    if((_S395.primal_0) < 0.00100000004749745f)
    {
        float _S396 = _S395.differential_0 * _S395.primal_0;
        float _S397 = 1.0f - _S395.primal_0 * _S395.primal_0 / 3.0f;
        float _S398 = ((0.0f - (_S396 + _S396) * 0.3333333432674408f) * _S376 - _S397 * 0.0f) / (_S376 * _S376);
        k_7 = _S397 / _S376;
        s_diff_k_2 = _S398;
    }
    else
    {
        float _S399 = (_S395.differential_0 * _S392.primal_0 - _S395.primal_0 * _S392.differential_0) / (_S392.primal_0 * _S392.primal_0);
        k_7 = _S395.primal_0 / _S392.primal_0;
        s_diff_k_2 = _S399;
    }
    float2  _S400 = _S372 * make_float2 (k_7);
    float2  _S401 = _S390 * make_float2 (k_7) + make_float2 (s_diff_k_2) * _S372;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S402;
    (&_S402)->primal_0 = _S400;
    (&_S402)->differential_0 = _S401;
    FixedArray<float, 4>  _S403 = dist_coeffs_19;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S404 = s_fwd_DistOpenCV_distort_0(&_S402, &_S403);
    float _S405 = _S404.differential_0.y * fy_5;
    *&(((&J_5)->rows + (int(0)))->y) = _S404.differential_0.x * fx_5;
    *&(((&J_5)->rows + (int(1)))->y) = _S405;
    float2  _S406 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S407;
    (&_S407)->primal_0 = _S372;
    (&_S407)->differential_0 = _S406;
    DiffPair_float_0 _S408 = s_fwd_length_impl_0(&_S407);
    DiffPair_float_0 _S409;
    (&_S409)->primal_0 = _S408.primal_0;
    (&_S409)->differential_0 = _S408.differential_0;
    DiffPair_float_0 _S410;
    (&_S410)->primal_0 = _S376;
    (&_S410)->differential_0 = 1.0f;
    DiffPair_float_0 _S411 = _d_atan2_0(&_S409, &_S410);
    if((_S411.primal_0) < 0.00100000004749745f)
    {
        float _S412 = _S411.differential_0 * _S411.primal_0;
        float _S413 = 1.0f - _S411.primal_0 * _S411.primal_0 / 3.0f;
        float _S414 = ((0.0f - (_S412 + _S412) * 0.3333333432674408f) * _S376 - _S413) / (_S376 * _S376);
        k_7 = _S413 / _S376;
        s_diff_k_2 = _S414;
    }
    else
    {
        float _S415 = (_S411.differential_0 * _S408.primal_0 - _S411.primal_0 * _S408.differential_0) / (_S408.primal_0 * _S408.primal_0);
        k_7 = _S411.primal_0 / _S408.primal_0;
        s_diff_k_2 = _S415;
    }
    float2  _S416 = _S372 * make_float2 (k_7);
    float2  _S417 = _S406 * make_float2 (k_7) + make_float2 (s_diff_k_2) * _S372;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S418;
    (&_S418)->primal_0 = _S416;
    (&_S418)->differential_0 = _S417;
    FixedArray<float, 4>  _S419 = dist_coeffs_19;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S420 = s_fwd_DistOpenCV_distort_0(&_S418, &_S419);
    float _S421 = _S420.differential_0.y * fy_5;
    *&(((&J_5)->rows + (int(0)))->z) = _S420.differential_0.x * fx_5;
    *&(((&J_5)->rows + (int(1)))->z) = _S421;
    return J_5;
}

inline __device__ Matrix<float, 2, 3>  equisolid_proj_jac_opencv(float3  p_view_13, float4  intrins_13, FixedArray<float, 4>  dist_coeffs_20)
{
    Matrix<float, 2, 3>  J_6;
    float2  _S422 = float2 {p_view_13.x, p_view_13.y};
    float2  _S423 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S424;
    (&_S424)->primal_0 = _S422;
    (&_S424)->differential_0 = _S423;
    DiffPair_float_0 _S425 = s_fwd_length_impl_0(&_S424);
    float _S426 = p_view_13.z;
    DiffPair_float_0 _S427;
    (&_S427)->primal_0 = _S425.primal_0;
    (&_S427)->differential_0 = _S425.differential_0;
    DiffPair_float_0 _S428;
    (&_S428)->primal_0 = _S426;
    (&_S428)->differential_0 = 0.0f;
    DiffPair_float_0 _S429 = _d_atan2_0(&_S427, &_S428);
    float k_8;
    float s_diff_k_3;
    if((_S425.primal_0) < 9.99999997475242708e-07f)
    {
        float _S430 = _S429.differential_0 * _S429.primal_0;
        float _S431 = 1.0f - _S429.primal_0 * _S429.primal_0 / 24.0f;
        float _S432 = ((0.0f - (_S430 + _S430) * 0.0416666679084301f) * _S426 - _S431 * 0.0f) / (_S426 * _S426);
        k_8 = _S431 / _S426;
        s_diff_k_3 = _S432;
    }
    else
    {
        float _S433 = _S429.differential_0 * 0.5f;
        DiffPair_float_0 _S434;
        (&_S434)->primal_0 = 0.5f * _S429.primal_0;
        (&_S434)->differential_0 = _S433;
        DiffPair_float_0 _S435 = _d_sin_0(&_S434);
        float _S436 = 2.0f * _S435.primal_0;
        float _S437 = (_S435.differential_0 * 2.0f * _S425.primal_0 - _S436 * _S425.differential_0) / (_S425.primal_0 * _S425.primal_0);
        k_8 = _S436 / _S425.primal_0;
        s_diff_k_3 = _S437;
    }
    float2  _S438 = _S422 * make_float2 (k_8);
    float2  _S439 = _S423 * make_float2 (k_8) + make_float2 (s_diff_k_3) * _S422;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S440;
    (&_S440)->primal_0 = _S438;
    (&_S440)->differential_0 = _S439;
    FixedArray<float, 4>  _S441 = dist_coeffs_20;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S442 = s_fwd_DistOpenCV_distort_0(&_S440, &_S441);
    float fx_6 = intrins_13.x;
    float fy_6 = intrins_13.y;
    float _S443 = _S442.differential_0.y * fy_6;
    *&(((&J_6)->rows + (int(0)))->x) = _S442.differential_0.x * fx_6;
    *&(((&J_6)->rows + (int(1)))->x) = _S443;
    float2  _S444 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S445;
    (&_S445)->primal_0 = _S422;
    (&_S445)->differential_0 = _S444;
    DiffPair_float_0 _S446 = s_fwd_length_impl_0(&_S445);
    DiffPair_float_0 _S447;
    (&_S447)->primal_0 = _S446.primal_0;
    (&_S447)->differential_0 = _S446.differential_0;
    DiffPair_float_0 _S448;
    (&_S448)->primal_0 = _S426;
    (&_S448)->differential_0 = 0.0f;
    DiffPair_float_0 _S449 = _d_atan2_0(&_S447, &_S448);
    if((_S446.primal_0) < 9.99999997475242708e-07f)
    {
        float _S450 = _S449.differential_0 * _S449.primal_0;
        float _S451 = 1.0f - _S449.primal_0 * _S449.primal_0 / 24.0f;
        float _S452 = ((0.0f - (_S450 + _S450) * 0.0416666679084301f) * _S426 - _S451 * 0.0f) / (_S426 * _S426);
        k_8 = _S451 / _S426;
        s_diff_k_3 = _S452;
    }
    else
    {
        float _S453 = _S449.differential_0 * 0.5f;
        DiffPair_float_0 _S454;
        (&_S454)->primal_0 = 0.5f * _S449.primal_0;
        (&_S454)->differential_0 = _S453;
        DiffPair_float_0 _S455 = _d_sin_0(&_S454);
        float _S456 = 2.0f * _S455.primal_0;
        float _S457 = (_S455.differential_0 * 2.0f * _S446.primal_0 - _S456 * _S446.differential_0) / (_S446.primal_0 * _S446.primal_0);
        k_8 = _S456 / _S446.primal_0;
        s_diff_k_3 = _S457;
    }
    float2  _S458 = _S422 * make_float2 (k_8);
    float2  _S459 = _S444 * make_float2 (k_8) + make_float2 (s_diff_k_3) * _S422;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S460;
    (&_S460)->primal_0 = _S458;
    (&_S460)->differential_0 = _S459;
    FixedArray<float, 4>  _S461 = dist_coeffs_20;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S462 = s_fwd_DistOpenCV_distort_0(&_S460, &_S461);
    float _S463 = _S462.differential_0.y * fy_6;
    *&(((&J_6)->rows + (int(0)))->y) = _S462.differential_0.x * fx_6;
    *&(((&J_6)->rows + (int(1)))->y) = _S463;
    float2  _S464 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S465;
    (&_S465)->primal_0 = _S422;
    (&_S465)->differential_0 = _S464;
    DiffPair_float_0 _S466 = s_fwd_length_impl_0(&_S465);
    DiffPair_float_0 _S467;
    (&_S467)->primal_0 = _S466.primal_0;
    (&_S467)->differential_0 = _S466.differential_0;
    DiffPair_float_0 _S468;
    (&_S468)->primal_0 = _S426;
    (&_S468)->differential_0 = 1.0f;
    DiffPair_float_0 _S469 = _d_atan2_0(&_S467, &_S468);
    if((_S466.primal_0) < 9.99999997475242708e-07f)
    {
        float _S470 = _S469.differential_0 * _S469.primal_0;
        float _S471 = 1.0f - _S469.primal_0 * _S469.primal_0 / 24.0f;
        float _S472 = ((0.0f - (_S470 + _S470) * 0.0416666679084301f) * _S426 - _S471) / (_S426 * _S426);
        k_8 = _S471 / _S426;
        s_diff_k_3 = _S472;
    }
    else
    {
        float _S473 = _S469.differential_0 * 0.5f;
        DiffPair_float_0 _S474;
        (&_S474)->primal_0 = 0.5f * _S469.primal_0;
        (&_S474)->differential_0 = _S473;
        DiffPair_float_0 _S475 = _d_sin_0(&_S474);
        float _S476 = 2.0f * _S475.primal_0;
        float _S477 = (_S475.differential_0 * 2.0f * _S466.primal_0 - _S476 * _S466.differential_0) / (_S466.primal_0 * _S466.primal_0);
        k_8 = _S476 / _S466.primal_0;
        s_diff_k_3 = _S477;
    }
    float2  _S478 = _S422 * make_float2 (k_8);
    float2  _S479 = _S464 * make_float2 (k_8) + make_float2 (s_diff_k_3) * _S422;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S480;
    (&_S480)->primal_0 = _S478;
    (&_S480)->differential_0 = _S479;
    FixedArray<float, 4>  _S481 = dist_coeffs_20;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S482 = s_fwd_DistOpenCV_distort_0(&_S480, &_S481);
    float _S483 = _S482.differential_0.y * fy_6;
    *&(((&J_6)->rows + (int(0)))->z) = _S482.differential_0.x * fx_6;
    *&(((&J_6)->rows + (int(1)))->z) = _S483;
    return J_6;
}

inline __device__ float2  distort_point_opencv(float2  uv_21, int camera_model_4, FixedArray<float, 4>  dist_coeffs_21)
{
    float2  _S484;
    for(;;)
    {
        if(camera_model_4 == int(3))
        {
            _S484 = uv_21;
            break;
        }
        float k_9;
        if(camera_model_4 == int(1))
        {
            float r_17 = length_0(uv_21);
            float theta_6 = (F32_atan((r_17)));
            if(r_17 < 0.00100000004749745f)
            {
                k_9 = 1.0f - theta_6 * theta_6 / 6.0f;
            }
            else
            {
                k_9 = theta_6 / r_17;
            }
            _S484 = uv_21 * make_float2 (k_9);
        }
        else
        {
            if(camera_model_4 == int(2))
            {
                float r_18 = length_0(uv_21);
                float theta_7 = (F32_atan((r_18)));
                if(r_18 < 0.00100000004749745f)
                {
                    k_9 = 1.0f - theta_7 * theta_7 / 24.0f;
                }
                else
                {
                    k_9 = 2.0f * (F32_sin((0.5f * theta_7))) / r_18;
                }
                _S484 = uv_21 * make_float2 (k_9);
            }
            else
            {
                _S484 = uv_21;
            }
        }
        FixedArray<float, 4>  _S485 = dist_coeffs_21;
        float2  _S486 = DistOpenCV_distort_0(_S484, &_S485);
        _S484 = _S486;
        break;
    }
    return _S484;
}

inline __device__ bool undistort_point_opencv(float2  uv_22, int camera_model_5, FixedArray<float, 4>  dist_coeffs_22, float2  * uv_undist_4)
{
    bool _S487;
    for(;;)
    {
        *uv_undist_4 = make_float2 (0.0f);
        if(camera_model_5 == int(3))
        {
            float lon_2 = uv_22.x;
            float lat_3 = uv_22.y;
            float cl_3 = (F32_cos((lat_3)));
            *uv_undist_4 = make_float2 (cl_3 * (F32_sin((lon_2))), (F32_sin((lat_3)))) / make_float2 ((F32_max((cl_3 * (F32_cos((lon_2)))), (9.999999960041972e-13f))));
            _S487 = true;
            break;
        }
        FixedArray<float, 4>  _S488 = dist_coeffs_22;
        float2  uv_u_3;
        bool _S489 = undistort_point_1(uv_22, &_S488, int(8), &uv_u_3);
        if(!_S489)
        {
            _S487 = false;
            break;
        }
        float2  _S490 = uv_u_3;
        float3  raydir_3;
        if(camera_model_5 == int(1))
        {
            float r_19 = length_0(_S490);
            float s_3;
            if(r_19 < 0.00100000004749745f)
            {
                s_3 = 1.0f - r_19 * r_19 / 6.0f;
            }
            else
            {
                s_3 = (F32_sin((r_19))) / r_19;
            }
            raydir_3 = make_float3 ((_S490 * make_float2 (s_3)).x, (_S490 * make_float2 (s_3)).y, (F32_cos((r_19))));
        }
        else
        {
            if(camera_model_5 == int(2))
            {
                float r_20 = length_0(_S490);
                raydir_3 = make_float3 ((_S490 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_20 * r_20)))))))).x, (_S490 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_20 * r_20)))))))).y, 1.0f - 0.5f * r_20 * r_20);
            }
            else
            {
                raydir_3 = make_float3 (_S490.x, _S490.y, 1.0f);
            }
        }
        *uv_undist_4 = float2 {raydir_3.x, raydir_3.y} / make_float2 ((F32_max((raydir_3.z), (9.999999960041972e-13f))));
        _S487 = true;
        break;
    }
    return _S487;
}

inline __device__ bool unproject_point_opencv(float2  uv_23, int camera_model_6, FixedArray<float, 4>  dist_coeffs_23, float3  * raydir_4)
{
    bool _S491;
    for(;;)
    {
        if(camera_model_6 == int(4))
        {
            *raydir_4 = make_float3 (0.0f, 0.0f, 1.0f);
            _S491 = true;
            break;
        }
        int3  _S492 = make_int3 (int(0));
        float3  _S493 = make_float3 ((float)_S492.x, (float)_S492.y, (float)_S492.z);
        *raydir_4 = _S493;
        if(camera_model_6 == int(3))
        {
            float lon_3 = uv_23.x;
            float lat_4 = uv_23.y;
            float cl_4 = (F32_cos((lat_4)));
            *raydir_4 = make_float3 (cl_4 * (F32_sin((lon_3))), (F32_sin((lat_4))), cl_4 * (F32_cos((lon_3))));
            _S491 = true;
            break;
        }
        FixedArray<float, 4>  _S494 = dist_coeffs_23;
        float2  uv_u_4;
        bool _S495 = undistort_point_1(uv_23, &_S494, int(8), &uv_u_4);
        if(!_S495)
        {
            _S491 = false;
            break;
        }
        float2  _S496 = uv_u_4;
        if(camera_model_6 == int(1))
        {
            float r_21 = length_0(_S496);
            float s_4;
            if(r_21 < 0.00100000004749745f)
            {
                s_4 = 1.0f - r_21 * r_21 / 6.0f;
            }
            else
            {
                s_4 = (F32_sin((r_21))) / r_21;
            }
            *raydir_4 = make_float3 ((_S496 * make_float2 (s_4)).x, (_S496 * make_float2 (s_4)).y, (F32_cos((r_21))));
        }
        else
        {
            if(camera_model_6 == int(2))
            {
                float r_22 = length_0(_S496);
                *raydir_4 = make_float3 ((_S496 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_22 * r_22)))))))).x, (_S496 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_22 * r_22)))))))).y, 1.0f - 0.5f * r_22 * r_22);
            }
            else
            {
                *raydir_4 = make_float3 (_S496.x, _S496.y, 1.0f);
            }
        }
        _S491 = true;
        break;
    }
    return _S491;
}

inline __device__ bool generate_ray_opencv(float2  uv_24, int camera_model_7, FixedArray<float, 4>  dist_coeffs_24, float3  * raydir_5)
{
    bool _S497;
    for(;;)
    {
        if(camera_model_7 == int(4))
        {
            *raydir_5 = make_float3 (0.0f, 0.0f, 1.0f);
            _S497 = true;
            break;
        }
        if(camera_model_7 == int(3))
        {
            float _S498 = uv_24.x;
            if((F32_abs((_S498))) > 3.14159274101257324f)
            {
                _S497 = true;
            }
            else
            {
                _S497 = (F32_abs((uv_24.y))) > 1.57079637050628662f;
            }
            if(_S497)
            {
                int3  _S499 = make_int3 (int(0));
                float3  _S500 = make_float3 ((float)_S499.x, (float)_S499.y, (float)_S499.z);
                *raydir_5 = _S500;
                _S497 = false;
                break;
            }
            float lat_5 = uv_24.y;
            float cl_5 = (F32_cos((lat_5)));
            *raydir_5 = make_float3 (cl_5 * (F32_sin((_S498))), (F32_sin((lat_5))), cl_5 * (F32_cos((_S498))));
            _S497 = true;
            break;
        }
        FixedArray<float, 4>  _S501 = dist_coeffs_24;
        float2  uv_u_5;
        bool _S502 = undistort_point_1(uv_24, &_S501, int(8), &uv_u_5);
        if(!_S502)
        {
            int3  _S503 = make_int3 (int(0));
            float3  _S504 = make_float3 ((float)_S503.x, (float)_S503.y, (float)_S503.z);
            *raydir_5 = _S504;
            _S497 = false;
            break;
        }
        float2  _S505 = uv_u_5;
        if(camera_model_7 == int(1))
        {
            float r_23 = length_0(_S505);
            if(r_23 >= 3.14159274101257324f)
            {
                int3  _S506 = make_int3 (int(0));
                float3  _S507 = make_float3 ((float)_S506.x, (float)_S506.y, (float)_S506.z);
                *raydir_5 = _S507;
                _S497 = false;
                break;
            }
            float s_5;
            if(r_23 < 0.00100000004749745f)
            {
                s_5 = 1.0f - r_23 * r_23 / 6.0f;
            }
            else
            {
                s_5 = (F32_sin((r_23))) / r_23;
            }
            *raydir_5 = make_float3 ((_S505 * make_float2 (s_5)).x, (_S505 * make_float2 (s_5)).y, (F32_cos((r_23))));
        }
        else
        {
            if(camera_model_7 == int(2))
            {
                float r_24 = length_0(_S505);
                if(r_24 >= 2.0f)
                {
                    int3  _S508 = make_int3 (int(0));
                    float3  _S509 = make_float3 ((float)_S508.x, (float)_S508.y, (float)_S508.z);
                    *raydir_5 = _S509;
                    _S497 = false;
                    break;
                }
                *raydir_5 = make_float3 ((_S505 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_24 * r_24)))))))).x, (_S505 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_24 * r_24)))))))).y, 1.0f - 0.5f * r_24 * r_24);
            }
            else
            {
                *raydir_5 = make_float3 (_S505.x, _S505.y, 1.0f);
            }
        }
        *raydir_5 = normalize_0(*raydir_5);
        _S497 = true;
        break;
    }
    return _S497;
}

inline __device__ bool is_valid_distortion_prism(float2  uv_25, FixedArray<float, 8>  dist_coeffs_25)
{
    float2  _S510 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S511;
    (&_S511)->primal_0 = uv_25;
    (&_S511)->differential_0 = _S510;
    FixedArray<float, 8>  _S512 = dist_coeffs_25;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S513 = s_fwd_DistThinPrism_distort_0(&_S511, &_S512);
    float2  _S514 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S515;
    (&_S515)->primal_0 = uv_25;
    (&_S515)->differential_0 = _S514;
    FixedArray<float, 8>  _S516 = dist_coeffs_25;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S517 = s_fwd_DistThinPrism_distort_0(&_S515, &_S516);
    Matrix<float, 2, 2>  _S518 = transpose_1(makeMatrix<float, 2, 2> (_S513.differential_0, _S517.differential_0));
    float _S519 = (F32_min((determinant_0(_S518)), ((F32_min((_S518.rows[int(0)].x), (_S518.rows[int(1)].y))))));
    bool _S520;
    if(_S519 > 0.25f)
    {
        _S520 = _S519 < 4.0f;
    }
    else
    {
        _S520 = false;
    }
    if(_S520)
    {
        FixedArray<float, 8>  _S521 = dist_coeffs_25;
        float2  _S522 = DistThinPrism_distort_0(uv_25, &_S521);
        _S520 = (dot_0(uv_25, _S522)) >= 0.0f;
    }
    else
    {
        _S520 = false;
    }
    return _S520;
}

inline __device__ bool persp_proj_nav_prism(float3  p_view_14, float4  intrins_14, FixedArray<float, 8>  dist_coeffs_26, float2  * uv_26)
{
    bool _S523;
    for(;;)
    {
        float2  _S524 = float2 {p_view_14.x, p_view_14.y};
        float _S525 = p_view_14.z;
        float2  uv0_2 = _S524 / make_float2 (_S525);
        if(_S525 < 0.0f)
        {
            _S523 = true;
        }
        else
        {
            float2  _S526 = make_float2 (1.0f, 0.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S527;
            (&_S527)->primal_0 = uv0_2;
            (&_S527)->differential_0 = _S526;
            FixedArray<float, 8>  _S528 = dist_coeffs_26;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S529 = s_fwd_DistThinPrism_distort_0(&_S527, &_S528);
            float2  _S530 = make_float2 (0.0f, 1.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S531;
            (&_S531)->primal_0 = uv0_2;
            (&_S531)->differential_0 = _S530;
            FixedArray<float, 8>  _S532 = dist_coeffs_26;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S533 = s_fwd_DistThinPrism_distort_0(&_S531, &_S532);
            Matrix<float, 2, 2>  _S534 = transpose_1(makeMatrix<float, 2, 2> (_S529.differential_0, _S533.differential_0));
            float _S535 = (F32_min((determinant_0(_S534)), ((F32_min((_S534.rows[int(0)].x), (_S534.rows[int(1)].y))))));
            if(_S535 > 0.25f)
            {
                _S523 = _S535 < 4.0f;
            }
            else
            {
                _S523 = false;
            }
            if(_S523)
            {
                FixedArray<float, 8>  _S536 = dist_coeffs_26;
                float2  _S537 = DistThinPrism_distort_0(uv0_2, &_S536);
                _S523 = (dot_0(uv0_2, _S537)) >= 0.0f;
            }
            else
            {
                _S523 = false;
            }
            _S523 = !_S523;
        }
        if(_S523)
        {
            *uv_26 = uv0_2;
            _S523 = false;
            break;
        }
        float2  uv_27 = _S524 / make_float2 (_S525);
        FixedArray<float, 8>  _S538 = dist_coeffs_26;
        float2  _S539 = DistThinPrism_distort_0(uv_27, &_S538);
        *uv_26 = make_float2 (intrins_14.x * _S539.x + intrins_14.z, intrins_14.y * _S539.y + intrins_14.w);
        _S523 = true;
        break;
    }
    return _S523;
}

inline __device__ bool fisheye_proj_nav_prism(float3  p_view_15, float4  intrins_15, FixedArray<float, 8>  dist_coeffs_27, float2  * uv_28)
{
    bool _S540;
    for(;;)
    {
        float2  _S541 = float2 {p_view_15.x, p_view_15.y};
        float r_25 = length_0(_S541);
        float _S542 = p_view_15.z;
        float theta_8 = (F32_atan2((r_25), (_S542)));
        bool _S543 = theta_8 < 0.00100000004749745f;
        float k_10;
        if(_S543)
        {
            k_10 = (1.0f - theta_8 * theta_8 / 3.0f) / _S542;
        }
        else
        {
            k_10 = theta_8 / r_25;
        }
        float2  _S544 = _S541 * make_float2 (k_10);
        float2  _S545 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S546;
        (&_S546)->primal_0 = _S544;
        (&_S546)->differential_0 = _S545;
        FixedArray<float, 8>  _S547 = dist_coeffs_27;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S548 = s_fwd_DistThinPrism_distort_0(&_S546, &_S547);
        float2  _S549 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S550;
        (&_S550)->primal_0 = _S544;
        (&_S550)->differential_0 = _S549;
        FixedArray<float, 8>  _S551 = dist_coeffs_27;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S552 = s_fwd_DistThinPrism_distort_0(&_S550, &_S551);
        Matrix<float, 2, 2>  _S553 = transpose_1(makeMatrix<float, 2, 2> (_S548.differential_0, _S552.differential_0));
        float _S554 = (F32_min((determinant_0(_S553)), ((F32_min((_S553.rows[int(0)].x), (_S553.rows[int(1)].y))))));
        if(_S554 > 0.25f)
        {
            _S540 = _S554 < 4.0f;
        }
        else
        {
            _S540 = false;
        }
        if(_S540)
        {
            FixedArray<float, 8>  _S555 = dist_coeffs_27;
            float2  _S556 = DistThinPrism_distort_0(_S544, &_S555);
            _S540 = (dot_0(_S544, _S556)) >= 0.0f;
        }
        else
        {
            _S540 = false;
        }
        if(!_S540)
        {
            *uv_28 = _S544;
            _S540 = false;
            break;
        }
        if(_S543)
        {
            k_10 = (1.0f - theta_8 * theta_8 / 3.0f) / _S542;
        }
        else
        {
            k_10 = theta_8 / r_25;
        }
        float2  _S557 = _S541 * make_float2 (k_10);
        FixedArray<float, 8>  _S558 = dist_coeffs_27;
        float2  _S559 = DistThinPrism_distort_0(_S557, &_S558);
        *uv_28 = make_float2 (intrins_15.x * _S559.x + intrins_15.z, intrins_15.y * _S559.y + intrins_15.w);
        _S540 = true;
        break;
    }
    return _S540;
}

inline __device__ bool equisolid_proj_nav_prism(float3  p_view_16, float4  intrins_16, FixedArray<float, 8>  dist_coeffs_28, float2  * uv_29)
{
    bool _S560;
    for(;;)
    {
        float2  _S561 = float2 {p_view_16.x, p_view_16.y};
        float r_26 = length_0(_S561);
        float _S562 = p_view_16.z;
        float theta_9 = (F32_atan2((r_26), (_S562)));
        bool _S563 = r_26 < 9.99999997475242708e-07f;
        float k_11;
        if(_S563)
        {
            k_11 = (1.0f - theta_9 * theta_9 / 24.0f) / _S562;
        }
        else
        {
            k_11 = 2.0f * (F32_sin((0.5f * theta_9))) / r_26;
        }
        float2  _S564 = _S561 * make_float2 (k_11);
        float2  _S565 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S566;
        (&_S566)->primal_0 = _S564;
        (&_S566)->differential_0 = _S565;
        FixedArray<float, 8>  _S567 = dist_coeffs_28;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S568 = s_fwd_DistThinPrism_distort_0(&_S566, &_S567);
        float2  _S569 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S570;
        (&_S570)->primal_0 = _S564;
        (&_S570)->differential_0 = _S569;
        FixedArray<float, 8>  _S571 = dist_coeffs_28;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S572 = s_fwd_DistThinPrism_distort_0(&_S570, &_S571);
        Matrix<float, 2, 2>  _S573 = transpose_1(makeMatrix<float, 2, 2> (_S568.differential_0, _S572.differential_0));
        float _S574 = (F32_min((determinant_0(_S573)), ((F32_min((_S573.rows[int(0)].x), (_S573.rows[int(1)].y))))));
        if(_S574 > 0.25f)
        {
            _S560 = _S574 < 4.0f;
        }
        else
        {
            _S560 = false;
        }
        if(_S560)
        {
            FixedArray<float, 8>  _S575 = dist_coeffs_28;
            float2  _S576 = DistThinPrism_distort_0(_S564, &_S575);
            _S560 = (dot_0(_S564, _S576)) >= 0.0f;
        }
        else
        {
            _S560 = false;
        }
        if(!_S560)
        {
            *uv_29 = _S564;
            _S560 = false;
            break;
        }
        if(_S563)
        {
            k_11 = (1.0f - theta_9 * theta_9 / 24.0f) / _S562;
        }
        else
        {
            k_11 = 2.0f * (F32_sin((0.5f * theta_9))) / r_26;
        }
        float2  _S577 = _S561 * make_float2 (k_11);
        FixedArray<float, 8>  _S578 = dist_coeffs_28;
        float2  _S579 = DistThinPrism_distort_0(_S577, &_S578);
        *uv_29 = make_float2 (intrins_16.x * _S579.x + intrins_16.z, intrins_16.y * _S579.y + intrins_16.w);
        _S560 = true;
        break;
    }
    return _S560;
}

inline __device__ Matrix<float, 2, 3>  persp_proj_jac_prism(float3  p_view_17, float4  intrins_17, FixedArray<float, 8>  dist_coeffs_29)
{
    float2  _S580 = float2 {p_view_17.x, p_view_17.y};
    float _S581 = p_view_17.z;
    float2  _S582 = _S580 * make_float2 (0.0f);
    float _S583 = _S581 * _S581;
    float2  s_diff_uv_6 = (make_float2 (1.0f, 0.0f) * make_float2 (_S581) - _S582) / make_float2 (_S583);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S584;
    (&_S584)->primal_0 = _S580 / make_float2 (_S581);
    (&_S584)->differential_0 = s_diff_uv_6;
    FixedArray<float, 8>  _S585 = dist_coeffs_29;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S586 = s_fwd_DistThinPrism_distort_0(&_S584, &_S585);
    float fx_7 = intrins_17.x;
    float fy_7 = intrins_17.y;
    float _S587 = _S586.differential_0.y * fy_7;
    Matrix<float, 2, 3>  J_7;
    *&(((&J_7)->rows + (int(0)))->x) = _S586.differential_0.x * fx_7;
    *&(((&J_7)->rows + (int(1)))->x) = _S587;
    float2  s_diff_uv_7 = (make_float2 (0.0f, 1.0f) * make_float2 (_S581) - _S582) / make_float2 (_S583);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S588;
    (&_S588)->primal_0 = _S580 / make_float2 (_S581);
    (&_S588)->differential_0 = s_diff_uv_7;
    FixedArray<float, 8>  _S589 = dist_coeffs_29;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S590 = s_fwd_DistThinPrism_distort_0(&_S588, &_S589);
    float _S591 = _S590.differential_0.y * fy_7;
    *&(((&J_7)->rows + (int(0)))->y) = _S590.differential_0.x * fx_7;
    *&(((&J_7)->rows + (int(1)))->y) = _S591;
    float2  s_diff_uv_8 = (make_float2 (0.0f, 0.0f) * make_float2 (_S581) - _S580) / make_float2 (_S583);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S592;
    (&_S592)->primal_0 = _S580 / make_float2 (_S581);
    (&_S592)->differential_0 = s_diff_uv_8;
    FixedArray<float, 8>  _S593 = dist_coeffs_29;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S594 = s_fwd_DistThinPrism_distort_0(&_S592, &_S593);
    float _S595 = _S594.differential_0.y * fy_7;
    *&(((&J_7)->rows + (int(0)))->z) = _S594.differential_0.x * fx_7;
    *&(((&J_7)->rows + (int(1)))->z) = _S595;
    return J_7;
}

inline __device__ Matrix<float, 2, 3>  fisheye_proj_jac_prism(float3  p_view_18, float4  intrins_18, FixedArray<float, 8>  dist_coeffs_30)
{
    Matrix<float, 2, 3>  J_8;
    float2  _S596 = float2 {p_view_18.x, p_view_18.y};
    float2  _S597 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S598;
    (&_S598)->primal_0 = _S596;
    (&_S598)->differential_0 = _S597;
    DiffPair_float_0 _S599 = s_fwd_length_impl_0(&_S598);
    float _S600 = p_view_18.z;
    DiffPair_float_0 _S601;
    (&_S601)->primal_0 = _S599.primal_0;
    (&_S601)->differential_0 = _S599.differential_0;
    DiffPair_float_0 _S602;
    (&_S602)->primal_0 = _S600;
    (&_S602)->differential_0 = 0.0f;
    DiffPair_float_0 _S603 = _d_atan2_0(&_S601, &_S602);
    float k_12;
    float s_diff_k_4;
    if((_S603.primal_0) < 0.00100000004749745f)
    {
        float _S604 = _S603.differential_0 * _S603.primal_0;
        float _S605 = 1.0f - _S603.primal_0 * _S603.primal_0 / 3.0f;
        float _S606 = ((0.0f - (_S604 + _S604) * 0.3333333432674408f) * _S600 - _S605 * 0.0f) / (_S600 * _S600);
        k_12 = _S605 / _S600;
        s_diff_k_4 = _S606;
    }
    else
    {
        float _S607 = (_S603.differential_0 * _S599.primal_0 - _S603.primal_0 * _S599.differential_0) / (_S599.primal_0 * _S599.primal_0);
        k_12 = _S603.primal_0 / _S599.primal_0;
        s_diff_k_4 = _S607;
    }
    float2  _S608 = _S596 * make_float2 (k_12);
    float2  _S609 = _S597 * make_float2 (k_12) + make_float2 (s_diff_k_4) * _S596;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S610;
    (&_S610)->primal_0 = _S608;
    (&_S610)->differential_0 = _S609;
    FixedArray<float, 8>  _S611 = dist_coeffs_30;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S612 = s_fwd_DistThinPrism_distort_0(&_S610, &_S611);
    float fx_8 = intrins_18.x;
    float fy_8 = intrins_18.y;
    float _S613 = _S612.differential_0.y * fy_8;
    *&(((&J_8)->rows + (int(0)))->x) = _S612.differential_0.x * fx_8;
    *&(((&J_8)->rows + (int(1)))->x) = _S613;
    float2  _S614 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S615;
    (&_S615)->primal_0 = _S596;
    (&_S615)->differential_0 = _S614;
    DiffPair_float_0 _S616 = s_fwd_length_impl_0(&_S615);
    DiffPair_float_0 _S617;
    (&_S617)->primal_0 = _S616.primal_0;
    (&_S617)->differential_0 = _S616.differential_0;
    DiffPair_float_0 _S618;
    (&_S618)->primal_0 = _S600;
    (&_S618)->differential_0 = 0.0f;
    DiffPair_float_0 _S619 = _d_atan2_0(&_S617, &_S618);
    if((_S619.primal_0) < 0.00100000004749745f)
    {
        float _S620 = _S619.differential_0 * _S619.primal_0;
        float _S621 = 1.0f - _S619.primal_0 * _S619.primal_0 / 3.0f;
        float _S622 = ((0.0f - (_S620 + _S620) * 0.3333333432674408f) * _S600 - _S621 * 0.0f) / (_S600 * _S600);
        k_12 = _S621 / _S600;
        s_diff_k_4 = _S622;
    }
    else
    {
        float _S623 = (_S619.differential_0 * _S616.primal_0 - _S619.primal_0 * _S616.differential_0) / (_S616.primal_0 * _S616.primal_0);
        k_12 = _S619.primal_0 / _S616.primal_0;
        s_diff_k_4 = _S623;
    }
    float2  _S624 = _S596 * make_float2 (k_12);
    float2  _S625 = _S614 * make_float2 (k_12) + make_float2 (s_diff_k_4) * _S596;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S626;
    (&_S626)->primal_0 = _S624;
    (&_S626)->differential_0 = _S625;
    FixedArray<float, 8>  _S627 = dist_coeffs_30;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S628 = s_fwd_DistThinPrism_distort_0(&_S626, &_S627);
    float _S629 = _S628.differential_0.y * fy_8;
    *&(((&J_8)->rows + (int(0)))->y) = _S628.differential_0.x * fx_8;
    *&(((&J_8)->rows + (int(1)))->y) = _S629;
    float2  _S630 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S631;
    (&_S631)->primal_0 = _S596;
    (&_S631)->differential_0 = _S630;
    DiffPair_float_0 _S632 = s_fwd_length_impl_0(&_S631);
    DiffPair_float_0 _S633;
    (&_S633)->primal_0 = _S632.primal_0;
    (&_S633)->differential_0 = _S632.differential_0;
    DiffPair_float_0 _S634;
    (&_S634)->primal_0 = _S600;
    (&_S634)->differential_0 = 1.0f;
    DiffPair_float_0 _S635 = _d_atan2_0(&_S633, &_S634);
    if((_S635.primal_0) < 0.00100000004749745f)
    {
        float _S636 = _S635.differential_0 * _S635.primal_0;
        float _S637 = 1.0f - _S635.primal_0 * _S635.primal_0 / 3.0f;
        float _S638 = ((0.0f - (_S636 + _S636) * 0.3333333432674408f) * _S600 - _S637) / (_S600 * _S600);
        k_12 = _S637 / _S600;
        s_diff_k_4 = _S638;
    }
    else
    {
        float _S639 = (_S635.differential_0 * _S632.primal_0 - _S635.primal_0 * _S632.differential_0) / (_S632.primal_0 * _S632.primal_0);
        k_12 = _S635.primal_0 / _S632.primal_0;
        s_diff_k_4 = _S639;
    }
    float2  _S640 = _S596 * make_float2 (k_12);
    float2  _S641 = _S630 * make_float2 (k_12) + make_float2 (s_diff_k_4) * _S596;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S642;
    (&_S642)->primal_0 = _S640;
    (&_S642)->differential_0 = _S641;
    FixedArray<float, 8>  _S643 = dist_coeffs_30;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S644 = s_fwd_DistThinPrism_distort_0(&_S642, &_S643);
    float _S645 = _S644.differential_0.y * fy_8;
    *&(((&J_8)->rows + (int(0)))->z) = _S644.differential_0.x * fx_8;
    *&(((&J_8)->rows + (int(1)))->z) = _S645;
    return J_8;
}

inline __device__ Matrix<float, 2, 3>  equisolid_proj_jac_prism(float3  p_view_19, float4  intrins_19, FixedArray<float, 8>  dist_coeffs_31)
{
    Matrix<float, 2, 3>  J_9;
    float2  _S646 = float2 {p_view_19.x, p_view_19.y};
    float2  _S647 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S648;
    (&_S648)->primal_0 = _S646;
    (&_S648)->differential_0 = _S647;
    DiffPair_float_0 _S649 = s_fwd_length_impl_0(&_S648);
    float _S650 = p_view_19.z;
    DiffPair_float_0 _S651;
    (&_S651)->primal_0 = _S649.primal_0;
    (&_S651)->differential_0 = _S649.differential_0;
    DiffPair_float_0 _S652;
    (&_S652)->primal_0 = _S650;
    (&_S652)->differential_0 = 0.0f;
    DiffPair_float_0 _S653 = _d_atan2_0(&_S651, &_S652);
    float k_13;
    float s_diff_k_5;
    if((_S649.primal_0) < 9.99999997475242708e-07f)
    {
        float _S654 = _S653.differential_0 * _S653.primal_0;
        float _S655 = 1.0f - _S653.primal_0 * _S653.primal_0 / 24.0f;
        float _S656 = ((0.0f - (_S654 + _S654) * 0.0416666679084301f) * _S650 - _S655 * 0.0f) / (_S650 * _S650);
        k_13 = _S655 / _S650;
        s_diff_k_5 = _S656;
    }
    else
    {
        float _S657 = _S653.differential_0 * 0.5f;
        DiffPair_float_0 _S658;
        (&_S658)->primal_0 = 0.5f * _S653.primal_0;
        (&_S658)->differential_0 = _S657;
        DiffPair_float_0 _S659 = _d_sin_0(&_S658);
        float _S660 = 2.0f * _S659.primal_0;
        float _S661 = (_S659.differential_0 * 2.0f * _S649.primal_0 - _S660 * _S649.differential_0) / (_S649.primal_0 * _S649.primal_0);
        k_13 = _S660 / _S649.primal_0;
        s_diff_k_5 = _S661;
    }
    float2  _S662 = _S646 * make_float2 (k_13);
    float2  _S663 = _S647 * make_float2 (k_13) + make_float2 (s_diff_k_5) * _S646;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S664;
    (&_S664)->primal_0 = _S662;
    (&_S664)->differential_0 = _S663;
    FixedArray<float, 8>  _S665 = dist_coeffs_31;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S666 = s_fwd_DistThinPrism_distort_0(&_S664, &_S665);
    float fx_9 = intrins_19.x;
    float fy_9 = intrins_19.y;
    float _S667 = _S666.differential_0.y * fy_9;
    *&(((&J_9)->rows + (int(0)))->x) = _S666.differential_0.x * fx_9;
    *&(((&J_9)->rows + (int(1)))->x) = _S667;
    float2  _S668 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S669;
    (&_S669)->primal_0 = _S646;
    (&_S669)->differential_0 = _S668;
    DiffPair_float_0 _S670 = s_fwd_length_impl_0(&_S669);
    DiffPair_float_0 _S671;
    (&_S671)->primal_0 = _S670.primal_0;
    (&_S671)->differential_0 = _S670.differential_0;
    DiffPair_float_0 _S672;
    (&_S672)->primal_0 = _S650;
    (&_S672)->differential_0 = 0.0f;
    DiffPair_float_0 _S673 = _d_atan2_0(&_S671, &_S672);
    if((_S670.primal_0) < 9.99999997475242708e-07f)
    {
        float _S674 = _S673.differential_0 * _S673.primal_0;
        float _S675 = 1.0f - _S673.primal_0 * _S673.primal_0 / 24.0f;
        float _S676 = ((0.0f - (_S674 + _S674) * 0.0416666679084301f) * _S650 - _S675 * 0.0f) / (_S650 * _S650);
        k_13 = _S675 / _S650;
        s_diff_k_5 = _S676;
    }
    else
    {
        float _S677 = _S673.differential_0 * 0.5f;
        DiffPair_float_0 _S678;
        (&_S678)->primal_0 = 0.5f * _S673.primal_0;
        (&_S678)->differential_0 = _S677;
        DiffPair_float_0 _S679 = _d_sin_0(&_S678);
        float _S680 = 2.0f * _S679.primal_0;
        float _S681 = (_S679.differential_0 * 2.0f * _S670.primal_0 - _S680 * _S670.differential_0) / (_S670.primal_0 * _S670.primal_0);
        k_13 = _S680 / _S670.primal_0;
        s_diff_k_5 = _S681;
    }
    float2  _S682 = _S646 * make_float2 (k_13);
    float2  _S683 = _S668 * make_float2 (k_13) + make_float2 (s_diff_k_5) * _S646;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S684;
    (&_S684)->primal_0 = _S682;
    (&_S684)->differential_0 = _S683;
    FixedArray<float, 8>  _S685 = dist_coeffs_31;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S686 = s_fwd_DistThinPrism_distort_0(&_S684, &_S685);
    float _S687 = _S686.differential_0.y * fy_9;
    *&(((&J_9)->rows + (int(0)))->y) = _S686.differential_0.x * fx_9;
    *&(((&J_9)->rows + (int(1)))->y) = _S687;
    float2  _S688 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S689;
    (&_S689)->primal_0 = _S646;
    (&_S689)->differential_0 = _S688;
    DiffPair_float_0 _S690 = s_fwd_length_impl_0(&_S689);
    DiffPair_float_0 _S691;
    (&_S691)->primal_0 = _S690.primal_0;
    (&_S691)->differential_0 = _S690.differential_0;
    DiffPair_float_0 _S692;
    (&_S692)->primal_0 = _S650;
    (&_S692)->differential_0 = 1.0f;
    DiffPair_float_0 _S693 = _d_atan2_0(&_S691, &_S692);
    if((_S690.primal_0) < 9.99999997475242708e-07f)
    {
        float _S694 = _S693.differential_0 * _S693.primal_0;
        float _S695 = 1.0f - _S693.primal_0 * _S693.primal_0 / 24.0f;
        float _S696 = ((0.0f - (_S694 + _S694) * 0.0416666679084301f) * _S650 - _S695) / (_S650 * _S650);
        k_13 = _S695 / _S650;
        s_diff_k_5 = _S696;
    }
    else
    {
        float _S697 = _S693.differential_0 * 0.5f;
        DiffPair_float_0 _S698;
        (&_S698)->primal_0 = 0.5f * _S693.primal_0;
        (&_S698)->differential_0 = _S697;
        DiffPair_float_0 _S699 = _d_sin_0(&_S698);
        float _S700 = 2.0f * _S699.primal_0;
        float _S701 = (_S699.differential_0 * 2.0f * _S690.primal_0 - _S700 * _S690.differential_0) / (_S690.primal_0 * _S690.primal_0);
        k_13 = _S700 / _S690.primal_0;
        s_diff_k_5 = _S701;
    }
    float2  _S702 = _S646 * make_float2 (k_13);
    float2  _S703 = _S688 * make_float2 (k_13) + make_float2 (s_diff_k_5) * _S646;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S704;
    (&_S704)->primal_0 = _S702;
    (&_S704)->differential_0 = _S703;
    FixedArray<float, 8>  _S705 = dist_coeffs_31;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S706 = s_fwd_DistThinPrism_distort_0(&_S704, &_S705);
    float _S707 = _S706.differential_0.y * fy_9;
    *&(((&J_9)->rows + (int(0)))->z) = _S706.differential_0.x * fx_9;
    *&(((&J_9)->rows + (int(1)))->z) = _S707;
    return J_9;
}

inline __device__ float2  distort_point_prism(float2  uv_30, int camera_model_8, FixedArray<float, 8>  dist_coeffs_32)
{
    float2  _S708;
    for(;;)
    {
        if(camera_model_8 == int(3))
        {
            _S708 = uv_30;
            break;
        }
        float k_14;
        if(camera_model_8 == int(1))
        {
            float r_27 = length_0(uv_30);
            float theta_10 = (F32_atan((r_27)));
            if(r_27 < 0.00100000004749745f)
            {
                k_14 = 1.0f - theta_10 * theta_10 / 6.0f;
            }
            else
            {
                k_14 = theta_10 / r_27;
            }
            _S708 = uv_30 * make_float2 (k_14);
        }
        else
        {
            if(camera_model_8 == int(2))
            {
                float r_28 = length_0(uv_30);
                float theta_11 = (F32_atan((r_28)));
                if(r_28 < 0.00100000004749745f)
                {
                    k_14 = 1.0f - theta_11 * theta_11 / 24.0f;
                }
                else
                {
                    k_14 = 2.0f * (F32_sin((0.5f * theta_11))) / r_28;
                }
                _S708 = uv_30 * make_float2 (k_14);
            }
            else
            {
                _S708 = uv_30;
            }
        }
        FixedArray<float, 8>  _S709 = dist_coeffs_32;
        float2  _S710 = DistThinPrism_distort_0(_S708, &_S709);
        _S708 = _S710;
        break;
    }
    return _S708;
}

inline __device__ bool undistort_point_prism(float2  uv_31, int camera_model_9, FixedArray<float, 8>  dist_coeffs_33, float2  * uv_undist_5)
{
    bool _S711;
    for(;;)
    {
        *uv_undist_5 = make_float2 (0.0f);
        if(camera_model_9 == int(3))
        {
            float lon_4 = uv_31.x;
            float lat_6 = uv_31.y;
            float cl_6 = (F32_cos((lat_6)));
            *uv_undist_5 = make_float2 (cl_6 * (F32_sin((lon_4))), (F32_sin((lat_6)))) / make_float2 ((F32_max((cl_6 * (F32_cos((lon_4)))), (9.999999960041972e-13f))));
            _S711 = true;
            break;
        }
        FixedArray<float, 8>  _S712 = dist_coeffs_33;
        float2  uv_u_6;
        bool _S713 = undistort_point_2(uv_31, &_S712, int(8), &uv_u_6);
        if(!_S713)
        {
            _S711 = false;
            break;
        }
        float2  _S714 = uv_u_6;
        float3  raydir_6;
        if(camera_model_9 == int(1))
        {
            float r_29 = length_0(_S714);
            float s_6;
            if(r_29 < 0.00100000004749745f)
            {
                s_6 = 1.0f - r_29 * r_29 / 6.0f;
            }
            else
            {
                s_6 = (F32_sin((r_29))) / r_29;
            }
            raydir_6 = make_float3 ((_S714 * make_float2 (s_6)).x, (_S714 * make_float2 (s_6)).y, (F32_cos((r_29))));
        }
        else
        {
            if(camera_model_9 == int(2))
            {
                float r_30 = length_0(_S714);
                raydir_6 = make_float3 ((_S714 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_30 * r_30)))))))).x, (_S714 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_30 * r_30)))))))).y, 1.0f - 0.5f * r_30 * r_30);
            }
            else
            {
                raydir_6 = make_float3 (_S714.x, _S714.y, 1.0f);
            }
        }
        *uv_undist_5 = float2 {raydir_6.x, raydir_6.y} / make_float2 ((F32_max((raydir_6.z), (9.999999960041972e-13f))));
        _S711 = true;
        break;
    }
    return _S711;
}

inline __device__ bool unproject_point_prism(float2  uv_32, int camera_model_10, FixedArray<float, 8>  dist_coeffs_34, float3  * raydir_7)
{
    bool _S715;
    for(;;)
    {
        if(camera_model_10 == int(4))
        {
            *raydir_7 = make_float3 (0.0f, 0.0f, 1.0f);
            _S715 = true;
            break;
        }
        int3  _S716 = make_int3 (int(0));
        float3  _S717 = make_float3 ((float)_S716.x, (float)_S716.y, (float)_S716.z);
        *raydir_7 = _S717;
        if(camera_model_10 == int(3))
        {
            float lon_5 = uv_32.x;
            float lat_7 = uv_32.y;
            float cl_7 = (F32_cos((lat_7)));
            *raydir_7 = make_float3 (cl_7 * (F32_sin((lon_5))), (F32_sin((lat_7))), cl_7 * (F32_cos((lon_5))));
            _S715 = true;
            break;
        }
        FixedArray<float, 8>  _S718 = dist_coeffs_34;
        float2  uv_u_7;
        bool _S719 = undistort_point_2(uv_32, &_S718, int(8), &uv_u_7);
        if(!_S719)
        {
            _S715 = false;
            break;
        }
        float2  _S720 = uv_u_7;
        if(camera_model_10 == int(1))
        {
            float r_31 = length_0(_S720);
            float s_7;
            if(r_31 < 0.00100000004749745f)
            {
                s_7 = 1.0f - r_31 * r_31 / 6.0f;
            }
            else
            {
                s_7 = (F32_sin((r_31))) / r_31;
            }
            *raydir_7 = make_float3 ((_S720 * make_float2 (s_7)).x, (_S720 * make_float2 (s_7)).y, (F32_cos((r_31))));
        }
        else
        {
            if(camera_model_10 == int(2))
            {
                float r_32 = length_0(_S720);
                *raydir_7 = make_float3 ((_S720 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_32 * r_32)))))))).x, (_S720 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_32 * r_32)))))))).y, 1.0f - 0.5f * r_32 * r_32);
            }
            else
            {
                *raydir_7 = make_float3 (_S720.x, _S720.y, 1.0f);
            }
        }
        _S715 = true;
        break;
    }
    return _S715;
}

inline __device__ bool generate_ray_prism(float2  uv_33, int camera_model_11, FixedArray<float, 8>  dist_coeffs_35, float3  * raydir_8)
{
    bool _S721;
    for(;;)
    {
        if(camera_model_11 == int(4))
        {
            *raydir_8 = make_float3 (0.0f, 0.0f, 1.0f);
            _S721 = true;
            break;
        }
        if(camera_model_11 == int(3))
        {
            float _S722 = uv_33.x;
            if((F32_abs((_S722))) > 3.14159274101257324f)
            {
                _S721 = true;
            }
            else
            {
                _S721 = (F32_abs((uv_33.y))) > 1.57079637050628662f;
            }
            if(_S721)
            {
                int3  _S723 = make_int3 (int(0));
                float3  _S724 = make_float3 ((float)_S723.x, (float)_S723.y, (float)_S723.z);
                *raydir_8 = _S724;
                _S721 = false;
                break;
            }
            float lat_8 = uv_33.y;
            float cl_8 = (F32_cos((lat_8)));
            *raydir_8 = make_float3 (cl_8 * (F32_sin((_S722))), (F32_sin((lat_8))), cl_8 * (F32_cos((_S722))));
            _S721 = true;
            break;
        }
        FixedArray<float, 8>  _S725 = dist_coeffs_35;
        float2  uv_u_8;
        bool _S726 = undistort_point_2(uv_33, &_S725, int(8), &uv_u_8);
        if(!_S726)
        {
            int3  _S727 = make_int3 (int(0));
            float3  _S728 = make_float3 ((float)_S727.x, (float)_S727.y, (float)_S727.z);
            *raydir_8 = _S728;
            _S721 = false;
            break;
        }
        float2  _S729 = uv_u_8;
        if(camera_model_11 == int(1))
        {
            float r_33 = length_0(_S729);
            if(r_33 >= 3.14159274101257324f)
            {
                int3  _S730 = make_int3 (int(0));
                float3  _S731 = make_float3 ((float)_S730.x, (float)_S730.y, (float)_S730.z);
                *raydir_8 = _S731;
                _S721 = false;
                break;
            }
            float s_8;
            if(r_33 < 0.00100000004749745f)
            {
                s_8 = 1.0f - r_33 * r_33 / 6.0f;
            }
            else
            {
                s_8 = (F32_sin((r_33))) / r_33;
            }
            *raydir_8 = make_float3 ((_S729 * make_float2 (s_8)).x, (_S729 * make_float2 (s_8)).y, (F32_cos((r_33))));
        }
        else
        {
            if(camera_model_11 == int(2))
            {
                float r_34 = length_0(_S729);
                if(r_34 >= 2.0f)
                {
                    int3  _S732 = make_int3 (int(0));
                    float3  _S733 = make_float3 ((float)_S732.x, (float)_S732.y, (float)_S732.z);
                    *raydir_8 = _S733;
                    _S721 = false;
                    break;
                }
                *raydir_8 = make_float3 ((_S729 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_34 * r_34)))))))).x, (_S729 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_34 * r_34)))))))).y, 1.0f - 0.5f * r_34 * r_34);
            }
            else
            {
                *raydir_8 = make_float3 (_S729.x, _S729.y, 1.0f);
            }
        }
        *raydir_8 = normalize_0(*raydir_8);
        _S721 = true;
        break;
    }
    return _S721;
}

inline __device__ void _d_mul_1(DiffPair_vectorx3Cfloatx2C3x3E_0 * left_4, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * right_4, float3  dOut_5)
{
    float _S734 = (*right_4).primal_0.rows[int(0)].x * dOut_5.x;
    Matrix<float, 3, 3>  right_d_result_2;
    *&(((&right_d_result_2)->rows + (int(0)))->x) = (*left_4).primal_0.x * dOut_5.x;
    float sum_10 = _S734 + (*right_4).primal_0.rows[int(0)].y * dOut_5.y;
    *&(((&right_d_result_2)->rows + (int(0)))->y) = (*left_4).primal_0.x * dOut_5.y;
    float sum_11 = sum_10 + (*right_4).primal_0.rows[int(0)].z * dOut_5.z;
    *&(((&right_d_result_2)->rows + (int(0)))->z) = (*left_4).primal_0.x * dOut_5.z;
    float3  left_d_result_2;
    *&((&left_d_result_2)->x) = sum_11;
    float _S735 = (*right_4).primal_0.rows[int(1)].x * dOut_5.x;
    *&(((&right_d_result_2)->rows + (int(1)))->x) = (*left_4).primal_0.y * dOut_5.x;
    float sum_12 = _S735 + (*right_4).primal_0.rows[int(1)].y * dOut_5.y;
    *&(((&right_d_result_2)->rows + (int(1)))->y) = (*left_4).primal_0.y * dOut_5.y;
    float sum_13 = sum_12 + (*right_4).primal_0.rows[int(1)].z * dOut_5.z;
    *&(((&right_d_result_2)->rows + (int(1)))->z) = (*left_4).primal_0.y * dOut_5.z;
    *&((&left_d_result_2)->y) = sum_13;
    float _S736 = (*right_4).primal_0.rows[int(2)].x * dOut_5.x;
    *&(((&right_d_result_2)->rows + (int(2)))->x) = (*left_4).primal_0.z * dOut_5.x;
    float sum_14 = _S736 + (*right_4).primal_0.rows[int(2)].y * dOut_5.y;
    *&(((&right_d_result_2)->rows + (int(2)))->y) = (*left_4).primal_0.z * dOut_5.y;
    float sum_15 = sum_14 + (*right_4).primal_0.rows[int(2)].z * dOut_5.z;
    *&(((&right_d_result_2)->rows + (int(2)))->z) = (*left_4).primal_0.z * dOut_5.z;
    *&((&left_d_result_2)->z) = sum_15;
    left_4->primal_0 = (*left_4).primal_0;
    left_4->differential_0 = left_d_result_2;
    right_4->primal_0 = (*right_4).primal_0;
    right_4->differential_0 = right_d_result_2;
    return;
}

inline __device__ float3  mul_3(float3  left_5, Matrix<float, 3, 3>  right_5)
{
    float3  result_8;
    int j_1 = int(0);
    for(;;)
    {
        if(j_1 < int(3))
        {
        }
        else
        {
            break;
        }
        int i_6 = int(0);
        float sum_16 = 0.0f;
        for(;;)
        {
            if(i_6 < int(3))
            {
            }
            else
            {
                break;
            }
            float sum_17 = sum_16 + _slang_vector_get_element(left_5, i_6) * _slang_vector_get_element(right_5.rows[i_6], j_1);
            i_6 = i_6 + int(1);
            sum_16 = sum_17;
        }
        *_slang_vector_get_element_ptr(&result_8, j_1) = sum_16;
        j_1 = j_1 + int(1);
    }
    return result_8;
}

inline __device__ void _d_cross_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * a_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * b_0, float3  dOut_6)
{
    float _S737 = dOut_6.y;
    float _S738 = dOut_6.z;
    float _S739 = dOut_6.x;
    float _S740 = (*a_0).primal_0.z * _S737 + - (*a_0).primal_0.y * _S738;
    float _S741 = - (*a_0).primal_0.z * _S739 + (*a_0).primal_0.x * _S738;
    float _S742 = (*a_0).primal_0.y * _S739 + - (*a_0).primal_0.x * _S737;
    float3  _S743 = make_float3 (- (*b_0).primal_0.z * _S737 + (*b_0).primal_0.y * _S738, (*b_0).primal_0.z * _S739 + - (*b_0).primal_0.x * _S738, - (*b_0).primal_0.y * _S739 + (*b_0).primal_0.x * _S737);
    a_0->primal_0 = (*a_0).primal_0;
    a_0->differential_0 = _S743;
    float3  _S744 = make_float3 (_S740, _S741, _S742);
    b_0->primal_0 = (*b_0).primal_0;
    b_0->differential_0 = _S744;
    return;
}

inline __device__ float3  cross_0(float3  left_6, float3  right_6)
{
    float _S745 = left_6.y;
    float _S746 = right_6.z;
    float _S747 = left_6.z;
    float _S748 = right_6.y;
    float _S749 = right_6.x;
    float _S750 = left_6.x;
    return make_float3 (_S745 * _S746 - _S747 * _S748, _S747 * _S749 - _S750 * _S746, _S750 * _S748 - _S745 * _S749);
}

inline __device__ float3  transform_ray_o(Matrix<float, 3, 3>  R_0, float3  t_0)
{
    Matrix<float, 3, 3>  _S751 = transpose_0(R_0);
    Matrix<float, 3, 3>  _S752 = mul_1(R_0, _S751);
    bool _S753 = (F32_max(((F32_max(((F32_max(((F32_max(((F32_max(((F32_max(((F32_max(((F32_max(((F32_max((0.0f), ((F32_abs((_S752.rows[int(0)].x - 1.0f))))))), ((F32_abs((_S752.rows[int(0)].y))))))), ((F32_abs((_S752.rows[int(0)].z))))))), ((F32_abs((_S752.rows[int(1)].x))))))), ((F32_abs((_S752.rows[int(1)].y - 1.0f))))))), ((F32_abs((_S752.rows[int(1)].z))))))), ((F32_abs((_S752.rows[int(2)].x))))))), ((F32_abs((_S752.rows[int(2)].y))))))), ((F32_abs((_S752.rows[int(2)].z - 1.0f)))))) <= 9.99999997475242708e-07f;
    if(_S753)
    {
        return - mul_3(t_0, R_0);
    }
    Matrix<float, 3, 3>  _S754;
    for(;;)
    {
        if(_S753)
        {
            _S754 = _S751;
            break;
        }
        float3  a_1 = cross_0(R_0.rows[int(1)], R_0.rows[int(2)]);
        _S754 = transpose_0(makeMatrix<float, 3, 3> (a_1, cross_0(R_0.rows[int(2)], R_0.rows[int(0)]), cross_0(R_0.rows[int(0)], R_0.rows[int(1)]))) / makeMatrix<float, 3, 3> (dot_1(R_0.rows[int(0)], a_1));
        break;
    }
    return - mul_2(_S754, t_0);
}

inline __device__ float3  transform_ray_d(Matrix<float, 3, 3>  R_1, float3  raydir_9)
{
    Matrix<float, 3, 3>  _S755 = transpose_0(R_1);
    Matrix<float, 3, 3>  _S756 = mul_1(R_1, _S755);
    bool _S757 = (F32_max(((F32_max(((F32_max(((F32_max(((F32_max(((F32_max(((F32_max(((F32_max(((F32_max((0.0f), ((F32_abs((_S756.rows[int(0)].x - 1.0f))))))), ((F32_abs((_S756.rows[int(0)].y))))))), ((F32_abs((_S756.rows[int(0)].z))))))), ((F32_abs((_S756.rows[int(1)].x))))))), ((F32_abs((_S756.rows[int(1)].y - 1.0f))))))), ((F32_abs((_S756.rows[int(1)].z))))))), ((F32_abs((_S756.rows[int(2)].x))))))), ((F32_abs((_S756.rows[int(2)].y))))))), ((F32_abs((_S756.rows[int(2)].z - 1.0f)))))) <= 9.99999997475242708e-07f;
    if(_S757)
    {
        return mul_3(raydir_9, R_1);
    }
    Matrix<float, 3, 3>  _S758;
    for(;;)
    {
        if(_S757)
        {
            _S758 = _S755;
            break;
        }
        float3  a_2 = cross_0(R_1.rows[int(1)], R_1.rows[int(2)]);
        _S758 = transpose_0(makeMatrix<float, 3, 3> (a_2, cross_0(R_1.rows[int(2)], R_1.rows[int(0)]), cross_0(R_1.rows[int(0)], R_1.rows[int(1)]))) / makeMatrix<float, 3, 3> (dot_1(R_1.rows[int(0)], a_2));
        break;
    }
    return mul_2(_S758, raydir_9);
}

inline __device__ float3  undo_transform_ray_d(Matrix<float, 3, 3>  R_2, float3  raydir_10)
{
    return mul_3(raydir_10, transpose_0(R_2));
}

inline __device__ Matrix<float, 3, 3>  s_primal_ctx_mul_0(Matrix<float, 3, 3>  _S759, Matrix<float, 3, 3>  _S760)
{
    return mul_1(_S759, _S760);
}

inline __device__ float s_primal_ctx_abs_0(float _S761)
{
    return (F32_abs((_S761)));
}

inline __device__ float3  s_primal_ctx_cross_0(float3  _S762, float3  _S763)
{
    return cross_0(_S762, _S763);
}

inline __device__ float s_primal_ctx_dot_0(float3  _S764, float3  _S765)
{
    return dot_1(_S764, _S765);
}

inline __device__ void s_bwd_prop_mul_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S766, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S767, float3  _S768)
{
    _d_mul_0(_S766, _S767, _S768);
    return;
}

inline __device__ void s_bwd_prop_dot_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S769, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S770, float _S771)
{
    _d_dot_0(_S769, _S770, _S771);
    return;
}

inline __device__ void s_bwd_prop_cross_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S772, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S773, float3  _S774)
{
    _d_cross_0(_S772, _S773, _S774);
    return;
}

inline __device__ void s_bwd_prop_abs_0(DiffPair_float_0 * _S775, float _S776)
{
    _d_abs_0(_S775, _S776);
    return;
}

inline __device__ void s_bwd_prop_mul_1(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S777, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S778, float3  _S779)
{
    _d_mul_1(_S777, _S778, _S779);
    return;
}

inline __device__ void s_bwd_prop_transform_ray_o_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * dpR_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpt_0, float3  _s_dOut_0)
{
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S780 = *dpR_0;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S781 = *dpt_0;
    float3  _S782 = make_float3 (0.0f);
    Matrix<float, 3, 3>  _S783 = makeMatrix<float, 3, 3> (0.0f);
    Matrix<float, 3, 3>  _S784 = transpose_0((*dpR_0).primal_0);
    Matrix<float, 3, 3>  _S785 = s_primal_ctx_mul_0((*dpR_0).primal_0, _S784);
    float _S786 = _S785.rows[int(0)].x - 1.0f;
    float _S787 = s_primal_ctx_abs_0(_S786);
    float _S788 = (F32_max((0.0f), (_S787)));
    float _S789 = s_primal_ctx_abs_0(_S785.rows[int(0)].y);
    float _S790 = (F32_max((_S788), (_S789)));
    float _S791 = s_primal_ctx_abs_0(_S785.rows[int(0)].z);
    float _S792 = (F32_max((_S790), (_S791)));
    float _S793 = s_primal_ctx_abs_0(_S785.rows[int(1)].x);
    float _S794 = (F32_max((_S792), (_S793)));
    float _S795 = _S785.rows[int(1)].y - 1.0f;
    float _S796 = s_primal_ctx_abs_0(_S795);
    float _S797 = (F32_max((_S794), (_S796)));
    float _S798 = s_primal_ctx_abs_0(_S785.rows[int(1)].z);
    float _S799 = (F32_max((_S797), (_S798)));
    float _S800 = s_primal_ctx_abs_0(_S785.rows[int(2)].x);
    float _S801 = (F32_max((_S799), (_S800)));
    float _S802 = s_primal_ctx_abs_0(_S785.rows[int(2)].y);
    float _S803 = (F32_max((_S801), (_S802)));
    float _S804 = _S785.rows[int(2)].z - 1.0f;
    float _S805 = s_primal_ctx_abs_0(_S804);
    bool _S806 = (F32_max((_S803), (_S805))) <= 9.99999997475242708e-07f;
    bool _S807 = !_S806;
    Matrix<float, 3, 3>  _S808;
    Matrix<float, 3, 3>  _S809;
    Matrix<float, 3, 3>  _S810;
    Matrix<float, 3, 3>  _S811;
    float3  _S812;
    float3  _S813;
    float3  _S814;
    float3  _S815;
    bool _S816;
    bool _S817;
    float _S818;
    float _S819;
    float _S820;
    float _S821;
    float _S822;
    float _S823;
    float _S824;
    float _S825;
    float _S826;
    float _S827;
    float _S828;
    float _S829;
    float _S830;
    float _S831;
    float _S832;
    float _S833;
    float _S834;
    float _S835;
    float _S836;
    float _S837;
    float _S838;
    float _S839;
    float _S840;
    float _S841;
    float _S842;
    float _S843;
    if(_S807)
    {
        if(_S807)
        {
            float3  _S844 = s_primal_ctx_cross_0(_S780.primal_0.rows[int(1)], _S780.primal_0.rows[int(2)]);
            Matrix<float, 3, 3>  _S845 = transpose_0(makeMatrix<float, 3, 3> (_S844, s_primal_ctx_cross_0(_S780.primal_0.rows[int(2)], _S780.primal_0.rows[int(0)]), s_primal_ctx_cross_0(_S780.primal_0.rows[int(0)], _S780.primal_0.rows[int(1)])));
            float _S846 = s_primal_ctx_dot_0(_S780.primal_0.rows[int(0)], _S844);
            Matrix<float, 3, 3>  _S847 = makeMatrix<float, 3, 3> (_S846);
            Matrix<float, 3, 3>  _S848 = makeMatrix<float, 3, 3> (_S846 * _S846);
            _S808 = _S845 / makeMatrix<float, 3, 3> (_S846);
            _S809 = _S848;
            _S810 = _S845;
            _S811 = _S847;
            _S812 = _S780.primal_0.rows[int(0)];
            _S813 = _S844;
            _S814 = _S780.primal_0.rows[int(1)];
            _S815 = _S780.primal_0.rows[int(2)];
        }
        else
        {
            _S808 = _S784;
            _S809 = _S783;
            _S810 = _S783;
            _S811 = _S783;
            _S812 = _S782;
            _S813 = _S782;
            _S814 = _S782;
            _S815 = _S782;
        }
        _S816 = _S807;
        _S817 = _S806;
        _S818 = _S803;
        _S819 = _S805;
        _S820 = _S804;
        _S821 = _S801;
        _S822 = _S802;
        _S823 = _S785.rows[int(2)].y;
        _S824 = _S799;
        _S825 = _S800;
        _S826 = _S785.rows[int(2)].x;
        _S827 = _S797;
        _S828 = _S798;
        _S829 = _S785.rows[int(1)].z;
        _S830 = _S794;
        _S831 = _S796;
        _S832 = _S795;
        _S833 = _S792;
        _S834 = _S793;
        _S835 = _S785.rows[int(1)].x;
        _S836 = _S790;
        _S837 = _S791;
        _S838 = _S785.rows[int(0)].z;
        _S839 = _S788;
        _S840 = _S789;
        _S841 = _S785.rows[int(0)].y;
        _S842 = _S787;
        _S843 = _S786;
    }
    else
    {
        _S808 = _S783;
        _S816 = false;
        _S809 = _S783;
        _S810 = _S783;
        _S811 = _S783;
        _S812 = _S782;
        _S813 = _S782;
        _S814 = _S782;
        _S815 = _S782;
        _S817 = false;
        _S818 = 0.0f;
        _S819 = 0.0f;
        _S820 = 0.0f;
        _S821 = 0.0f;
        _S822 = 0.0f;
        _S823 = 0.0f;
        _S824 = 0.0f;
        _S825 = 0.0f;
        _S826 = 0.0f;
        _S827 = 0.0f;
        _S828 = 0.0f;
        _S829 = 0.0f;
        _S830 = 0.0f;
        _S831 = 0.0f;
        _S832 = 0.0f;
        _S833 = 0.0f;
        _S834 = 0.0f;
        _S835 = 0.0f;
        _S836 = 0.0f;
        _S837 = 0.0f;
        _S838 = 0.0f;
        _S839 = 0.0f;
        _S840 = 0.0f;
        _S841 = 0.0f;
        _S842 = 0.0f;
        _S843 = 0.0f;
    }
    if(_S807)
    {
        float3  _S849 = - _s_dOut_0;
        DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S850;
        (&_S850)->primal_0 = _S808;
        (&_S850)->differential_0 = _S783;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S851;
        (&_S851)->primal_0 = _S781.primal_0;
        (&_S851)->differential_0 = _S782;
        s_bwd_prop_mul_0(&_S850, &_S851, _S849);
        DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S852 = _S850;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S853 = _S851;
        if(_S816)
        {
            Matrix<float, 3, 3>  _S854 = _S852.differential_0 / _S809;
            Matrix<float, 3, 3>  _S855 = _S810 * - _S854;
            Matrix<float, 3, 3>  _S856 = _S811 * _S854;
            float _S857 = _S855.rows[int(0)].x + _S855.rows[int(0)].y + _S855.rows[int(0)].z + _S855.rows[int(1)].x + _S855.rows[int(1)].y + _S855.rows[int(1)].z + _S855.rows[int(2)].x + _S855.rows[int(2)].y + _S855.rows[int(2)].z;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S858;
            (&_S858)->primal_0 = _S812;
            (&_S858)->differential_0 = _S782;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S859;
            (&_S859)->primal_0 = _S813;
            (&_S859)->differential_0 = _S782;
            s_bwd_prop_dot_0(&_S858, &_S859, _S857);
            Matrix<float, 3, 3>  _S860 = transpose_0(_S856);
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S861;
            (&_S861)->primal_0 = _S812;
            (&_S861)->differential_0 = _S782;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S862;
            (&_S862)->primal_0 = _S814;
            (&_S862)->differential_0 = _S782;
            s_bwd_prop_cross_0(&_S861, &_S862, _S860.rows[int(2)]);
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S863;
            (&_S863)->primal_0 = _S815;
            (&_S863)->differential_0 = _S782;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S864;
            (&_S864)->primal_0 = _S812;
            (&_S864)->differential_0 = _S782;
            s_bwd_prop_cross_0(&_S863, &_S864, _S860.rows[int(1)]);
            float3  _S865 = _S858.differential_0 + _S861.differential_0 + _S864.differential_0;
            float3  _S866 = _S859.differential_0 + _S860.rows[int(0)];
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S867;
            (&_S867)->primal_0 = _S814;
            (&_S867)->differential_0 = _S782;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S868;
            (&_S868)->primal_0 = _S815;
            (&_S868)->differential_0 = _S782;
            s_bwd_prop_cross_0(&_S867, &_S868, _S866);
            float3  _S869 = _S863.differential_0 + _S868.differential_0;
            float3  _S870 = _S862.differential_0 + _S867.differential_0;
            Matrix<float, 3, 3>  _S871 = _S783;
            _S871[int(0)] = _S865;
            _S871[int(2)] = _S869;
            _S871[int(1)] = _S870;
            _S808 = _S783;
            _S809 = _S871;
        }
        else
        {
            _S808 = _S852.differential_0;
            _S809 = _S783;
        }
        if(_S817)
        {
            _S808 = transpose_0(_S808) + _S809;
        }
        else
        {
            _S808 = _S809;
        }
        DiffPair_float_0 _S872;
        (&_S872)->primal_0 = _S818;
        (&_S872)->differential_0 = 0.0f;
        DiffPair_float_0 _S873;
        (&_S873)->primal_0 = _S819;
        (&_S873)->differential_0 = 0.0f;
        _d_max_0(&_S872, &_S873, 0.0f);
        DiffPair_float_0 _S874;
        (&_S874)->primal_0 = _S820;
        (&_S874)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S874, _S873.differential_0);
        DiffPair_float_0 _S875;
        (&_S875)->primal_0 = _S821;
        (&_S875)->differential_0 = 0.0f;
        DiffPair_float_0 _S876;
        (&_S876)->primal_0 = _S822;
        (&_S876)->differential_0 = 0.0f;
        _d_max_0(&_S875, &_S876, _S872.differential_0);
        DiffPair_float_0 _S877;
        (&_S877)->primal_0 = _S823;
        (&_S877)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S877, _S876.differential_0);
        DiffPair_float_0 _S878;
        (&_S878)->primal_0 = _S824;
        (&_S878)->differential_0 = 0.0f;
        DiffPair_float_0 _S879;
        (&_S879)->primal_0 = _S825;
        (&_S879)->differential_0 = 0.0f;
        _d_max_0(&_S878, &_S879, _S875.differential_0);
        DiffPair_float_0 _S880;
        (&_S880)->primal_0 = _S826;
        (&_S880)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S880, _S879.differential_0);
        float3  _S881 = _S782;
        *&((&_S881)->z) = _S874.differential_0;
        *&((&_S881)->y) = _S877.differential_0;
        *&((&_S881)->x) = _S880.differential_0;
        DiffPair_float_0 _S882;
        (&_S882)->primal_0 = _S827;
        (&_S882)->differential_0 = 0.0f;
        DiffPair_float_0 _S883;
        (&_S883)->primal_0 = _S828;
        (&_S883)->differential_0 = 0.0f;
        _d_max_0(&_S882, &_S883, _S878.differential_0);
        DiffPair_float_0 _S884;
        (&_S884)->primal_0 = _S829;
        (&_S884)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S884, _S883.differential_0);
        DiffPair_float_0 _S885;
        (&_S885)->primal_0 = _S830;
        (&_S885)->differential_0 = 0.0f;
        DiffPair_float_0 _S886;
        (&_S886)->primal_0 = _S831;
        (&_S886)->differential_0 = 0.0f;
        _d_max_0(&_S885, &_S886, _S882.differential_0);
        DiffPair_float_0 _S887;
        (&_S887)->primal_0 = _S832;
        (&_S887)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S887, _S886.differential_0);
        DiffPair_float_0 _S888;
        (&_S888)->primal_0 = _S833;
        (&_S888)->differential_0 = 0.0f;
        DiffPair_float_0 _S889;
        (&_S889)->primal_0 = _S834;
        (&_S889)->differential_0 = 0.0f;
        _d_max_0(&_S888, &_S889, _S885.differential_0);
        DiffPair_float_0 _S890;
        (&_S890)->primal_0 = _S835;
        (&_S890)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S890, _S889.differential_0);
        float3  _S891 = _S782;
        *&((&_S891)->z) = _S884.differential_0;
        *&((&_S891)->y) = _S887.differential_0;
        *&((&_S891)->x) = _S890.differential_0;
        DiffPair_float_0 _S892;
        (&_S892)->primal_0 = _S836;
        (&_S892)->differential_0 = 0.0f;
        DiffPair_float_0 _S893;
        (&_S893)->primal_0 = _S837;
        (&_S893)->differential_0 = 0.0f;
        _d_max_0(&_S892, &_S893, _S888.differential_0);
        DiffPair_float_0 _S894;
        (&_S894)->primal_0 = _S838;
        (&_S894)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S894, _S893.differential_0);
        DiffPair_float_0 _S895;
        (&_S895)->primal_0 = _S839;
        (&_S895)->differential_0 = 0.0f;
        DiffPair_float_0 _S896;
        (&_S896)->primal_0 = _S840;
        (&_S896)->differential_0 = 0.0f;
        _d_max_0(&_S895, &_S896, _S892.differential_0);
        DiffPair_float_0 _S897;
        (&_S897)->primal_0 = _S841;
        (&_S897)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S897, _S896.differential_0);
        DiffPair_float_0 _S898;
        (&_S898)->primal_0 = 0.0f;
        (&_S898)->differential_0 = 0.0f;
        DiffPair_float_0 _S899;
        (&_S899)->primal_0 = _S842;
        (&_S899)->differential_0 = 0.0f;
        _d_max_0(&_S898, &_S899, _S895.differential_0);
        DiffPair_float_0 _S900;
        (&_S900)->primal_0 = _S843;
        (&_S900)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S900, _S899.differential_0);
        float3  _S901 = _S782;
        *&((&_S901)->z) = _S894.differential_0;
        *&((&_S901)->y) = _S897.differential_0;
        *&((&_S901)->x) = _S900.differential_0;
        Matrix<float, 3, 3>  _S902 = _S783;
        _S902[int(2)] = _S881;
        _S902[int(1)] = _S891;
        _S902[int(0)] = _S901;
        _S812 = _S782;
        _S813 = _S853.differential_0;
    }
    else
    {
        _S812 = _s_dOut_0;
        _S808 = _S783;
        _S813 = _S782;
    }
    if(_S806)
    {
        float3  _S903 = - _S812;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S904;
        (&_S904)->primal_0 = _S781.primal_0;
        (&_S904)->differential_0 = _S782;
        DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S905;
        (&_S905)->primal_0 = _S780.primal_0;
        (&_S905)->differential_0 = _S783;
        s_bwd_prop_mul_1(&_S904, &_S905, _S903);
        Matrix<float, 3, 3>  _S906 = _S905.differential_0 + _S808;
        _S812 = _S904.differential_0 + _S813;
        _S808 = _S906;
    }
    else
    {
        _S812 = _S813;
    }
    DiffPair_float_0 _S907;
    (&_S907)->primal_0 = _S803;
    (&_S907)->differential_0 = 0.0f;
    DiffPair_float_0 _S908;
    (&_S908)->primal_0 = _S805;
    (&_S908)->differential_0 = 0.0f;
    _d_max_0(&_S907, &_S908, 0.0f);
    DiffPair_float_0 _S909;
    (&_S909)->primal_0 = _S804;
    (&_S909)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S909, _S908.differential_0);
    DiffPair_float_0 _S910;
    (&_S910)->primal_0 = _S801;
    (&_S910)->differential_0 = 0.0f;
    DiffPair_float_0 _S911;
    (&_S911)->primal_0 = _S802;
    (&_S911)->differential_0 = 0.0f;
    _d_max_0(&_S910, &_S911, _S907.differential_0);
    DiffPair_float_0 _S912;
    (&_S912)->primal_0 = _S785.rows[int(2)].y;
    (&_S912)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S912, _S911.differential_0);
    DiffPair_float_0 _S913;
    (&_S913)->primal_0 = _S799;
    (&_S913)->differential_0 = 0.0f;
    DiffPair_float_0 _S914;
    (&_S914)->primal_0 = _S800;
    (&_S914)->differential_0 = 0.0f;
    _d_max_0(&_S913, &_S914, _S910.differential_0);
    DiffPair_float_0 _S915;
    (&_S915)->primal_0 = _S785.rows[int(2)].x;
    (&_S915)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S915, _S914.differential_0);
    float3  _S916 = _S782;
    *&((&_S916)->z) = _S909.differential_0;
    *&((&_S916)->y) = _S912.differential_0;
    *&((&_S916)->x) = _S915.differential_0;
    DiffPair_float_0 _S917;
    (&_S917)->primal_0 = _S797;
    (&_S917)->differential_0 = 0.0f;
    DiffPair_float_0 _S918;
    (&_S918)->primal_0 = _S798;
    (&_S918)->differential_0 = 0.0f;
    _d_max_0(&_S917, &_S918, _S913.differential_0);
    DiffPair_float_0 _S919;
    (&_S919)->primal_0 = _S785.rows[int(1)].z;
    (&_S919)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S919, _S918.differential_0);
    DiffPair_float_0 _S920;
    (&_S920)->primal_0 = _S794;
    (&_S920)->differential_0 = 0.0f;
    DiffPair_float_0 _S921;
    (&_S921)->primal_0 = _S796;
    (&_S921)->differential_0 = 0.0f;
    _d_max_0(&_S920, &_S921, _S917.differential_0);
    DiffPair_float_0 _S922;
    (&_S922)->primal_0 = _S795;
    (&_S922)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S922, _S921.differential_0);
    DiffPair_float_0 _S923;
    (&_S923)->primal_0 = _S792;
    (&_S923)->differential_0 = 0.0f;
    DiffPair_float_0 _S924;
    (&_S924)->primal_0 = _S793;
    (&_S924)->differential_0 = 0.0f;
    _d_max_0(&_S923, &_S924, _S920.differential_0);
    DiffPair_float_0 _S925;
    (&_S925)->primal_0 = _S785.rows[int(1)].x;
    (&_S925)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S925, _S924.differential_0);
    float3  _S926 = _S782;
    *&((&_S926)->z) = _S919.differential_0;
    *&((&_S926)->y) = _S922.differential_0;
    *&((&_S926)->x) = _S925.differential_0;
    DiffPair_float_0 _S927;
    (&_S927)->primal_0 = _S790;
    (&_S927)->differential_0 = 0.0f;
    DiffPair_float_0 _S928;
    (&_S928)->primal_0 = _S791;
    (&_S928)->differential_0 = 0.0f;
    _d_max_0(&_S927, &_S928, _S923.differential_0);
    DiffPair_float_0 _S929;
    (&_S929)->primal_0 = _S785.rows[int(0)].z;
    (&_S929)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S929, _S928.differential_0);
    DiffPair_float_0 _S930;
    (&_S930)->primal_0 = _S788;
    (&_S930)->differential_0 = 0.0f;
    DiffPair_float_0 _S931;
    (&_S931)->primal_0 = _S789;
    (&_S931)->differential_0 = 0.0f;
    _d_max_0(&_S930, &_S931, _S927.differential_0);
    DiffPair_float_0 _S932;
    (&_S932)->primal_0 = _S785.rows[int(0)].y;
    (&_S932)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S932, _S931.differential_0);
    DiffPair_float_0 _S933;
    (&_S933)->primal_0 = 0.0f;
    (&_S933)->differential_0 = 0.0f;
    DiffPair_float_0 _S934;
    (&_S934)->primal_0 = _S787;
    (&_S934)->differential_0 = 0.0f;
    _d_max_0(&_S933, &_S934, _S930.differential_0);
    DiffPair_float_0 _S935;
    (&_S935)->primal_0 = _S786;
    (&_S935)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S935, _S934.differential_0);
    float3  _S936 = _S782;
    *&((&_S936)->z) = _S929.differential_0;
    *&((&_S936)->y) = _S932.differential_0;
    *&((&_S936)->x) = _S935.differential_0;
    Matrix<float, 3, 3>  _S937 = _S783;
    _S937[int(2)] = _S916;
    _S937[int(1)] = _S926;
    _S937[int(0)] = _S936;
    dpt_0->primal_0 = (*dpt_0).primal_0;
    dpt_0->differential_0 = _S812;
    dpR_0->primal_0 = (*dpR_0).primal_0;
    dpR_0->differential_0 = _S808;
    return;
}

inline __device__ void s_bwd_transform_ray_o_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S938, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S939, float3  _S940)
{
    s_bwd_prop_transform_ray_o_0(_S938, _S939, _S940);
    return;
}

inline __device__ void transform_ray_o_vjp(Matrix<float, 3, 3>  R_3, float3  t_1, float3  v_ray_o_0, Matrix<float, 3, 3>  * v_R_0, float3  * v_t_0)
{
    Matrix<float, 3, 3>  _S941 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 dp_R_0;
    (&dp_R_0)->primal_0 = R_3;
    (&dp_R_0)->differential_0 = _S941;
    float3  _S942 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_t_0;
    (&dp_t_0)->primal_0 = t_1;
    (&dp_t_0)->differential_0 = _S942;
    s_bwd_transform_ray_o_0(&dp_R_0, &dp_t_0, v_ray_o_0);
    *v_R_0 = dp_R_0.differential_0;
    *v_t_0 = dp_t_0.differential_0;
    return;
}

inline __device__ void s_bwd_prop_transform_ray_d_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * dpR_1, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpraydir_0, float3  _s_dOut_1)
{
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S943 = *dpR_1;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S944 = *dpraydir_0;
    float3  _S945 = make_float3 (0.0f);
    Matrix<float, 3, 3>  _S946 = makeMatrix<float, 3, 3> (0.0f);
    Matrix<float, 3, 3>  _S947 = transpose_0((*dpR_1).primal_0);
    Matrix<float, 3, 3>  _S948 = s_primal_ctx_mul_0((*dpR_1).primal_0, _S947);
    float _S949 = _S948.rows[int(0)].x - 1.0f;
    float _S950 = s_primal_ctx_abs_0(_S949);
    float _S951 = (F32_max((0.0f), (_S950)));
    float _S952 = s_primal_ctx_abs_0(_S948.rows[int(0)].y);
    float _S953 = (F32_max((_S951), (_S952)));
    float _S954 = s_primal_ctx_abs_0(_S948.rows[int(0)].z);
    float _S955 = (F32_max((_S953), (_S954)));
    float _S956 = s_primal_ctx_abs_0(_S948.rows[int(1)].x);
    float _S957 = (F32_max((_S955), (_S956)));
    float _S958 = _S948.rows[int(1)].y - 1.0f;
    float _S959 = s_primal_ctx_abs_0(_S958);
    float _S960 = (F32_max((_S957), (_S959)));
    float _S961 = s_primal_ctx_abs_0(_S948.rows[int(1)].z);
    float _S962 = (F32_max((_S960), (_S961)));
    float _S963 = s_primal_ctx_abs_0(_S948.rows[int(2)].x);
    float _S964 = (F32_max((_S962), (_S963)));
    float _S965 = s_primal_ctx_abs_0(_S948.rows[int(2)].y);
    float _S966 = (F32_max((_S964), (_S965)));
    float _S967 = _S948.rows[int(2)].z - 1.0f;
    float _S968 = s_primal_ctx_abs_0(_S967);
    bool _S969 = (F32_max((_S966), (_S968))) <= 9.99999997475242708e-07f;
    bool _S970 = !_S969;
    Matrix<float, 3, 3>  _S971;
    Matrix<float, 3, 3>  _S972;
    Matrix<float, 3, 3>  _S973;
    Matrix<float, 3, 3>  _S974;
    float3  _S975;
    float3  _S976;
    float3  _S977;
    float3  _S978;
    bool _S979;
    bool _S980;
    float _S981;
    float _S982;
    float _S983;
    float _S984;
    float _S985;
    float _S986;
    float _S987;
    float _S988;
    float _S989;
    float _S990;
    float _S991;
    float _S992;
    float _S993;
    float _S994;
    float _S995;
    float _S996;
    float _S997;
    float _S998;
    float _S999;
    float _S1000;
    float _S1001;
    float _S1002;
    float _S1003;
    float _S1004;
    float _S1005;
    float _S1006;
    if(_S970)
    {
        if(_S970)
        {
            float3  _S1007 = s_primal_ctx_cross_0(_S943.primal_0.rows[int(1)], _S943.primal_0.rows[int(2)]);
            Matrix<float, 3, 3>  _S1008 = transpose_0(makeMatrix<float, 3, 3> (_S1007, s_primal_ctx_cross_0(_S943.primal_0.rows[int(2)], _S943.primal_0.rows[int(0)]), s_primal_ctx_cross_0(_S943.primal_0.rows[int(0)], _S943.primal_0.rows[int(1)])));
            float _S1009 = s_primal_ctx_dot_0(_S943.primal_0.rows[int(0)], _S1007);
            Matrix<float, 3, 3>  _S1010 = makeMatrix<float, 3, 3> (_S1009);
            Matrix<float, 3, 3>  _S1011 = makeMatrix<float, 3, 3> (_S1009 * _S1009);
            _S971 = _S1008 / makeMatrix<float, 3, 3> (_S1009);
            _S972 = _S1011;
            _S973 = _S1008;
            _S974 = _S1010;
            _S975 = _S943.primal_0.rows[int(0)];
            _S976 = _S1007;
            _S977 = _S943.primal_0.rows[int(1)];
            _S978 = _S943.primal_0.rows[int(2)];
        }
        else
        {
            _S971 = _S947;
            _S972 = _S946;
            _S973 = _S946;
            _S974 = _S946;
            _S975 = _S945;
            _S976 = _S945;
            _S977 = _S945;
            _S978 = _S945;
        }
        _S979 = _S970;
        _S980 = _S969;
        _S981 = _S966;
        _S982 = _S968;
        _S983 = _S967;
        _S984 = _S964;
        _S985 = _S965;
        _S986 = _S948.rows[int(2)].y;
        _S987 = _S962;
        _S988 = _S963;
        _S989 = _S948.rows[int(2)].x;
        _S990 = _S960;
        _S991 = _S961;
        _S992 = _S948.rows[int(1)].z;
        _S993 = _S957;
        _S994 = _S959;
        _S995 = _S958;
        _S996 = _S955;
        _S997 = _S956;
        _S998 = _S948.rows[int(1)].x;
        _S999 = _S953;
        _S1000 = _S954;
        _S1001 = _S948.rows[int(0)].z;
        _S1002 = _S951;
        _S1003 = _S952;
        _S1004 = _S948.rows[int(0)].y;
        _S1005 = _S950;
        _S1006 = _S949;
    }
    else
    {
        _S971 = _S946;
        _S979 = false;
        _S972 = _S946;
        _S973 = _S946;
        _S974 = _S946;
        _S975 = _S945;
        _S976 = _S945;
        _S977 = _S945;
        _S978 = _S945;
        _S980 = false;
        _S981 = 0.0f;
        _S982 = 0.0f;
        _S983 = 0.0f;
        _S984 = 0.0f;
        _S985 = 0.0f;
        _S986 = 0.0f;
        _S987 = 0.0f;
        _S988 = 0.0f;
        _S989 = 0.0f;
        _S990 = 0.0f;
        _S991 = 0.0f;
        _S992 = 0.0f;
        _S993 = 0.0f;
        _S994 = 0.0f;
        _S995 = 0.0f;
        _S996 = 0.0f;
        _S997 = 0.0f;
        _S998 = 0.0f;
        _S999 = 0.0f;
        _S1000 = 0.0f;
        _S1001 = 0.0f;
        _S1002 = 0.0f;
        _S1003 = 0.0f;
        _S1004 = 0.0f;
        _S1005 = 0.0f;
        _S1006 = 0.0f;
    }
    if(_S970)
    {
        DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1012;
        (&_S1012)->primal_0 = _S971;
        (&_S1012)->differential_0 = _S946;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1013;
        (&_S1013)->primal_0 = _S944.primal_0;
        (&_S1013)->differential_0 = _S945;
        s_bwd_prop_mul_0(&_S1012, &_S1013, _s_dOut_1);
        DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1014 = _S1012;
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1015 = _S1013;
        if(_S979)
        {
            Matrix<float, 3, 3>  _S1016 = _S1014.differential_0 / _S972;
            Matrix<float, 3, 3>  _S1017 = _S973 * - _S1016;
            Matrix<float, 3, 3>  _S1018 = _S974 * _S1016;
            float _S1019 = _S1017.rows[int(0)].x + _S1017.rows[int(0)].y + _S1017.rows[int(0)].z + _S1017.rows[int(1)].x + _S1017.rows[int(1)].y + _S1017.rows[int(1)].z + _S1017.rows[int(2)].x + _S1017.rows[int(2)].y + _S1017.rows[int(2)].z;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1020;
            (&_S1020)->primal_0 = _S975;
            (&_S1020)->differential_0 = _S945;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1021;
            (&_S1021)->primal_0 = _S976;
            (&_S1021)->differential_0 = _S945;
            s_bwd_prop_dot_0(&_S1020, &_S1021, _S1019);
            Matrix<float, 3, 3>  _S1022 = transpose_0(_S1018);
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1023;
            (&_S1023)->primal_0 = _S975;
            (&_S1023)->differential_0 = _S945;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1024;
            (&_S1024)->primal_0 = _S977;
            (&_S1024)->differential_0 = _S945;
            s_bwd_prop_cross_0(&_S1023, &_S1024, _S1022.rows[int(2)]);
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1025;
            (&_S1025)->primal_0 = _S978;
            (&_S1025)->differential_0 = _S945;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1026;
            (&_S1026)->primal_0 = _S975;
            (&_S1026)->differential_0 = _S945;
            s_bwd_prop_cross_0(&_S1025, &_S1026, _S1022.rows[int(1)]);
            float3  _S1027 = _S1020.differential_0 + _S1023.differential_0 + _S1026.differential_0;
            float3  _S1028 = _S1021.differential_0 + _S1022.rows[int(0)];
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1029;
            (&_S1029)->primal_0 = _S977;
            (&_S1029)->differential_0 = _S945;
            DiffPair_vectorx3Cfloatx2C3x3E_0 _S1030;
            (&_S1030)->primal_0 = _S978;
            (&_S1030)->differential_0 = _S945;
            s_bwd_prop_cross_0(&_S1029, &_S1030, _S1028);
            float3  _S1031 = _S1025.differential_0 + _S1030.differential_0;
            float3  _S1032 = _S1024.differential_0 + _S1029.differential_0;
            Matrix<float, 3, 3>  _S1033 = _S946;
            _S1033[int(0)] = _S1027;
            _S1033[int(2)] = _S1031;
            _S1033[int(1)] = _S1032;
            _S971 = _S946;
            _S972 = _S1033;
        }
        else
        {
            _S971 = _S1014.differential_0;
            _S972 = _S946;
        }
        if(_S980)
        {
            _S971 = transpose_0(_S971) + _S972;
        }
        else
        {
            _S971 = _S972;
        }
        DiffPair_float_0 _S1034;
        (&_S1034)->primal_0 = _S981;
        (&_S1034)->differential_0 = 0.0f;
        DiffPair_float_0 _S1035;
        (&_S1035)->primal_0 = _S982;
        (&_S1035)->differential_0 = 0.0f;
        _d_max_0(&_S1034, &_S1035, 0.0f);
        DiffPair_float_0 _S1036;
        (&_S1036)->primal_0 = _S983;
        (&_S1036)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S1036, _S1035.differential_0);
        DiffPair_float_0 _S1037;
        (&_S1037)->primal_0 = _S984;
        (&_S1037)->differential_0 = 0.0f;
        DiffPair_float_0 _S1038;
        (&_S1038)->primal_0 = _S985;
        (&_S1038)->differential_0 = 0.0f;
        _d_max_0(&_S1037, &_S1038, _S1034.differential_0);
        DiffPair_float_0 _S1039;
        (&_S1039)->primal_0 = _S986;
        (&_S1039)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S1039, _S1038.differential_0);
        DiffPair_float_0 _S1040;
        (&_S1040)->primal_0 = _S987;
        (&_S1040)->differential_0 = 0.0f;
        DiffPair_float_0 _S1041;
        (&_S1041)->primal_0 = _S988;
        (&_S1041)->differential_0 = 0.0f;
        _d_max_0(&_S1040, &_S1041, _S1037.differential_0);
        DiffPair_float_0 _S1042;
        (&_S1042)->primal_0 = _S989;
        (&_S1042)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S1042, _S1041.differential_0);
        float3  _S1043 = _S945;
        *&((&_S1043)->z) = _S1036.differential_0;
        *&((&_S1043)->y) = _S1039.differential_0;
        *&((&_S1043)->x) = _S1042.differential_0;
        DiffPair_float_0 _S1044;
        (&_S1044)->primal_0 = _S990;
        (&_S1044)->differential_0 = 0.0f;
        DiffPair_float_0 _S1045;
        (&_S1045)->primal_0 = _S991;
        (&_S1045)->differential_0 = 0.0f;
        _d_max_0(&_S1044, &_S1045, _S1040.differential_0);
        DiffPair_float_0 _S1046;
        (&_S1046)->primal_0 = _S992;
        (&_S1046)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S1046, _S1045.differential_0);
        DiffPair_float_0 _S1047;
        (&_S1047)->primal_0 = _S993;
        (&_S1047)->differential_0 = 0.0f;
        DiffPair_float_0 _S1048;
        (&_S1048)->primal_0 = _S994;
        (&_S1048)->differential_0 = 0.0f;
        _d_max_0(&_S1047, &_S1048, _S1044.differential_0);
        DiffPair_float_0 _S1049;
        (&_S1049)->primal_0 = _S995;
        (&_S1049)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S1049, _S1048.differential_0);
        DiffPair_float_0 _S1050;
        (&_S1050)->primal_0 = _S996;
        (&_S1050)->differential_0 = 0.0f;
        DiffPair_float_0 _S1051;
        (&_S1051)->primal_0 = _S997;
        (&_S1051)->differential_0 = 0.0f;
        _d_max_0(&_S1050, &_S1051, _S1047.differential_0);
        DiffPair_float_0 _S1052;
        (&_S1052)->primal_0 = _S998;
        (&_S1052)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S1052, _S1051.differential_0);
        float3  _S1053 = _S945;
        *&((&_S1053)->z) = _S1046.differential_0;
        *&((&_S1053)->y) = _S1049.differential_0;
        *&((&_S1053)->x) = _S1052.differential_0;
        DiffPair_float_0 _S1054;
        (&_S1054)->primal_0 = _S999;
        (&_S1054)->differential_0 = 0.0f;
        DiffPair_float_0 _S1055;
        (&_S1055)->primal_0 = _S1000;
        (&_S1055)->differential_0 = 0.0f;
        _d_max_0(&_S1054, &_S1055, _S1050.differential_0);
        DiffPair_float_0 _S1056;
        (&_S1056)->primal_0 = _S1001;
        (&_S1056)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S1056, _S1055.differential_0);
        DiffPair_float_0 _S1057;
        (&_S1057)->primal_0 = _S1002;
        (&_S1057)->differential_0 = 0.0f;
        DiffPair_float_0 _S1058;
        (&_S1058)->primal_0 = _S1003;
        (&_S1058)->differential_0 = 0.0f;
        _d_max_0(&_S1057, &_S1058, _S1054.differential_0);
        DiffPair_float_0 _S1059;
        (&_S1059)->primal_0 = _S1004;
        (&_S1059)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S1059, _S1058.differential_0);
        DiffPair_float_0 _S1060;
        (&_S1060)->primal_0 = 0.0f;
        (&_S1060)->differential_0 = 0.0f;
        DiffPair_float_0 _S1061;
        (&_S1061)->primal_0 = _S1005;
        (&_S1061)->differential_0 = 0.0f;
        _d_max_0(&_S1060, &_S1061, _S1057.differential_0);
        DiffPair_float_0 _S1062;
        (&_S1062)->primal_0 = _S1006;
        (&_S1062)->differential_0 = 0.0f;
        s_bwd_prop_abs_0(&_S1062, _S1061.differential_0);
        float3  _S1063 = _S945;
        *&((&_S1063)->z) = _S1056.differential_0;
        *&((&_S1063)->y) = _S1059.differential_0;
        *&((&_S1063)->x) = _S1062.differential_0;
        Matrix<float, 3, 3>  _S1064 = _S946;
        _S1064[int(2)] = _S1043;
        _S1064[int(1)] = _S1053;
        _S1064[int(0)] = _S1063;
        _S975 = _S945;
        _S976 = _S1015.differential_0;
    }
    else
    {
        _S975 = _s_dOut_1;
        _S971 = _S946;
        _S976 = _S945;
    }
    if(_S969)
    {
        DiffPair_vectorx3Cfloatx2C3x3E_0 _S1065;
        (&_S1065)->primal_0 = _S944.primal_0;
        (&_S1065)->differential_0 = _S945;
        DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1066;
        (&_S1066)->primal_0 = _S943.primal_0;
        (&_S1066)->differential_0 = _S946;
        s_bwd_prop_mul_1(&_S1065, &_S1066, _S975);
        Matrix<float, 3, 3>  _S1067 = _S1066.differential_0 + _S971;
        _S975 = _S1065.differential_0 + _S976;
        _S971 = _S1067;
    }
    else
    {
        _S975 = _S976;
    }
    DiffPair_float_0 _S1068;
    (&_S1068)->primal_0 = _S966;
    (&_S1068)->differential_0 = 0.0f;
    DiffPair_float_0 _S1069;
    (&_S1069)->primal_0 = _S968;
    (&_S1069)->differential_0 = 0.0f;
    _d_max_0(&_S1068, &_S1069, 0.0f);
    DiffPair_float_0 _S1070;
    (&_S1070)->primal_0 = _S967;
    (&_S1070)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S1070, _S1069.differential_0);
    DiffPair_float_0 _S1071;
    (&_S1071)->primal_0 = _S964;
    (&_S1071)->differential_0 = 0.0f;
    DiffPair_float_0 _S1072;
    (&_S1072)->primal_0 = _S965;
    (&_S1072)->differential_0 = 0.0f;
    _d_max_0(&_S1071, &_S1072, _S1068.differential_0);
    DiffPair_float_0 _S1073;
    (&_S1073)->primal_0 = _S948.rows[int(2)].y;
    (&_S1073)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S1073, _S1072.differential_0);
    DiffPair_float_0 _S1074;
    (&_S1074)->primal_0 = _S962;
    (&_S1074)->differential_0 = 0.0f;
    DiffPair_float_0 _S1075;
    (&_S1075)->primal_0 = _S963;
    (&_S1075)->differential_0 = 0.0f;
    _d_max_0(&_S1074, &_S1075, _S1071.differential_0);
    DiffPair_float_0 _S1076;
    (&_S1076)->primal_0 = _S948.rows[int(2)].x;
    (&_S1076)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S1076, _S1075.differential_0);
    float3  _S1077 = _S945;
    *&((&_S1077)->z) = _S1070.differential_0;
    *&((&_S1077)->y) = _S1073.differential_0;
    *&((&_S1077)->x) = _S1076.differential_0;
    DiffPair_float_0 _S1078;
    (&_S1078)->primal_0 = _S960;
    (&_S1078)->differential_0 = 0.0f;
    DiffPair_float_0 _S1079;
    (&_S1079)->primal_0 = _S961;
    (&_S1079)->differential_0 = 0.0f;
    _d_max_0(&_S1078, &_S1079, _S1074.differential_0);
    DiffPair_float_0 _S1080;
    (&_S1080)->primal_0 = _S948.rows[int(1)].z;
    (&_S1080)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S1080, _S1079.differential_0);
    DiffPair_float_0 _S1081;
    (&_S1081)->primal_0 = _S957;
    (&_S1081)->differential_0 = 0.0f;
    DiffPair_float_0 _S1082;
    (&_S1082)->primal_0 = _S959;
    (&_S1082)->differential_0 = 0.0f;
    _d_max_0(&_S1081, &_S1082, _S1078.differential_0);
    DiffPair_float_0 _S1083;
    (&_S1083)->primal_0 = _S958;
    (&_S1083)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S1083, _S1082.differential_0);
    DiffPair_float_0 _S1084;
    (&_S1084)->primal_0 = _S955;
    (&_S1084)->differential_0 = 0.0f;
    DiffPair_float_0 _S1085;
    (&_S1085)->primal_0 = _S956;
    (&_S1085)->differential_0 = 0.0f;
    _d_max_0(&_S1084, &_S1085, _S1081.differential_0);
    DiffPair_float_0 _S1086;
    (&_S1086)->primal_0 = _S948.rows[int(1)].x;
    (&_S1086)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S1086, _S1085.differential_0);
    float3  _S1087 = _S945;
    *&((&_S1087)->z) = _S1080.differential_0;
    *&((&_S1087)->y) = _S1083.differential_0;
    *&((&_S1087)->x) = _S1086.differential_0;
    DiffPair_float_0 _S1088;
    (&_S1088)->primal_0 = _S953;
    (&_S1088)->differential_0 = 0.0f;
    DiffPair_float_0 _S1089;
    (&_S1089)->primal_0 = _S954;
    (&_S1089)->differential_0 = 0.0f;
    _d_max_0(&_S1088, &_S1089, _S1084.differential_0);
    DiffPair_float_0 _S1090;
    (&_S1090)->primal_0 = _S948.rows[int(0)].z;
    (&_S1090)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S1090, _S1089.differential_0);
    DiffPair_float_0 _S1091;
    (&_S1091)->primal_0 = _S951;
    (&_S1091)->differential_0 = 0.0f;
    DiffPair_float_0 _S1092;
    (&_S1092)->primal_0 = _S952;
    (&_S1092)->differential_0 = 0.0f;
    _d_max_0(&_S1091, &_S1092, _S1088.differential_0);
    DiffPair_float_0 _S1093;
    (&_S1093)->primal_0 = _S948.rows[int(0)].y;
    (&_S1093)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S1093, _S1092.differential_0);
    DiffPair_float_0 _S1094;
    (&_S1094)->primal_0 = 0.0f;
    (&_S1094)->differential_0 = 0.0f;
    DiffPair_float_0 _S1095;
    (&_S1095)->primal_0 = _S950;
    (&_S1095)->differential_0 = 0.0f;
    _d_max_0(&_S1094, &_S1095, _S1091.differential_0);
    DiffPair_float_0 _S1096;
    (&_S1096)->primal_0 = _S949;
    (&_S1096)->differential_0 = 0.0f;
    s_bwd_prop_abs_0(&_S1096, _S1095.differential_0);
    float3  _S1097 = _S945;
    *&((&_S1097)->z) = _S1090.differential_0;
    *&((&_S1097)->y) = _S1093.differential_0;
    *&((&_S1097)->x) = _S1096.differential_0;
    Matrix<float, 3, 3>  _S1098 = _S946;
    _S1098[int(2)] = _S1077;
    _S1098[int(1)] = _S1087;
    _S1098[int(0)] = _S1097;
    dpraydir_0->primal_0 = (*dpraydir_0).primal_0;
    dpraydir_0->differential_0 = _S975;
    dpR_1->primal_0 = (*dpR_1).primal_0;
    dpR_1->differential_0 = _S971;
    return;
}

inline __device__ void s_bwd_transform_ray_d_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S1099, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1100, float3  _S1101)
{
    s_bwd_prop_transform_ray_d_0(_S1099, _S1100, _S1101);
    return;
}

inline __device__ void transform_ray_d_vjp(Matrix<float, 3, 3>  R_4, float3  raydir_11, float3  v_ray_d_0, Matrix<float, 3, 3>  * v_R_1, float3  * v_raydir_0)
{
    Matrix<float, 3, 3>  _S1102 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 dp_R_1;
    (&dp_R_1)->primal_0 = R_4;
    (&dp_R_1)->differential_0 = _S1102;
    float3  _S1103 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_raydir_0;
    (&dp_raydir_0)->primal_0 = raydir_11;
    (&dp_raydir_0)->differential_0 = _S1103;
    s_bwd_transform_ray_d_0(&dp_R_1, &dp_raydir_0, v_ray_d_0);
    *v_R_1 = dp_R_1.differential_0;
    *v_raydir_0 = dp_raydir_0.differential_0;
    return;
}

inline __device__ void _d_exp_0(DiffPair_float_0 * dpx_7, float dOut_7)
{
    float _S1104 = (F32_exp(((*dpx_7).primal_0))) * dOut_7;
    dpx_7->primal_0 = (*dpx_7).primal_0;
    dpx_7->differential_0 = _S1104;
    return;
}

inline __device__ float3  exp_0(float3  x_12)
{
    float3  result_9;
    int i_7 = int(0);
    for(;;)
    {
        if(i_7 < int(3))
        {
        }
        else
        {
            break;
        }
        *_slang_vector_get_element_ptr(&result_9, i_7) = (F32_exp((_slang_vector_get_element(x_12, i_7))));
        i_7 = i_7 + int(1);
    }
    return result_9;
}

inline __device__ void _d_exp_vector_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dpx_8, float3  dOut_8)
{
    float3  _S1105 = exp_0((*dpx_8).primal_0) * dOut_8;
    dpx_8->primal_0 = (*dpx_8).primal_0;
    dpx_8->differential_0 = _S1105;
    return;
}

inline __device__ Matrix<float, 3, 3>  compute_3dgut_iscl_rot(float4  quat_5, float3  scale_4)
{
    float x_13 = quat_5.y;
    float x2_5 = x_13 * x_13;
    float y2_5 = quat_5.z * quat_5.z;
    float z2_5 = quat_5.w * quat_5.w;
    float xy_5 = quat_5.y * quat_5.z;
    float xz_5 = quat_5.y * quat_5.w;
    float yz_5 = quat_5.z * quat_5.w;
    float wx_5 = quat_5.x * quat_5.y;
    float wy_5 = quat_5.x * quat_5.z;
    float wz_5 = quat_5.x * quat_5.w;
    float3  _S1106 = exp_0(- scale_4);
    return mul_1(makeMatrix<float, 3, 3> (_S1106.x, 0.0f, 0.0f, 0.0f, _S1106.y, 0.0f, 0.0f, 0.0f, _S1106.z), transpose_0(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_5 + z2_5), 2.0f * (xy_5 + wz_5), 2.0f * (xz_5 - wy_5), 2.0f * (xy_5 - wz_5), 1.0f - 2.0f * (x2_5 + z2_5), 2.0f * (yz_5 + wx_5), 2.0f * (xz_5 + wy_5), 2.0f * (yz_5 - wx_5), 1.0f - 2.0f * (x2_5 + y2_5)))));
}

struct DiffPair_vectorx3Cfloatx2C4x3E_0
{
    float4  primal_0;
    float4  differential_0;
};

inline __device__ float3  s_primal_ctx_exp_0(float3  _S1107)
{
    return exp_0(_S1107);
}

inline __device__ void s_bwd_prop_mul_2(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S1108, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S1109, Matrix<float, 3, 3>  _S1110)
{
    mul_0(_S1108, _S1109, _S1110);
    return;
}

inline __device__ void s_bwd_prop_exp_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1111, float3  _S1112)
{
    _d_exp_vector_0(_S1111, _S1112);
    return;
}

inline __device__ void s_bwd_prop_compute_3dgut_iscl_rot_0(DiffPair_vectorx3Cfloatx2C4x3E_0 * dpquat_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpscale_0, Matrix<float, 3, 3>  _s_dOut_2)
{
    float _S1113 = (*dpquat_0).primal_0.y;
    float x2_6 = _S1113 * _S1113;
    float y2_6 = (*dpquat_0).primal_0.z * (*dpquat_0).primal_0.z;
    float z2_6 = (*dpquat_0).primal_0.w * (*dpquat_0).primal_0.w;
    float xy_6 = (*dpquat_0).primal_0.y * (*dpquat_0).primal_0.z;
    float xz_6 = (*dpquat_0).primal_0.y * (*dpquat_0).primal_0.w;
    float yz_6 = (*dpquat_0).primal_0.z * (*dpquat_0).primal_0.w;
    float wx_6 = (*dpquat_0).primal_0.x * (*dpquat_0).primal_0.y;
    float wy_6 = (*dpquat_0).primal_0.x * (*dpquat_0).primal_0.z;
    float wz_6 = (*dpquat_0).primal_0.x * (*dpquat_0).primal_0.w;
    float3  _S1114 = - (*dpscale_0).primal_0;
    float3  _S1115 = s_primal_ctx_exp_0(_S1114);
    Matrix<float, 3, 3>  _S1116 = transpose_0(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_6 + z2_6), 2.0f * (xy_6 + wz_6), 2.0f * (xz_6 - wy_6), 2.0f * (xy_6 - wz_6), 1.0f - 2.0f * (x2_6 + z2_6), 2.0f * (yz_6 + wx_6), 2.0f * (xz_6 + wy_6), 2.0f * (yz_6 - wx_6), 1.0f - 2.0f * (x2_6 + y2_6))));
    Matrix<float, 3, 3>  _S1117 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1118;
    (&_S1118)->primal_0 = makeMatrix<float, 3, 3> (_S1115.x, 0.0f, 0.0f, 0.0f, _S1115.y, 0.0f, 0.0f, 0.0f, _S1115.z);
    (&_S1118)->differential_0 = _S1117;
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1119;
    (&_S1119)->primal_0 = _S1116;
    (&_S1119)->differential_0 = _S1117;
    s_bwd_prop_mul_2(&_S1118, &_S1119, _s_dOut_2);
    Matrix<float, 3, 3>  _S1120 = transpose_0(_S1119.differential_0);
    float3  _S1121 = make_float3 (_S1118.differential_0.rows[int(0)].x, _S1118.differential_0.rows[int(1)].y, _S1118.differential_0.rows[int(2)].z);
    float3  _S1122 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1123;
    (&_S1123)->primal_0 = _S1114;
    (&_S1123)->differential_0 = _S1122;
    s_bwd_prop_exp_0(&_S1123, _S1121);
    float3  _S1124 = - _S1123.differential_0;
    Matrix<float, 3, 3>  _S1125 = transpose_0(_S1120);
    float _S1126 = 2.0f * - _S1125.rows[int(2)].z;
    float _S1127 = 2.0f * _S1125.rows[int(2)].y;
    float _S1128 = 2.0f * _S1125.rows[int(2)].x;
    float _S1129 = 2.0f * _S1125.rows[int(1)].z;
    float _S1130 = 2.0f * - _S1125.rows[int(1)].y;
    float _S1131 = 2.0f * _S1125.rows[int(1)].x;
    float _S1132 = 2.0f * _S1125.rows[int(0)].z;
    float _S1133 = 2.0f * _S1125.rows[int(0)].y;
    float _S1134 = 2.0f * - _S1125.rows[int(0)].x;
    float _S1135 = - _S1131 + _S1133;
    float _S1136 = _S1128 + - _S1132;
    float _S1137 = - _S1127 + _S1129;
    float _S1138 = _S1127 + _S1129;
    float _S1139 = _S1128 + _S1132;
    float _S1140 = _S1131 + _S1133;
    float _S1141 = (*dpquat_0).primal_0.w * (_S1130 + _S1134);
    float _S1142 = (*dpquat_0).primal_0.z * (_S1126 + _S1134);
    float _S1143 = (*dpquat_0).primal_0.y * (_S1126 + _S1130);
    float _S1144 = (*dpquat_0).primal_0.x * _S1135 + (*dpquat_0).primal_0.z * _S1138 + (*dpquat_0).primal_0.y * _S1139 + _S1141 + _S1141;
    float _S1145 = (*dpquat_0).primal_0.x * _S1136 + (*dpquat_0).primal_0.w * _S1138 + (*dpquat_0).primal_0.y * _S1140 + _S1142 + _S1142;
    float _S1146 = (*dpquat_0).primal_0.x * _S1137 + (*dpquat_0).primal_0.w * _S1139 + (*dpquat_0).primal_0.z * _S1140 + _S1143 + _S1143;
    float _S1147 = (*dpquat_0).primal_0.w * _S1135 + (*dpquat_0).primal_0.z * _S1136 + (*dpquat_0).primal_0.y * _S1137;
    dpscale_0->primal_0 = (*dpscale_0).primal_0;
    dpscale_0->differential_0 = _S1124;
    float4  _S1148 = make_float4 (0.0f);
    *&((&_S1148)->w) = _S1144;
    *&((&_S1148)->z) = _S1145;
    *&((&_S1148)->y) = _S1146;
    *&((&_S1148)->x) = _S1147;
    dpquat_0->primal_0 = (*dpquat_0).primal_0;
    dpquat_0->differential_0 = _S1148;
    return;
}

inline __device__ void s_bwd_compute_3dgut_iscl_rot_0(DiffPair_vectorx3Cfloatx2C4x3E_0 * _S1149, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1150, Matrix<float, 3, 3>  _S1151)
{
    s_bwd_prop_compute_3dgut_iscl_rot_0(_S1149, _S1150, _S1151);
    return;
}

inline __device__ void compute_3dgut_iscl_rot_vjp(float4  quat_6, float3  scale_5, Matrix<float, 3, 3>  v_iscl_rot_0, float4  * v_quat_0, float3  * v_scale_0)
{
    float4  _S1152 = make_float4 (0.0f);
    DiffPair_vectorx3Cfloatx2C4x3E_0 dp_quat_0;
    (&dp_quat_0)->primal_0 = quat_6;
    (&dp_quat_0)->differential_0 = _S1152;
    float3  _S1153 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_scale_0;
    (&dp_scale_0)->primal_0 = scale_5;
    (&dp_scale_0)->differential_0 = _S1153;
    s_bwd_compute_3dgut_iscl_rot_0(&dp_quat_0, &dp_scale_0, v_iscl_rot_0);
    *v_quat_0 = dp_quat_0.differential_0;
    *v_scale_0 = dp_scale_0.differential_0;
    return;
}

inline __device__ float evaluate_alpha_3dgs(float3  mean_0, Matrix<float, 3, 3>  iscl_rot_0, float opacity_0, float3  ray_o_0, float3  ray_d_0)
{
    float3  grd_0 = mul_2(iscl_rot_0, ray_d_0);
    float3  gcrod_0 = cross_0(grd_0, mul_2(iscl_rot_0, ray_o_0 - mean_0));
    return opacity_0 * (F32_exp((-0.5f * dot_1(gcrod_0, gcrod_0) / dot_1(grd_0, grd_0))));
}

inline __device__ float3  s_primal_ctx_mul_1(Matrix<float, 3, 3>  _S1154, float3  _S1155)
{
    return mul_2(_S1154, _S1155);
}

inline __device__ float s_primal_ctx_exp_1(float _S1156)
{
    return (F32_exp((_S1156)));
}

inline __device__ void s_bwd_prop_exp_1(DiffPair_float_0 * _S1157, float _S1158)
{
    _d_exp_0(_S1157, _S1158);
    return;
}

inline __device__ void s_bwd_prop_evaluate_alpha_3dgs_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dpmean_0, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * dpiscl_rot_0, DiffPair_float_0 * dpopacity_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpray_o_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpray_d_0, float _s_dOut_3)
{
    float3  _S1159 = (*dpray_o_0).primal_0 - (*dpmean_0).primal_0;
    float3  _S1160 = s_primal_ctx_mul_1((*dpiscl_rot_0).primal_0, _S1159);
    float3  _S1161 = s_primal_ctx_mul_1((*dpiscl_rot_0).primal_0, (*dpray_d_0).primal_0);
    float3  _S1162 = s_primal_ctx_cross_0(_S1161, _S1160);
    float _S1163 = -0.5f * s_primal_ctx_dot_0(_S1162, _S1162);
    float _S1164 = s_primal_ctx_dot_0(_S1161, _S1161);
    float _S1165 = _S1163 / _S1164;
    float _S1166 = _S1164 * _S1164;
    float _S1167 = (*dpopacity_0).primal_0 * _s_dOut_3;
    float _S1168 = s_primal_ctx_exp_1(_S1165) * _s_dOut_3;
    DiffPair_float_0 _S1169;
    (&_S1169)->primal_0 = _S1165;
    (&_S1169)->differential_0 = 0.0f;
    s_bwd_prop_exp_1(&_S1169, _S1167);
    float _S1170 = _S1169.differential_0 / _S1166;
    float _S1171 = _S1163 * - _S1170;
    float _S1172 = _S1164 * _S1170;
    float3  _S1173 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1174;
    (&_S1174)->primal_0 = _S1161;
    (&_S1174)->differential_0 = _S1173;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1175;
    (&_S1175)->primal_0 = _S1161;
    (&_S1175)->differential_0 = _S1173;
    s_bwd_prop_dot_0(&_S1174, &_S1175, _S1171);
    float _S1176 = -0.5f * _S1172;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1177;
    (&_S1177)->primal_0 = _S1162;
    (&_S1177)->differential_0 = _S1173;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1178;
    (&_S1178)->primal_0 = _S1162;
    (&_S1178)->differential_0 = _S1173;
    s_bwd_prop_dot_0(&_S1177, &_S1178, _S1176);
    float3  _S1179 = _S1178.differential_0 + _S1177.differential_0;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1180;
    (&_S1180)->primal_0 = _S1161;
    (&_S1180)->differential_0 = _S1173;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1181;
    (&_S1181)->primal_0 = _S1160;
    (&_S1181)->differential_0 = _S1173;
    s_bwd_prop_cross_0(&_S1180, &_S1181, _S1179);
    float3  _S1182 = _S1175.differential_0 + _S1174.differential_0 + _S1180.differential_0;
    Matrix<float, 3, 3>  _S1183 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1184;
    (&_S1184)->primal_0 = (*dpiscl_rot_0).primal_0;
    (&_S1184)->differential_0 = _S1183;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1185;
    (&_S1185)->primal_0 = (*dpray_d_0).primal_0;
    (&_S1185)->differential_0 = _S1173;
    s_bwd_prop_mul_0(&_S1184, &_S1185, _S1182);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1186;
    (&_S1186)->primal_0 = (*dpiscl_rot_0).primal_0;
    (&_S1186)->differential_0 = _S1183;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1187;
    (&_S1187)->primal_0 = _S1159;
    (&_S1187)->differential_0 = _S1173;
    s_bwd_prop_mul_0(&_S1186, &_S1187, _S1181.differential_0);
    float3  _S1188 = - _S1187.differential_0;
    dpray_d_0->primal_0 = (*dpray_d_0).primal_0;
    dpray_d_0->differential_0 = _S1185.differential_0;
    dpray_o_0->primal_0 = (*dpray_o_0).primal_0;
    dpray_o_0->differential_0 = _S1187.differential_0;
    dpopacity_0->primal_0 = (*dpopacity_0).primal_0;
    dpopacity_0->differential_0 = _S1168;
    Matrix<float, 3, 3>  _S1189 = _S1184.differential_0 + _S1186.differential_0;
    dpiscl_rot_0->primal_0 = (*dpiscl_rot_0).primal_0;
    dpiscl_rot_0->differential_0 = _S1189;
    dpmean_0->primal_0 = (*dpmean_0).primal_0;
    dpmean_0->differential_0 = _S1188;
    return;
}

inline __device__ void s_bwd_evaluate_alpha_3dgs_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1190, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S1191, DiffPair_float_0 * _S1192, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1193, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1194, float _S1195)
{
    s_bwd_prop_evaluate_alpha_3dgs_0(_S1190, _S1191, _S1192, _S1193, _S1194, _S1195);
    return;
}

inline __device__ void evaluate_alpha_3dgs_vjp(float3  mean_1, Matrix<float, 3, 3>  iscl_rot_1, float opacity_1, float3  ray_o_1, float3  ray_d_1, float v_alpha_0, float3  * v_mean_0, Matrix<float, 3, 3>  * v_iscl_rot_1, float * v_opacity_0, float3  * v_ray_o_1, float3  * v_ray_d_1)
{
    float3  _S1196 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_mean_0;
    (&dp_mean_0)->primal_0 = mean_1;
    (&dp_mean_0)->differential_0 = _S1196;
    Matrix<float, 3, 3>  _S1197 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 dp_iscl_rot_0;
    (&dp_iscl_rot_0)->primal_0 = iscl_rot_1;
    (&dp_iscl_rot_0)->differential_0 = _S1197;
    DiffPair_float_0 dp_opacity_0;
    (&dp_opacity_0)->primal_0 = opacity_1;
    (&dp_opacity_0)->differential_0 = 0.0f;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_ray_o_0;
    (&dp_ray_o_0)->primal_0 = ray_o_1;
    (&dp_ray_o_0)->differential_0 = _S1196;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_ray_d_0;
    (&dp_ray_d_0)->primal_0 = ray_d_1;
    (&dp_ray_d_0)->differential_0 = _S1196;
    s_bwd_evaluate_alpha_3dgs_0(&dp_mean_0, &dp_iscl_rot_0, &dp_opacity_0, &dp_ray_o_0, &dp_ray_d_0, v_alpha_0);
    *v_mean_0 = dp_mean_0.differential_0;
    *v_iscl_rot_1 = dp_iscl_rot_0.differential_0;
    *v_opacity_0 = dp_opacity_0.differential_0;
    *v_ray_o_1 = dp_ray_o_0.differential_0;
    *v_ray_d_1 = dp_ray_d_0.differential_0;
    return;
}

inline __device__ void evaluate_color_3dgs(float3  mean_2, Matrix<float, 3, 3>  iscl_rot_2, float opacity_2, float3  rgb_0, float3  ray_o_2, float3  ray_d_2, float3  * out_rgb_0, float * depth_0)
{
    *out_rgb_0 = rgb_0;
    float3  grd_1 = mul_2(iscl_rot_2, ray_d_2);
    *depth_0 = - dot_1(mul_2(iscl_rot_2, ray_o_2 - mean_2), grd_1) / dot_1(grd_1, grd_1);
    return;
}

inline __device__ void s_bwd_prop_evaluate_color_3dgs_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dpmean_1, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * dpiscl_rot_1, DiffPair_float_0 * dpopacity_1, DiffPair_vectorx3Cfloatx2C3x3E_0 * dprgb_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpray_o_1, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpray_d_1, float3  dpout_rgb_0, float dpdepth_0)
{
    float3  _S1198 = (*dpray_o_1).primal_0 - (*dpmean_1).primal_0;
    float3  _S1199 = s_primal_ctx_mul_1((*dpiscl_rot_1).primal_0, _S1198);
    float3  _S1200 = s_primal_ctx_mul_1((*dpiscl_rot_1).primal_0, (*dpray_d_1).primal_0);
    float _S1201 = s_primal_ctx_dot_0(_S1200, _S1200);
    float _S1202 = dpdepth_0 / (_S1201 * _S1201);
    float _S1203 = - s_primal_ctx_dot_0(_S1199, _S1200) * - _S1202;
    float _S1204 = _S1201 * _S1202;
    float3  _S1205 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1206;
    (&_S1206)->primal_0 = _S1200;
    (&_S1206)->differential_0 = _S1205;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1207;
    (&_S1207)->primal_0 = _S1200;
    (&_S1207)->differential_0 = _S1205;
    s_bwd_prop_dot_0(&_S1206, &_S1207, _S1203);
    float _S1208 = - _S1204;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1209;
    (&_S1209)->primal_0 = _S1199;
    (&_S1209)->differential_0 = _S1205;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1210;
    (&_S1210)->primal_0 = _S1200;
    (&_S1210)->differential_0 = _S1205;
    s_bwd_prop_dot_0(&_S1209, &_S1210, _S1208);
    float3  _S1211 = _S1207.differential_0 + _S1206.differential_0 + _S1210.differential_0;
    Matrix<float, 3, 3>  _S1212 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1213;
    (&_S1213)->primal_0 = (*dpiscl_rot_1).primal_0;
    (&_S1213)->differential_0 = _S1212;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1214;
    (&_S1214)->primal_0 = (*dpray_d_1).primal_0;
    (&_S1214)->differential_0 = _S1205;
    s_bwd_prop_mul_0(&_S1213, &_S1214, _S1211);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1215;
    (&_S1215)->primal_0 = (*dpiscl_rot_1).primal_0;
    (&_S1215)->differential_0 = _S1212;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1216;
    (&_S1216)->primal_0 = _S1198;
    (&_S1216)->differential_0 = _S1205;
    s_bwd_prop_mul_0(&_S1215, &_S1216, _S1209.differential_0);
    float3  _S1217 = - _S1216.differential_0;
    dpray_d_1->primal_0 = (*dpray_d_1).primal_0;
    dpray_d_1->differential_0 = _S1214.differential_0;
    dpray_o_1->primal_0 = (*dpray_o_1).primal_0;
    dpray_o_1->differential_0 = _S1216.differential_0;
    dprgb_0->primal_0 = (*dprgb_0).primal_0;
    dprgb_0->differential_0 = dpout_rgb_0;
    dpopacity_1->primal_0 = (*dpopacity_1).primal_0;
    dpopacity_1->differential_0 = 0.0f;
    Matrix<float, 3, 3>  _S1218 = _S1213.differential_0 + _S1215.differential_0;
    dpiscl_rot_1->primal_0 = (*dpiscl_rot_1).primal_0;
    dpiscl_rot_1->differential_0 = _S1218;
    dpmean_1->primal_0 = (*dpmean_1).primal_0;
    dpmean_1->differential_0 = _S1217;
    return;
}

inline __device__ void s_bwd_evaluate_color_3dgs_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1219, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S1220, DiffPair_float_0 * _S1221, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1222, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1223, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1224, float3  _S1225, float _S1226)
{
    s_bwd_prop_evaluate_color_3dgs_0(_S1219, _S1220, _S1221, _S1222, _S1223, _S1224, _S1225, _S1226);
    return;
}

inline __device__ void evaluate_color_3dgs_vjp(float3  mean_3, Matrix<float, 3, 3>  iscl_rot_3, float opacity_3, float3  rgb_1, float3  ray_o_3, float3  ray_d_3, float3  v_out_rgb_0, float v_depth_0, float3  * v_mean_1, Matrix<float, 3, 3>  * v_iscl_rot_2, float * v_opacity_1, float3  * v_rgb_0, float3  * v_ray_o_2, float3  * v_ray_d_2)
{
    float3  _S1227 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_mean_1;
    (&dp_mean_1)->primal_0 = mean_3;
    (&dp_mean_1)->differential_0 = _S1227;
    Matrix<float, 3, 3>  _S1228 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 dp_iscl_rot_1;
    (&dp_iscl_rot_1)->primal_0 = iscl_rot_3;
    (&dp_iscl_rot_1)->differential_0 = _S1228;
    DiffPair_float_0 dp_opacity_1;
    (&dp_opacity_1)->primal_0 = opacity_3;
    (&dp_opacity_1)->differential_0 = 0.0f;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_rgb_0;
    (&dp_rgb_0)->primal_0 = rgb_1;
    (&dp_rgb_0)->differential_0 = _S1227;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_ray_o_1;
    (&dp_ray_o_1)->primal_0 = ray_o_3;
    (&dp_ray_o_1)->differential_0 = _S1227;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_ray_d_1;
    (&dp_ray_d_1)->primal_0 = ray_d_3;
    (&dp_ray_d_1)->differential_0 = _S1227;
    s_bwd_evaluate_color_3dgs_0(&dp_mean_1, &dp_iscl_rot_1, &dp_opacity_1, &dp_rgb_0, &dp_ray_o_1, &dp_ray_d_1, v_out_rgb_0, v_depth_0);
    *v_mean_1 = dp_mean_1.differential_0;
    *v_iscl_rot_2 = dp_iscl_rot_1.differential_0;
    *v_opacity_1 = dp_opacity_1.differential_0;
    *v_rgb_0 = dp_rgb_0.differential_0;
    *v_ray_o_2 = dp_ray_o_1.differential_0;
    *v_ray_d_2 = dp_ray_d_1.differential_0;
    return;
}

inline __device__ float view_radius_3dgs(float3  mean_4, float3  log_scale_0, float logit_opacity_0, float3  campos_0)
{
    float radius_0 = (F32_exp(((F32_max((log_scale_0.x), ((F32_max((log_scale_0.y), (log_scale_0.z))))))))) * (F32_sqrt((2.0f * (F32_log(((F32_max((255.0f / (1.0f + (F32_exp((- logit_opacity_0))))), (1.0f)))))))));
    float dist_0 = length_1(mean_4 - campos_0);
    return radius_0 / ((F32_max((dist_0), (radius_0))) + (F32_sqrt(((F32_max((dist_0 * dist_0 - radius_0 * radius_0), (0.0f)))))));
}

