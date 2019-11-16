function [pts2] = get2Dpt(img, num, i)
    addpath('data');
    fname = strcat('data/img2Dpts', num2str(i), '.mat');
    %fname = strcat('calib', num2str(i), '.mat');
    if isfile(fname)
        load(fname);
        pts2 = [x, y];
    else
        im = im2single(rgb2gray(img));
        figure, imshow(im);
        hold on;
        [x, y] = ginput(num);
        hold off;
        pts2 = [x, y];
        filename = strcat("data/img2Dpts", num2str(i), ".mat");
        save(filename, 'x', 'y');
    end
end