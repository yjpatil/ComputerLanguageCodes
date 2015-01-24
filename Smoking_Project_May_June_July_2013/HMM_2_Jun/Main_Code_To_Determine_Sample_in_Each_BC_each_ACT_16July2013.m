% Training of the HMM for a given activity to select the sub-optimal
% parameters for the HMM [States, Obs, Intial Prob]
% Date : 23 Jun 2013
clc;clear all;close all;

%  Add this path for HMM folder
addpath(genpath('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM'));

%  Add this path into the paths so as to access all HMM toolkit
addpath(genpath('C:\Users\student\Documents\MATLAB\HMM\HMMEverything'));

%  Add this path into the paths so as to access all Pre-processing functions for 20 Subjects  
addpath(genpath('C:\Users\student\Documents\MATLAB\BioBldg_20_Function_Get_AS_VT'));

clc

Sit = [0 0]
Read = [0 0]
Walk = [0 0]
Smk = [0 0]

global sf ts;
sf = 101.73;

%%Actlist = char('SIT','Read','Stand','Slow Walk','Fast Walk','Laptop','Hand Eat','Fork Eat','Walk Out','Smk Sit','Rest','Smk Stand');

path = char('C:\Users\student\Documents\MATLAB\Biology_bldg_20subjects\');

list = char('Sub_003','Sub_004','Sub_005','Sub_006','Sub_007','Sub_008','Sub_009','Sub_010','Sub_011','Sub_012','Sub_013','Sub_014','Sub_015','Sub_016','Sub_017','Sub_019','Sub_020','Sub_021','Sub_022','Sub_023');
Size_List = size(list,1);
% ----------------------------------------------------------------------- %
% ----------  MAKE SURE THE FIELDS HAVE RIGHT NAME AND ORDER
load('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\Waveform_Numbering\ComSubWNos')    
SubWNos = ComSubWNos;   %% <--- Make Sure you Name it correctly   

% for i = 1 : 1 : length(SubWNos)
%     SubWNos(i).Sit = num2cell(SubWNos(i).Sit);
%     SubWNos(i).Read = num2cell(SubWNos(i).Read);
%     SubWNos(i).Walk = num2cell(SubWNos(i).Walk);
%     SubWNos(i).Smk = num2cell(SubWNos(i).Smk);
% end

% ----------  fields in DividedSUB == fields in SubWNos
% ----------------------------------------------------------------------- %
DetermineSamplesSUB(Size_List) = struct('SamplesVT',[],'SamplesAS',[],'TimeInst',[],'WaveNo',[]); 

VTDividedSUB(Size_List) = struct('Sit',[],'Read',[],'Walk',[],'Smk',[]);
ASDividedSUB = VTDividedSUB;

I = 1;      %  <<----------- MAKE CHANGES HERE $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

%I = 13; <<= Not somewhat Good One  SepPts = 25;States = 5;Obs = 19;


while(I <= Size_List)
    
    I
   
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
        if(T2 - T1 <= 1.0)%
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
    
    %[Ijk] = Plot_General_20subjects(PSraw,5*PS,ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,Score,I,list,2,Actlist,Activities);        
    
    %---------------------------------------------------------------------%     
       % Values Should be common for all ACTIVITIES %
    WinSize = 1; % Window Size = 3 Breaths Cycle <=== Should be common for all ACTIVITIES    
    %---------------------------------------------------------------------%
    
    % *************** WARNING : Change the Breath cycle Segmentation based
    % on Tidal Volume segmentation only and not AS ********************** %
    
    Counter = 1; % <<------------------------------ This is the important variable as 
    % Extract the encoding for the waveform from all 12 ACTIVITIES %    
    for i = 1 : 1 : 12
        Actcnt = i; % Activity # 1 %  Sitting        
        [DetermineSamplesSUB,Counter] = fDetermine_Samples_Ver1(DetermineSamplesSUB,I,Counter,VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Activities,2*i+1,2*i+2); % The last entry is the Figure Number.e.g here 12 = figure(12)        
    end
    % ------------------------------------------------------------------- %
    %   This will eventually contain the waveform numbers   %
    
    
    % Comment above lines later when you have .mat files  %
    
    % load('SubWNos')                   
    [Sit,Read,Walk,Smk,ASDividedSUB,VTDividedSUB] = fdivideSamplesusingWnosVER1(Sit,Read,Walk,Smk,ASDividedSUB,VTDividedSUB,I,SubWNos,DetermineSamplesSUB,ComSubWNos); %
    
%     EnCodSubWNos(I).CodeVT = VTDividedSUB;
%     EnCodSubWNos(I).CodeAS = ASDividedSUB;
%     EnCodSubWNos(I).TimeInst = TimeDividedSUB;
    
    %plot(cell2num(TimeDividedSUB(I).Smk),0.02*ones(length(cell2num(TimeDividedSUB(I).Smk)),1),'*c');

    I = I + 1;
end

Sit1 = mean(Sit)
Read1 = mean(Read)
Walk1 = mean(Walk)
Smk1 = mean(Smk)

% % clearvars -except ASDividedSUB VTDividedSUB
% % 



    
    
    
    
    
    
    
    