% This function is utilized in the vehicle tracking algorithm to get the
% needed threshold values for thresholding processes.
%
% Article    : ieeexplore.ieee.org/document/8404205/
% Date       : 28.04.2018
% Authors    : Abdülhakim Gültekin
% Institute  : Gebze Technical University
% Conference : SÝU 2018 (Signal Processing and Communucations Applications)
% GitHub     : github.com/AbdulhakimGultekin

function [th1, th2] = thresholdingMethod(grayLevelVideo, ForegroundModel, BackgrounModel, frameAmount)
    
    MovingObjDiff(:, :, :) = abs(grayLevelVideo(:, :, 1 : frameAmount) - BackgrounModel(:, :, 1 : frameAmount));
    MovingObjSum = 0;
    for frameNum = 1 : frameAmount
        MovingObjSum = MovingObjDiff(:, :, frameNum) + MovingObjSum;
    end
    tempMaxVal = max(max(MovingObjSum));
    [x, y] = find(MovingObjSum == tempMaxVal);
    
    % Since videos we used for tests are commonly shooted as parallel to
    % the movement direction of objects, we prefer using row number 'x' for
    % all but 'test3' video.
    tempMat = ForegroundModel(x, :, :);
    profMat = squeeze(tempMat);
    meanVal = mean(mean(profMat));
    maxVal  = max(max(profMat));
    minVal  = min(min(profMat));
    % 'adj1' and 'adj2' are adjustment values. It depends on the video 
    % which is being processed. 
    % For 'sherbrooke' video  adj1 = 1.1  and adj2 = 1.46
    % For 'stMarc'     video  adj1 = 1.0  and adj2 = 1.2
    % For 'whitecar'   video  adj1 = 0.66 and adj2 = 1.0
    % For 'test1'      video  adj1 = 0.65 and adj2 = 0.55
    % For 'test2'      video  adj1 = 0.9  and adj2 = 1.53
    % For 'test3'      video  adj1 = 1.0  and adj2 = 1.45
    adj1 = 0.65;
    adj2 = 0.55;
    level1  = (meanVal + maxVal) * (1 / 2) * (adj1);
    level2  = (meanVal + minVal) * (1 / 2) * (adj2);

    th1 = level1; % Threshold value for light objects.
    th2 = level2; % Threshold value for dark  objects.
end