function gaussian_pyramid = gaussianPyramid(img,filter)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
sample_vector = [1:2:256];
maxSize = 256;

filtered_img = img;
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
    
    % store the result in cell gaussian_pyramid
    gaussian_pyramid{1, level} = resized_img;
    
    % update loop_num;
    level = level + 1;
    
    % prepare new sample vector
    maxSize = maxSize / 2;
    sample_vector = [1:2:maxSize];
end


end

