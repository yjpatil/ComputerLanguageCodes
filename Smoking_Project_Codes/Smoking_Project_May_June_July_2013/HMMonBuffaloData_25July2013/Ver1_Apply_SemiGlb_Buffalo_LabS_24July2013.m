% This code Test the Semi-Global model created from 5 subjects (of 20 
% Subjects) and Apply them on Lab Sessions of Buffalo Data
% Date : 24 July 2013

clc;clear all;close all;

global sf ts;
sf = 101.73;

path = char('C:\Users\student\Documents\MATLAB\Data update Buffalo 08-Jan-2013\');

%list = char('DATA_PACT_105','DATA_PACT_107','DATA_PACT_108','DATA_PACT_109','DATA_PACT_114','DATA_PACT_117','DATA_PACT_118','DATA_PACT_120','DATA_PACT_122','DATA_PACT_124','DATA_PACT_127','DATA_PACT_128','DATA_PACT_129','DATA_PACT_132','DATA_PACT_134','DATA_PACT_136','DATA_PACT_138','DATA_PACT_140');

list = char('DATA_PACT_105','DATA_PACT_109','DATA_PACT_117','DATA_PACT_129','DATA_PACT_136','DATA_PACT_138');

CodeStruct = struct('CodeTrVT',[],'CodeTrAS',[],'TrTimeInst',[],'CodeValVT',[],'CodeValAS',[],'ValTimeInst',[]); 

Size_List = size(list,1);



I = 2;       %  <<----------- MAKE CHANGES HERE $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%while(I <= Size_List)
   
    load(strcat(path(1,:),list(I,:),'.mat'));   
        
    L = length(Signals);
    ts = Signals(:,1);
    
    [ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,PS,PSraw] = All_Buffalo_Signals_Processed(Signals); 
    
    [VtsVT] = Remove_Unwanted_BC(VtsVT,PtsVT,1.0);   % 1.0sec is the min time allowed for separation between two valleys    
    
    %Plot_ASorVT = 1;   % 1 = VT, 2 = AS, 3 = AS and VT
    %[I] = fPlot_Buffalo_Subject(PSraw,5*PS,ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,puff_score,I,list,Plot_ASorVT);
    
    % =======================   ACHTUNG  =========================== %
    % ------ MAKE SURE THAT YOU HAVE SAME DIVISIONS AND SEPARATIONS ON 
    % ------ BUFFALO DATA --SIMILAR TO THAT OF 20 SUBJECT SEMI-GLB MODEL%     
    
    WinSize = 1; % Window Size = 3 Breaths Cycle <=== Should be common for all ACTIVITIES
    Sep = 6; % MAKE SURE THAT YOU HAVE SAME SEPARATIONS  TO THAT OF 20 SUBJECT SEMI-GLB MODEL
    Div = 3; % MAKE SURE THAT YOU HAVE SAME DIVISIONS  TO THAT OF 20 SUBJECT SEMI-GLB MODEL
    %---------------------------------------------------------------------%
    % *************** WARNING : Change the Breath cycle Segmentation based
    % on Tidal Volume segmentation only and not AS ********************** %
    
    % Extract the encoding for the waveform from all 12 ACTIVITIES % 
             %     Separate them into train and test       %
             
    Code1VT = [];Code2AS = [];TimeInst = [];Code1 = [];Code2 = [];    
    FigVT = 11;FigAS = 12; Lab_S = 2; 
    Time1 = Lab_sessions(Lab_S,1); Time2 = Lab_sessions(Lab_S,2);
    [Code1VT,Code2AS,TimeInst] = fBWbyWEncode2Ver(VTts,ASts,PtsVT,VtsVT,[],WinSize,Sep,Div,Time1,Time2,FigVT,FigAS,puff_score,'FixLen'); % The last entry is the Figure Number.e.g here 12 = figure(12)  
    
    load('BestHmms_3Div6pts');  % <<------ Change Here
%     load('Sub9_BestHmm_Read_3Div8pts');  % <<------ Change Here
%     load('Sub9_BestHmm_Walk_3Div8pts');  % <<------ Change Here
%     load('Sub9_BestHmm_Smk_3Div8pts');  % <<------ Change Here
    
    HMM1 = BestHmm1;
    HMM2 = BestHmm2;
    HMM3 = BestHmm3;
    HMM4 = BestHmm4;
    
    
    
    Itr1 = 1;
    Itr2 = 1;
    
    DataArray = Code1VT;
    TimeArray = TimeInst;
    
    L = length(DataArray);
    
    for j = 1 : 1 : L
        Log1(j) = dhmm_logprob(DataArray{j}, HMM1.prior, HMM1.transmat, HMM1.obsmat);    
        Log2(j) = dhmm_logprob(DataArray{j}, HMM2.prior, HMM2.transmat, HMM2.obsmat);    
        Log3(j) = dhmm_logprob(DataArray{j}, HMM3.prior, HMM3.transmat, HMM3.obsmat);    
        Log4(j) = dhmm_logprob(DataArray{j}, HMM4.prior, HMM4.transmat, HMM4.obsmat);            
        
        Index = find( max([ Log1(j) Log2(j) Log3(j) Log4(j) ]) == [ Log1(j) Log2(j) Log3(j) Log4(j) ]);            
        
        Time1 = TimeArray(j,1);
        Time2 = TimeArray(j,2);
        
        if(Index == 1)            
            EstLabel(Itr1,1) = 1;    % Estimated Labels
            Itr1 = Itr1 + 1;
        elseif(Index == 2)
            EstLabel(Itr1,1) = 2;    % Estimated Labels                
            Itr1 = Itr1 + 1;
        elseif(Index == 3)
            EstLabel(Itr1,1) = 3;    % Estimated Labels
            Itr1 = Itr1 + 1;
        elseif(Index == 4)
            EstLabel(Itr1,1) = 4;    % Estimated Labels
            Itr1 = Itr1 + 1;
            text(Time1+((Time2-Time1)/2),2.1,'Smoke','BackgroundColor',[.7 .9 .7])
        elseif(length(Index) > 1)    % Sometimes the array of [Log1 Log2 Log3 Log4] are all "-Inf", hence the Index = [1 2 3 4]            
            SpecialLabel(Itr2,1) = 5;
            Itr2 = Itr2 + 1;            
            EstLabel(Itr1,1) = 5;    % Estimated Labels
            Itr1 = Itr1 + 1;
        end
    end    
    
    
    %I = I + 1;
%end









