% ----------------------------------------------------------------------- %
%
%
% ----------------------------------------------------------------------- %
clc;clear all;close all;


% ---- Path for Data ----- %
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_17Feb2014\Scenario1_No_Sync\Large_Iterations')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_17Feb2014\Scenario1_No_Sync\Large_Iterations_Part2')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_17Feb2014\Scenario2_Sync_talking\Data01')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_17Feb2014\Scenario2_Sync_talking\Data02')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_17Feb2014\Scenario3_FetchingCoffee\Data01')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_17Feb2014\Scenario3_FetchingCoffee\Data02')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_17Feb2014\Scenario3_FetchingCoffee\Data03')
%  Initialize all the data set in cell format  %

% %--------- Activity (1) = DATA (1) --------- %
load('Data_Large_Iter');

XF_loc(1,:) = Hist1;
XF_loc(2,:) = Hist2; 

XF_dir(1,:) = Direction1;
XF_dir(2,:) = Direction2;

Direction = [];Direction1 = [];Direction2 = [];Location1 = [];Location2 = [];
% %--------- Activity (1) = DATA (2) --------- %
load('Data_Large_Iter_Part2');

XF_loc(3,:) = Hist1; 
XF_loc(4,:) = Hist2; 

XF_dir(3,:) = Direction1;
XF_dir(4,:) = Direction2;

XL_loc(1,1) = 1;% Label Activity # 1
XL_loc(2,1) = 1;% Label Activity # 1
XL_loc(3,1) = 1;% Label Activity # 1
XL_loc(4,1) = 1;% Label Activity # 1

Direction = [];Direction1 = [];Direction2 = [];Location1 = [];Location2 = [];
% %--------- Activity (2) = DATA (1) --------- %
load('Data01_talk_walk')

XF_loc(5,:) = Hist1;
XF_loc(6,:) = Hist2; 

XF_dir(5,:) = Direction1;
XF_dir(6,:) = Direction2;

Direction = [];Direction1 = [];Direction2 = [];Location1 = [];Location2 = [];
% %--------- Activity (2) = DATA (2) --------- %
load('Data02_talk_walk');

XF_loc(7,:) = Hist1;
XF_loc(8,:) = Hist2; 

XF_dir(7,:) = Direction1;
XF_dir(8,:) = Direction2;

XL_loc(5,1) = 2;% Label Activity # 2
XL_loc(6,1) = 2;% Label Activity # 2
XL_loc(7,1) = 2;% Label Activity # 2
XL_loc(8,1) = 2;% Label Activity # 2

Direction = [];Direction1 = [];Direction2 = [];Location1 = [];Location2 = [];

% %--------- Activity (3) = DATA (1) --------- %
load('Data01_fetch_coffee')

XF_loc(9,:) = Hist1;
XF_loc(10,:) = Hist2; 

XF_dir(9,:) = Direction1;
XF_dir(10,:) = Direction2;

Direction = [];Direction1 = [];Direction2 = [];Location1 = [];Location2 = [];
% %--------- Activity (3) = DATA (2) --------- %
load('Data02_fetch_coffee');

XF_loc(11,:) = Hist1;
XF_loc(12,:) = Hist2; 

XF_dir(11,:) = Direction1;
XF_dir(12,:) = Direction2;

Direction = [];Direction1 = [];Direction2 = [];Location1 = [];Location2 = [];
% %--------- Activity (3) = DATA (3) --------- %
load('Data03_fetch_coffee');

XF_loc(13,:) = Hist1;
XF_loc(14,:) = Hist2; 

XF_dir(13,:) = Direction1;
XF_dir(14,:) = Direction2;

XL_loc(9,1) = 3;% Label Activity # 3
XL_loc(10,1) = 3;% Label Activity # 3
XL_loc(11,1) = 3;% Label Activity # 3
XL_loc(12,1) = 3;% Label Activity # 3
XL_loc(13,1) = 3;% Label Activity # 3
XL_loc(14,1) = 3;% Label Activity # 3

Direction = [];Direction1 = [];Direction2 = [];Location1 = [];Location2 = [];

% % ------------------------------------------------------------------- % %
% % Count = 1;
% % for i = 1 : 1 : Min
% %     XF(Count,:) = Featclass1(i,:);
% %     XL(Count,1) = Labelsclass1(i);
% %     Count = Count + 1;
% %     XF(Count,:) = Featclass2(i,:);
% %     XL(Count,1) = Labelsclass2(i);
% %     Count = Count + 1;
% %     XF(Count,:) = Featclass3(i,:);
% %     XL(Count,1) = Labelsclass3(i);
% %     Count = Count + 1;
% %     XF(Count,:) = Featclass4(i,:);
% %     XL(Count,1) = Labelsclass4(i);
% %     Count = Count + 1;
% % end

% % TrainSize = 0.8 % 0.8 == 80%
% % 
% % Size11 = round(TrainSize*length(XF));
% % 
Xt = XF_dir;dt = XL_loc;

X = XF_dir;d = XL_loc;


X_train = Xt;
Labels_train = dt;

X_test = Xt;
Labels_test = dt;
% % X_test = X;
% % Labels_test = d;


Temp_Acc = 0;
clc;
Tim0 = toc
tic

for p1 = -15 : 1 : 15          % for loop for search of C value in RBF
    Cval = num2str(exp(p1));   % The value of C parameter in SVM
    %for p2 = 1 : 1 : 5      % for loop for search of gamma value in RBF        
        %gval = num2str(exp(p2));          
        options = [' -s ',' 0 ',' -t ',' 0 ',' d ',' 2 ',' -c ',Cval];%,' -g ',gval];            
        %options = [' -s ',' 0 ',' -t ',' 0 ',' -c ',Cval];%,' -g ',gval];            
        model = svmtrain(Labels_train, X_train,options);            
        [predict_label_L, accuracy_L, dec_values_L] = svmpredict(Labels_test,X_test, model);            
           
        if(accuracy_L(1,1) > Temp_Acc)
            BestCval = Cval;
            Temp_Acc = accuracy_L(1,1);
            Temp_Pre_L = predict_label_L;
            Temp_Acc_L = Labels_test;
        end
    %end       % for loop for gamma values
end           % for loop for C values


clc

Tim1 = toc;

fprintf('\n ======= Final results for SVM classifier ======== \n\n')

fprintf('\n The time taken for Feature Extraction is : %f \n',Tim0)

fprintf('\n The time taken to train the SVM is : %f \n',Tim1)

fprintf('\n ==== The results for SVM validation set ==== \n\n')
[Cf1] =  cfmatrix(Temp_Acc_L,Temp_Pre_L, [1 2 3 4], 0, 1);



% options = [' -s ',' 0 ',' -t ',' 0 ',' d ',' 2 ',' -c ',BestCval];      
% model = svmtrain(Labels_train, X_train,options);  
% 
% [predict_label_L, accuracy_L, dec_values_L] = svmpredict(Labels_test,X_test, model);   
% 
% [Cf1] =  cfmatrix(Labels_test,predict_label_L, [1 2 3 4], 0, 1);
% 


% save('BestModel.dat','model')



















