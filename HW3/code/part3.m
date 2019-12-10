%%
addpath('./code')
p1 = load('data/img2Dpts1.mat');
p2 = load('data/img2Dpts2.mat');
p3 = load('data/img2Dpts3.mat');
p4 = load('data/img2Dpts4.mat');
p5 = load('data/img2Dpts5.mat');
ps = {p1, p2, p3, p4, p5};

%%
isAppear1 = [1 2 3 0; 0 0 0 0; 4 5 6 0; 0 0 0 0; 7 8 9 0; 0 0 0 0; 10 0 11 0; 12 13 14 0; 0 15 16 17];
isAppear2 = [1 2 3 0; 0 0 0 0; 4 5 6 0; 0 0 0 0; 7 8 9 0; 0 0 0 0; 10 0 11 0; 12 13 14 0; 0 15 16 0];
isAppear3 = [1 2 3 0; 0 0 0 0; 4 5 6 0; 0 0 0 0; 7 8 9 0; 0 0 0 0; 10 0 11 0; 12 13 14 0; 0 15 16 17];
isAppear4 = [1 2 0 0; 0 0 0 0; 3 4 0 0; 0 0 0 0; 5 6 0 7; 0 0 0 0; 8 0 0 0; 9 10 0 11; 0 12 13 0];
isAppear5 = [1 2 0 3; 0 0 0 0; 4 5 0 6; 0 0 0 0; 7 8 0 9; 0 0 0 0; 10 0 0 11; 12 13 0 14; 0 15 0 16];

isAppear = {};
isAppear{end +1} = isAppear1;
isAppear{end +1} = isAppear2;
isAppear{end +1} = isAppear3;
isAppear{end +1} = isAppear4;
isAppear{end +1} = isAppear5;
%%
% read img1 and img2 
img1 = imread('data/DSCF4177.jpg');
img2 = imread('data/DSCF4178.jpg');
img3 = imread('data/DSCF4179.jpg');
img4 = imread('data/DSCF4180.jpg');
img5 = imread('data/DSCF4181.jpg');
imgs = {img1, img2, img3, img4, img5};

%%
pair = {[3, 4],[3, 5],[4, 5]};

%% 
for i = 1:3
    
    % set(i, j) == 1 -> point(i, j) appear in both images
    set = (isAppear{pair{i}(1)}>0) .* (isAppear{pair{i}(2)}>0);
    matchedPoints1 = ones(sum(set, 'all'),2);
    matchedPoints2 = ones(sum(set, 'all'),2);
    
    % get the indexes of common points for both images.
    points1_index = isAppear{pair{i}(1)}(set>0);
    points2_index = isAppear{pair{i}(2)}(set>0);
    
    point1_x = ps{pair{i}(1)}.x;
    point1_y = ps{pair{i}(1)}.y;
    matchedPoints1(:,1) = point1_x(points1_index);
    matchedPoints1(:,2) = point1_y(points1_index);
    
    point2_x = ps{pair{i}(2)}.x;
    point2_y = ps{pair{i}(2)}.y;
    matchedPoints2(:,1) = point2_x(points2_index);
    matchedPoints2(:,2) = point2_y(points2_index);
    

    [fLMedS,inliers] = estimateFundamentalMatrix(matchedPoints1,...
        matchedPoints2,'NumTrials',4000);

    I1 = imgs{pair{i}(1)};
    figure; 
    subplot(121);
    imshow(I1); 
    title('Inliers and Epipolar Lines in First Image'); hold on;
    plot(matchedPoints1(inliers,1),matchedPoints1(inliers,2),'go')

    %% 
    epiLines = epipolarLine(fLMedS',matchedPoints2(inliers,:));
    points = lineToBorderPoints(epiLines,size(I1));
    line(points(:,[1,3])',points(:,[2,4])');

    %%
    I2 = imgs{pair{i}(1)};
    subplot(122); 
    imshow(I2);
    title('Inliers and Epipolar Lines in Second Image'); hold on;
    plot(matchedPoints2(inliers,1),matchedPoints2(inliers,2),'go')

    %%
    epiLines = epipolarLine(fLMedS,matchedPoints1(inliers,:));
    points = lineToBorderPoints(epiLines,size(I2));
    line(points(:,[1,3])',points(:,[2,4])');
    
    %% 
    Image = getframe(gcf);
    imwrite(Image.cdata, "part3_"+i+".jpg");
end