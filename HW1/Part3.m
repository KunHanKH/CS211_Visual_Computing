% 1. prepare image
img = imread("./img-gallery/CARTOON.jpg");
img = imresize(img, [256, 256]);
img = im2double(img);
% 2. prepare filter
filter = [1/4, 1/4; 1/4, 1/4];
la_filter = [-1/8, -1/8, -1/8; -1/8, 1, -1/8; -1/8, -1/8, -1/8];

% 3. threshold
threshold = 0.00001;

multi_scale_edge = multiScaleEdge(img, filter, la_filter, threshold);
displayPyramid(img, multi_scale_edge)