#pragma once

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <numeric>
#include <stdexcept>
#include <vector>

namespace spirula::stereo::study {

struct Contributions {
    std::vector<double> weight;
    std::vector<int> peak_pixel;
    std::vector<float> peak_weight;
    std::vector<float> transmission;
    std::vector<double> opacity, inverse_depth;
};

template<class Visitor>
Contributions raster(const std::vector<float>& rows, const std::vector<double>& z,
                     int width, int height, Visitor visit) {
    const size_t count = z.size();
    if (rows.size()!=14*count || width<=0 || height<=0 || count>500000)
        throw std::runtime_error("depth study: invalid projection raster");
    Contributions result;
    result.weight.assign(count,0);
    result.peak_pixel.assign(count,-1);
    result.peak_weight.assign(count,0);
    result.transmission.assign((size_t)width*height,1);
    result.opacity.assign(result.transmission.size(),0);
    result.inverse_depth.assign(result.transmission.size(),0);
    std::vector<uint8_t> done(result.transmission.size(),0);
    std::vector<size_t> order(count);
    std::iota(order.begin(),order.end(),0);
    std::stable_sort(order.begin(),order.end(),[&](size_t a,size_t b) { return (std::isfinite(z[a]) ? z[a] : INFINITY)<(std::isfinite(z[b]) ? z[b] : INFINITY); });
    for (size_t i:order) {
        const float* row = rows.data()+14*i;
        const double a=row[6], b=row[7], c=row[8], opacity=row[9];
        const double determinant=a*c-b*b;
        if (!(z[i]>0 && std::isfinite(z[i]) && opacity>1./255. && determinant>0)) continue;
        const double sigma=2*std::log(255*opacity);
        const double rx=std::sqrt(sigma*c/determinant), ry=std::sqrt(sigma*a/determinant);
        if (!(std::isfinite(rx) && std::isfinite(ry) && std::isfinite(row[4]) && std::isfinite(row[5]))) continue;
        if (row[4]+rx<-.5 || row[4]-rx>width+.5 || row[5]+ry<-.5 || row[5]-ry>height+.5) continue;
        const int x0=(int)std::max(0.,std::floor(row[4]-rx-.5)-1);
        const int x1=(int)std::min((double)width-1,std::ceil(row[4]+rx-.5)+1);
        const int y0=(int)std::max(0.,std::floor(row[5]-ry-.5)-1);
        const int y1=(int)std::min((double)height-1,std::ceil(row[5]+ry-.5)+1);
        float peak=0;
        for (int y=y0;y<=y1;++y) for (int x=x0;x<=x1;++x) {
            const size_t pixel=(size_t)y*width+x;
            if (done[pixel]) continue;
            const float dx=row[4]-(x+.5f),dy=row[5]-(y+.5f);
            const float power=.5f*(row[6]*dx*dx+row[8]*dy*dy)+row[7]*dx*dy;
            if (power<0) continue;
            const float alpha=std::min(.999f,row[9]*std::exp(-power));
            if (alpha<=1.f/255.f) continue;
            const float before=result.transmission[pixel];
            const float after=before*(1-alpha);
            if (after<=1e-4f) { done[pixel]=1; continue; }
            const float weight=before*alpha;
            result.weight[i]+=weight;
            result.opacity[pixel]+=weight;
            result.inverse_depth[pixel]+=weight/z[i];
            if (weight>peak) { peak=weight;result.peak_pixel[i]=(int)pixel;result.peak_weight[i]=weight; }
            result.transmission[pixel]=after;
            visit(i,pixel,weight);
        }
    }
    return result;
}

inline double quantile(const std::vector<double>& depths,const std::vector<double>& weights,double p) {
    std::vector<size_t> order(depths.size());
    std::iota(order.begin(),order.end(),0);
    std::stable_sort(order.begin(),order.end(),[&](size_t a,size_t b) { return (std::isfinite(depths[a]) ? depths[a] : INFINITY)<(std::isfinite(depths[b]) ? depths[b] : INFINITY); });
    const double total=std::accumulate(weights.begin(),weights.end(),0.);
    if (!(total>0)) throw std::runtime_error("depth study: no visible contribution");
    double sum=0;
    for (size_t i:order) { sum+=weights[i];if (sum>=p*total) return depths[i]; }
    return depths[order.back()];
}

inline std::vector<double> pixel_depths(const Contributions& contributions) {
    std::vector<double> depths(contributions.opacity.size(),INFINITY);
    for (size_t i=0;i<depths.size();++i)
        if (contributions.inverse_depth[i]>0)
            depths[i]=contributions.opacity[i]/contributions.inverse_depth[i];
    return depths;
}

inline std::vector<double> axial_depths(const std::vector<float>& rows,const float* view,double scale) {
    if (!(scale>0) || rows.size()%14) throw std::runtime_error("depth study: invalid scene scale");
    std::vector<double> z(rows.size()/14);
    for (size_t i=0;i<z.size();++i) {
        const float* p=rows.data()+14*i+1;
        z[i]=(view[8]*p[0]+view[9]*p[1]+view[10]*p[2]+view[11])/scale;
    }
    return z;
}

}  // namespace spirula::stereo::study
