%% Use SVM Example:
% load fisheriris
% xdata = meas(51:end,3:4);
% group = species(51:end);
% model = svmtrain(xdata,group);
% label = svmclassify(model, xdata);

%% data prepare

addpath_scatnet
clear all;

for n = 1:51
    sf = strcat('scatteringdata/pixel_fg_', int2str(n), '.mat');
    ss = strcat('scatteringdata/pixel_shadow_', int2str(n), '.mat');
    f{n} = load(sf);
    s{n} = load(ss);
end

i = 0;
for n = 1:51
    
    xdata = [];
    label = {};
    ddata = [];
    dlabel = {};
    for m = 1:51
        temp1 = f{m}.pixel_fg;
        temp2 = s{m}.pixel_shadow;
        [tt1, ss1] = size(temp1);
        [tt1, ss2] = size(temp2);
        tempxdata = zeros(ss1+ss2, 226);
        templabel = {};
        for i = 1:ss1
            tmp = transpose(temp1{i});
            tempxdata(i, :) = [tmp(1, :) tmp(2, :)];
            templabel{i, 1} = '1';
        end
        for i = 1:ss2
            tmp = transpose(temp2{i});
            tempxdata(ss1 + i, :) = [tmp(1, :) tmp(2, :)];
            templabel{ss1 + i, 1} = '2';
        end
        if m ~= n
            % train
            xdata = [xdata; tempxdata];
            label = [label; templabel];
        else
            % detect
            ddata = [xdata; tempxdata];
            dlabel = [label; templabel];
        end
    end
    
    BaggedEnsemble = TreeBagger(50,xdata,label);
    re = predict(BaggedEnsemble,ddata);
    
    ri = 0;
    rj = 0;
    rii = 0;
    rjj = 0;
    [ss3, tt1] = size(ddata);
    for i = 1:ss3
        if re{i} == '1' && dlabel{i} == '1'
            ri = ri + 1;
        elseif re{i} == '2' && dlabel{i} == '2'
            rj = rj + 1;
        end
        if re{i} == '1'
            rii = rii + 1;
        elseif re{i} == '2'
            rjj = rjj + 1;
        end
    end

    a{n} = ri / rii;
    b{n} = rj / rjj;
    
end




%% do svm
% options.MaxIter = 1000000;
% model = svmtrain(xdata,label, 'Options', options);
% res = svmclassify(model, xdata);

%% decision tree
% tree = ClassificationTree.fit(xdata,label);
% re = predict(tree,xdata);

BaggedEnsemble = TreeBagger(50,xdata,label);

save('BaggedEnsemble.mat', 'BaggedEnsemble');


