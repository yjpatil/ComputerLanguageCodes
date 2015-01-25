% ----------------------------------------------------------------------- %
% This code takes a particular target defined by the user, Then calculates
% the statistics for it. Then it uses the test data (for the same target)
% and calculates new statistics for the test data. Finally it compares the
% test data stats with the train data stats.
% Cluster = if a single target is selected,then gaits are the cluster
%         = if a single gait is selected,then targets are the cluster
% ----------------------------------------------------------------------- %
try fclose(s2); catch end
clear all; close all; clc;
addpath('rec_functions'); 
addpath('data_fix_path_tar_gait_train');
addpath('data_fix_path_tar_gait_test');

num_target=5; % <*> In our case it is LogLikelihood values vs True Labels for all Scenarios 
% <*> xxxx Wrong ::Total number of targets ------ (OurCase:: Total number of Subjects, Scenarios,Activities)

sel_tar=1;   % Selected Subject (Only One) ------ (OurCase:: Select a Subject or Scenario or Activitie)
sel_gait=5;  % Selected Gait (Only One) ------ (OurCase::  
num_sen=4;   % Total number of sensors  ------ (OurCase:: 

% rows == for diff tar, cols == for diff gait
bin_event_train = load_data(1);      % load_data is a function that contains the path details for each data
%bin_event_train=bin_event_train(:,sel_gait);    % If you want the data for specific gait
bin_event_train = bin_event_train(sel_tar,:);     % If you want the data for specific target gait

% ------ Get features (2nd order Statistics) for the specific target/gait for given # of sensors
model_feature = train_st(bin_event_train,num_sen); % model_feature = Cell Matrix of 5 (gaits/targets)x 4(sensors) <*> Each having 8 features !!
% model_feature=train_hmm(bin_event_train,num_sen);

% save model_hmm model_hmm
% load model_hmm; model_feature=model_hmm;

% % -----------------------------------------------------------
% This is where you load TEST data %
bin_event_test = load_data(2);
% bin_event_test=bin_event_test(:,sel_gait);
bin_event_test = bin_event_test(sel_tar,:); % For specififc Target

% ------------- testing ----------------------------------
test_cycle = 30;  % ?????Total number of iterations
PAIR       = 2;   % Combination pairs 
ML         = zeros(test_cycle, PAIR, PAIR); %????? ML is  a 3D matrix, ML = [] 30x2x2
len_test   = 800; % Enough Data length to calculate stats

%sel=[1 2];
%num_target=3; 
for i_c = 1 : test_cycle
    i_c
    sel = unidrnd(num_target,1,PAIR); % Generate a pair of target indices (2 targets here) between 1 and 5
    while (sel(1) == sel(2))  % If the two elements (target indices) are same in 'sel' change them
        sel(2) = unidrnd(num_target);
    end % Do until the two elements are not same

    sel_model = model_feature(sel,:);  %** TRAIN DATA ** % Get the two corresponding gaits/targets statistics for all sensors and load them in 'sel_model'
    sel_data = bin_event_test(sel);    %** TEST DATA ** % Select the corresponding gait/target test data for chosen target/gait respectively 
    
    for i_Model = 1 : PAIR     %% i_Model :: What feature of two particular gaits/targets you want to compare with the test data target/gait
        for i_Test = 1 : PAIR  %% i_Test  :: 
            ML(i_c,i_Model,i_Test) = ...
                ml_calclate_pst(sel_model(i_Model,:),sel_data{i_Test},len_test);  % % ml_calclate_pst(train_stats,test_Rawdata, reduced length)
        end
    end
    
end

ML=ML*200;
figure(1)
Plot_MLo_HistFit('MAP', ML, 1);
figure(2)
Plot_MLo_ROC(ML, 'k - d')













