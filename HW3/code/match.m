function match(img1, img2, mask1, mask2, title)
    
%     if isfile(title)
%         return
%     end
        

    N = 100;
    [fa, da] = vl_sift(im2single(rgb2gray(img1)));
    [fb, db] = vl_sift(im2single(rgb2gray(img2)));
    [matches, scores] = vl_ubcmatch(da, db);
    [~, ordered] = sort(scores, 'descend');
    selected = ordered(1:N);
    matches = matches(:, selected);
    scores = scores(selected);

    xa = fa(1, matches(1, :));
    xb = fb(1, matches(2, :)) + size(img1, 2);
    ya = fa(2, matches(1, :));
    yb = fb(2, matches(2, :));

    perma = maskFilt(mask1, xa, ya);
    permb = maskFilt(mask2, xb - size(img1, 2), yb);
    selected = intersect(perma, permb);
    selected = selected(1:10);
    matches = matches(:, selected);

    figure;
    imagesc(cat(2, img1, img2));

    xa = xa(:, selected);
    xb = xb(:, selected);
    ya = ya(:, selected);
    yb = yb(:, selected);

    hold on ;
    h = line([xa; xb], [ya; yb]);
    set(h, 'linewidth', 1, 'color', 'b');
    vl_plotframe(fa(:, matches(1, :))) ;
    fb(1, :) = fb(1, :) + size(img1, 2) ;
    vl_plotframe(fb(:, matches(2, :))) ;
    
    Image = getframe(gcf);
    imwrite(Image.cdata, title);
    
    axis image off;
end

function matches = maskFilt(mask, x, y)
    img = zeros(size(mask));
    for i = 1:size(x, 2)
        img(round(y(:, i)), round(x(:, i))) = i;
    end
    img(mask == 0) = 0;
    matches = img(img ~= 0);
end