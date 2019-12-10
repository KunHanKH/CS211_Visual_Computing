%%

folder = dir(fullfile('data','*.jpg'));
addpath('data')
masks = {};
imgs = {};

load('cameraParams.mat');

for i = 1:length(folder)
    imgName = folder(i).name;
    if contains(imgName, 'Mask')
        masks{end + 1} = imread(imgName);
    else
        imgs{end + 1} = imread(imgName);
    end
end

%%

I1 = masks{1}/255 .* imgs{1};

points3D = [];
color = [];
%%
for i = 2:2
    I2 = masks{i}/255 .* imgs{i};
    [orient, loc] = generateRelativeCameraPose(cameraParams, I1, I2);
    [tempPoints3D,tempColor] = generatePts3DAndColor(cameraParams, I1, I2, orient, loc, 1);
    points3D = [points3D;tempPoints3D];
    color = [color; tempColor];
    
end

for i = 3:3
    I2 = masks{i}/255 .* imgs{i};
    [orient, loc] = generateRelativeCameraPose(cameraParams, I1, I2);
    [tempPoints3D,tempColor] = generatePts3DAndColor(cameraParams, I1, I2, orient, loc, 2);
    points3D = [points3D;tempPoints3D];
    color = [color; tempColor];
    
end

%%
% Create the point cloud
ptCloud = pointCloud(points3D, 'Color', color);

%%
% Visualize the camera locations and orientations
cameraSize = 0.3;
figure
plotCamera('Size', cameraSize, 'Color', 'r', 'Label', '1', 'Opacity', 0);
hold on
grid on
plotCamera('Location', loc, 'Orientation', orient, 'Size', cameraSize, ...
    'Color', 'b', 'Label', '2', 'Opacity', 0);

% Visualize the point cloud
pcshow(ptCloud, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', ...
    'MarkerSize', 45);

% Rotate and zoom the plot
camorbit(0, -30);
camzoom(1.5);

% Label the axes
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis')

title('Up to Scale Reconstruction of the Scene');

