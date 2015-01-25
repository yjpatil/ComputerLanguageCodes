% This code is to reduce the false breath cycles that occur due to peak
% detection code. The idea is to remove shallow breats by using window
% function
% Date : 29 May 2013
clc;clear all;close all;

%  Add this path into the paths so as to access all HMM toolkit 
addpath(genpath('C:\Users\student\Documents\MATLAB\HMM\HMMEverything'));

%  Add this path into the paths so as to access all Pre-processing functions for 20 Subjects  
addpath(genpath('C:\Users\student\Documents\MATLAB\Smoking_Project_May_2013\HMM'));

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
    WinSize = 3; % Window Size = 3 Breaths Cycle <=== Should be common for all ACTIVITIES
    Sep = 30; % Separation of points for a given waveform for Encoding
    Div = 5; % Divisions of the quarter circle for Encoding
    %---------------------------------------------------------------------%
    Actcnt = 1; % Activity # 1 %  Sitting
    [Code11] = WinbyWinEncode(ASts,PtsAS,VtsAS,Actcnt,WinSize,Sep,Div,Activities,11); % The last entry is the Figure Number.e.g here 12 = figure(12)
    gcf;title(strcat('Air Flow signal for Act#',num2str(Actcnt),' & Subject#',list(I,[6,7])));xlabel('time (sec)');
    [Code12] = WinbyWinEncode(VTts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,12);
    gcf;title(strcat('Tidal Volume signal for Act#',num2str(Actcnt),' & Subject#',list(I,[6,7])));xlabel('time (sec)');
    
    
    
    
    
    
    
    
    
    
    
    
    