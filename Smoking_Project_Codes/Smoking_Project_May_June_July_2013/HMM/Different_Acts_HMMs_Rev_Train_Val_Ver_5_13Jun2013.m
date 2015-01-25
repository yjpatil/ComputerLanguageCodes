% This code builds HMM's for each activity and finds the log-likelihood for
% a given window against a given model. 
% Date : 12 Jun 2013
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

CodeStruct = struct('CodeTrVT',[],'CodeTrAS',[],'TrTimeInst',[],'CodeValVT',[],'CodeValAS',[],'ValTimeInst',[]); 

Size_List = size(list,1);



I = 18;       %  <<----------- MAKE CHANGES HERE $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%I = 13; <<= Not somewhat Good One  SepPts = 25;States = 5;Obs = 19;

%while(I <= Size_List)
   
    load(strcat(path(1,:),list(I,:),'.mat'));   
        
    L = length(Data);
    ts = [1:L]/sf;ts = ts';ts = ts-(Activities(1,2));
    
    [ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,PS,PSraw] = All_Signals_Processed(Data); 
    
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
    
    %[I] = Plot_General(PSraw,5*PS,ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,Score,I,list,1);        
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
             
    for i = 1 : 1 : 12
        Actcnt = i; % Activity # 1 %  Sitting
        Code1VT = [];Code2AS = [];TimeInst = [];Code1 = [];Code2 = [];
        
        [Code1VT,Code2AS,TimeInst] = WinbyWinEncode3Ver(VTts,ASts,PtsVT,VtsVT,Actcnt,WinSize,Sep,Div,Activities,2*i+1,2*i+2); % The last entry is the Figure Number.e.g here 12 = figure(12)
        
        % ################# COMMENT BELOW IF YO WOULD LIKE TO TEST ON ALL
        % DATA ###################### %
%         Code1 = Code1VT;
%         Len = length(Code1); 
%         HLen = round(length(Code1)*(3/4));   %$$$$$$ <<<-------------------- MAKE changes here to modify the length of the TEST DATA set
%         CodeTrVT = Code1(1:HLen);   
%         CodeValVT = Code1(HLen+1:Len);        
%         
%         Code2 = Code2AS;
%         CodeTrAS = Code2(1:HLen);   
%         CodeValAS = Code2(HLen+1:Len);
%         
%         TrTimeInst = TimeInst(1:HLen,:);  
%         ValTimeInst = TimeInst(HLen+1:Len,:);
%         
%         CodeStruct(i).CodeTrVT = CodeTrVT;
%         CodeStruct(i).CodeValVT = CodeValVT;
%         
%         CodeStruct(i).CodeTrAS = CodeTrAS;
%         CodeStruct(i).CodeValAS = CodeValAS;        
%         
%         CodeStruct(i).TrTimeInst = TrTimeInst;
%         CodeStruct(i).ValTimeInst = ValTimeInst;
        % ################# COMMENT ABOVE IF YO WOULD LIKE TO TEST ON ALL
        % DATA ###################### %
        
        CodeStruct(i).CodeValVT = Code1VT;
        CodeStruct(i).CodeValAS = Code2AS;
        CodeStruct(i).ValTimeInst = TimeInst;
        
    end
    
    % ---- $$$$$$$$$$$$$$$$$ Change Here $$$$$$$$$$$$$$$$$$$$$$$$$$ ----- %
    load('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_2013\BestHMM\Subject_010\Activities_01\BestHMM_Act1');  % <<------ Change Here
    
    HMMAct1 = BestHMM;    
    % ----------------$$$$$$ Change Here $$$$$$$$------------------------ %        
    ActTrain = 1;  % % <<------ Change Here
    ActTest = [1:9]; % <<----- Which Acts you want to test on            
    % ------------------------------------------------------------------- %   
    
%     Code = CodeStruct(ActTrain).CodeVT;
%     TimeInst = CodeStruct(ActTrain).TimeInst;
%     
%     Len = length(Code);
%     HLen = round(length(Code)*(1/2));   % <<------ Include:: Size of the Training Data Set is Half  
%     CodeTrain = Code(1:HLen);    
%     CodeTest = Code(HLen+1:Len);
%     CodeTestAS = CodeStruct(ActTrain).CodeAS(HLen+1:Len);
%     
%     TimeInstTrain = TimeInst(1:HLen,:);  % <<--------- ActTrain :: it has two columns
%     TimeInstTest = TimeInst(HLen+1:Len,:); % <<--------- ActTrain :: it has two columns
%     
%     [LogLkhdAct1, HMMAct1] = GetHMM(CodeTrain,States,Obs);
    
    % ------------------------------------------------------------------- %
    % Plot the Tidal Volume Signal %
    figure(111);hold on;title(strcat('Tidal Volume Signal__using__',Actlist(ActTrain,:),'__Model'));xlabel('time (sec)');
    plot(VTts(:,1),VTts(:,2));
    O = 0.01*ones(size(Score,1));    
    plot(Score(:,3),O,'ob');
    plot(Score(:,6),O,'or');
    
    it1 = 2;
    while(it1 <= length(Activities))
        temp1 = [rand rand rand];        
        plot([Activities(it1,1) Activities(it1,1)],[-4 6],'Color',temp1,'LineWidth',2); 
        plot([Activities(it1,2) Activities(it1,2)],[-4 6],'Color',temp1,'LineWidth',2); 
        midpt = (Activities(it1,2)-Activities(it1,1))/4;
        midpt = Activities(it1,1) + midpt;
        text(midpt,4,Actlist(it1-1,:));
        it1 = it1 + 1;
    end
    % ------------------------------------------------------------------- %
    
