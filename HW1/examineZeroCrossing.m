function value = examineZeroCrossing(img, x, y, maxX, maxY, threshold)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
surranding = [];
for(j = y-1:y+1)
    if(j>0 && j<maxY)
        for(i = x-1:x+1)
            if(i>0 && i<maxX)
                if(j~=y && i~=x)
                    surranding = [surranding, img(j, i)];
                end
            end
        end
    end
end

variance = var(surranding);
if(variance > threshold)
    value = 1;
else
    value = 0;
end



end

