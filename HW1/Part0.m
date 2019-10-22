%% prepare image
% 1. read the image
img = imread("./img-gallery/CARTOON.jpg");
% 2. resize the image to [100, 100]
img = imresize(img, [100, 100]);
% 3. change the data type to double
img = im2double(img);
figure
imshow(img)
pause

%% a. sort

flatten_img = img(:)';
x = sort(flatten_img);
plot(x)
pause

%% b. histogram
histogram(flatten_img, 32)
pause

%% c. threshold
threshold = 0.9;
BW = imbinarize(img, threshold);
imshowpair(img, BW, 'montage')
pause

%% d. substract mean value
img_mean = mean(img, 'all');
img_sub_mean = img - img_mean;
img_sub_mean(img_sub_mean<0) = 0;
imshow(img_sub_mean);
pause

%% e. reshape
y = [1:8];
s = reshape(y, [4, 2]);
s = s';

%% f. sample image
sample_vector = [1:2:99];
sampled_img = img(sample_vector, sample_vector);
imshow(sampled_img);
pause
close

%% g. imfilter
figure
subplot(1, 3, 1)
gauss_filter = fspecial('gaussian', 3, 0.5);
img_filter_1 = imfilter(img, gauss_filter);
imshow(img_filter_1)

subplot(1, 3, 2)
gauss_filter = fspecial('gaussian', 5, 0.5);
img_filter_2 = imfilter(img, gauss_filter);
imshow(img_filter_2)

subplot(1, 3, 3)
gauss_filter = fspecial('gaussian', 3, 0.7);
img_filter_3 = imfilter(img, gauss_filter);
imshow(img_filter_3)
pause

%% h. conv2 filter
figure
gauss_filter = fspecial('gaussian', 3, 0.7);
img_gaussian = conv2(img, gauss_filter);
imshowpair(img_filter_3, img_gaussian, 'montage')
display("imfilter uses correlation to filter images by default that starts from one side of the image, whereas covolution starts from the other, so there may be some small differences in the filter output.")
