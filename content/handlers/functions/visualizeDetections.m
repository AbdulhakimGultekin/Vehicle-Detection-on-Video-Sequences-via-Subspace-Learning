% Article    : ieeexplore.ieee.org/document/8404205/
% Date       : 28.04.2018
% Authors    : Abdülhakim Gültekin
% Institute  : Gebze Technical University
% Conference : SÝU 2018 (Signal Processing and Communucations Applications)
% GitHub     : github.com/AbdulhakimGultekin

function visualizeDetections(grayVideo, binaryVideo)
    
    [~, ~, Num_of_Frames] = size(binaryVideo);
    figure;
    for frameNum = 1 : Num_of_Frames
        cc = bwconncomp(binaryVideo(:, :, frameNum));
        stats = regionprops(cc, 'BoundingBox');
        imshow(grayVideo(:, :, frameNum)), title('Detected Objects');
        for objectNum = 1 : cc.NumObjects
            rectangle('Position', stats(objectNum).BoundingBox, ...
                                  'EdgeColor', 'r', 'LineWidth', 1);
        end
        pause(0.0005)
    end
end