%% Extract and Plot HOG Features
%% Read the image of interest.

% Copyright 2015 The MathWorks, Inc.

    img = imread('oto10.png');
    img = imresize(img,[24,24]);
%% Extract HOG features.
    [featureVector, hogVisualization] = extractHOGFeatures(img);
%% Plot HOG features over the original image.
    figure;
    imshow(img); hold on;
    plot(hogVisualization);

%% ----------------------------------------------------

% clear all; clc;
% 
% load fisheriris
% xdata = meas(51:end,3:4);
% group = species(51:end);
% figure;
% svmStruct = svmtrain(xdata,group,'ShowPlot',true);
% Md1SV = fitcsvm(xdata,group);
% Group = svmclassify(SVMStruct,Sample,'Showplot',true);
% Mdl = discardSupportVectors(Md1SV);

%% --------- test SVM ----------------------------------------
% clear all; clc;
% %Load Data
% load fisheriris % --> meas, species
% TrainInputs = meas(1:end,3:4);
% TrainTargets = species(1:end);
% 
% %% Design SVM --> svmstruct , C
% C = 100;
% svmstruct = svmtrain(TrainInputs,TrainTargets,...
%     'boxconstraint',C,...
%     'kernel_function','rbf',...
%     'rbf_sigma',0.5,...
%     'showplot','false');
% %% Test SVM
% dataTset = meas(60,3:4);
% TestInputs = dataTset;
% 
% TestOutputs = svmclassify(svmstruct,TestInputs,'showplot','false');

%% --------- SVM phan loai phuowng tien giao thong----------------------------------------
% clear all; clc;
% %Load Data
% TrainInputs = data';
% TrainTargets = species(1:end);

%% Design SVM --> svmstruct , C
% C = 100;
% svmstruct = svmtrain(TrainInputs,TrainTargets,...
%     'boxconstraint',C,...
%     'kernel_function','rbf',...
%     'rbf_sigma',0.5,...
%     'showplot','false');
% %% Test SVM
% dataTset = meas(60,3:4);
% TestInputs = dataTset;
% 
% TestOutputs = svmclassify(svmstruct,TestInputs,'showplot','false');
