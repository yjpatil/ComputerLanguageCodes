% Code to create the model_feature and test_feature cell matrix for ROC
% curve
clc;clear all;
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bICA\Data_ROC\Sub1');

% for i = 1 : 1 : 6
%     load(strcat('S1C1c',num2str(i),'_TestFeat.mat'));
%     load(strcat('S1C1c',num2str(i),'_TrueFeat.mat'));
%      model_feature{i,1} = mfeat;
%      test_feature{i,1} = A;
% end
    


% for i = 1 : 1 : 6
%     load(strcat('S1C1c',num2str(i),'_TestFeat.mat'));
%     load(strcat('S1C1c',num2str(i),'_TrueFeat.mat'));
%      model_feature{i,1} = [0.7,0,0.3,0,0];
%      test_feature{i,1} = [0.65,0,0.35,0,0];
% end




model_feature{1,1} = [0.7,0,0.3,0,0];
test_feature{1,1} = [0.65,0,0.35,0,0];

model_feature{2,1} = [0.37,0,0.63,0,0];
test_feature{2,1} = [0.34,0,0.66,0,0];

model_feature{3,1} = [0.7,0,0.3,0,0];
test_feature{3,1} = [0.69,0,0.31,0,0];

model_feature{4,1} = [0.5,0,0.5,0,0];
test_feature{4,1} = [0.51,0,0.49,0,0];

model_feature{4,1} = [0.8,0,0.2,0,0];
test_feature{4,1} = [0.83,0,0.17,0,0];

model_feature{5,1} = [0.6,0,0.4,0,0];
test_feature{5,1} = [0.51,0,0.49,0,0];

% model_feature{1,2} = [0.7,0,0.3,0,0];
% test_feature{1,2} = [0.65,0,0.35,0,0];
% 
% model_feature{2,2} = [0.37,0,0.63,0,0];
% test_feature{2,2} = [0.34,0,0.66,0,0];
% 
% model_feature{3,2} = [0.7,0,0.3,0,0];
% test_feature{3,2} = [0.69,0,0.31,0,0];
% 
% model_feature{4,2} = [0.5,0,0.5,0,0];
% test_feature{4,2} = [0.51,0,0.49,0,0];
% 
% model_feature{4,2} = [0.8,0,0.2,0,0];
% test_feature{4,2} = [0.83,0,0.17,0,0];
% 
% model_feature{5,2} = [0.6,0,0.4,0,0];
% test_feature{5,2} = [0.51,0,0.49,0,0];






