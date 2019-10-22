function laplacian_pyramid = laplacianPyramid(img, filter)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

prev_img = img;
loop_num = log2(256);
level = 1;
while(loop_num >= level)
    
    % get the filtered image
    img = imfilter(img, filter, 'same');
    [height, width] = size(img);
    img = img(1:2:height, 1:2:width);
    
    % or we could use self-defined function to get the downsampled img
    % after apply gaussian filter
    % filtered_img = applyGaussian(filtered_img, filter);
    
    % resize the filtered image using bilinear
    resized_img = imresize(img, 2, 'bilinear');
    
    % get the image after applying Laplacian pyramid
    la_img = prev_img - resized_img;
    
    la_img = imresize(la_img, [256, 256], 'bilinear');
    % process the negative pixel value
    % la_img  = la_img - min(la_img, [], 'all');
    
    % store the result in cell gaussian_pyramid
    laplacian_pyramid{1, level} = la_img;
    
    % update loop_num
    level = level + 1;
    
    prev_img = img;
end
end

