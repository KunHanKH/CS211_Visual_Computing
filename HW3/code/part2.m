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
        temp = split(imgName, '.');
        imgNames{end + 1} = temp(1);
    end
end

%% manually input the 3D coordinate
info3D =[...
    [[0 0 0];[64 0 0];[64 64 0];[0 64 0]]; ... %blue bottom
    [[0 0 19];[64 0 19];[64 64 19];[0 64 19]]; ... %blue top / red bottom
    [[0 0 29];[64 0 29];[64 64 29];[0 64 29]]; ... %red top
    [[16 16 29];[48 16 29];[48 48 29];[16 48 29]]; ... %red top / center green bottom
    [[16 16 48];[48 16 48];[48 48 48];[16 48 48]]; ... %center green top
    [[0 48 29];[32 48 29];[32 80 29];[0 80 29]]; ... %corner green bottom
    [[0 48 48];[32 48 48];[32 80 48];[0 80 48]]; ... %corner green top/ yellow bottom
    [[0 48 67];[32 48 67];[32 80 67];[0 80 67]]; ... %yellow top
    [[20 20 0];[180 20 0];[180 180 0];[20 180 0]] ... %checkboard corner
];
% which point is visible in the image
% isAppear1 = [1 1 1 0; 1 1 1 0; 1 1 1 0; 1 1 1 0; 1 1 1 0; 0 0 1 0; 1 0 1 0; 1 1 1 0; 0 1 1 1];
% isAppear2 = [1 1 1 0; 1 1 1 0; 1 1 1 0; 1 1 1 0; 1 1 1 0; 0 0 1 0; 1 0 1 0; 1 1 1 0; 0 1 1 0];
% isAppear3 = [1 1 0 0; 1 1 0 0; 1 1 0 0; 1 1 0 0; 1 1 0 1; 1 0 0 0; 1 0 0 0; 1 1 0 1; 0 1 1 0];
% isAppear4 = [1 1 0 1; 1 1 0 1; 1 1 0 1; 1 1 0 1; 1 1 0 1; 1 0 0 1; 1 0 0 1; 1 1 0 1; 0 1 0 1];

isAppear1 = [1 1 1 0; 0 0 0 0; 1 1 1 0; 0 0 0 0; 1 1 1 0; 0 0 0 0; 1 0 1 0; 1 1 1 0; 0 1 1 1];
isAppear2 = [1 1 1 0; 0 0 0 0; 1 1 1 0; 0 0 0 0; 1 1 1 0; 0 0 0 0; 1 0 1 0; 1 1 1 0; 0 1 1 0];
isAppear3 = [1 1 1 0; 0 0 0 0; 1 1 1 0; 0 0 0 0; 1 1 1 0; 0 0 0 0; 1 0 1 0; 1 1 1 0; 0 1 1 1];
isAppear4 = [1 1 0 0; 0 0 0 0; 1 1 0 0; 0 0 0 0; 1 1 0 1; 0 0 0 0; 1 0 0 0; 1 1 0 1; 0 1 1 0];
isAppear5 = [1 1 0 1; 0 0 0 0; 1 1 0 1; 0 0 0 0; 1 1 0 1; 0 0 0 0; 1 0 0 1; 1 1 0 1; 0 1 0 1];

appearPts = {isAppear1', isAppear2', isAppear3', isAppear4', isAppear5'};

%% get 3D visible 3d points and their 2D points
n = 5;

pts2D = {};
pts3D = {};
for i = 1:5
    numPts = sum(appearPts{i}(:));
    % manually capture or laod 2D correspond points
    pts2D{end + 1} = get2Dpt(imgs{i}, numPts, i);  
    pts3D{end + 1} = info3D(appearPts{i}(:) > 0,:);
    figure, imshow(rgb2gray(imgs{i}));
    hold on;
    scatter(pts2D{i}(:, 1), pts2D{i}(:, 2));
    hold off;
    drawnow;
end

%%
Cs = zeros(n, 3);
Rs = {};
Ks = zeros(3, 3);

for i = 1:n
    [K, R, t] = calibrate(pts3D{i}, pts2D{i});
    Ks = Ks + K;
    Cs(i, :) = t;
    Rs{end + 1} = R;
end
K = Ks / n
save("K.mat", 'K');

%%
%plot cameras
centerPts = {};
camera = {};
for i=1:n
    centerPts{end + 1} = mean(pts3D{i},1);
    camera{end+1} = imgNames{i};
end
plotCam(Cs, centerPts, camera);





