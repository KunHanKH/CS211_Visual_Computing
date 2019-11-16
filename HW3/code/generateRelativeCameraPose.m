function [orient, loc] = generateRelativeCameraPose(cameraParams, I1, I2)
    I1 = undistortImage(I1, cameraParams);
    I2 = undistortImage(I2, cameraParams);
    % Detect feature points
    imagePoints1 = detectMinEigenFeatures(rgb2gray(I1), 'MinQuality', 0.1);
    
    tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 5);

    % Initialize the point tracker
    imagePoints1 = imagePoints1.Location;
    initialize(tracker, imagePoints1, I1);

    % Track the points
    [imagePoints2, validIdx] = step(tracker, I2);
    matchedPoints1 = imagePoints1(validIdx, :);
    matchedPoints2 = imagePoints2(validIdx, :);
    
    [E, epipolarInliers] = estimateEssentialMatrix(...
    matchedPoints1, matchedPoints2, cameraParams, 'Confidence', 80);
    
    % Find epipolar inliers
    inlierPoints1 = matchedPoints1(epipolarInliers, :);
    inlierPoints2 = matchedPoints2(epipolarInliers, :);
    
   
    %%
    [orient, loc] = relativeCameraPose(E, cameraParams, inlierPoints1, inlierPoints2);
end