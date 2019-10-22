function displayPyramid(img,pyramid)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
loop_num = log2(256);
for(i = 1:loop_num)
    display(i)
    imshowpair(img, pyramid{1, i}, 'montage')
    pause
end
end

