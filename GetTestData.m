function [bgs, frames, shadows] = GetTestData()

    num = 1;
    bgs = {};
    frames = {};
    shadows = {};
    
    index = {
        'C:/testImages/Shadow/aton_campus/';
        'C:/testImages/Shadow/aton_hallway/';
        'C:/testImages/Shadow/aton_hallway1/';
        'C:/testImages/Shadow/aton_hallway3/';
        'C:/testImages/Shadow/aton_lab/';
        'C:/testImages/Shadow/aton_room/'
        };
    
    index_size = length(index);
    for n=1:index_size
        % for each fonder
        idx_bgs = [index{n} 'bgs/'];
        idx_frames = [index{n} 'frames/'];
        idx_shadows = [index{n} 'shadows/'];
        dir_bgs = dir(idx_bgs);
        dir_frames = dir(idx_frames);
        dir_shadows = dir(idx_shadows);
        if (length(dir_bgs) == length(dir_frames)) && (length(dir_frames) == length(dir_shadows))
            % for each image get data
            for i=3:length(dir_bgs)
                bgs{num} = imread([idx_bgs dir_bgs(i).name]);
                frames{num} = imread([idx_frames dir_frames(i).name]);
                shadows{num} = imread([idx_shadows dir_shadows(i).name]);
                num = num + 1;
            end
        end
    end

end