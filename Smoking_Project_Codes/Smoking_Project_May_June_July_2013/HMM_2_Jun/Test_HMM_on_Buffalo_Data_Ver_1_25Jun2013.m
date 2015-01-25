% This code builds HMM's for each activity and finds the log-likelihood for
% a given window against a given model. 
% Date : 12 Jun 2013
clc;clear all;close all;

%  Add this path into the paths so as to access all functions 
addpath(genpath('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM'));

%  Add this path into the paths so as to access all HMM toolkit 
addpath(genpath('C:\Users\student\Documents\MATLAB\HMM\HMMEverything'));

%  Add this path into the paths so as to access all Pre-processing functions for 20 Subjects  
addpath(genpath('C:\Users\student\Documents\MATLAB\BioBldg_20_Function_Get_AS_VT'));

global sf ts;
sf = 101.73;


path = char('C:\Users\student\Documents\MATLAB\Data update Buffalo 08-Jan-2013\');

%list = char('DATA_PACT_105','DATA_PACT_107','DATA_PACT_108','DATA_PACT_109','DATA_PACT_114','DATA_PACT_117','DATA_PACT_118','DATA_PACT_120','DATA_PACT_122','DATA_PACT_124','DATA_PACT_127','DATA_PACT_128','DATA_PACT_129','DATA_PACT_132','DATA_PACT_134','DATA_PACT_136','DATA_PACT_138','DATA_PACT_140');

list = char('DATA_PACT_105','DATA_PACT_109','DATA_PACT_117','DATA_PACT_129','DATA_PACT_136','DATA_PACT_138');

CodeStruct = struct('CodeTrVT',[],'CodeTrAS',[],'TrTimeInst',[],'CodeValVT',[],'CodeValAS',[],'ValTimeInst',[]); 

Size_List = size(list,1);



I = 5;       %  <<----------- MAKE CHANGES HERE $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%I = 13; <<= Not somewhat Good One  SepPts = 25;States = 5;Obs = 19;

%while(I <= Size_List)
   
    load(strcat(path(1,:),list(I,:),'.mat'));   
        
    L = length(Signals);
    ts = Signals(:,1);
    
    [ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,PS,PSraw] = All_Buffalo_Signals_Processed(Signals); 
    
    L11 = (length(VtsVT)) - 1
    i = 1;
    while(i <= L11)
        T1 = VtsVT(i,1); % Get the time duration between two consecutive valleys
        T2 = VtsVT(i+1,1); % Delete one of the valleys
        if(T2 - T1 <= 1.0)%if(T2 - T1 <= 2.3)
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
    
    
%     Plot_Case = 1;   % 1 = 20 Subjects, 2 = Buffalo Data
%     [I] = Plot_General(PSraw,5*PS,ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,puff_score,I,list,Plot_Case,[]);        
    %---------------------------------------------------------------------%     
       % Values Should be common for all ACTIVITIES %
    WinSize = 1; % Window Size = 3 Breaths Cycle <=== Should be common for all ACTIVITIES
    Sep = 40; % Separation of points for a given waveform for Encoding
    Div = 5; % Divisions of the quarter circle for Encoding
    %---------------------------------------------------------------------%
    % *************** WARNING : Change the Breath cycle Segmentation based
    % on Tidal Volume segmentation only and not AS ********************** %
    
    % Extract the encoding for the waveform from all 12 ACTIVITIES % 
             %     Separate them into train and test       %
             
    Code1VT = [];Code2AS = [];TimeInst = [];Code1 = [];Code2 = [];    
    FigVT = 11;FigAS = 12; Lab_S = 2; 
    Time1 = Lab_sessions(Lab_S,1); Time2 = Lab_sessions(Lab_S,2);
    [Code1VT,Code2AS,TimeInst] = fBWinbyWinEncode1Ver(VTts,ASts,PtsVT,VtsVT,[],WinSize,Sep,Div,Time1,Time2,FigVT,FigAS,puff_score); % The last entry is the Figure Number.e.g here 12 = figure(12)               
    
    % ---- $$$$$$$$$$$$$$$$$ Change Here $$$$$$$$$$$$$$$$$$$$$$$$$$ ----- %
    load('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_2013\BestHMM\Subject_015\Activities_06\BestHMM_Act6');  % <<------ Change Here
    
    HMMAct1 = BestHMM;    
       
    % Test the Model on Training data of All Acts to get loglikelihood values %       
    CodeTest = [];
    TimeInstTest = [];
    CodeTest = Code1VT;          % $$$ <<----------- Make Changes here also to implement the MODEL on TRAIN/VALIDATION Data Set
    TimeInstTest = TimeInst;    % $$$ <<----------- Make Changes here also to implement the MODEL on TRAIN/VALIDATION Data Set          
    
    for i = 1 : 1 : length(CodeTest)
        lglk(i) = dhmm_logprob(CodeTest{i},HMMAct1.prior, HMMAct1.transmat, HMMAct1.obsmat);
        figure(FigVT);gcf;hold on;title(strcat('Tidal Volume for Lab Sesion #',num2str(Lab_S),list(I,[6,7,8,9,11,12,13])));
        T1 = TimeInstTest(i,1);
        T2 = TimeInstTest(i,2);
        if(lglk(i) > -15)
            text(T1+((T2-T1)/2),2.1,num2str(lglk(i)))
            %plot([T1 T1],[-2 2],'-k');plot([T1 T2],[2 2],'-k');plot([T2 T2],[2 -2],'-k');plot([T2 T1],[-2 -2],'-k');
        else
            text(T1+((T2-T1)/2),2.1,num2str(lglk(i)),'BackgroundColor',[.7 .9 .7])
            %plot([T1 T1],[-2 2],'-k');plot([T1 T2],[2 2],'-k');plot([T2 T2],[2 -2],'-k');plot([T2 T1],[-2 -2],'-k');
        end
        %disp(sprintf('[class ACT 10: %d -th data]model ACT 1:%.3f',i,loglikOA(i) ));
    end
    IndexPS = find(Time1 <= puff_score(:,1) & puff_score(:,1) <= Time2);
    Score = puff_score(IndexPS,:);
    O = 0.02*ones(size(Score,1));
    plot(Score(:,1),O,'ob');plot(Score(:,2),O,'or');
  
    
%     Ldgnd1 = [];Ldgnd2 = [];
%     figure;hold on;title(strcat('PDE__LogLkhd Values','__using__',Actlist(ActTrain,:),'__Model'))
%     for i = 1 : 1 : length(LoglikStruct)
%         Ind = find(LoglikStruct(i).lglk == -Inf);
%         LoglikStruct(i).lglk(Ind) = [];
%         if(isempty(LoglikStruct(i).lglk))
%         else
%             p = gkde0(LoglikStruct(i).lglk);
%         end
%         Ldgnd1(i) = plot(p.x,p.f,'linewidth',2,'Color',[rand rand rand]);
%     end
%     
%     legend([Ldgnd1],{Actlist})
        
    
%     Ind1 = find(loglikSA == -Inf);
%     loglikSA(Ind1) = [];
%     
%     Ind2 = find(loglikOA == -Inf);
%     loglikOA(Ind2) = [];
%     
%     figure;hold on;title(strcat('Log Likelihood Values Vs Activity','__',strTrain,'__and','__',strTest));xlabel('Activity # -->');ylabel('Log Likelihood -->')
%     plot(ActTrain*ones(length(loglikSA),1),loglikSA,'+','Color',[1,0,0]);
%     plot(ActTest*ones(length(loglikOA),1),loglikOA,'o','Color',[0,0,0]);    
%     xlim([0 12])
    
    list(I,:)
%     ylim[0 ]
    
      
    %I = I + 1;
%end













