%% show image

folder = dir(fullfile('data','*.jpg'));
addpath('data')
masks = {};
imgs = {};
imgNames = {};

for i = 1:length(folder)
    imgName = folder(i).name;
    if contains(imgName, 'Mask')
        masks{end + 1} = imread(imgName);
    else
        imgs{end + 1} = imread(imgName);
        imgNames{end+1} = imgName;
    end
end

%% 
index = 1;
figure;
subplot(1, 3, 1);
imshow(imgs{index});
subplot(1, 3, 2);
imshow(masks{index});
subplot(1, 3, 3);
temp = masks{index} / 255 .*imgs{index};
imshow(temp);


%%
pair = {[3, 4],[3, 5],[4, 5]};

%%
pair_index = 1;
i = pair{pair_index}(1);
j = pair{pair_index}(2);
splitName1 = split(imgNames{i}, '.');
splitName2 = split(imgNames{j}, '.');
title = strcat(splitName1{1, 1}, '_', splitName2{1, 1}, '.jpg');
match(imgs{i}, imgs{j}, masks{i}, masks{j}, title)

%%
pair_index = 2;
i = pair{pair_index}(1);
j = pair{pair_index}(2);
splitName1 = split(imgNames{i}, '.');
splitName2 = split(imgNames{j}, '.');
title = strcat(splitName1{1, 1}, '_', splitName2{1, 1}, '.jpg');
match(imgs{i}, imgs{j}, masks{i}, masks{j}, title)


%%
pair_index = 3;
i = pair{pair_index}(1);
j = pair{pair_index}(2);
splitName1 = split(imgNames{i}, '.');
splitName2 = split(imgNames{j}, '.');
title = strcat(splitName1{1, 1}, '_', splitName2{1, 1}, '.jpg');
match(imgs{i}, imgs{j}, masks{i}, masks{j}, title)







