% ================== 4 HMMS INDIVIDUAL MODEL TRAINING =================== %
% This is the main code to train and validate the HMM models for different
% acts. HMM model for each act is selected based on the loglikelihood value
% in the training phase. Then these HMM models are then applied on the
% validation data set and confusion matrix gives the performance of the HMM
% models classification
clc;clear all;close all;

tic



%  Add this path for HMM folder
addpath(genpath('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM'));

%  Add this path into the paths so as to access all HMM toolkit
addpath(genpath('C:\Users\student\Documents\MATLAB\HMM\HMMEverything'));

%  Add this path into the paths so as to access all Pre-processing functions for 20 Subjects  
addpath(genpath('C:\Users\student\Documents\MATLAB\BioBldg_20_Function_Get_AS_VT'));

addpath(genpath('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun'));

load('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\Data_Encoded_Selected_Waves\EnCod_4Div_200pts_VTASts_15Jul13')

clc;

VTEnCod = VTDividedSUB;
ASEnCod = ASDividedSUB;
ts = TimeDividedSUB;

clearvars -except VTEnCod ASEnCod ts  % Hope this command does not clears the addpath's

ACTlist = char('Sit','Read','Walk','Smk');  %%%%  <<<<<<< LIST OF ALL VARIABLES %%%%%

Len = length(VTEnCod);


I = 10 %8 %10; %% Train Models with I = 10 and Test on I = 8

I1 = 8;


%while(I <= Len)
    PartitionType = 1;
    [TrData,TrLabels,TstData,TstLabels] = fPartitionDataIndModel(VTEnCod,I,PartitionType);
    
    PartitionType = 2;
    [TrData1,TrLabels1,TstData1,TstLabels1] = fPartitionDataIndModel(VTEnCod,I1,PartitionType);
    
    
    % ========== Training HMM  Model for SIT ACT =============== %
    ActNo = 1; % Sitting is the Act number one
    StartState1 = 15;EndState1 = 17;StartObs1 = 14;EndObs1 = 16;MaxIter1 = 18;    
    Data1 = TrData.Sit;
    
    [BestLogLkhd1,BestHmm1,BestStates1,BestObs1,BestIter1,RecLogLkhd1] = fTrainHMM_Ver1(StartState1,EndState1,StartObs1,EndObs1,MaxIter1,Data1);
    
% %     figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I),ACTlist(ActNo,:)))
% %     plot(RecLogLkhd1);
% %     plot(BestIter1,BestLogLkhd1,'*r');
    % ========== Training HMM Model for READ ACT =============== %
    ActNo = 2; % Reading is the Act number two
    StartState2 = 15;EndState2 = 17;StartObs2 = 14;EndObs2 = 16;MaxIter2 = 18;    
    Data2 = TrData.Read;
    
    [BestLogLkhd2,BestHmm2,BestStates2,BestObs2,BestIter2,RecLogLkhd2] = fTrainHMM_Ver1(StartState2,EndState2,StartObs2,EndObs2,MaxIter2,Data2);
    
% %     figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I),ACTlist(ActNo,:)))
% %     plot(RecLogLkhd2);
% %     plot(BestIter2,BestLogLkhd2,'*r');
    % ========== Training HMM  Model for WALK ACT =============== %
    ActNo = 3; % Walk is the Act number 3
    StartState3 = 15;EndState3 = 17;StartObs3 = 14;EndObs3 = 36;MaxIter3 = 18;
    Data3 = TrData.Walk;
    
    [BestLogLkhd3,BestHmm3,BestStates3,BestObs3,BestIter3,RecLogLkhd3] = fTrainHMM_Ver1(StartState3,EndState3,StartObs3,EndObs3,MaxIter3,Data3);
    
