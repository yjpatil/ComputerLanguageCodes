%  This code performs the Waveform en-coding of Air-Flow and Tidal-Volume
%  Signal 
% May 19 2013
clc;clear all;close all;

%  Add this path into the paths so as to access all HMM toolkit 
% addpath(genpath('C:\Users\student\Documents\MATLAB\Smoking_Project_May_2013\HMM'));

%  Add this path into the paths so as to access all Pre-processing functions for 20 Subjects  
addpath(genpath('C:\Users\student\Documents\MATLAB\BioBldg_20_Function_Get_AS_VT'));

global sf ts;
sf = 101.73;


path = char('C:\Users\student\Documents\MATLAB\Biology_bldg_20subjects\');

list = char('Sub_003','Sub_004','Sub_005','Sub_006','Sub_007','Sub_008','Sub_009','Sub_010','Sub_011','Sub_012','Sub_013','Sub_014','Sub_015','Sub_016','Sub_017','Sub_019','Sub_020','Sub_021','Sub_022','Sub_023');

Size_List = size(list,1);

Sub(Size_List) = struct('Features',[],'Labels',[],'ts_feat',[],'TPR',[],'Name',[],'Act_ts',[]);  % TPR = True Positive Rate = length(Score)  Recall = TP/TPR

H=1;

I = 1;

%while(I <= Size_List)
   
    load(strcat(path(1,:),list(I,:),'.mat'));
    
    Sub(I).Name = list(I,:);
    
    Sub(I).Act_ts = Activities;
    
    L = length(Data);
    
    ts = [1:L]/sf;ts = ts';ts = ts-(Activities(1,2));
    
    PSraw = Data(:,2)/max(Data(:,2)); % Normalized Proximity Sensor before passing to merge function
    
    PS = merge_function(PSraw,ts,0.046,0.5,8,1.2); 
    PSraw = PSraw .* 1;       
    
    [AB,RC] = process_AB_RC(3,Data(:,4),Data(:,5));    % 2 & 3 = Invert the Signals 
    
    [ASr,VTr] = get_AS_VT(0,AB,RC,1,4);        % 0 = (AB+RC)/2,  1 = RC,  2 = AB.% + Filtering using Ideal Filter = 1 or WT filter = 2. ALso the threshold value (4) for the component removal        
    
    ASts = [ts ASr];VTts = [ts VTr];
    
    [ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal
    
    PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 
    PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS]; 
    
    [ASnorm,VTnorm] = Normalization_Second_stage(ASts(:,2),VTts(:,2),1,VtsAS(:,2),PtsAS(:,2),VtsVT(:,2),PtsVT(:,2),[-1 +1]);  % Check if the choice for min/max is "MEDIAN == 1" or "MEAN == 2"
    
    ASts = []; VTts = [];
    
    ASts = [ts ASnorm];VTts = [ts VTnorm];
    
    [ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal
    
    PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT];     %% Peaks and Valleys for TIDAL VOLUME(VT) signal %%
    PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS]; %% Peaks and Valleys for AIR FLOW(AF) signal %%             
    
    %[I] = Plot_General(PSraw,5*PS,ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,Score,I,list,2);
    ASorVT = 1;Levels = 5;
    Act = 10;
    Act = Act + 1;
    T1 = Activities(Act,1);T2 = Activities(Act,2);
    Ind_AS = find( T1 <= ASts(:,1) & ASts(:,1) <= T2);
    ASts_temp = ASts(Ind_AS,:);
    [CodeAS] = WholeSigEncode(ASts_temp,15,ASorVT,Levels);
    if(Act == 11)
        Ind_PS = find( T1 <= Score(:,3) & Score(:,3) <= T2);
        Score_temp = Score(Ind_PS,:);
        O = 0.02*ones(size(Score_temp,1));
        H3 = plot(Score_temp(:,3),O,'ob');
        H4 = plot(Score_temp(:,4),O,'or');
    elseif(Act == 13)
        Ind_PS = find( T1 <= Score(:,3) & Score(:,3) <= T2);
        Score_temp = Score(Ind_PS,:);
        O = 0.02*ones(size(Score_temp,1));
        H3 = plot(Score_temp(:,3),O,'ob');
        H4 = plot(Score_temp(:,4),O,'or');
    else
    end             
        
    
    ASorVT = 2;Levels = 5;
    Ind_VT = find( T1 <= VTts(:,1) & VTts(:,1) <= T2);
    VTts_temp = VTts(Ind_VT,:);
    [CodeAS] = WholeSigEncode(VTts_temp,15,ASorVT,Levels);
    if(Act == 11)
        Ind_PS = find( T1 <= Score(:,3) & Score(:,3) <= T2);
        Score_temp = Score(Ind_PS,:);
        O = 0.02*ones(size(Score_temp,1));
        H3 = plot(Score_temp(:,3),O,'ob');
        H4 = plot(Score_temp(:,4),O,'or');
    elseif(Act == 13)
        Ind_PS = find( T1 <= Score(:,3) & Score(:,3) <= T2);
        Score_temp = Score(Ind_PS,:);
        O = 0.02*ones(size(Score,1));
        H3 = plot(Score_temp(:,3),O,'ob');
        H4 = plot(Score_temp(:,4),O,'or');
    else
    end      
    
    
    
    
    
    