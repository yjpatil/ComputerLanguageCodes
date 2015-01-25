%  This code performs the Waveform en-coding of Air-Flow and Tidal-Volume
%  Signal 
% May 19 2013
clc;clear all;close all;

%  Add this path into the paths so as to access all HMM toolkit 
addpath(genpath('C:\Users\student\Documents\MATLAB\HMM\HMMEverything'));

%  Add this path into the paths so as to access all Pre-processing functions for 20 Subjects  
addpath(genpath('C:\Users\student\Documents\MATLAB\Bio_Bldg_20Sub_Feat_Extarct_6Nov2012'));

global sf ts;
sf = 101.73;


path = char('C:\Users\student\Documents\MATLAB\Biology_bldg_20subjects\');

list = char('Sub_003','Sub_004','Sub_005','Sub_006','Sub_007','Sub_008','Sub_009','Sub_010','Sub_011','Sub_012','Sub_013','Sub_014','Sub_015','Sub_016','Sub_017','Sub_019','Sub_020','Sub_021','Sub_022','Sub_023');

Size_List = size(list,1);

Sub(Size_List) = struct('Features',[],'Labels',[],'ts_feat',[],'TPR',[],'Name',[],'Act_ts',[]);  % TPR = True Positive Rate = length(Score)  Recall = TP/TPR

H=1;

I = 10;
%I = 13; <<= Not somewhat Good One  SepPts = 25;States = 5;Obs = 19;

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
    
    [I] = Plot_General(PSraw,5*PS,ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,Score,I,list);
    
    inttsPS = [];   
    [inttsPS,y111] = intersections(ts,PS,[ts(1) ts(length(ts),1)],[0.1 0.1],1);  
    
    SORTtsPS = [];
    SORTtsPS(:,1) = inttsPS(1:2:(length(inttsPS))); %%START in Column 1 
    SORTtsPS(:,2) = inttsPS(2:2:(length(inttsPS))); %%END in Column 2
    
    SEtsPS = [];EtsPS = [];
    SEtsPS = SORTtsPS;      %% Contains time stamps for START && END of PS 
    EtsPS = SORTtsPS(:,2);  %% Contains only time stamp for END of PS                 
    %----------------------------------------------------------------------
    
    H=1;
    ASsmkcnt = 1;ASnsmkcnt = 1;
    VTsmkcnt = 1;VTnsmkcnt = 1;
    while(H <= length(SEtsPS) - 1)
        Sub(I).ts_feat(H,:) = [SEtsPS(H,1) SEtsPS(H,2)];
        Sub(I).TPR = length(Score(:,3));
        %---------------------  Auto Labelling ---------------------------%
        Label = SmkorNonSmkHG(SEtsPS,Score,H);
        Sub(I).Labels(H,1) = Label;
% %         gcf;
% %         if(Sub(I).Labels(H,1) == +1)
% %             gcf
% %             plot([SEtsPS(H,1) SEtsPS(H,2)],[0.8 0.8],'-*c');hold on;grid on;
% %             %pause(3);
% %         else
% %         end
        % ---------------  Current AS peak+valley ----------------------- %       
        Start = SEtsPS(H,1);End = SEtsPS(H,2); % Get the current peak that is immediately after the end of HG %`
        Index1 = find( End <= PtsAS(:,1) & PtsAS(:,1) <= End+55, 1 );
        Curr_AS_pk_time = PtsAS(Index1,1);
        Curr_AS_pk_amp = PtsAS(Index1,2);
        % Now get the valley that is immediately after the current peak %
        Index2 = find(Curr_AS_pk_time <= VtsAS(:,1) & VtsAS(:,1) <= Curr_AS_pk_time + 55,1);
        Curr_AS_vy_time = VtsAS(Index2,1);
        Curr_AS_vy_amp = VtsAS(Index2,2);    
        
        % Now extract the part of the AirFlow signal that is between
        % "START" of the HG and "Current Valley" %
        T1 = Start;T2 = Curr_AS_vy_time;        
        Ind_AS = find( T1 <= ASts(:,1) & ASts(:,1) <= T2);
        ASts_temp = ASts(Ind_AS,:);
        Levels = 9;
        %figure;hold on;
        [CodeAS] = EncodedSeq(ASts_temp,35,Levels); % The first argument is (1)Signal (AirFlow or TidalVolume), (2)Interval between succesive data points <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        % You can also form two separate sit and stand smk cells, by simply
        % comparing the ASpeak time that occur before the start of stand
        % smk event
        if(Label == +1)
            ASdatasmk{ASsmkcnt} = CodeAS;
            ASsmkcnt = ASsmkcnt + 1;
        else
            ASdatansmk{ASnsmkcnt} = CodeAS;
            ASnsmkcnt = ASnsmkcnt + 1;
        end
        
        % ---------------  Current VT peak+valley ----------------------- %
        Index3 = find( End <= PtsVT(:,1) & PtsVT(:,1) <= End+55, 1 );
        Curr_VT_pk_time = PtsVT(Index3,1);
        Curr_VT_pk_amp = PtsVT(Index3,2);
        
        Index4 = find(Curr_VT_pk_time <= VtsVT(:,1) & VtsVT(:,1) <= Curr_VT_pk_time + 55,1);
        Curr_VT_vy_time = VtsVT(Index4,1);
        Curr_VT_vy_amp = VtsVT(Index4,2);     
        
        % Now extract the part of the TidalVolume signal that is between
        % "START" of the HG and "Current Valley" %
        T3 = Start;T4 = Curr_VT_vy_time;        
        Ind_VT = find( T3 <= VTts(:,1) & VTts(:,1) <= T4);
        VTts_temp = VTts(Ind_VT,:);
        %figure;hold on;
        Levels = 9;
        [CodeVT] = EncodedSeq(VTts_temp,25,Levels); % The first argument is (1)Signal (AirFlow or TidalVolume), (2)Interval between succesive data points <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        % You can also form two separate sit and stand smk cells, by simply
        % comparing the ASpeak time that occur before the start of stand
        % smk event
        if(Label == +1)
            VTdatasmk{VTsmkcnt} = CodeVT;
            VTsmkcnt = VTsmkcnt + 1;
        else
            VTdatansmk{VTnsmkcnt} = CodeVT;
            VTnsmkcnt = VTnsmkcnt + 1;
        end         
                             
        H = H + 1;               
%         oo = input('\n Please input value to continue <= 10 // end >= 11\n');
%         if(oo <= 10)
%         else
%             stop1
%         end
    end       
    % Now divide the 'ASdatasmk' matrix into Training and Testing
    Len_AS = length(ASdatasmk);
    HLen_AS = round(length(ASdatasmk)/2);
    
    ASdatasmkTrain = ASdatasmk(1:HLen_AS);
    
    ASdatasmkTest = ASdatasmk(HLen_AS+1:length(ASdatasmk));
    
    
    % HMM initialization for class non-smoking % 
%     hmmNsmk.prior = [1 0 0];
%     hmmNsmk.transmat = rand(3,3);
%     hmmNsmk.transmat(2,1) = 0;hmmNsmk.transmat(3,1) = 0;hmmNsmk.transmat(3,2) = 0;
%     hmmNsmk.transmat = mk_stochastic(hmmNsmk.transmat);  
%     hmmNsmk.obsmat = rand(3, 16);  % 16 is the output symbols 
%     hmmNsmk.obsmat = mk_stochastic(hmmNsmk.obsmat);     
    
    % HMM initialization for smoking class %
    States = 5;Obs = 19;
    Prior = zeros(1,States);Prior(1,1) = 1;
    hmmsmk.prior = Prior;
    TransMat1 = rand(States,States);
    [TransMat] = InitializeTransMat(TransMat1);
    hmmsmk.transmat = TransMat;
%     hmmsmk.transmat(1,4) = 0;hmmsmk.transmat(1,5) = 0;
%     hmmsmk.transmat(2,1) = 0;hmmsmk.transmat(2,4) = 0;hmmsmk.transmat(2,5) = 0;
%     hmmsmk.transmat(3,1) = 0;hmmsmk.transmat(3,2) = 0;
%     hmmsmk.transmat(4,2) = 0;hmmsmk.transmat(4,3) = 0;
%     hmmsmk.transmat(5,1) = 0;hmmsmk.transmat(5,2) = 0;hmmsmk.transmat(5,3) = 0;hmmsmk.transmat(5,4) = 0;
    hmmsmk.transmat = mk_stochastic(hmmsmk.transmat);
    hmmsmk.obsmat = rand(States, Obs);
    hmmsmk.obsmat = mk_stochastic(hmmsmk.obsmat);   
    
    fprintf('\n ======================================================== \n');
    fprintf('\n ============ HMM Trained for smoking Data ============== \n');
    
    [LL0, hmmsmk.prior, hmmsmk.transmat, hmmsmk.obsmat] = dhmm_em(ASdatasmkTrain, ...
        hmmsmk.prior, hmmsmk.transmat, hmmsmk.obsmat,'max_iter', 25);
    
    % Evaluation of the Model trained for Smoking Data %
    fprintf('\n ======================================================== \n');
    fprintf('\n ======= Test Results for Applying HMM on smoking Data ===== \n');
    for i = 1 : 1 : length(ASdatasmkTest)
        loglikSMK = dhmm_logprob(ASdatasmkTest{i},hmmsmk.prior, hmmsmk.transmat, hmmsmk.obsmat);        
        disp(sprintf('[class SMK: %d -th data]model SMK:%.3f',i,loglikSMK));
    end
    
    %Array = randperm(length(ASdatansmk));
    
    fprintf('\n ======================================================== \n');
    fprintf('\n ======= Test Results for Applying HMM on non-smoking Data ===== \n');
    for i = 1 : 1 : length(ASdatansmk)
        %j = Array(i);
        loglikNSMK = dhmm_logprob(ASdatansmk{i},hmmsmk.prior, hmmsmk.transmat, hmmsmk.obsmat);
        disp(sprintf('[class Non-SMK: %d -th data]model SMK:%.3f',i,loglikNSMK));
    end
    fprintf('\n ============================================================== \n');    
    
      
    I = I + 1;
%end










