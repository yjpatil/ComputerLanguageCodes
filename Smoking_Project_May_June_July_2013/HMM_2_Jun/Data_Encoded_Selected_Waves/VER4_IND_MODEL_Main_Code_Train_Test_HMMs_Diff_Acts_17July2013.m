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


load('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\New_Data_Encoded_Selected_BC_23July2013\ComWholeSubWNos\Info1')

load('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\Data_Encoded_Selected_Waves\EnCod_2Div_15pts_VTASts_19Jul13')

clc;

VTEnCod = VTDividedSUB;
ASEnCod = ASDividedSUB;
ts = TimeDividedSUB;

clearvars -except VTEnCod ASEnCod ts  % Hope this command does not clears the addpath's

ACTlist = char('Sit','Read','Walk','Smk');  %%%%  <<<<<<< LIST OF ALL VARIABLES %%%%%

Len = length(VTEnCod);


I = 10 %8 %10; %% Train Models with I = 10 and Test on I = 8

I1 = 8%16%8; 


%while(I <= Len)
    PartitionType = 1;
    [TrData,TrLabels,TstData,TstLabels] = fPartitionDataIndModel(VTEnCod,I,PartitionType);
    
    if(PartitionType == 2)
        TrData = TstData;
        TrLabels = TstLabels;
    end
    
    PartitionType1 = 2;
    [TrData1,TrLabels1,TstData1,TstLabels1] = fPartitionDataIndModel(VTEnCod,I1,PartitionType1);
    
    % ========== Training HMM  Model Common Parameters =============== %
    ComStStart = 7;ComStEnd = 17;ComObsStart = 7;ComObsEnd = 17;ComIter = 15;
    % ========== Training HMM  Model for SIT ACT =============== %
    ActNo = 1; % Sitting is the Act number one
    %StartState1 = ;EndState1 = ;StartObs1 = ;EndObs1 = ;MaxIter1 = ;    
    StartState1 = ComStStart;EndState1 = ComStEnd;StartObs1 = ComObsStart;EndObs1 = ComObsEnd;MaxIter1 = ComIter;    
    Data1 = TrData.Sit;
    
    [BestLogLkhd1,BestHmm1,BestStates1,BestObs1,BestIter1,RecLogLkhd1] = fTrainHMM_Ver1(StartState1,EndState1,StartObs1,EndObs1,MaxIter1,Data1);
    
% %     figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I),ACTlist(ActNo,:)))
% %     plot(RecLogLkhd1);
% %     plot(BestIter1,BestLogLkhd1,'*r');
    % ========== Training HMM Model for READ ACT =============== %
    ActNo = 2; % Reading is the Act number two
    StartState2 = ComStStart;EndState2 = ComStEnd;StartObs2 = ComObsStart;EndObs2 = ComObsEnd;MaxIter2 = ComIter;    
    %StartState2 = ;EndState2 = ;StartObs2 = ;EndObs2 = ;MaxIter2 = ;    
    Data2 = TrData.Read;
    
    [BestLogLkhd2,BestHmm2,BestStates2,BestObs2,BestIter2,RecLogLkhd2] = fTrainHMM_Ver1(StartState2,EndState2,StartObs2,EndObs2,MaxIter2,Data2);
    
% %     figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I),ACTlist(ActNo,:)))
% %     plot(RecLogLkhd2);
% %     plot(BestIter2,BestLogLkhd2,'*r');
    % ========== Training HMM  Model for WALK ACT =============== %
    ActNo = 3; % Walk is the Act number 3
    StartState3 = ComStStart;EndState3 = ComStEnd;StartObs3 = ComObsStart;EndObs3 = ComObsEnd;MaxIter3 = ComIter;
    %StartState3 = ;EndState3 = ;StartObs3 = ;EndObs3 = ;MaxIter3 = ;
    Data3 = TrData.Walk;
    
    [BestLogLkhd3,BestHmm3,BestStates3,BestObs3,BestIter3,RecLogLkhd3] = fTrainHMM_Ver1(StartState3,EndState3,StartObs3,EndObs3,MaxIter3,Data3);
    
% %     figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I),ACTlist(ActNo,:)))
% %     plot(RecLogLkhd3);
% %     plot(BestIter3,BestLogLkhd3,'*r');
    % ========== Training HMM Model for SMOKE ACT =============== %
    ActNo = 4; % Smk is the Act number 4
    StartState4 = ComStStart;EndState4 = ComStEnd;StartObs4 = ComObsStart;EndObs4 = ComObsEnd;MaxIter4 = ComIter;
    %StartState4 = ;EndState4 = ;StartObs4 = ;EndObs4 = ;MaxIter4 = ;
    Data4 = TrData.Smk;
    
    [BestLogLkhd4,BestHmm4,BestStates4,BestObs4,BestIter4,RecLogLkhd4] = fTrainHMM_Ver1(StartState4,EndState4,StartObs4,EndObs4,MaxIter4,Data4);
    
% %     figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I),ACTlist(ActNo,:)))
% %     plot(RecLogLkhd4);
% %     plot(BestIter4,BestLogLkhd4,'*r');
    
    %%%%%%%%%%%%%%%%%%%%   END OF HMM MODEL TRAINING %%%%%%%%%%%%%%%%%%%%
    
     %%%%%%%%%%%%  APPLY TRAINNED MODEL ON TRAIN-TEST DATA %%%%%%%%%%%%
    %  %%   Now Test the Sit HMM model on the different ACTS present %% %
    
    if(PartitionType == 2)
    else
        [TrLog1,TrLog2,TrLog3,TrLog4,TrEstLabel,SpecialLabel] = fTest4HMM_Ver1(TrData,TrLabels,BestHmm1,BestHmm2,BestHmm3,BestHmm4);                        
        % Get the Confusion Matrix %
        [TrCfMtx] = fGetConfusionMatrix(TrEstLabel)
        
        Time2 = toc;
    end
    
    % ------- ON TEST DATA SET ---------- %
    [TstLog1,TstLog2,TstLog3,TstLog4,TstEstLabel,SpecialLabel1] = fTest4HMM_Ver1(TstData,TstLabels,BestHmm1,BestHmm2,BestHmm3,BestHmm4);
                        
    % Get the Confusion Matrix %
    [TstCfMtx] = fGetConfusionMatrix(TstEstLabel)
    
    Time3 = toc
    
    % ------- ON WHOLE DATA SET ---------- %
    [Tst2Log1,Tst2Log2,Tst2Log3,Tst2Log4,Tst2EstLabel,SpecialLabel2] = fTest4HMM_Ver1(TstData1,TstLabels1,BestHmm1,BestHmm2,BestHmm3,BestHmm4);
                        
    % Get the Confusion Matrix %
    [Tst2CfMtx] = fGetConfusionMatrix(Tst2EstLabel)
    
    Time4 = toc
    
            
    
    %I = I + 1;
%end


save('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\Results_m_files_18July2013\Results_EnCod_3Div_50pts_VTASts_15Jul13\ResultsALLData_ALLEnCod_2Div_15pts_VTASts_19Jul13.mat')








