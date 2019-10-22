% 1. prepare image
img = imread("./img-gallery/CARTOON.jpg");
img = imresize(img, [256, 256]);
img = im2double(img);
% 2. prepare filter
filter = [1/4, 1/4; 1/4, 1/4];
la_filter = [-1/8, -1/8, -1/8; -1/8, 1, -1/8; -1/8, -1/8, -1/8];

sample_vector = [1:2:256];
maxSize = 256;

filtered_img = img;
loop_num = log2(256);
prev_img = img;
while(loop_num > 0)
    
    % get the gaussian filtered image
    filtered_img = imfilter(filtered_img, filter, 'same');
    % sample image every two pixels
    filtered_img = filtered_img(sample_vector, sample_vector);
    
    % or we could use self-defined function to get the downsampled img
    % after apply gaussian filter
    % filtered_img = applyGaussian(filtered_img, filter);
    
    % resize the filtered image using bilinear
    resized_img = imresize(filtered_img, [256, 256], 'bilinear');
    
    % apply Laplacian filter and generate the second derivative image
    la_img = imfilter(resized_img, la_filter, 'same');
    
    % segment the second order derivative image
    la_img(la_img<=0) = 0;
    la_img(la_img>0) = 1;
    
    % detect the zero crossing in the segmented image
    [image_zero_crossing, edge_after_examine] = detectZeroCrossing(img, la_img, 0.1);
    
    % update loop_num
    loop_num = loop_num - 1;
    % show image pair
    imshowpair(img, edge_after_examine, 'montage')
    pause
    
    % prepare new sample vector
    maxSize = maxSize / 2;
    sample_vector = [1:2:maxSize];
end

    
