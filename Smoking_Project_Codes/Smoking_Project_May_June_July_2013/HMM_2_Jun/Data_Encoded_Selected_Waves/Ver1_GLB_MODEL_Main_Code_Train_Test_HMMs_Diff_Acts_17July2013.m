% ================== 4 HMMS INDIVIDUAL MODEL TRAINING =================== %
% This is the main code to train and validate the HMM models for different
% acts. HMM model for each act is selected based on the loglikelihood value
% in the training phase. Then these HMM models are then applied on the
% validation data set and confusion matrix gives the performance of the HMM
% models classification
clc;clear all;close all;

tic

%1) EnCod_4Div_200pts_VTASts_15Jul13 = StartState2 = 5;EndState2 = 20;StartObs2 = 14;EndObs2 = 36;MaxIter2 = 20;
%2) EnCod_3Div_50pts_VTASts_15Jul13 = -SAS-


%  Add this path for HMM folder
addpath(genpath('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM'));

%  Add this path into the paths so as to access all HMM toolkit
addpath(genpath('C:\Users\student\Documents\MATLAB\HMM\HMMEverything'));

%  Add this path into the paths so as to access all Pre-processing functions for 20 Subjects  
addpath(genpath('C:\Users\student\Documents\MATLAB\BioBldg_20_Function_Get_AS_VT'));

addpath(genpath('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun'));

load('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\Data_Encoded_Selected_Waves\EnCod_3Div_50pts_VTASts_15Jul13')

clc;

VTEnCod = VTDividedSUB;
ASEnCod = ASDividedSUB;
ts = TimeDividedSUB;

clearvars -except VTEnCod ASEnCod ts  % Hope this command does not clears the addpath's

ACTlist = char('Sit','Read','Walk','Smk');  %%%%  <<<<<<< LIST OF ALL VARIABLES %%%%%


I = 10 %8 %10; %% Train Models with I = 10 and Test on I = 8

Len = length(VTEnCod);

for i = 1 : 1 : Len
    Labels(i).Sit = 1 * ones(length(VTEnCod(i).Sit),1);
    Labels(i).Read = 2 * ones(length(VTEnCod(i).Read),1);
    Labels(i).Walk = 3 * ones(length(VTEnCod(i).Walk),1);
    Labels(i).Smk = 4 * ones(length(VTEnCod(i).Smk),1);
end


%while(I <= Len)
    [TrData,TrLabels,TstData,TstLabels] = fGLB_Data_Partition(I,VTEnCod,Labels);    
    
    % ========== Training HMM  Model for SIT ACT =============== %
    ActNo = 1; % Sitting is the Act number one
    StartState1 = 5;EndState1 = 20;StartObs1 = 14;EndObs1 = 36;MaxIter1 = 20;    
    Data1 = TrData.Sit;
    
    [BestLogLkhd1,BestHmm1,BestStates1,BestObs1,BestIter1,RecLogLkhd1] = fTrainHMM_Ver1(StartState1,EndState1,StartObs1,EndObs1,MaxIter1,Data1);
    
% %     figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I),ACTlist(ActNo,:)))
% %     plot(RecLogLkhd1);
% %     plot(BestIter1,BestLogLkhd1,'*r');
    % ========== Training HMM Model for READ ACT =============== %
    ActNo = 2; % Reading is the Act number two
    StartState2 = 5;EndState2 = 20;StartObs2 = 14;EndObs2 = 36;MaxIter2 = 20;    
    Data2 = TrData.Read;
    
    [BestLogLkhd2,BestHmm2,BestStates2,BestObs2,BestIter2,RecLogLkhd2] = fTrainHMM_Ver1(StartState2,EndState2,StartObs2,EndObs2,MaxIter2,Data2);
    
% %     figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I),ACTlist(ActNo,:)))
% %     plot(RecLogLkhd2);
% %     plot(BestIter2,BestLogLkhd2,'*r');
    % ========== Training HMM  Model for WALK ACT =============== %
    ActNo = 3; % Walk is the Act number 3
    StartState3 = 5;EndState3 = 20;StartObs3 = 14;EndObs3 = 36;MaxIter3 = 20;
    Data3 = TrData.Walk;
    
    [BestLogLkhd3,BestHmm3,BestStates3,BestObs3,BestIter3,RecLogLkhd3] = fTrainHMM_Ver1(StartState3,EndState3,StartObs3,EndObs3,MaxIter3,Data3);
    
% %     figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I),ACTlist(ActNo,:)))
% %     plot(RecLogLkhd3);
% %     plot(BestIter3,BestLogLkhd3,'*r');
    % ========== Training HMM Model for SMOKE ACT =============== %
    ActNo = 4; % Smk is the Act number 4
    StartState4 = 5;EndState4 = 20;StartObs4 = 14;EndObs4 = 36;MaxIter4 = 20;
    Data4 = TrData.Smk;
    
    [BestLogLkhd4,BestHmm4,BestStates4,BestObs4,BestIter4,RecLogLkhd4] = fTrainHMM_Ver1(StartState4,EndState4,StartObs4,EndObs4,MaxIter4,Data4);
    
% %     figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I),ACTlist(ActNo,:)))
% %     plot(RecLogLkhd4);
% %     plot(BestIter4,BestLogLkhd4,'*r');
    
    %%%%%%%%%%%%%%%%%%%%   END OF HMM MODEL TRAINING %%%%%%%%%%%%%%%%%%%%
    
     %%%%%%%%%%%%  APPLY TRAINNED MODEL ON TRAIN-TEST DATA %%%%%%%%%%%%
    %  %%   Now Test the Sit HMM model on the different ACTS present %% %       
    
    [TrLog1,TrLog2,TrLog3,TrLog4,TrEstLabel,SpecialLabel] = fTest4HMM_Ver1(TrData,TrLabels,BestHmm1,BestHmm2,BestHmm3,BestHmm4);                       
    % Get the Confusion Matrix %
    [TrCfMtx] = fGetConfusionMatrix(TrEstLabel);        
    
    Time2 = toc;    
    
    % ------- ON TEST DATA SET ---------- %
    [TstLog1,TstLog2,TstLog3,TstLog4,TstEstLabel,SpecialLabel1] = fTest4HMM_Ver1(TstData,TstLabels,BestHmm1,BestHmm2,BestHmm3,BestHmm4);
                        
    % Get the Confusion Matrix %
    [TstCfMtx] = fGetConfusionMatrix(TstEstLabel);
    
    Time3 = toc
    
   
            
    
    %I = I + 1;
%end


save('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\GLB_Models_Results_m_files_18July2013\GLB_Model_EnCod_3Div_50pts_VTASts_15Jul13\GLB_Results_EnCod_3Div_50pts_VTASts_18Jul13')








