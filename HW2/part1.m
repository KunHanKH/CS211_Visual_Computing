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


% Step3: Compute the Discrete Fourier Transform of this image.
Y =fftshift(fft2(img));
magnitude = abs(Y);
phase = angle(Y);
figure
imshow(log(magnitude),[]);
figure
imshow(unwrap(phase), []);
pause

%% b Show the Discrete Fourier Transform of the following image and explain the pattern in the result in your pdf file. 
cross = rgb2gray(im2double(imread("./img-gallery/Cross.jpg")));
figure
imshow(cross)

Y = fft2(cross);
Y = fftshift(Y);
magnitude = abs(Y);
phase = angle(Y);
figure 
imshow(Y, []);
figure
imshow(log(magnitude), []);
figure
imshow(unwrap(phase), []);
pause
