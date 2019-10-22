function img_after_filter = applyGaussian(img, filter)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[maxY, maxX] = size(img);
img_after_filter = zeros([maxY/2, maxX/2]);

for(y = 1:maxY/2)
    for(x = 1:maxX/2)
        img_after_filter(y, x) = sum(img(y*2-1:y*2, x*2-1:x*2).*filter, 'all');
    end
end

end

