% Training of the HMM for a given activity to select the sub-optimal
% parameters for the HMM [States, Obs, Intial Prob]
% Date : 22 Jul 2013
clc;clear all;close all;

global sf ts;
sf = 101.73;

Actlist = char('SIT','Read','Stand','Slow Walk','Fast Walk','Laptop','Hand Eat','Fork Eat','Walk Out','Smk Sit','Rest','Smk Stand');

path = char('C:\Users\student\Documents\MATLAB\Biology_bldg_20subjects\');

list = char('Sub_003','Sub_004','Sub_005','Sub_006','Sub_007','Sub_008','Sub_009','Sub_010','Sub_011','Sub_012','Sub_013','Sub_014','Sub_015','Sub_016','Sub_017','Sub_019','Sub_020','Sub_021','Sub_022','Sub_023');
Size_List = size(list,1);
% ----------------------------------------------------------------------- %
% ----------  MAKE SURE THE FIELDS HAVE RIGHT NAME AND ORDER
load('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\Waveform_Numbering\ComWholeSubWNos')    
SubWNos = ComSubWNos;   %%<--- Make Sure you     
for i = 1 : 1 : length(SubWNos)
    SubWNos(i).Sit = num2cell(SubWNos(i).Sit);
    SubWNos(i).Read = num2cell(SubWNos(i).Read);
    %SubWNos(i).Walk = num2cell(SubWNos(i).Walk);
    SubWNos(i).Smk = num2cell(SubWNos(i).Smk);
end
VTDividedSUB = SubWNos;
ASDividedSUB = VTDividedSUB;
TimeDividedSUB = VTDividedSUB;
% ----------  fields in DividedSUB == fields in SubWNos
% ----------------------------------------------------------------------- %
SUB(Size_List) = struct('CodeVT',[],'CodeAS',[],'TimeInst',[],'WaveNo',[]); 

EnCodSubWNos(Size_List) = struct('CodeVT',[],'CodeAS',[],'TimeInst',[]); 



I = 1;      %  <<----------- MAKE CHANGES HERE $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%I = 13; <<= Not somewhat Good One  SepPts = 25;States = 5;Obs = 19;


while(I <= Size_List)
   
    load(strcat(path(1,:),list(I,:),'.mat'));
    
    %Sub(I).Name = list(I,:);
    
    %Sub(I).Act_ts = Activities;
    
    L = length(Data);
    
    ts = [1:L]/sf;ts = ts';ts = ts-(Activities(1,2));
    
    [ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,PS,PSraw] = All_Signals_Processed(Data); 
    
    [VtsVT] = Remove_Unwanted_BC(VtsVT,PtsVT,1.0);   % 1.0sec is the min time allowed for separation between two valleys
    
    %[Ijk] = Plot_General_20subjects(PSraw,5*PS,ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,Score,I,list,2,Actlist,Activities);        
    %---------------------------------------------------------------------%     
       % Values Should be common for all ACTIVITIES %
    WinSize = 1; % Window Size = 3 Breaths Cycle <=== Should be common for all ACTIVITIES
    Sep = 8; % Separation of points for a given waveform for Encoding
    Div = 3; % Divisions of the quarter circle for Encoding
    %---------------------------------------------------------------------%
    % *************** WARNING : Change the Breath cycle Segmentation based
    % on Tidal Volume segmentation only and not AS ********************** %
    
    Counter = 1; % <<------------------------------ This is the important variable as 
    % Extract the encoding for the waveform from all 12 ACTIVITIES %    
    for i = 1 : 1 : 12
        Actcnt = i; % Activity # 1 %  Sitting        
        [SUB,Counter] = fWbyWNumVer1(SUB,I,Counter,VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,2*i+1,2*i+2,'FixLen'); % The last entry is the Figure Number.e.g here 12 = figure(12)        
    end
    % ------------------------------------------------------------------- %
    %   This will eventually contain the waveform numbers   %
    
    
    % Comment above lines later when you have .mat files  %
    
    % load('SubWNos')                   
    [TimeDividedSUB,ASDividedSUB,VTDividedSUB] = fDivideSUBusingWnosVER2(TimeDividedSUB,ASDividedSUB,VTDividedSUB,I,SubWNos,SUB,ComSubWNos);
    
%     EnCodSubWNos(I).CodeVT = VTDividedSUB;
%     EnCodSubWNos(I).CodeAS = ASDividedSUB;
%     EnCodSubWNos(I).TimeInst = TimeDividedSUB;
    
    %plot(cell2num(TimeDividedSUB(I).Smk),0.02*ones(length(cell2num(TimeDividedSUB(I).Smk)),1),'*c');

    I = I + 1;
end



clearvars -except TimeDividedSUB ASDividedSUB VTDividedSUB




    
    
    
    
    
    
    
    