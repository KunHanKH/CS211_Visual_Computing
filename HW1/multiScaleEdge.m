function multi_scale_edge = multiScaleEdge(img, filter, la_filter)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
loop_num = log2(256);

gaussian_pyramid = gaussianPyramid(img, filter);
for(i = 1:loop_num)
    gaussian_filter_image = gaussian_pyramid{1, i};
    
    % apply Laplacian filter and generate the second derivative image
    la_img = imfilter(gaussian_filter_image, la_filter, 'same');
    
    % segment the second order derivative image
    la_img(la_img<=0) = 0;
    la_img(la_img>0) = 1;
    
    % detect the zero crossing in the segmented image
    [image_zero_crossing, edge_after_examine] = detectZeroCrossing(img, la_img, 0.1);
    multi_scale_edge{1, i} = edge_after_examine;
end

