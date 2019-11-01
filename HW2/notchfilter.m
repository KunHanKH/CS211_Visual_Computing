function [filteredImg] = notchfilter(img, lower_threshold, upper_threshold, range)
Y = fft2(img);
Y = fftshift(Y);
magnitude = log(abs(Y));

figure
imshow(real((magnitude)),[]);

[M, N] = size(img);
for i = 1:M
    for j = 1:N
        if ~(i>M/2-range && i<M/2+range && j>N/2-range && j< N/2+range)
             if magnitude(i, j) < upper_threshold && magnitude(i, j) > lower_threshold
                 Y(i, j) = 0;
                 magnitude(i, j) = 0;
             end
        end
    end
end

figure
imshow(magnitude, []);
filteredImg = ifft2(fftshift(Y));
figure
imshow(real(filteredImg), []);
end

