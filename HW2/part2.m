% 1. load image
moonlanding =im2double(imread("./img-gallery/moonlanding.png"));
figure
imshow(moonlanding, [])

psnr =rgb2gray(im2double(imread("./img-gallery/psnr2.png")));
figure
imshow(psnr, [])


%% 2. notch filter
lower_threshold = 7.0;
upper_threshold =20.0;
range = 40;
filteredImg = notchfilter(moonlanding ,lower_threshold, upper_threshold, range);

lower_threshold = 0.2;
upper_threshold =3.7;
range = 10;
filteredImg = notchfilter(psnr,lower_threshold, upper_threshold, range);
