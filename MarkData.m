function tag = MarkData(pixel_data)

    % this method use to read mark shadow image
    % input: shadow map's pixel value
    % output: tag number
    
    if pixel_data == 255
        tag = 2;            % foreground
    else
        if pixel_data == 127
            tag = 1;        % shadow
        else
            tag = 0;        % background
        end
    end    

end