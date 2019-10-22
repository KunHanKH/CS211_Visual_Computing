% 1. prepare image
img_1 = imread("./img-gallery/flowergray.jpg");
img_1 = imresize(img_1, [256, 256]);
img_1 = im2double(img_1);

img_2 = imread("./img-gallery/kitty.jpg");
img_2 = imresize(img_2, [256, 256]);
img_2 = im2double(img_2);

% 2. prepare filter
filter = [1/4, 1/4; 1/4, 1/4];

% 3. prepare mask
mask = zeros([256, 256]);
mask(64:256-64, 64:256-64) = 1;
mask = double(mask);

% 3. generate laplacian pyramid for both images
la_pyramid_1 = laplacianPyramid(img_1, filter);
la_pyramid_2 = laplacianPyramid(img_2, filter);

% displayPyramid(img_1, la_pyramid_1)
% displayPyramid(img_2, la_pyramid_2)


% 4. generate gaussian pyramid for mask
mask_pyramid = gaussianPyramid(mask, filter);
% displayPyramid(mask, mask_pyramid)


% 5. generate new laplacian pyramid by interpolating
interpolated_pyramid = interpolatePyramid(la_pyramid_1, la_pyramid_2, mask_pyramid);

% add all level of pyramid
loop_num = log2(256);
final_output = zeros(256);
for(i = 1:loop_num)
    final_output = final_output + interpolated_pyramid{1, i};
end

imshow(final_output)



