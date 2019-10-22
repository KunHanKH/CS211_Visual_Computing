% 1. prepare image
img = imread("./img-gallery/CARTOON.jpg");
img = imresize(img, [256, 256]);
img = im2double(img);
% 2. prepare filter
filter = [1/4, 1/4; 1/4, 1/4];

laplacian_pyramid = laplacianPyramid(img, filter);
displayPyramid(img, laplacian_pyramid)