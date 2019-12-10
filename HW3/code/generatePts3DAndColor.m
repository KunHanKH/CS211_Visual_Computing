function [points3D,color] = generatePts3DAndColor(cameraParams, I1, I2, orient, loc, flag)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
roi = [30, 30, size(I1, 2) - 30, size(I1, 1) - 30];
imagePoints1 = detectMinEigenFeatures(rgb2gray(I1), 'ROI', roi, ...
    'MinQuality', 0.001);

% Create the point tracker
% tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 5);
tracker = vision.PointTracker('MaxBidirectionalError', 3, 'NumPyramidLevels', 5, 'BlockSize', [31, 31]);

% Initialize the point tracker
imagePoints1 = imagePoints1.Location;
initialize(tracker, imagePoints1, I1);

% Track the points
[imagePoints2, validIdx] = step(tracker, I2);
matchedPoints1 = imagePoints1(validIdx, :);
matchedPoints2 = imagePoints2(validIdx, :);



% Compute the camera matrices for each position of the camera
% The first camera is at the origin looking along the Z-axis. Thus, its
% rotation matrix is identity, and its translation vector is 0.
camMatrix1 = cameraMatrix(cameraParams, eye(3), [0 0 0]);

% Compute extrinsics of the second camera
[R, t] = cameraPoseToExtrinsics(orient, loc);
camMatrix2 = cameraMatrix(cameraParams, R, t);

% Compute the 3-D points
points3D = triangulate(matchedPoints1, matchedPoints2, camMatrix1, camMatrix2);

% Get the color of each reconstructed point
numPixels = size(I1, 1) * size(I1, 2);
allColors = reshape(I1, [numPixels, 3]);

if(flag == 1)
    allColors(:, 1) = 0;
    allColors(:, 2) = 0;
    allColors(:, 3) = 255;
end
if(flag == 2)
    allColors(:, 1) = 255;
    allColors(:, 2) = 0;
    allColors(:, 3) = 0;
end



colorIdx = sub2ind([size(I1, 1), size(I1, 2)], round(matchedPoints1(:,2)), ...
    round(matchedPoints1(:, 1)));
color = allColors(colorIdx, :);
end

