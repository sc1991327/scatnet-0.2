% get the pixel feature
function [featureS, featureU] = GetPixelFeature(Sx, Ux, Pi, Pj, rows, cols)
    
    featureS = [];
    featureU = [];

    % get feature s
    level_s = length(Sx);
    for lev = 1:level_s
        ssl = length(Sx{lev}.signal);
        for sig = 1:ssl
            ti = ceil(Pi / 16);
            tj = ceil(Pj / 16);
            tdata = Sx{lev}.signal{sig}(ti, tj);
            featureS = [featureS; tdata];
        end
    end
    
    % get feature u
    level_u = length(Ux);
    for lev = 1:level_u
        ssl = length(Ux{lev}.signal);
        for sig = 1:ssl
            [sgr, sgc] = size(Ux{lev}.signal{sig});
            ti = ceil(Pi * sgr / rows);
            tj = ceil(Pj * sgc / cols);
            tdata = Ux{lev}.signal{sig}(ti, tj);
            featureU = [featureU; tdata];
        end
    end

end