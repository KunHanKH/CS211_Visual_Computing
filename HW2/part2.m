
% 1. load image
moonlanding =im2double(imread("./img-gallery/moonlanding.png"));
psnr =rgb2gray(im2double(imread("./img-gallery/psnr2.png")));

figure
subplot(1, 2, 1);
imshow(moonlanding);
title("moonlanding");
subplot(1, 2, 2);
imshow(psnr);
title("psnr2");


%% 2. notch filter
lower_threshold = 5.0;
upper_threshold =30.0;
range = 30;
filteredImg = notchfilter(moonlanding ,lower_threshold, upper_threshold, range);


lower_threshold = 4.0;
upper_threshold =30.0;
range = 30;
filteredImg = notchfilter(psnr,lower_threshold, upper_threshold, range);