%     for i = 1 : 1 : length(CodeTrain)
%         %j = Array(i);
%         loglikSA = dhmm_logprob(CodeTrain{i},HMMAct1.prior, HMMAct1.transmat, HMMAct1.obsmat);
%         %figure(333);gcf;hold on;title(strcat('Tidal Volume for Activity','__',strTrain));
%         figure(111);gcf;hold on;
%         T1 = TimeInstTrain(i,1);
%         T2 = TimeInstTrain(i,2);
%         if(loglikSA > - 15)
%             text(T1+((T2-T1)/2),2.1,num2str(loglikSA))
%             plot([T1 T1],[-2 2],'-k');plot([T1 T2],[2 2],'-k');plot([T2 T2],[2 -2],'-k');plot([T2 T1],[-2 -2],'-k');
%         else
%             text(T1+((T2-T1)/2),2.1,num2str(loglikSA),'BackgroundColor',[.7 .9 .7])
%             plot([T1 T1],[-2 2],'-k');plot([T1 T2],[2 2],'-k');plot([T2 T2],[2 -2],'-k');plot([T2 T1],[-2 -2],'-k');
%         end          
%         %disp(sprintf('[class ACT 1: %d -th data]model ACT 1:%.3f',i,loglikSA(i) ));
%     end
%     
%     % -------- Change the  Activity Parameters That you used for Training%
%     CodeStruct(ActTrain).CodeVT = CodeTest;
%     CodeStruct(ActTrain).CodeAS = CodeTestAS;
%     CodeStruct(ActTrain).TimeInst = TimeInstTest;
    % -------------------------------------
    
    % Test the Model on Training data of All Acts to get loglikelihood values %
    
    for j = 1 : 1 : 12
        CodeTest = [];
        TimeInstTest = [];
        CodeTest = CodeStruct(j).CodeValVT;          % $$$ <<----------- Make Changes here also to implement the MODEL on TRAIN/VALIDATION Data Set
        TimeInstTest = CodeStruct(j).ValTimeInst;    % $$$ <<----------- Make Changes here also to implement the MODEL on TRAIN/VALIDATION Data Set  
        
        for i = 1 : 1 : length(CodeTest)
            %j = Array(i);
            LoglikStruct(j).lglk(i) = dhmm_logprob(CodeTest{i},HMMAct1.prior, HMMAct1.transmat, HMMAct1.obsmat);
            figure(111);gcf;hold on;%%title(strcat('Tidal Volume for Activity','__ ',strTest));
            T1 = TimeInstTest(i,1);
            T2 = TimeInstTest(i,2);
            if(LoglikStruct(j).lglk(i) > -15)
                text(T1+((T2-T1)/2),2.1,num2str(LoglikStruct(j).lglk(i)))
                plot([T1 T1],[-2 2],'-k');plot([T1 T2],[2 2],'-k');plot([T2 T2],[2 -2],'-k');plot([T2 T1],[-2 -2],'-k');
            else
                text(T1+((T2-T1)/2),2.1,num2str(LoglikStruct(j).lglk(i)),'BackgroundColor',[.7 .9 .7])
                plot([T1 T1],[-2 2],'-k');plot([T1 T2],[2 2],'-k');plot([T2 T2],[2 -2],'-k');plot([T2 T1],[-2 -2],'-k');
            end                
            %disp(sprintf('[class ACT 10: %d -th data]model ACT 1:%.3f',i,loglikOA(i) ));
        end
    end   
    
    Ldgnd1 = [];Ldgnd2 = [];
    figure;hold on;title(strcat('PDE__LogLkhd Values','__using__',Actlist(ActTrain,:),'__Model'))
    for i = 1 : 1 : length(LoglikStruct)
        Ind = find(LoglikStruct(i).lglk == -Inf);
        LoglikStruct(i).lglk(Ind) = [];
        if(isempty(LoglikStruct(i).lglk))
        else
            p = gkde0(LoglikStruct(i).lglk);
        end
        Ldgnd1(i) = plot(p.x,p.f,'linewidth',2,'Color',[rand rand rand]);
    end
    
    legend([Ldgnd1],{Actlist})
        
    
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













