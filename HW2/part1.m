%% a
% Step1: Create a 512¡Á512 pixel image.
size_of_image = 512;
img = zeros(size_of_image, size_of_image, 1);

% Step2: Assume that X and Y are the coordinates of pixels in the above image. Calculate the value of each pixel using the following equation:

for i = 1: size_of_image
    for j = 1:size_of_image
        img(i, j) = sin(0.2*i) + sin(0.3*i) + cos(0.4*i) + sin(sqrt(i*i+j*j)*0.15) + sin(sqrt(i*i+j*j)*0.35);
    end
end
figure
imshow(img)
title("img");


% Step3: Compute the Discrete Fourier Transform of this image.
Y_1 = fft2(img);
Y_2 =fftshift(Y_1);
magnitude = abs(Y_2);
phase = angle(Y_2);
figure
imshow(log(magnitude),[]);
title("log magnitude");
figure
imshow(unwrap(phase), []);
title("phase");

Y = Y_1*sqrt(2);
X = ifft2(Y);
figure
imshow(X);
title("img with 2 times multitude");
pause

%% b Show the Discrete Fourier Transform of the following image and explain the pattern in the result in your pdf file. 
cross = rgb2gray(im2double(imread("./img-gallery/Cross.jpg")));
figure
imshow(cross);
title("cross");

Y = fft2(cross);
Y = fftshift(Y);
magnitude = abs(Y);
phase = angle(Y);
figure
imshow(log(magnitude), []);
title("magnitude");
figure
imshow(unwrap(phase), []);
title("phase");
pause
