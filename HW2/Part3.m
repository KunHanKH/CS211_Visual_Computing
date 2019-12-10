% 1. load and image and resize to 64x64
flower = imresize(im2double(imread("./img-gallery/flowergray.jpg")), [64,64]);
showDFT(flower);

% 2. pad image to 128 x 128 and show its DFT
img = padImge(flower);
showDFT(img);

% 3. pad image to 256 x 256 and show its DFT
img = padImge(img);
showDFT(img);

% 4. pad image to 512 x 512 and show its DFT
img = padImge(img);
showDFT(img);


function showDFT(img)

Y = fftshift(fft2(img));
magnitude = log(abs(Y));
phase = angle(Y);

figure
subplot(1, 3, 1);
imshow(img);
title("padded image");

subplot(1, 3, 2);
imshow(magnitude, []);
title("magnitude");

subplot(1, 3, 3);
imshow(unwrap(phase),[]);
title("phase");

end

function paddedImg = padImge(img)

[height, width] = size(img);
paddedImg = zeros(height*2, width*2);
paddedImg(1:height, 1:width) = img;

end