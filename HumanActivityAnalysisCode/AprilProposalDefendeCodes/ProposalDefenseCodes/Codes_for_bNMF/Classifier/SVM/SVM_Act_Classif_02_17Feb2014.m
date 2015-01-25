% ----------------------------------------------------------------------- %
%
%
% ----------------------------------------------------------------------- %
clc;clear all;close all;


% ---- Path for Data ----- %
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_18Feb2014\Trajectory1')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_18Feb2014\Trajectory2')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_18Feb2014\Trajectory3')
%  Initialize all the data set in cell format  %

% %--------- Activity (1) = DATA (1) --------- %
load('T1C1');
XF_loc(1,:) = T1C1_Hist1;XF_loc(2,:) = T1C1_Hist2; 

XF_dir(1,:) = T1C1_Dir1;XF_dir(2,:) = T1C1_Dir2;

% %--------- Activity (1) = DATA (2) --------- %
load('T1C2');

XF_loc(3,:) = T1C2_Hist1;XF_loc(4,:) = T1C2_Hist2; 

XF_dir(3,:) = T1C2_Dir1;XF_dir(4,:) = T1C2_Dir2;

% %--------- Activity (1) = DATA (3) --------- %
load('T1C3');

XF_loc(5,:) = T1C3_Hist1;XF_loc(6,:) = T1C3_Hist2; 

XF_dir(5,:) = T1C3_Dir1;XF_dir(6,:) = T1C3_Dir2;

% %--------- Activity (1) = DATA (4) --------- %
load('T1C4');

XF_loc(7,:) = T1C4_Hist1;XF_loc(8,:) = T1C4_Hist2; 

XF_dir(7,:) = T1C4_Dir1;XF_dir(8,:) = T1C4_Dir2;

% * -------- Label Activity # 1 -------- * %
XL_loc(1,1) = 1;XL_loc(2,1) = 1;XL_loc(3,1) = 1;XL_loc(4,1) = 1;
XL_loc(5,1) = 1;XL_loc(6,1) = 1;XL_loc(7,1) = 1;XL_loc(8,1) = 1;

% %--------- Activity (2) = DATA (1) --------- %
load('T2C1');

XF_loc(9,:) = T2C1_Hist1;XF_loc(10,:) = T2C1_Hist2; 

XF_dir(9,:) = T2C1_Dir1;XF_dir(10,:) = T2C1_Dir2;

% %--------- Activity (2) = DATA (2) --------- %
load('T2C2');

XF_loc(11,:) = T2C2_Hist1;XF_loc(12,:) = T2C2_Hist2; 

XF_dir(11,:) = T2C2_Dir1;XF_dir(12,:) = T2C2_Dir2;

% %--------- Activity (2) = DATA (3) --------- %
load('T2C3');

XF_loc(13,:) = T2C3_Hist1;XF_loc(14,:) = T2C3_Hist2; 

XF_dir(13,:) = T2C3_Dir1;XF_dir(14,:) = T2C3_Dir2;
% %--------- Activity (2) = DATA (4) --------- %
load('T2C4');

XF_loc(15,:) = T2C4_Hist1;XF_loc(16,:) = T2C4_Hist2; 

XF_dir(15,:) = T2C4_Dir1;XF_dir(16,:) = T2C4_Dir2;
% %--------- Activity (2) = DATA (5) --------- %
load('T2C5');

XF_loc(17,:) = T2C5_Hist1;XF_loc(18,:) = T2C5_Hist2; 

XF_dir(17,:) = T2C5_Dir1;XF_dir(18,:) = T2C5_Dir2;
% * -------- Label Activity # 2 -------- * %
XL_loc(9,1) = 2;XL_loc(10,1) = 2;XL_loc(11,1) = 2;XL_loc(12,1) = 2;
XL_loc(13,1) = 2;XL_loc(14,1) = 2;XL_loc(15,1) = 2;XL_loc(16,1) = 2;
XL_loc(17,1) = 2;XL_loc(18,1) = 2;
% %--------- Activity (3) = DATA (1) --------- %
load('T3C1');

XF_loc(19,:) = T3C1_Hist1;XF_loc(20,:) = T3C1_Hist2; 

XF_dir(19,:) = T3C1_Dir1;XF_dir(20,:) = T3C1_Dir2;

% %--------- Activity (3) = DATA (2) --------- %
load('T3C2');

XF_loc(21,:) = T3C2_Hist1;XF_loc(22,:) = T3C2_Hist2; 

XF_dir(21,:) = T3C2_Dir1;XF_dir(22,:) = T3C2_Dir2;

% %--------- Activity (3) = DATA (3) --------- %
load('T3C3');

XF_loc(23,:) = T3C3_Hist1;XF_loc(24,:) = T3C3_Hist2; 

XF_dir(23,:) = T3C3_Dir1;XF_dir(24,:) = T3C3_Dir2;
% * -------- Label Activity # 3 -------- * %
XL_loc(19,1) = 3;XL_loc(20,1) = 3;XL_loc(21,1) = 3;XL_loc(22,1) = 3;
XL_loc(23,1) = 3;XL_loc(24,1) = 3;
% % % ======================== () ============================== % % %
Array_Train = [1,2,3,4,5,6,9,10,11,12,13,14,15,19,20,21,22];
Array_Test = [1,2,3,7,8,11,12,13,16,17,18,19,20,21,23,24];

Xt = XF_dir(Array_Train,:);
%Xt = XF_loc(Array_Train,:);
dt = XL_loc(Array_Train,:);

X = XF_dir(Array_Test,:);
%X = XF_loc(Array_Test,:);
d = XL_loc(Array_Test,:);


X_train = Xt;
Labels_train = dt;

% X_test = Xt;
% Labels_test = dt;
X_test = X;
Labels_test = d;


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
[Cf1] =  cfmatrix(Temp_Acc_L,Temp_Pre_L, [1 2 3], 0, 1);



% options = [' -s ',' 0 ',' -t ',' 0 ',' d ',' 2 ',' -c ',BestCval];      
% model = svmtrain(Labels_train, X_train,options);  
% 
% [predict_label_L, accuracy_L, dec_values_L] = svmpredict(Labels_test,X_test, model);   
% 
% [Cf1] =  cfmatrix(Labels_test,predict_label_L, [1 2 3 4], 0, 1);
% 


% save('BestModel.dat','model')



















