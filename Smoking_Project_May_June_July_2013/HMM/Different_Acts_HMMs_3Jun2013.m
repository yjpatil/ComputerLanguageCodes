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

path = char('C:\Users\student\Documents\MATLAB\Biology_bldg_20subjects\');

list = char('Sub_003','Sub_004','Sub_005','Sub_006','Sub_007','Sub_008','Sub_009','Sub_010','Sub_011','Sub_012','Sub_013','Sub_014','Sub_015','Sub_016','Sub_017','Sub_019','Sub_020','Sub_021','Sub_022','Sub_023');

Size_List = size(list,1);

Sub(Size_List) = struct('Features',[],'Labels',[],'ts_feat',[],'TPR',[],'Name',[],'Act_ts',[]);  % TPR = True Positive Rate = length(Score)  Recall = TP/TPR

I = 8;
%I = 13; <<= Not somewhat Good One  SepPts = 25;States = 5;Obs = 19;

%while(I <= Size_List)
   
    load(strcat(path(1,:),list(I,:),'.mat'));
    
    Sub(I).Name = list(I,:);
    
    Sub(I).Act_ts = Activities;
    
    L = length(Data);
    ts = [1:L]/sf;ts = ts';ts = ts-(Activities(1,2));
    
    [ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,PS,PSraw] = All_Signals_Processed(Data);            
    
    %%[I] = Plot_General(PSraw,5*PS,ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,Score,I,list);        
    %---------------------------------------------------------------------%     
       % Values Should be common for all ACTIVITIES %
    WinSize = 1; % Window Size = 3 Breaths Cycle <=== Should be common for all ACTIVITIES
    Sep = 40; % Separation of points for a given waveform for Encoding
    Div = 5; % Divisions of the quarter circle for Encoding
    %---------------------------------------------------------------------%
    % *************** WARNING : Change the Breath cycle Segmentation based
    % on Tidal Volume segmentation only and not AS ********************** %
    
    Actcnt = 1; % Activity # 1 %  Sitting
    [Code11] = WinbyWinEncode(ASts,PtsAS,VtsAS,Actcnt,WinSize,Sep,Div,Activities,11); % The last entry is the Figure Number.e.g here 12 = figure(12)
    [Code12] = WinbyWinEncode(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,12);
    %---------------------------------------------------------------------%     
    Actcnt = 2; % Activity # 2 %   Reading
    [Code21] = WinbyWinEncode(ASts,PtsAS,VtsAS,Actcnt,WinSize,Sep,Div,Activities,21);
    [Code22] = WinbyWinEncode(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,22);
    %---------------------------------------------------------------------%     
    Actcnt = 3; % Activity # 3 %  Standing
    [Code31] = WinbyWinEncode(ASts,PtsAS,VtsAS,Actcnt,WinSize,Sep,Div,Activities,31);
    [Code32] = WinbyWinEncode(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,32);
    %---------------------------------------------------------------------%     
    Actcnt = 4; % Activity # 4 %  Walk Slow
    [Code41] = WinbyWinEncode(ASts,PtsAS,VtsAS,Actcnt,WinSize,Sep,Div,Activities,41);
    [Code42] = WinbyWinEncode(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,42);
    %---------------------------------------------------------------------%     
    Actcnt = 5; % Activity # 5 %  Walk Fast
    [Code51] = WinbyWinEncode(ASts,PtsAS,VtsAS,Actcnt,WinSize,Sep,Div,Activities,51);
    [Code52] = WinbyWinEncode(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,52);
    %---------------------------------------------------------------------%     
    Actcnt = 6; % Activity # 6 %  Laptop
    [Code61] = WinbyWinEncode(ASts,PtsAS,VtsAS,Actcnt,WinSize,Sep,Div,Activities,61);
    [Code62] = WinbyWinEncode(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,62);
    %---------------------------------------------------------------------%     
    Actcnt = 7; % Activity # 7 %  Eat with Hands
    [Code71] = WinbyWinEncode(ASts,PtsAS,VtsAS,Actcnt,WinSize,Sep,Div,Activities,71);
    [Code72] = WinbyWinEncode(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,72);
    %---------------------------------------------------------------------%     
    Actcnt = 8; % Activity # 8 %  Eat with Fork
    [Code81] = WinbyWinEncode(ASts,PtsAS,VtsAS,Actcnt,WinSize,Sep,Div,Activities,81);
    [Code82] = WinbyWinEncode(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,82);
    %---------------------------------------------------------------------%     
    Actcnt = 9; % Activity # 9 % Walk Outside
    [Code91] = WinbyWinEncode(ASts,PtsAS,VtsAS,Actcnt,WinSize,Sep,Div,Activities,91);
    [Code92] = WinbyWinEncode(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,92);
    %---------------------------------------------------------------------%     
    Actcnt = 10; % Activity # 10 % Smoking Sit
    [Code101] = WinbyWinEncode(ASts,PtsAS,VtsAS,Actcnt,WinSize,Sep,Div,Activities,101);
    [Code102] = WinbyWinEncode(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,102);
    %---------------------------------------------------------------------%     
    Actcnt = 11; % Activity # 11 % Rest
    [Code111] = WinbyWinEncode(ASts,PtsAS,VtsAS,Actcnt,WinSize,Sep,Div,Activities,111);
    [Code112] = WinbyWinEncode(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,112);
    %---------------------------------------------------------------------%     
    Actcnt = 12; % Activity # 12 % Smoking Stand
    [Code121] = WinbyWinEncode(ASts,PtsAS,VtsAS,Actcnt,WinSize,Sep,Div,Activities,121);
    [Code122] = WinbyWinEncode(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,122);    
    %---------------------------------------------------------------------% 
    States = 19;Obs = 16;
    [LogLkhdAct2, HMMAct2] = GetHMM(Code22,States,Obs);
    
    fprintf('\n ======================================================= \n');
    fprintf('\n ======= Test Results for Act2 HMM on ACT11 ===== \n');
    for i = 1 : 1 : length(Code112)
        %j = Array(i);
        loglik = dhmm_logprob(Code112{i},HMMAct2.prior, HMMAct2.transmat, HMMAct2.obsmat);
        disp(sprintf('[class ACT 11: %d -th data]model ACT 2:%.3f',i,loglik));
    end
    fprintf('\n ======================================================= \n');
    
    fprintf('\n ======================================================= \n');
    fprintf('\n ======= Test Results for Act2 HMM on ACT2 ===== \n');
    for i = 1 : 1 : length(Code22)
        %j = Array(i);
        loglik = dhmm_logprob(Code22{i},HMMAct2.prior, HMMAct2.transmat, HMMAct2.obsmat);
        disp(sprintf('[class ACT 2: %d -th data]model ACT 2:%.3f',i,loglik));
    end
    fprintf('\n ======================================================= \n');
        
    
      
    %I = I + 1;
%end













