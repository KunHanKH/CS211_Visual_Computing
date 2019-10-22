function interpolated_pyramid = interpolatePyramid(laplacian_pyramid_1, laplacian_pyramid_2, mask_pyramid)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
loop_num = log2(256);

for(i = 1:loop_num)
    interpolated_pyramid{1, i} = laplacian_pyramid_1{1, i}.*mask_pyramid{1, i} + laplacian_pyramid_2{1, i}.*(1-mask_pyramid{1, i});
end

end

