function [FSx, FUx] = GetScatterData(frames)

    FSx = {};
    FUx = {};
    
    %% build the wavelet transform operator with shannon filters
    filt_opt = struct();
    filt_opt.min_margin = [0,0];
    filt_opt.filter_type = 'shannon';
    scat_opt = struct();
    scat_opt.oversampling = 0;
    
    ss = length(frames);
    for i=1:ss
        x = im2double(rgb2gray(frames{i}));
        
        size_in = size(x);
        [Wop, filters] = wavelet_factory_2d(size_in, filt_opt, scat_opt);
        
        [Sx, Ux] = scat(x, Wop);
        FSx{i} = Sx;
        FUx{i} = Ux;
    end

end