
% 1. prepare image
img = imread("./img-gallery/CARTOON.jpg");
img = imresize(img, [256, 256]);
img = im2double(img);
% 2. prepare filter
filter = [1/4, 1/4; 1/4, 1/4];

gaussian_pyramid = gaussianPyramid(img, filter);
displayPyramid(img, gaussian_pyramid)

    
