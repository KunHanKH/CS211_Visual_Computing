function plotCam(cams, centerPts, camera)
    figure;
    hold on;
    
    n = 90;
    set(gca, 'CameraPosition', [n n n]);
    for i = 1:size(cams, 1)
        plot3(centerPts{i}(2), centerPts{i}(1),  centerPts{i}(3), 'bo', 'MarkerSize', 2);
        scatter3(cams(i, 2), cams(i, 1), cams(i, 3));
        %starts = (repmat(cams(i, :)', 1, 3))';
        starts = cams(i, :)';
        
        
        
        a = [centerPts{i}(1) - starts(1)]' * 0.5;
        b = [centerPts{i}(2) - starts(2)]' * 0.5;
        c = [centerPts{i}(3) - starts(3)]' * 0.5;
        ends = transpose([a, b, c]);
        
        text(starts(2), starts(1), starts(3),camera{i})
        
        quiver3(starts(2), starts(1), starts(3), ends(2), ends(1), ends(3), 0);
    end
    grid on;
    rotate3d on;
    axis equal;
    hold off;
end