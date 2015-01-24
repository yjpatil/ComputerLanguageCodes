% This code builds HMM's for each activity and finds the log-likelihood for
% a given window against a given model. 
% Date : 27 May 2013
clc;clear all;close all;

%  Add this path into the paths so as to access all HMM toolkit 
addpath(genpath('C:\Users\student\Documents\MATLAB\HMM\HMMEverything'));

%  Add this path into the paths so as to access all Pre-processing functions for 20 Subjects  
addpath(genpath('C:\Users\student\Documents\MATLAB\BioBldg_20_Function_Get_AS_VT'));

global sf ts;
sf = 101.73;

Actlist = char('SIT','Read','Stand','Slow Walk','Fast Walk','Laptop','Hand Eat','Fork Eat','Walk Out','Smk Sit','Rest','Smk Stand');

path = char('C:\Users\student\Documents\MATLAB\Biology_bldg_20subjects\');

list = char('Sub_003','Sub_004','Sub_005','Sub_006','Sub_007','Sub_008','Sub_009','Sub_010','Sub_011','Sub_012','Sub_013','Sub_014','Sub_015','Sub_016','Sub_017','Sub_019','Sub_020','Sub_021','Sub_022','Sub_023');

Size_List = size(list,1);

%Sub(Size_List) = struct('Features',[],'Labels',[],'ts_feat',[],'TPR',[],'Name',[],'Act_ts',[]);  % TPR = True Positive Rate = length(Score)  Recall = TP/TPR

I = 18;
%I = 13; <<= Not somewhat Good One  SepPts = 25;States = 5;Obs = 19;

%while(I <= Size_List)
   
    load(strcat(path(1,:),list(I,:),'.mat'));
    
    %Sub(I).Name = list(I,:);
    
    %Sub(I).Act_ts = Activities;
    
    L = length(Data);
    ts = [1:L]/sf;ts = ts';ts = ts-(Activities(1,2));
    
    [ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,PS,PSraw] = All_Signals_Processed(Data); 
    
    L11 = (length(VtsVT)) - 1
    i = 1;
    while(i <= L11)
        T1 = VtsVT(i,1); % Get the time duration between two consecutive valleys
        T2 = VtsVT(i+1,1); % Delete one of the valleys
        if(T2 - T1 <= 1.0) % if(T2 - T1 <= 2.3)
            if(VtsVT(i,1) < VtsVT(i+1,1)) % Delete the valley which has the lowest value
                VtsVT(i+1,:) = [];
                L11 = L11 - 1; 
            else
                VtsVT(i,:) = [];
                L11 = L11 - 1;
            end
        else
        end
        i = i + 1;
    end
            
    L11    
    
    L11 = (length(VtsVT)) - 1
    i = 1;
    while(i <= L11)
        T1 = VtsVT(i,1); % Get the time duration between two consecutive valleys
        T2 = VtsVT(i+1,1); % Check if there is a peak present in-between them
        indtemp = find(T1 <= PtsVT(:,1) & PtsVT(:,1) <= T2);
        if(isempty(indtemp))
            if(VtsVT(i,1) < VtsVT(i+1,1)) % Delete the valley which has the lowest value
                VtsVT(i+1,:) = [];
                L11 = L11 - 1; 
            else
                VtsVT(i,:) = [];
                L11 = L11 - 1;
            end
        else
        end
        i = i + 1;
    end
    
    %[I] = Plot_General(PSraw,5*PS,ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,Score,I,list,1);        
    %---------------------------------------------------------------------%     
       % Values Should be common for all ACTIVITIES %
    WinSize = 1; % Window Size = 3 Breaths Cycle <=== Should be common for all ACTIVITIES
    Sep = 40; % Separation of points for a given waveform for Encoding
    Div = 5; % Divisions of the quarter circle for Encoding
    %---------------------------------------------------------------------%
    % *************** WARNING : Change the Breath cycle Segmentation based
    % on Tidal Volume segmentation only and not AS ********************** %
    
    Actcnt = 1; % Activity # 1 %  Sitting
    [Code11,Code12,TimeInst1] = WinbyWinEncode3Ver(VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,11,12); % The last entry is the Figure Number.e.g here 12 = figure(12)
    %%%%%[Code12] = WinbyWinEncode2Ver(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,12);
    %---------------------------------------------------------------------%     
    Actcnt = 2; % Activity # 2 %   Reading
    [Code21,Code22,TimeInst2] = WinbyWinEncode3Ver(VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,21,22);
    %%%%%[Code22] = WinbyWinEncode2Ver(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,22);
    %---------------------------------------------------------------------%     
    Actcnt = 3; % Activity # 3 %  Standing
    [Code31,Code32,TimeInst3] = WinbyWinEncode3Ver(VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,31,32);
    %%%%%[Code32] = WinbyWinEncode2Ver(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,32);
    %---------------------------------------------------------------------%     
    Actcnt = 4; % Activity # 4 %  Walk Slow
    [Code41,Code42,TimeInst4] = WinbyWinEncode3Ver(VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,41,42);
    %%%%%[Code42] = WinbyWinEncode2Ver(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,42);
    %---------------------------------------------------------------------%     
    Actcnt = 5; % Activity # 5 %  Walk Fast
    [Code51,Code52,TimeInst5] = WinbyWinEncode3Ver(VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,51,52);
    %%%%%[Code52] = WinbyWinEncode2Ver(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,52);
    %---------------------------------------------------------------------%     
    Actcnt = 6; % Activity # 6 %  Laptop
    [Code61,Code62,TimeInst6] = WinbyWinEncode3Ver(VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,61,62);
    %%%%%[Code62] = WinbyWinEncode2Ver(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,62);
    %---------------------------------------------------------------------%     
    Actcnt = 7; % Activity # 7 %  Eat with Hands
    [Code71,Code72,TimeInst7] = WinbyWinEncode3Ver(VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,71,72);
    %%%%%[Code72] = WinbyWinEncode2Ver(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,72);
    %---------------------------------------------------------------------%     
    Actcnt = 8; % Activity # 8 %  Eat with Fork
    [Code81,Code82,TimeInst8] = WinbyWinEncode3Ver(VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,81,82);
    %%%%%[Code82] = WinbyWinEncode2Ver(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,82);
    %---------------------------------------------------------------------%     
    Actcnt = 9; % Activity # 9 % Walk Outside
    [Code91,Code92,TimeInst9] = WinbyWinEncode3Ver(VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,91,92);
    %%%%%[Code92] = WinbyWinEncode2Ver(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,92);
    %---------------------------------------------------------------------%     
    Actcnt = 10; % Activity # 10 % Smoking Sit
    [Code101,Code102,TimeInst10] = WinbyWinEncode3Ver(VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,101,102);
    %%%%%[Code102] = WinbyWinEncode2Ver(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,102);
    %---------------------------------------------------------------------%     
    Actcnt = 11; % Activity # 11 % Rest
    [Code111,Code112,TimeInst11] = WinbyWinEncode3Ver(VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,111,112);
    %%%%%[Code112] = WinbyWinEncode2Ver(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,112);
    %---------------------------------------------------------------------%     
    Actcnt = 12; % Activity # 12 % Smoking Stand
    [Code121,Code122,TimeInst12] = WinbyWinEncode3Ver(VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,121,122);
    %%%%%[Code122] = WinbyWinEncode2Ver(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,122);    
    
    % -------------------- Make All Changes Here -------------------- % 
%     States = 9;Obs = 16;
    
%     ActTrain = 5;ActTest = 5;
%     strTrain = Actlist(ActTrain,:);strTest = Actlist(ActTest,:);
%     
%     CodeTrain = Code51;CodeTest = Code51;
%     TimeInstTrain = TimeInst5;TimeInstTest = TimeInst5;
    % ---------------------------------------------------------------- %
    
    % -------------------- Make All Changes Here -------------------- %   
    States = 20;Obs = 21;    
    ActTrain = 5;ActTest = 5;
    strTrain = Actlist(ActTrain,:);
    strTest = Actlist(ActTest,:);    
    %CodeTrain = Code51;CodeTest = Code11;
    TimeInstTrain = TimeInst5;
    TimeInstTest = TimeInst5;    
    
    Code = Code51;
    Len = length(Code);
    HLen = round(length(Code)*(1/2));   % <<------ Include:: Size of the Training Data Set is Half  
    CodeTrain = Code(1:HLen);    
    CodeTest = Code(HLen+1:Len);    
    TimeInstTrain = TimeInstTrain(1:HLen,:);
    TimeInstTest = TimeInstTest(HLen+1:Len,:);
    % ---------------------------------------------------------------- %  
    
    
    [LogLkhdAct1, HMMAct1] = GetHMM(CodeTrain,States,Obs);
    
    fprintf('\n ======================================================= \n');
    fprintf('\n ========= Test Results for Act %s HMM on ACT %s ========= \n',ActTrain,ActTest);
    
    [J] = LogLkTestPlot(VTts,ASts,TimeInstTest,ActTest,Activities,111,222,Score); % Make Sure to plot only
    
    for i = 1 : 1 : length(CodeTest)
        %j = Array(i);
        loglikOA(i) = dhmm_logprob(CodeTest{i},HMMAct1.prior, HMMAct1.transmat, HMMAct1.obsmat);
        figure(111);gcf;hold on;title(strcat('Tidal Volume for Activity','__ ',strTest));
        T1 = TimeInstTest(i,1);
        T2 = TimeInstTest(i,2);
        text(T1+((T2-T1)/2),2.1,num2str(loglikOA(i)))
        disp(sprintf('[class ACT 10: %d -th data]model ACT 1:%.3f',i,loglikOA(i) ));
    end
    fprintf('\n ======================================================= \n');
    
    fprintf('\n ======================================================= \n');
    fprintf('\n ========= Test Results for Act %s HMM on ACT %s ========= \n',ActTest,ActTest);
    
    [K] = LogLkTestPlot(VTts,ASts,TimeInstTrain,ActTrain,Activities,333,444,Score); % Make Sure to plot only
    
    for i = 1 : 1 : length(CodeTrain)
        %j = Array(i);
        loglikSA(i) = dhmm_logprob(CodeTrain{i},HMMAct1.prior, HMMAct1.transmat, HMMAct1.obsmat);
        figure(333);gcf;hold on;title(strcat('Tidal Volume for Activity','__',strTrain));
        T1 = TimeInstTrain(i,1);
        T2 = TimeInstTrain(i,2);
        text(T1+((T2-T1)/2),2.1,num2str(loglikSA(i)))
        disp(sprintf('[class ACT 1: %d -th data]model ACT 1:%.3f',i,loglikSA(i) ));
    end
    fprintf('\n ======================================================= \n');
    
    Ind1 = find(loglikSA == -Inf);
    loglikSA(Ind1) = [];
    
    Ind2 = find(loglikOA == -Inf);
    loglikOA(Ind2) = [];
    
    figure;hold on;title(strcat('Log Likelihood Values Vs Activity','__',strTrain,'__and','__',strTest));xlabel('Activity # -->');ylabel('Log Likelihood -->')
    
    H1 = plot(ActTrain*ones(length(loglikSA),1),loglikSA,'+','Color',[1,0,0]);
    H2 = plot(ActTest*ones(length(loglikOA),1),loglikOA,'o','Color',[0,0,0]); 
    legend([H1,H2],{'Train Results' 'Test Results'})                     
    
    xlim([0 12])
    
    D = [mean(loglikOA) std(loglikOA) median(loglikOA)];
    
    figure
    gkdeb(loglikOA)
    
    list(I,:)
%     ylim[0 ]
    
      
    %I = I + 1;
%end













