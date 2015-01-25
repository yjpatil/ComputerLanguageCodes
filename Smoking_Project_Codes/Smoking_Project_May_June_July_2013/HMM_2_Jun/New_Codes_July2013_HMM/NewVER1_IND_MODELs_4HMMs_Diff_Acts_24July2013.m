% ================== 3 HMMS INDIVIDUAL MODEL TRAINING =================== %

clc;clear all;close all;

tic

% <<<<<<<<<<<<<<<<<<<<<   MAKE CHANGES BELOW  <<<<<<<<<<<<<<<<<<<<<<<<<<< %
path2 = char('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\New_Data_Encoded_Selected_BC_23July2013\ComWhole_Sit_Walk_Sep\'); 

load(strcat(path2,'ListInfo'));

path3 = char('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\New_IND_Results_4HMM_XDivs_YSeps_24July2013\');

% ResultInfo(20) = struct('Sep',[],'Div',[],'TimetrTst',[],'Name',{}, ... 
%                         'TrBestLogLkhd',[0 0 0],'TrCfMtx',[],'TrOvAcc',[], ...
%                         'TstCfMtx',[],'TstOvAcc',[]);

ACTlist = char('Sit','Read','Smk');  %  <<<<<<< LIST OF ALL VARIABLes
% <<<<<<<<<<<<<<<<<<<    MAKE CHANGES ABOVE  <<<<<<<<<<<<<<<<<<<<<<<<<<<< %


clc;


I = 9; %8 %10; %% Train Models with I = 10 and Test on I = 8

%while(I <= 20)
    Count = 1;
    while(Count <= length(ListInfo)-10)
        
        String1 = ListInfo(Count).Name;  % Get the name of teh first file that contain Encoded Data Info for VT AS ts
        
        String1 = cell2string(String1);  % File Exchange Function  :: Following Step is necessary
        String1 = String1(3:length(String1)-2); % Gives Otput as ==> {'Your Required String'}
        
        load(strcat(path2,String1));
        
        %%Sep1 = ;
        VTEnCod = VTDividedSUB;
        ASEnCod = ASDividedSUB;
        ts = TimeDividedSUB;
        
        PartitionType = 1;
        [TrData,TrLabels,TstData,TstLabels] = fPartitionDataIndModel(VTEnCod,I,PartitionType); 
        
        %if(PartitionType == 2)
        %TrData = TstData;
        %TrLabels = TstLabels;
        %end
        
        %PartitionType1 = 2;
        %[TrData1,TrLabels1,TstData1,TstLabels1] = fPartDataIndModel_NoWalk_Ver1(VTEnCod,I1,PartitionType1);    
        
        % ========== Training HMM  Model Common Parameters =============== %        
        ComStStart = 7;ComStEnd = 12;ComObsStart = 12;ComObsEnd = 16;ComIter = 20;
        
        % ========== Training HMM  Model for SIT ACT =============== %        
        %StartState1 = ;EndState1 = ;StartObs1 = ;EndObs1 = ;MaxIter1 = ;    
        StartState1 = ComStStart;EndState1 = ComStEnd;StartObs1 = ComObsStart;EndObs1 = ComObsEnd;MaxIter1 = ComIter;    
        Data1 = TrData.Sit;    
        [BestLogLkhd1,BestHmm1,BestStates1,BestObs1,BestIter1,RecLogLkhd1] = fTrainHMM_Ver1(StartState1,EndState1,StartObs1,EndObs1,MaxIter1,Data1);    
        % %     figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I),ACTlist(ActNo,:)))          % %     plot(RecLogLkhd1);       % %     plot(BestIter1,BestLogLkhd1,'*r');
        
        % ========== Training HMM Model for READ ACT =============== %
        StartState2 = ComStStart;EndState2 = ComStEnd;StartObs2 = ComObsStart;EndObs2 = ComObsEnd;MaxIter2 = ComIter;    
        %StartState2 = ;EndState2 = ;StartObs2 = ;EndObs2 = ;MaxIter2 = ;    
        Data2 = TrData.Read;    
        [BestLogLkhd2,BestHmm2,BestStates2,BestObs2,BestIter2,RecLogLkhd2] = fTrainHMM_Ver1(StartState2,EndState2,StartObs2,EndObs2,MaxIter2,Data2);    
        % %     figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I),ACTlist(ActNo,:)))           % %     plot(RecLogLkhd2);        % %     plot(BestIter2,BestLogLkhd2,'*r');
        
        % ========== Training HMM  Model for WALK ACT =============== %
        StartState3 = ComStStart;EndState3 = ComStEnd;StartObs3 = ComObsStart;EndObs3 = ComObsEnd;MaxIter3 = ComIter;
        %StartState3 = ;EndState3 = ;StartObs3 = ;EndObs3 = ;MaxIter3 = ;
        Data3 = TrData.Walk;    
        [BestLogLkhd3,BestHmm3,BestStates3,BestObs3,BestIter3,RecLogLkhd3] = fTrainHMM_Ver1(StartState3,EndState3,StartObs3,EndObs3,MaxIter3,Data3);
        % ========== Training HMM  Model for WALK ACT =============== %
        StartState4 = ComStStart;EndState4 = ComStEnd;StartObs4 = ComObsStart;EndObs4 = ComObsEnd;MaxIter4 = ComIter;
        %StartState3 = ;EndState3 = ;StartObs3 = ;EndObs3 = ;MaxIter3 = ;
        Data4 = TrData.Smk;    
        [BestLogLkhd4,BestHmm4,BestStates4,BestObs4,BestIter4,RecLogLkhd4] = fTrainHMM_Ver1(StartState4,EndState4,StartObs4,EndObs4,MaxIter4,Data4);
        
        %                END OF HMM MODEL TRAINING                  %    
        
        %         APPLY TRAINNED MODEL ON TRAIN-TEST DATA           %
        
        %     Now Test the Sit HMM model on the different ACTS present   %
        
        %if(PartitionType == 2)
        %else
            [TrLog1,TrLog2,TrLog3,TrLog4,TrEstLabel,SpecialLabel] = fTest4HMM_Ver1(TrData,TrLabels,BestHmm1,BestHmm2,BestHmm3,BestHmm4);
            % Get the Confusion Matrix %
            [TrCfMtx,TrOverallAcc] = fGetConfusionMatrix(TrEstLabel);        
            Time2 = toc;
        %end
        % ------- ON TEST DATA SET ---------- %
        [TstLog1,TstLog2,TstLog3,TstLog4,TstEstLabel,SpecialLabel1] = fTest4HMM_Ver1(TstData,TstLabels,BestHmm1,BestHmm2,BestHmm3,BestHmm4);                        
        % Get the Confusion Matrix %
        [TstCfMtx,TstOverallAcc] = fGetConfusionMatrix(TstEstLabel);   
        Time3 = toc;   
        
        SUB_4HMM(I).ResultInfo(Count).Sep = Sep;
        SUB_4HMM(I).ResultInfo(Count).Div = Div;
        SUB_4HMM(I).ResultInfo(Count).TimeTrTst = [Time2 Time3];
        SUB_4HMM(I).ResultInfo(Count).Name{1} = String1;
        SUB_4HMM(I).ResultInfo(Count).TrBestLogLkhd = [BestLogLkhd1 BestLogLkhd2 BestLogLkhd3];
        SUB_4HMM(I).ResultInfo(Count).TrCfMtx = TrCfMtx;
        SUB_4HMM(I).ResultInfo(Count).TrOvAcc = TrOverallAcc;
        SUB_4HMM(I).ResultInfo(Count).TstCfMtx = TstCfMtx;
        SUB_4HMM(I).ResultInfo(Count).TstOvAcc = TstOverallAcc;        
        
        save(strcat(path3,'New_IND_Results_4HMM_XDivs_YSeps_24July2013'))
        
        PlotTr(1,Count) = TrOverallAcc;
        PlotTr(2,Count) = Sep;
        PlotTr(3,Count) = Div;
        
        PlotTst(1,Count) = TstOverallAcc;
        PlotTst(2,Count) = Sep;
        PlotTst(3,Count) = Div;
        
        Count = Count + 1;
    end 
    figure
    plot(PlotTr(1,:))          
    figure
    plot(PlotTst(1,:))
            
    
    %I = I + 1
%end









