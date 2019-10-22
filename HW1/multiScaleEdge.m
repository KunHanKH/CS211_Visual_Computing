function multi_scale_edge = multiScaleEdge(img, filter, la_filter, threshold)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
loop_num = log2(256);

for(i = 1:loop_num)
    % each level of gaussian pyramid has defferent resolution
    img = imfilter(img, filter, 'replicate', 'same');
    [height, width] = size(img); 
    img = img(1:2:height, 1:2:width);
    
    % apply Laplacian filter and generate the second derivative image
    la_img = imfilter(img, la_filter, 'same');
    la_img = imresize(la_img, [256, 256], 'bilinear');
    
    segment_img = la_img;
    % segment the second order derivative image
    segment_img(la_img<=0) = 0;
    segment_img(la_img>0) = 1;
    
    % detect the zero crossing in the segmented image
    [image_zero_crossing, edge_after_examine] = detectZeroCrossing(la_img, segment_img, threshold);
    multi_scale_edge{1, i} = edge_after_examine;
end

