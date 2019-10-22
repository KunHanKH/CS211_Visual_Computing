function laplacian_pyramid = laplacianPyramid(img, filter)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
sample_vector = [1:2:256];
maxSize = 256;

filtered_img = img;
prev_img = img;

loop_num = log2(256);
level = 1;
while(loop_num >= level)
    
    % get the filtered image
    filtered_img = imfilter(filtered_img, filter, 'same');
    % sample image every two pixels
    filtered_img = filtered_img(sample_vector, sample_vector);
    
    % or we could use self-defined function to get the downsampled img
    % after apply gaussian filter
    % filtered_img = applyGaussian(filtered_img, filter);
    
    % resize the filtered image using bilinear
    resized_img = imresize(filtered_img, [256, 256], 'bilinear');
    
    % get the image after applying Laplacian pyramid
    la_img = prev_img - resized_img;
    % process the negative pixel value
    % la_img  = la_img - min(la_img, [], 'all');
    
    % store the result in cell gaussian_pyramid
    laplacian_pyramid{1, level} = la_img;
    
    % update loop_num
    level = level + 1;
    
    % prepare new sample vector
    maxSize = maxSize / 2;
    sample_vector = [1:2:maxSize];
    prev_img = resized_img;
end
end

