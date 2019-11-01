function [filteredImg] = notchfilter(img, lower_threshold, upper_threshold, range)
Y_1 = fft2(img);

Y_2 = fftshift(Y_1);
magnitude = log(abs(Y_2));

figure
imshow(img);
title("original img");

figure
imshow(magnitude);
title("magnitude before nocth filter");

[M, N] = size(img);
for i = 1:M
    for j = 1:N
        if ~(i>M/2-range && i<M/2+range && j>N/2-range && j< N/2+range)
             if magnitude(i, j) < upper_threshold && magnitude(i, j) > lower_threshold
                 Y_2(i, j) = complex(0);
                 magnitude(i, j) = 0;
             end
        end
    end
end

figure
imshow(magnitude);
title("magnitude after notch filter");
Y = ifftshift(Y_2);
filteredImg = abs(ifft2(Y));
figure;
imshow(filteredImg);
title("filtered Img");
end

