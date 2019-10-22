% 1. prepare image
img = imread("./img-gallery/CARTOON.jpg");
img = imresize(img, [256, 256]);
% 2. prepare filter
filter = [1/4, 1/4; 1/4, 1/4];

sample_vector = [1:2:256];
maxSize = 256;

filtered_img = img;
loop_num = log2(256);
prev_img = img;
while(loop_num > 0)
    
    % get the filtered image
    filtered_img = imfilter(filtered_img, filter, 'same');
    % sample image every two pixels
    filtered_img = filtered_img(sample_vector, sample_vector);
    % resize the filtered image using bilinear
    resized_img = imresize(filtered_img, [256, 256], 'bilinear');
    
    % get the image after applying Laplacian pyramid
    la_img = prev_img - resized_img;
    % process the negative pixel value
    la_img  = la_img - min(la_img, [], 'all');
    
    % update loop_num
    loop_num = loop_num - 1;
    imshowpair(img, la_img, 'montage')
    pause
    
    % prepare new sample vector
    maxSize = maxSize / 2;
    sample_vector = [1:2:maxSize];
    prev_img = resized_img;
end

    