% %     figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I),ACTlist(ActNo,:)))
% %     plot(RecLogLkhd3);
% %     plot(BestIter3,BestLogLkhd3,'*r');
    % ========== Training HMM Model for SMOKE ACT =============== %
    ActNo = 4; % Smk is the Act number 4
    StartState4 = 15;EndState4 = 17;StartObs4 = 14;EndObs4 = 16;MaxIter4 = 18;
    Data4 = TrData.Smk;
    
    [BestLogLkhd4,BestHmm4,BestStates4,BestObs4,BestIter4,RecLogLkhd4] = fTrainHMM_Ver1(StartState4,EndState4,StartObs4,EndObs4,MaxIter4,Data4);
    
% %     figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I),ACTlist(ActNo,:)))
% %     plot(RecLogLkhd4);
% %     plot(BestIter4,BestLogLkhd4,'*r');
    
    %%%%%%%%%%%%%%%%%%%%   END OF HMM MODEL TRAINING %%%%%%%%%%%%%%%%%%%%
    
     %%%%%%%%%%%%  APPLY TRAINNED MODEL ON TRAIN-TEST DATA %%%%%%%%%%%%
    %  %%   Now Test the Sit HMM model on the different ACTS present %% %
    %  %%      Apply on the Train Data Set to see the PDF and other plots
    ActNo = 1; % Sitting is the Act number one
    
    PlotYesNo = 1;  % '1' = Yes Plot, '2' = No Plot    
    [Log1] = fTestHMM(TrData,BestHmm1,PlotYesNo,11,12,ACTlist,ActNo);  % Test the HMM model ON tRAIN dATA 
    
    % ------- Test on Test Data set ------------ %
    Log1 = [];
    
    PlotYesNo = 1;  % '1' = Yes Plot, '2' = No Plot    
    [Log1] = fTestHMM(TstData,BestHmm1,PlotYesNo,13,14,ACTlist,ActNo);  % Test the HMM model ON tRAIN dATA           
    
    %  %%      Apply on the Train Data Set to see the PDF and other plots
    ActNo = 2; % Sitting is the Act number one
    
    PlotYesNo = 1;  % '1' = Yes Plot, '2' = No Plot
    [Log2] = fTestHMM(TrData,BestHmm2,PlotYesNo,21,22,ACTlist,ActNo);  % Test the HMM model ON tRAIN dATA             
    % ------- Test on Test Data set ------------ %
    Log2 = [];
    
    PlotYesNo = 1;  % '1' = Yes Plot, '2' = No Plot
    [Log2] = fTestHMM(TstData,BestHmm2,PlotYesNo,23,24,ACTlist,ActNo);  % Test the HMM model ON tRAIN dATA         
    
    %  %%      Apply on the Train Data Set to see the PDF and other plots
    ActNo = 3; % Sitting is the Act number one
    
    PlotYesNo = 1;  % '1' = Yes Plot, '2' = No Plot
    [Log3] = fTestHMM(TrData,BestHmm3,PlotYesNo,31,32,ACTlist,ActNo);  % Test the HMM model ON tRAIN dATA             
    % ------- Test on Test Data set ------------ %
    Log3 = [];
    
    PlotYesNo = 1;  % '1' = Yes Plot, '2' = No Plot
    [Log3] = fTestHMM(TstData,BestHmm3,PlotYesNo,33,34,ACTlist,ActNo);  % Test the HMM model ON tRAIN dATA    
    
    %  %%      Apply on the Train Data Set to see the PDF and other plots
    ActNo = 4; % Sitting is the Act number one
    
    PlotYesNo = 1;  % '1' = Yes Plot, '2' = No Plot
    [Log4] = fTestHMM(TrData,BestHmm4,PlotYesNo,41,42,ACTlist,ActNo);  % Test the HMM model ON tRAIN dATA 
    
    % ------- Test on Test Data set ------------ %
    Log4 = [];
    
    PlotYesNo = 1;  % '1' = Yes Plot, '2' = No Plot
    [Log4] = fTestHMM(TstData,BestHmm4,PlotYesNo,43,44,ACTlist,ActNo);  % Test the HMM model ON tRAIN dATA     
    
    
             
    
    
    
    
            
    
    %I = I + 1;
%end











