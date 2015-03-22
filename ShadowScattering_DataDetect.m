%% data prepare

addpath_scatnet
clear all;
load('test_fg.mat');
load('test_shadow.mat');
load('tree.mat');
load('BaggedEnsemble.mat');

label = {};
[t, ss1] = size(pixel_fg);
[t, ss2] = size(pixel_shadow);
xdata = zeros(ss1 + ss2, 226);
for i=1:ss1
    temp = transpose(pixel_fg{i});
    xdata(i, :) = [temp(1, :) temp(2, :)];
    label{i, 1} = '1';
end
for i=1:ss2
    temp = transpose(pixel_shadow{i});
    xdata(ss1 + i, :) = [temp(1, :) temp(2, :)];
    label{ss1 + i, 1} = '2';
end

% decision tree
% re = predict(tree,xdata);             % 0.71
% random forest
 re = predict(BaggedEnsemble,xdata);     % 0.67

ri = 0;
for i = 1:ss1
    if re{i} == '1'
        ri = ri + 1;
    end
end
rj = 0;
for i = 1:ss2
    if re{i + ss1} == '2'
        rj = rj + 1;
    end
end

a = ri / (ri + ss2 - rj);
b = rj / (rj + ss1 - ri);

