% get image data
[bgs, frames, shadows] = GetShadowData();
[fsx, fux] = GetScatterData(frames);

% handle for pixel
ss = length(bgs);
for n=1:ss
    
    num_bg = 0;
    num_fg = 0;
    num_shadow = 0;
    pixel_shadow = {};
    pixel_bg = {};
    pixel_fg = {};
    
    [r, c] = size(shadows{n});
    for i=1:r
        for j=1:c
            tag = MarkData(shadows{n}(i,j));
            [Fs, Fu] = GetPixelFeature(fsx{n}, fux{n}, i, j, r, c);
            % store data
            switch tag
                case 0
                    num_bg = num_bg + 1;
                    pixel_bg{num_bg} = [Fu, Fs];
                case 1
                    num_fg = num_fg + 1;
                    pixel_shadow{num_fg} = [Fu, Fs];
                case 2
                    num_shadow = num_shadow + 1;
                    pixel_fg{num_shadow} = [Fu, Fs];
            end
        end
    end
    
    ss = strcat('pixel_shadow_', int2str(n), '.mat');
    sf = strcat('pixel_fg_', int2str(n), '.mat');
    save(ss, 'pixel_shadow');
    save(sf, 'pixel_fg');
    
end