addpath_scatnet
clear all;
load('tree.mat');

% get image data
[bgs, frames, shadows] = GetTestData();
[fsx, fux] = GetScatterData(frames);

num_fg = 0;
num_shadow = 0;
pixel_shadow = {};
pixel_fg = {};
% handle for pixel
ss = length(bgs);
for n=1:ss
    
    [r, c] = size(shadows{n});
    for i=1:r
        for j=1:c
            tag = MarkData(shadows{n}(i,j));
            [Fs, Fu] = GetPixelFeature(fsx{n}, fux{n}, i, j, r, c);
            % store data
            switch tag
                case 1
                    num_fg = num_fg + 1;
                    pixel_shadow{num_fg} = [Fu, Fs];
                case 2
                    num_shadow = num_shadow + 1;
                    pixel_fg{num_shadow} = [Fu, Fs];
            end
        end
    end
    
end

save('test_shadow.mat', 'pixel_shadow');
save('test_fg.mat', 'pixel_fg');