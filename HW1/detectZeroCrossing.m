function [image_zero_crossing, edge_after_examine] = detectZeroCrossing(img, segmented_img, threshold)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
image_zero_crossing = zeros(size(segmented_img));
edge_after_examine = zeros(size(segmented_img));
[maxY, maxX] = size(segmented_img);

for y = 1:maxY
    for x = 1:maxX
        changeFlag = 0;
        for j = y-1:y+1
            if(j>0 && j<=maxY)
                for i = x-1:x+1
                    if(i>0 && i<=maxX)
                        if(segmented_img(y, x) ~= segmented_img(j, i))
                            changeFlag = 1;
                            break;
                        end
                    end
                end
                if(changeFlag == 1)
                    break
                end
            end
        end
        if(changeFlag == 1)
            image_zero_crossing(y, x) = 1;
            edge_after_examine(y, x) = examineZeroCrossing(img, x, y, maxX, maxY, threshold);
        end
    end
end

end

                        
                


