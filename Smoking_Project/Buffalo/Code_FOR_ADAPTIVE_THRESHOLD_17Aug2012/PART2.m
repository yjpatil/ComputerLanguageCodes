% This code finds the apnea part of the given lab sessions for a given
% SUBJECT. The thresholding technique is adaptive one. 
% TRAINING PHASE: using PUFF_SCORE matrix get the mean/median values for
% apneas in smoking instances. You find the MEAN of the amplitude and MIN
% & MAX amplitude of the APNEA part. Find the value of R1.
% Ratio, R1 = MEAN(APNEA_part)/MEAN(Total_amplitude_smk_breadth)
% Ratio, R2 = MEAN(APNEA_part)/MEAN(Diff_ValleySmk_Valleynxtsmk)
clc;clear all;close all;
%_________________________________________________________________________%
                z90 = 1.645;z95 = 1.96;z97 = 2.17;z99 = 2.58; % Z-values for different Confidence Intervals
                       zvalue = z99;  %<****** Change Me *******>
%_________________________________________________________________________%
global sf ts1 Counter_TP Counter_FN Counter_FP ;
sf = 101.73;
Counter_TP=0; Counter_FN = 0; Counter_FP = 0;

path = char('C:\Users\student\Documents\MATLAB\Buffalo_data_mat_files\');

list = char('DATA_PACT_105','DATA_PACT_107','DATA_PACT_108','DATA_PACT_109','DATA_PACT_114','DATA_PACT_117','DATA_PACT_118','DATA_PACT_120','DATA_PACT_122','DATA_PACT_124','DATA_PACT_127','DATA_PACT_128','DATA_PACT_129','DATA_PACT_132','DATA_PACT_134','DATA_PACT_136','DATA_PACT_138','DATA_PACT_140');

Size_List = size(list,1);

I = 9;    % Counter for Subjects

LS = 1;   % Counter for Lab_sessions 1 or 2

pf = 1;  % Counter for Puff_Scores

%while(I <= Size_List)
    
    load(strcat(path(1,:),list(I,:),'.mat'));
    
    clear('AB','RC','VT','AS','ASts','VTts','AS_min','AS_max','VT_min','VT_max')
    
    ts1 = Signals(:,1);
    
    [AB,RC] = process_AB_RC(1,Signals(:,2),Signals(:,3));   % 1 = no-inversion, 2 = invert
    
    [AS1,VT1] = get_AS_VT(0,AB,RC,1,4);        % 0 = (AB+RC)/2,  1 = RC,  2 = AB.% + Filtering using Ideal Filter = 1 or WT filter = 2. ALso the threshold value (4) for the component removal
    
    [AS1,VT1] = Normalization_tech(AS1,VT1,1,600,600,[-1 +1]);
    
    LS = 1;
    COUNTER = 1;
    size_LS = size(Lab_sessions,1);
    %while( COUNTER <= size_LS )
        ind_ts = [];ts = [];pf_score = [];ASts = [];VTts = [];
        PtsVT = []; VtsVT = [];PtsAS = []; VtsAS = [];n = [];    
        
       ind_ts = find(Lab_sessions(LS,1)<= ts1 & ts1 <= Lab_sessions(LS,2)); 
       
       ts = ts1(ind_ts);VT = VT1(ind_ts);AS = AS1(ind_ts);
       
       ind_pf = find(Lab_sessions(LS,1)<= puff_score(:,1) & puff_score(:,1) <= Lab_sessions(LS,2));  %% Selecting Puff_Score from "#LS" Lab_sessions only %%       
       pf_score = puff_score(ind_pf,:); %% PuFF_Score Matrix
       n = length(pf_score);
       
       ASts = [ts AS];VTts = [ts VT];
              
       [LpVT,MpVT] = peakfinder(VT,0.018,0.01,1);LpVT = VTts(LpVT,1);%peaks of VT signal%   
       [LvVT,MvVT] = peakfinder(VT,0.018,-0.01,-1);LvVT = VTts(LvVT,1);%valleys of VT signal%
       
       [LpAS,MpAS] = peakfinder(AS,0.018,0.01,1);LpAS = ASts(LpAS,1);%peaks of AS signal%
       [LvAS,MvAS] = peakfinder(AS,0.018,-0.01,-1);LvAS = ASts(LvAS,1);%valleys of AS signal%
       
       PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; %% Peaks and Valleys for TIDAL VOLUME(VT) signal %%
       PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS]; %% Peaks and Valleys for AIR FLOW(AF) signal %%       
       
       %            PLOT            %
% % %        figure(1);hold on;grid on;title(strcat(list(I,:),'Air Flow'));xlabel('Time \it s');
% % %        [H1,H3,H4] = PLOT_ME(pf_score,ASts,PtsAS,VtsAS);
% % %        legend([H1 H3(1) H4(1)],{'Air Flow' 'Start of Puff' 'End of Puff'});   
% % %        
       %            PLOT            %
% % %        figure(2);hold on;grid on;title(strcat(list(I,:),'Volume Tidal'));xlabel('Time \it s');
% % %        [H2,H3,H4] = PLOT_ME(pf_score,VTts,PtsVT,VtsVT);
% % %        legend([H2 H3(1) H4(1)],{'Volume Tidal' 'Start of Puff' 'End of Puff'});
       pf = 1;        
       while(pf <= size(pf_score,1))
           t1 = pf_score(pf,1);t2 = pf_score(pf,2);
           IndexAp = [];
           IndexAp = find(t1 <= ts & ts <= t2);
           
           SUB(I).LabS(LS).Stats_AS(pf,1) = t1;SUB(I).LabS(LS).Stats_VT(pf,1) = t1;
           SUB(I).LabS(LS).Stats_AS(pf,2) = t2;SUB(I).LabS(LS).Stats_VT(pf,2) = t2;
           SUB(I).LabS(LS).Stats_AS(pf,3) = t2-t1;SUB(I).LabS(LS).Stats_VT(pf,3) = t2-t1;  % (3) - Time Difference
           SUB(I).LabS(LS).Stats_AS(pf,4) = max(AS(IndexAp));SUB(I).LabS(LS).Stats_VT(pf,4) = max(VT(IndexAp));    % (4) MAX amplitude in AirFlow/TidalVolume
           SUB(I).LabS(LS).Stats_AS(pf,5) = min(AS(IndexAp));SUB(I).LabS(LS).Stats_VT(pf,5) = min(VT(IndexAp));    % (5) MIN amplitude in AirFlow/TidalVolume
           SUB(I).LabS(LS).Stats_AS(pf,6) = mean(AS(IndexAp));SUB(I).LabS(LS).Stats_VT(pf,6) = mean(VT(IndexAp));  % (6) MEAN amplitude in AirFlow/TidalVolume
           SUB(I).LabS(LS).Stats_AS(pf,7) = median(AS(IndexAp));SUB(I).LabS(LS).Stats_VT(pf,7) = median(VT(IndexAp)); % (7) MEDIAN amplitude in AirFlow/TidalVolume
           
           [Ind_nxt_ASp,Ind_nxt_ASv] = Find_Next_Peak(PtsAS,t2,VtsAS);
           [Ind_nxt_VTp,Ind_nxt_VTv] = Find_Next_Peak(PtsVT,t2,VtsVT);
           
           SUB(I).LabS(LS).Stats_AS(pf,8) = PtsAS(Ind_nxt_ASp,2) - VtsAS(Ind_nxt_ASv,2); % (8) Height of the Smoking WAVE - from peak to valley
           SUB(I).LabS(LS).Stats_VT(pf,8) = PtsVT(Ind_nxt_VTp,2) - VtsVT(Ind_nxt_VTv,2); % SAME for Tidal Volume
           
           %SUB(I).LabS(LS).Apnea_Part_AS(pf,:) = AS(IndexAp)'; % Apnea Part of the Wave
           %SUB(I).LabS(LS).Apnea_Part_VT(pf,:) = VT(IndexAp)';
           
           SUB(I).LabS(LS).Stats_AS(pf,9) = (PtsAS(Ind_nxt_ASp,2) - VtsAS(Ind_nxt_ASv,2))/mean(AS(IndexAp)); % (9) Ratio = (Peak - Valley)/(mean(APNEA))
           SUB(I).LabS(LS).Stats_VT(pf,9) = (PtsVT(Ind_nxt_VTp,2) - VtsVT(Ind_nxt_VTv,2))/mean(VT(IndexAp)); % SAME for Tidal Volume
           
           SUB(I).LabS(LS).Stats_AS(pf,10) = (PtsAS(Ind_nxt_ASp,2) - VtsAS(Ind_nxt_ASv,2))/median(AS(IndexAp)); % (10) Ratio = (Peak - Valley)/(median(APNEA))
           SUB(I).LabS(LS).Stats_VT(pf,10) = (PtsVT(Ind_nxt_VTp,2) - VtsVT(Ind_nxt_VTv,2))/median(VT(IndexAp)); % SAME for Tidal Volume
           
           SUB(I).LabS(LS).Stats_AS(pf,11) = abs( max(AS(IndexAp)) - mean(AS(IndexAp)) ); % (11) Absolute_Difference = MAX(Apnea) - MEAN(Apnea)
           SUB(I).LabS(LS).Stats_VT(pf,11) = abs( max(VT(IndexAp)) - mean(VT(IndexAp)) ); % (11) Absolute_Difference = MAX(Apnea) - MEAN(Apnea)
           
           SUB(I).LabS(LS).Stats_AS(pf,12) = abs( mean(AS(IndexAp)) - min(AS(IndexAp)) ); % (12) Absolute_Difference = MAX(Apnea) - MEAN(Apnea)
           SUB(I).LabS(LS).Stats_VT(pf,12) = abs( mean(VT(IndexAp)) - min(VT(IndexAp)) ); % (12) Absolute_Difference = MAX(Apnea) - MEAN(Apnea)          
           pf = pf + 1; 
       
       end
       % Now Collect there mean and median in different structure 
                 %          AIR FLOW (AS)             %
       %       1st Row MEAN 2nd Row Standard Deviation        %        
       SUBJECT(I).Labs(LS).Mean_Std_AS(1,1) = mean(SUB(I).LabS(LS).Stats_AS(:,3));SUBJECT(I).Labs(LS).Mean_Std_AS(2,1) = std(SUB(I).LabS(LS).Stats_AS(:,3));         % (1) Mean + Std of Time_difference
       
       SUBJECT(I).Labs(LS).Mean_Std_AS(1,2) = mean(SUB(I).LabS(LS).Stats_AS(:,4));SUBJECT(I).Labs(LS).Mean_Std_AS(2,2) = std(SUB(I).LabS(LS).Stats_AS(:,4));         % (2) Mean + Std of Max of Apnea
        
       SUBJECT(I).Labs(LS).Mean_Std_AS(1,3) = mean(SUB(I).LabS(LS).Stats_AS(:,5));SUBJECT(I).Labs(LS).Mean_Std_AS(2,3) = std(SUB(I).LabS(LS).Stats_AS(:,5));         % (3) Mean + Std of Min of Apnea
       
       SUBJECT(I).Labs(LS).Mean_Std_AS(1,4) = mean(SUB(I).LabS(LS).Stats_AS(:,6));SUBJECT(I).Labs(LS).Mean_Std_AS(2,4) = std(SUB(I).LabS(LS).Stats_AS(:,6));         % (4) Mean + Std of Mean of Apnea
       
       SUBJECT(I).Labs(LS).Mean_Std_AS(1,5) = mean(SUB(I).LabS(LS).Stats_AS(:,7));SUBJECT(I).Labs(LS).Mean_Std_AS(2,5) = std(SUB(I).LabS(LS).Stats_AS(:,7));         % (5) Mean + Std of Median of Apnea
       
       SUBJECT(I).Labs(LS).Mean_Std_AS(1,6) = mean(SUB(I).LabS(LS).Stats_AS(:,8));SUBJECT(I).Labs(LS).Mean_Std_AS(2,6) = std(SUB(I).LabS(LS).Stats_AS(:,8));         % (6) Mean + Std of Peak+Valley of smoking
       
       SUBJECT(I).Labs(LS).Mean_Std_AS(1,7) = mean(SUB(I).LabS(LS).Stats_AS(:,9));SUBJECT(I).Labs(LS).Mean_Std_AS(2,7) = std(SUB(I).LabS(LS).Stats_AS(:,9));         % (7) Mean + Std of Peak+Valley/mean(APNEA)
       
       SUBJECT(I).Labs(LS).Mean_Std_AS(1,8) = mean(SUB(I).LabS(LS).Stats_AS(:,10));SUBJECT(I).Labs(LS).Mean_Std_AS(2,8) = std(SUB(I).LabS(LS).Stats_AS(:,10));       % (8) Mean + Std of Peak+Valley/median(APNEA)
       
       SUBJECT(I).Labs(LS).Mean_Std_AS(1,9) = mean(SUB(I).LabS(LS).Stats_AS(:,11));SUBJECT(I).Labs(LS).Mean_Std_AS(2,9) = std(SUB(I).LabS(LS).Stats_AS(:,11));       % (9) Mean + Std of MAX-MEAN of (APNEA)
       
       SUBJECT(I).Labs(LS).Mean_Std_AS(1,10) = mean(SUB(I).LabS(LS).Stats_AS(:,12));SUBJECT(I).Labs(LS).Mean_Std_AS(2,10) = std(SUB(I).LabS(LS).Stats_AS(:,12));     % (10) Mean + Std of MEAN - MIN of (APNEA)
       %       1st Row MEDIAN 2nd Row Standard Deviation        %       
       SUBJECT(I).Labs(LS).Median_Std_AS(1,1) = median(SUB(I).LabS(LS).Stats_AS(:,3));SUBJECT(I).Labs(LS).Median_Std_AS(2,1) = std(SUB(I).LabS(LS).Stats_AS(:,3));   % (1) Median + Std of Time_difference
       
       SUBJECT(I).Labs(LS).Median_Std_AS(1,2) = median(SUB(I).LabS(LS).Stats_AS(:,4));SUBJECT(I).Labs(LS).Median_Std_AS(2,2) = std(SUB(I).LabS(LS).Stats_AS(:,4));   % (2) Median + Std of Max of Apnea
       
       SUBJECT(I).Labs(LS).Median_Std_AS(1,3) = median(SUB(I).LabS(LS).Stats_AS(:,5));SUBJECT(I).Labs(LS).Median_Std_AS(2,3) = std(SUB(I).LabS(LS).Stats_AS(:,5));   % (3) Median + Std of Min of Apnea
       
       SUBJECT(I).Labs(LS).Median_Std_AS(1,4) = median(SUB(I).LabS(LS).Stats_AS(:,6));SUBJECT(I).Labs(LS).Median_Std_AS(2,4) = std(SUB(I).LabS(LS).Stats_AS(:,6));   % (4) Median + Std of Mean of Apnea
       
       SUBJECT(I).Labs(LS).Median_Std_AS(1,5) = median(SUB(I).LabS(LS).Stats_AS(:,7));SUBJECT(I).Labs(LS).Median_Std_AS(2,5) = std(SUB(I).LabS(LS).Stats_AS(:,7));   % (5) Median + Std of Median of Apnea
       
       SUBJECT(I).Labs(LS).Median_Std_AS(1,6) = median(SUB(I).LabS(LS).Stats_AS(:,8));SUBJECT(I).Labs(LS).Median_Std_AS(2,6) = std(SUB(I).LabS(LS).Stats_AS(:,8));   % (6) Median + Std of Peak+Valley of smoking
       
       SUBJECT(I).Labs(LS).Median_Std_AS(1,7) = median(SUB(I).LabS(LS).Stats_AS(:,9));SUBJECT(I).Labs(LS).Median_Std_AS(2,7) = std(SUB(I).LabS(LS).Stats_AS(:,9));   % (7) Median + Std of Peak+Valley/mean(APNEA)
       
       SUBJECT(I).Labs(LS).Median_Std_AS(1,8) = median(SUB(I).LabS(LS).Stats_AS(:,10));SUBJECT(I).Labs(LS).Median_Std_AS(2,8) = std(SUB(I).LabS(LS).Stats_AS(:,10)); % (8) Median + Std of Peak+Valley/median(APNEA)
       
       SUBJECT(I).Labs(LS).Median_Std_AS(1,9) = median(SUB(I).LabS(LS).Stats_AS(:,11));SUBJECT(I).Labs(LS).Median_Std_AS(2,9) = std(SUB(I).LabS(LS).Stats_AS(:,11)); % (9) Median + Std of MAX-MEAN of (APNEA)
       
       SUBJECT(I).Labs(LS).Median_Std_AS(1,10) = median(SUB(I).LabS(LS).Stats_AS(:,12));SUBJECT(I).Labs(LS).Median_Std_AS(2,10) = std(SUB(I).LabS(LS).Stats_AS(:,12));   % (10) Median + Std of MEAN - MIN of (APNEA)
                 %          TIDAL VOLUME (VT)             %
       %       1st Row MEAN 2nd Row Standard Deviation        %       
       SUBJECT(I).Labs(LS).Mean_Std_VT(1,1) = mean(SUB(I).LabS(LS).Stats_VT(:,3));SUBJECT(I).Labs(LS).Mean_Std_VT(2,1) = std(SUB(I).LabS(LS).Stats_VT(:,3));         % (1) Mean + Std of Time_difference
       
       SUBJECT(I).Labs(LS).Mean_Std_VT(1,2) = mean(SUB(I).LabS(LS).Stats_VT(:,4));SUBJECT(I).Labs(LS).Mean_Std_VT(2,2) = std(SUB(I).LabS(LS).Stats_VT(:,4));         % (2) Mean + Std of Max of Apnea
       
       SUBJECT(I).Labs(LS).Mean_Std_VT(1,3) = mean(SUB(I).LabS(LS).Stats_VT(:,5));SUBJECT(I).Labs(LS).Mean_Std_VT(2,3) = std(SUB(I).LabS(LS).Stats_VT(:,5));         % (3) Mean + Std of Min of Apnea
       
       SUBJECT(I).Labs(LS).Mean_Std_VT(1,4) = mean(SUB(I).LabS(LS).Stats_VT(:,6));SUBJECT(I).Labs(LS).Mean_Std_VT(2,4) = std(SUB(I).LabS(LS).Stats_VT(:,6));         % (4) Mean + Std of Mean of Apnea
       
       SUBJECT(I).Labs(LS).Mean_Std_VT(1,5) = mean(SUB(I).LabS(LS).Stats_VT(:,7));SUBJECT(I).Labs(LS).Mean_Std_VT(2,5) = std(SUB(I).LabS(LS).Stats_VT(:,7));         % (5) Mean + Std of Median of Apnea
       
       SUBJECT(I).Labs(LS).Mean_Std_VT(1,6) = mean(SUB(I).LabS(LS).Stats_VT(:,8));SUBJECT(I).Labs(LS).Mean_Std_VT(2,6) = std(SUB(I).LabS(LS).Stats_VT(:,8));         % (6) Mean + Std of Peak+Valley of smoking
       
       SUBJECT(I).Labs(LS).Mean_Std_VT(1,7) = mean(SUB(I).LabS(LS).Stats_VT(:,9));SUBJECT(I).Labs(LS).Mean_Std_VT(2,7) = std(SUB(I).LabS(LS).Stats_VT(:,9));         % (7) Mean + Std of Peak+Valley/mean(APNEA)
       
       SUBJECT(I).Labs(LS).Mean_Std_VT(1,8) = mean(SUB(I).LabS(LS).Stats_VT(:,10));SUBJECT(I).Labs(LS).Mean_Std_VT(2,8) = std(SUB(I).LabS(LS).Stats_VT(:,10));       % (8) Mean + Std of Peak+Valley/median(APNEA)
       
       SUBJECT(I).Labs(LS).Mean_Std_VT(1,9) = mean(SUB(I).LabS(LS).Stats_VT(:,11));SUBJECT(I).Labs(LS).Mean_Std_VT(2,9) = std(SUB(I).LabS(LS).Stats_VT(:,11));       % (9) Mean + Std of MAX-MEAN of (APNEA)
       
       SUBJECT(I).Labs(LS).Mean_Std_VT(1,10) = mean(SUB(I).LabS(LS).Stats_VT(:,12));SUBJECT(I).Labs(LS).Mean_Std_VT(2,10) = std(SUB(I).LabS(LS).Stats_VT(:,12));     % (10) Mean + Std of MEAN - MIN of (APNEA)
       %       1st Row MEDIAN 2nd Row Standard Deviation        %       
       SUBJECT(I).Labs(LS).Median_Std_VT(1,1) = median(SUB(I).LabS(LS).Stats_VT(:,3));SUBJECT(I).Labs(LS).Median_Std_VT(2,1) = std(SUB(I).LabS(LS).Stats_VT(:,3));   % (1) Median + Std of Time_difference
       
       SUBJECT(I).Labs(LS).Median_Std_VT(1,2) = median(SUB(I).LabS(LS).Stats_VT(:,4));SUBJECT(I).Labs(LS).Median_Std_VT(2,2) = std(SUB(I).LabS(LS).Stats_VT(:,4));   % (2) Median + Std of Max of Apnea
       
       SUBJECT(I).Labs(LS).Median_Std_VT(1,3) = median(SUB(I).LabS(LS).Stats_VT(:,5));SUBJECT(I).Labs(LS).Median_Std_VT(2,3) = std(SUB(I).LabS(LS).Stats_VT(:,5));   % (3) Median + Std of Min of Apnea
       
       SUBJECT(I).Labs(LS).Median_Std_VT(1,4) = median(SUB(I).LabS(LS).Stats_VT(:,6));SUBJECT(I).Labs(LS).Median_Std_VT(2,4) = std(SUB(I).LabS(LS).Stats_VT(:,6));   % (4) Median + Std of Mean of Apnea
        
       SUBJECT(I).Labs(LS).Median_Std_VT(1,5) = median(SUB(I).LabS(LS).Stats_VT(:,7));SUBJECT(I).Labs(LS).Median_Std_VT(2,5) = std(SUB(I).LabS(LS).Stats_VT(:,7));   % (5) Median + Std of Median of Apnea
       
       SUBJECT(I).Labs(LS).Median_Std_VT(1,6) = median(SUB(I).LabS(LS).Stats_VT(:,8));SUBJECT(I).Labs(LS).Median_Std_VT(2,6) = std(SUB(I).LabS(LS).Stats_VT(:,8));   % (6) Median + Std of Peak+Valley of smoking
       
       SUBJECT(I).Labs(LS).Median_Std_VT(1,7) = median(SUB(I).LabS(LS).Stats_VT(:,9));SUBJECT(I).Labs(LS).Median_Std_VT(2,7) = std(SUB(I).LabS(LS).Stats_VT(:,9));   % (7) Median + Std of Peak+Valley/mean(APNEA)
       
       SUBJECT(I).Labs(LS).Median_Std_VT(1,8) = median(SUB(I).LabS(LS).Stats_VT(:,10));SUBJECT(I).Labs(LS).Median_Std_VT(2,8) = std(SUB(I).LabS(LS).Stats_VT(:,10)); % (8) Median + Std of Peak+Valley/median(APNEA)
       
       SUBJECT(I).Labs(LS).Median_Std_VT(1,9) = median(SUB(I).LabS(LS).Stats_VT(:,11));SUBJECT(I).Labs(LS).Median_Std_VT(2,9) = std(SUB(I).LabS(LS).Stats_VT(:,11)); % (9) Median + Std of MAX-MEAN of (APNEA)
       
       SUBJECT(I).Labs(LS).Median_Std_VT(1,10) = median(SUB(I).LabS(LS).Stats_VT(:,12));SUBJECT(I).Labs(LS).Median_Std_VT(2,10) = std(SUB(I).LabS(LS).Stats_VT(:,12));     % (10) Median + Std of MEAN - MIN of (APNEA)
       % Time to assign values to the Ratio R1, Time-Duration TD, Mean Threshold Mth, 
       % Upper Threshold Uth, Lower Threshold Lth.
       Case = 1;
       if(Case == 1)  %% Only MEan Values %%
           % For Air Flow Signal %
           TDmean_AS = SUBJECT(I).Labs(LS).Mean_Std_AS(1,1);TDstd_AS = SUBJECT(I).Labs(LS).Mean_Std_AS(2,1); % <---- Average Time_Duration Value
           L_TD_AS = TDmean_AS - ((zvalue * TDstd_AS)/sqrt(n)); % Lower Threshold for APNEA TIME_DURATION
           U_TD_AS = TDmean_AS + ((zvalue * TDstd_AS)/sqrt(n)); % Upper Threshold for APNEA TIME_DURATION
           
           Ratio_mean_AS = SUBJECT(I).Labs(LS).Mean_Std_AS(1,7);Ratio_std_AS = SUBJECT(I).Labs(LS).Mean_Std_AS(2,7); % <---- Average Ratio Value
           L_Ratio_AS = Ratio_mean_AS - ((zvalue * Ratio_std_AS)/sqrt(n)); % Lower Threshold for APNEA RATIO  % THRESHOLD # 1 %
           U_Ratio_AS = Ratio_mean_AS + ((zvalue * Ratio_std_AS)/sqrt(n)); % Lower Threshold for APNEA TIME_DURATION % THRESHOLD # 2 %
           
           Max_mean_AS = SUBJECT(I).Labs(LS).Mean_Std_AS(1,2);Max_std_AS = SUBJECT(I).Labs(LS).Mean_Std_AS(2,2); % <---- Mean of the Max in Apnea
           L_Max_AS = Max_mean_AS - ((zvalue * Max_std_AS)/sqrt(n)); % Lower Threshold for MAX of APNEA  % THRESHOLD # 3 %
           U_Max_AS = Max_mean_AS + ((zvalue * Max_std_AS)/sqrt(n)); % Upper Threshold for MAX of APNEA  % THRESHOLD # 3 %
           
           Min_mean_AS = SUBJECT(I).Labs(LS).Mean_Std_AS(1,3);Min_std_AS = SUBJECT(I).Labs(LS).Mean_Std_AS(2,3); % <---- Mean of the Min in Apnea
           L_Min_AS = Min_mean_AS - ((zvalue * Min_std_AS)/sqrt(n)); % Lower Threshold for MIN of APNEA  % THRESHOLD # 4 %
           U_Min_AS = Min_mean_AS + ((zvalue * Min_std_AS)/sqrt(n)); % Upper Threshold for MIN of APNEA  % THRESHOLD # 4 %
           
           % For Tidal Volume Signal %
           TDmean_VT = SUBJECT(I).Labs(LS).Mean_Std_VT(1,1);TDstd_VT = SUBJECT(I).Labs(LS).Mean_Std_VT(2,1); % <---- Average Time_Duration Value
           L_TD_VT = TDmean_VT - ((zvalue * TDstd_VT)/sqrt(n)); % Lower Threshold for APNEA TIME_DURATION
           U_TD_VT = TDmean_VT + ((zvalue * TDstd_VT)/sqrt(n)); % Upper Threshold for APNEA TIME_DURATION
           
           Ratio_mean_VT = SUBJECT(I).Labs(LS).Mean_Std_VT(1,7);Ratio_std_VT = SUBJECT(I).Labs(LS).Mean_Std_VT(2,7); % <---- Average Ratio Value
           L_Ratio_VT = Ratio_mean_VT - ((zvalue * Ratio_std_VT)/sqrt(n)); % Lower Threshold for APNEA RATIO  % THRESHOLD # 1 %
           U_Ratio_VT = Ratio_mean_VT + ((zvalue * Ratio_std_VT)/sqrt(n)); % Lower Threshold for APNEA TIME_DURATION % THRESHOLD # 2 %
           
           Max_mean_VT = SUBJECT(I).Labs(LS).Mean_Std_VT(1,2);Max_std_VT = SUBJECT(I).Labs(LS).Mean_Std_VT(2,2); % <---- Mean of the Max in Apnea
           L_Max_VT = Max_mean_VT - ((zvalue * Max_std_VT)/sqrt(n)); % Lower Threshold for MAX of APNEA  % THRESHOLD # 3 %
           U_Max_VT = Max_mean_VT + ((zvalue * Max_std_VT)/sqrt(n)); % Upper Threshold for MAX of APNEA  % THRESHOLD # 3 %
           
           Min_mean_VT = SUBJECT(I).Labs(LS).Mean_Std_VT(1,3);Min_std_VT = SUBJECT(I).Labs(LS).Mean_Std_VT(2,3); % <---- Mean of the Min in Apnea
           L_Min_VT = Min_mean_VT - ((zvalue * Min_std_VT)/sqrt(n)); % Lower Threshold for MIN of APNEA  % THRESHOLD # 4 %
           U_Min_VT = Min_mean_VT + ((zvalue * Min_std_VT)/sqrt(n)); % Upper Threshold for MIN of APNEA  % THRESHOLD # 4 %
       elseif(Case == 2)  %% Only Median Values %%
           % For Air Flow Signal %
           TDmedian_AS = SUBJECT(I).Labs(LS).Median_Std_AS(1,1);TDstd_AS = SUBJECT(I).Labs(LS).Median_Std_AS(2,1); % <---- Average Time_Duration Value
           L_TD_AS = TDmedian_AS - ((zvalue * TDstd_AS)/sqrt(n)); % Lower Threshold for APNEA TIME_DURATION
           U_TD_AS = TDmedian_AS + ((zvalue * TDstd_AS)/sqrt(n)); % Upper Threshold for APNEA TIME_DURATION
           
           Ratio_median_AS = SUBJECT(I).Labs(LS).Median_Std_AS(1,7);Ratio_std_AS = SUBJECT(I).Labs(LS).Median_Std_AS(2,7); % <---- Average Ratio Value
           L_Ratio_AS = Ratio_median_AS - ((zvalue * Ratio_std_AS)/sqrt(n)); % Lower Threshold for APNEA RATIO  % THRESHOLD # 1 %
           U_Ratio_AS = Ratio_median_AS + ((zvalue * Ratio_std_AS)/sqrt(n)); % Lower Threshold for APNEA TIME_DURATION % THRESHOLD # 2 %
           
           Max_median_AS = SUBJECT(I).Labs(LS).Median_Std_AS(1,2);Max_std_AS = SUBJECT(I).Labs(LS).Median_Std_AS(2,2); % <---- Mean of the Max in Apnea
           L_Max_AS = Max_median_AS - ((zvalue * Max_std_AS)/sqrt(n)); % Lower Threshold for MAX of APNEA  % THRESHOLD # 3 %
           U_Max_AS = Max_median_AS + ((zvalue * Max_std_AS)/sqrt(n)); % Upper Threshold for MAX of APNEA  % THRESHOLD # 3 %
           
           Min_median_AS = SUBJECT(I).Labs(LS).Median_Std_AS(1,3);Min_std_AS = SUBJECT(I).Labs(LS).Median_Std_AS(2,3); % <---- Mean of the Min in Apnea
           L_Min_AS = Min_median_AS - ((zvalue * Min_std_AS)/sqrt(n)); % Lower Threshold for MIN of APNEA  % THRESHOLD # 4 %
           U_Min_AS = Min_median_AS + ((zvalue * Min_std_AS)/sqrt(n)); % Upper Threshold for MIN of APNEA  % THRESHOLD # 4 %
           
           % For Tidal Volume Signal %
           TDmedian_VT = SUBJECT(I).Labs(LS).Median_Std_VT(1,1);TDstd_VT = SUBJECT(I).Labs(LS).Median_Std_VT(2,1); % <---- Average Time_Duration Value
           L_TD_VT = TDmedian_VT - ((zvalue * TDstd_VT)/sqrt(n)); % Lower Threshold for APNEA TIME_DURATION
           U_TD_VT = TDmedian_VT + ((zvalue * TDstd_VT)/sqrt(n)); % Upper Threshold for APNEA TIME_DURATION
           
           Ratio_median_VT = SUBJECT(I).Labs(LS).Median_Std_VT(1,7);Ratio_std_VT = SUBJECT(I).Labs(LS).Median_Std_VT(2,7); % <---- Average Ratio Value
           L_Ratio_VT = Ratio_median_VT - ((zvalue * Ratio_std_VT)/sqrt(n)); % Lower Threshold for APNEA RATIO  % THRESHOLD # 1 %
           U_Ratio_VT = Ratio_median_VT + ((zvalue * Ratio_std_VT)/sqrt(n)); % Lower Threshold for APNEA TIME_DURATION % THRESHOLD # 2 %
           
           Max_median_VT = SUBJECT(I).Labs(LS).Median_Std_VT(1,2);Max_std_VT = SUBJECT(I).Labs(LS).Median_Std_VT(2,2); % <---- Mean of the Max in Apnea
           L_Max_VT = Max_median_VT - ((zvalue * Max_std_VT)/sqrt(n)); % Lower Threshold for MAX of APNEA  % THRESHOLD # 3 %
           U_Max_VT = Max_median_VT + ((zvalue * Max_std_VT)/sqrt(n)); % Upper Threshold for MAX of APNEA  % THRESHOLD # 3 %
           
           Min_median_VT = SUBJECT(I).Labs(LS).Median_Std_VT(1,3);Min_std_VT = SUBJECT(I).Labs(LS).Median_Std_VT(2,3); % <---- Mean of the Min in Apnea
           L_Min_VT = Min_median_VT - ((zvalue * Min_std_VT)/sqrt(n)); % Lower Threshold for MIN of APNEA  % THRESHOLD # 4 %
           U_Min_VT = Min_median_VT + ((zvalue * Min_std_VT)/sqrt(n)); % Upper Threshold for MIN of APNEA  % THRESHOLD # 4 %
       end
       %% Now Change the Lab Session Number %%        
       if( LS == 1 )         %% <--------- This is where you can change the Lab-Session number !!
           LS = 1;
       elseif( LS == 2 )
           LS = 1; 
       end
       % Now next Lab Session find the peaks, valleys for AS and VT and plot %
       ind_ts = [];ts = [];pf_score = [];ASts = [];VTts = []; % Clear All variables
       PtsVT = []; VtsVT = [];PtsAS = []; VtsAS = [];  % Clear All variables
       
       ind_ts = find(Lab_sessions(LS,1)<= ts1 & ts1 <= Lab_sessions(LS,2)); 
       
       ts = ts1(ind_ts);VT = VT1(ind_ts);AS = AS1(ind_ts);
       
       ind_pf = find(Lab_sessions(LS,1)<= puff_score(:,1) & puff_score(:,1) <= Lab_sessions(LS,2));  %% Selecting Puff_Score from "#LS" Lab_sessions only %%       
       pf_score = puff_score(ind_pf,:); %% PuFF_Score Matrix
       
       ASts = [ts AS];VTts = [ts VT];
              
       [LpVT,MpVT] = peakfinder(VT,0.018,0.04,1);LpVT = VTts(LpVT,1);   % peaks of VT signal %   
       [LvVT,MvVT] = peakfinder(VT,0.018,-0.04,-1);LvVT = VTts(LvVT,1); % valleys of VT signal %
       
       [LpAS,MpAS] = peakfinder(AS,0.018,0.04,1);LpAS = ASts(LpAS,1);   % peaks of AS signal %
       [LvAS,MvAS] = peakfinder(AS,0.018,-0.04,-1);LvAS = ASts(LvAS,1); % valleys of AS signal %
       
       PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT];   %% Peaks and Valleys for TIDAL VOLUME(VT) signal %%
       PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];   %% Peaks and Valleys for AIR FLOW(AF) signal %%              
       
        %            PLOT 1 for AS            %
       figure(1);hold on;grid on;title(strcat(list(I,:),'Air Flow'));xlabel('Time \it s');
       [H1,H3,H4] = PLOT_ME(pf_score,ASts,PtsAS,VtsAS);
       legend([H1 H3(1) H4(1)],{'Air Flow' 'Start of Puff' 'End of Puff'});   
       
       %            PLOT 2 for VT            %
       figure(2);hold on;grid on;title(strcat(list(I,:),'Volume Tidal'));xlabel('Time \it s');
       [H2,H3,H4] = PLOT_ME(pf_score,VTts,PtsVT,VtsVT);
       legend([H2 H3(1) H4(1)],{'Volume Tidal' 'Start of Puff' 'End of Puff'});
       
       %--------------------------- Air Flow Signal ----------------------%
       pCount = 3;
       Counter_TP=0; Counter_FN = 0; Counter_FP = 0; % Initialize the values of TP, FN, FP
       while( pCount <= size(PtsAS,1)-5 ) %% For each peak of Air_Flow Signal
           time0 = PtsAS(pCount-1,1); %% Previous Peak of the Air_Flow signal 
           time1 = PtsAS(pCount,1);   %% Next Peak of the Air_Flow signal 
           indTemp = find(time0 <= VtsAS(:,1) & VtsAS(:,1) <= time1);  %% Check if there is a VALLEY present between the peak
           err0 = isempty(indTemp); % Check if there is valley between the two peaks !!
           if(err0 == 1) % If it is empty that means there is no valley. Hence it is not a valid peak
               flag = 1;
               while(flag == 1 )  % Raise a Flag for an invalid peak
                   pCount = pCount + 1; % Increase the peak count by 1
                   time0 = PtsAS(pCount-1,1); 
                   time1 = PtsAS(pCount,1);
                   indTemp = find(time0 <= VtsAS(:,1) & VtsAS(:,1) <= time1); % Check if the new peak has VALLEY in-between
                   errTemp = isempty(indTemp);  % if Value of errTemp is 1 then again there is no valley in-between
                   if(errTemp == 1)
                       flag = 1; % Raise Flag again
                   else
                       flag = 0; % Lower Flag
                   end
               end
           end
           %----------------------------------------------------------- %
           [Actual_score] = find_actual_score(time0,time1,pf_score);    % get the actual score of the 
           %----------------------------------------------------------- %
           ind_prevValley = find(time0 <= VtsAS(:,1) & VtsAS(:,1) <= time1,1);           
           
           ind_currValley = find(time1 <= VtsAS(:,1) & VtsAS(:,1) <= time1+45,1);
           
           V_ts_prev = VtsAS(ind_prevValley,1);V_amp_prev = VtsAS(ind_prevValley,2); % Previous valley amplitude and Time-stamp
           V_ts_curr = VtsAS(ind_currValley,1);V_amp_curr = VtsAS(ind_currValley,2); % Current Valley Amplitude and Time-stamp
           P_ts_curr = PtsAS(pCount,1);P_amp_curr = PtsAS(pCount,2); % Current Peak Amplitude and Time-stamp
           
           T11 = V_ts_prev;T22 = P_ts_curr; % Now get the part between the Prev VALLEY and Current PEAK
           Indx_tstemp = find(T11 <= ts & ts <= T22); 
           tstemp = ts(Indx_tstemp);
           AStemp = AS(Indx_tstemp);
           
           Sum_pv = P_amp_curr - V_amp_curr; % Current Peak and Valley Difference to find the Ratio for the Adaptive Threshold
           
           Thresh1 = Sum_pv/L_Ratio_AS;  % Threshold 1 % Lower value of mean = This Threshold is the lower mean %
           Thresh2 = Sum_pv/L_Ratio_AS;  % Threshold 2 % Upper value of mean = This Threshold is the upper mean %
           
           Thresh3 = L_Max_AS + Thresh2; % Threshold 3 % Thresh3 = L_Max_AS + Thresh2; % Threshold BELOW which the Apnea Part Should Stay
           Thresh4 = U_Min_AS + Thresh1; % Threshold 4 % Thresh4 = L_Min_AS + Thresh1; % Threshold ABOVE which the Apnea Part Should Stay
           
           [ ts_ZAS, z00 ] = intersections( tstemp, AStemp, [tstemp(1) tstemp(length(tstemp))], [0.0 0.0] ); % Intersection of the ZERO Line with AS
           
           [ ts_ASth1, z11 ] = intersections( tstemp, AStemp, [tstemp(1) tstemp(length(tstemp))], [Thresh1 Thresh1] );  % This Threshold is the Lower one, so its intersection with AS is LAST (First)
           
           [ ts_ASth2, z12 ] = intersections( tstemp, AStemp, [tstemp(1) tstemp(length(tstemp))], [Thresh2 Thresh2] );  % This Threshold is the Upper one, so its intersection with AS is FIRST (Last)
           
           if( isempty(ts_ASth1) )
               ts_ASth1 = ts_ZAS(1); % This is the First Intersection
           else
               ts_ASth1 = ts_ASth1(1); % If it is not empty use the first element of the Lower Threshold intersection with AS
           end
           
           if( isempty(ts_ASth2) )
               ts_ASth2 = ts_ZAS(length(ts_ZAS));
           else
               ts_ASth2 = ts_ASth2(length(ts_ASth2)); % If it is not empty use the last element of the Upper Threshold intersection with AS
           end
           
           START = ts_ASth2;END = ts_ASth1;
           TD = START - END; % < this should be +ve VALUE
           
           if(TD >= L_TD_AS)
           %if(TD >= L_TD_AS && TD <= U_TD_AS)  % Now check if the Time Difference is between the Lower TD and Upper TD; If yes proceed
               Indx_tstemp2 = find(END <= ts & ts <= START); % Now get the part between the START and the END
               tstemp2 = ts(Indx_tstemp2);AStemp2 = AS(Indx_tstemp2);
               
               [ts_ASth3,z13] = intersections( tstemp2, AStemp2, [tstemp2(1) tstemp2(length(tstemp2))], [Thresh3 Thresh3] ); % Check if there is an Intersection between Maximum Threshold and Air-Flow
               [ts_ASth4,z14] = intersections( tstemp2, AStemp2, [tstemp2(1) tstemp2(length(tstemp2))], [Thresh4 Thresh4] ); % Check if there is an Intersection between Minimum Threshold and Air-Flow
               err45 = isempty(ts_ASth3);err55 = isempty(ts_ASth4);
               
               if(err55 == 1)
               %if(err45 == 1 && err55 == 1) % If both the Thresholds do not intersect with the Air_Flow signal then it is likely a apnea
                   Predicted_Score = +1;
                   [u1] = Determine_Score(Actual_score,Predicted_Score);  % <|------ This function calculates the number of True Positives, False Negative and False Positive
                   figure(1);gcf;
                   if( Actual_score == Predicted_Score )
                       gcf;plot([END START],[0.08 0.08],'-*g')
                   end
                   plot([END END],[Thresh4 Thresh3],'-k','LineWidth',2);plot([END START],[Thresh3 Thresh3],'-k','LineWidth',2);plot([START START],[Thresh3 Thresh4],'-k','LineWidth',2);plot([START END],[Thresh4 Thresh4],'-k','LineWidth',2);
               else
                   Predicted_Score = -1; 
                   [u1] = Determine_Score(Actual_score,Predicted_Score);
               end              
           end
           
           pCount = pCount + 1;
       end
       % After the whole LAB_Session is complete Calculate the TP, FP and
       % FN's
       Prec = 0;Rec = 0;F1score = 0;
       Prec = (Counter_TP/(Counter_TP + Counter_FP));
       Rec = (Counter_TP/(length(pf_score)));
       F1score = 2*((Prec*Rec)/(Prec + Rec));
       %------------------------ For Air Flow Signal ---------------------%
       if(LS == 1)
           LS1_Table_AS_Adaptive(I,:) = [F1score*100 Prec*100 Rec*100 Counter_TP  (length(pf_score)-Counter_TP) Counter_FP length(pf_score) ((ts(length(ts))-ts(1))/60)];
       elseif(LS == 2)
           LS2_Table_AS_Adaptive(I,:) = [F1score*100 Prec*100 Rec*100 Counter_TP  (length(pf_score)-Counter_TP) Counter_FP length(pf_score) ((ts(length(ts))-ts(1))/60)];
       end
       %---------------------- For Tidal Volume Signal -------------------%
       pCount = 3;
       Counter_TP = 0; Counter_FN = 0; Counter_FP = 0; % Initialize the values of TP, FN, FP
       while( pCount <= size(PtsVT,1)-5 ) %% For each peak of Air_Flow Signal
           time0 = PtsVT(pCount-1,1); %% Previous Peak of the Air_Flow signal 
           time1 = PtsVT(pCount,1);   %% Next Peak of the Air_Flow signal 
           indTemp = find(time0 <= VtsVT(:,1) & VtsVT(:,1) <= time1);  %% Check if there is a VALLEY present between the peak
           err0 = isempty(indTemp); % Check if there is valley between the two peaks !!
           if(err0 == 1) % If it is empty that means there is no valley. Hence it is not a valid peak
               flag = 1;
               while(flag == 1 )  % Raise a Flag for an invalid peak
                   pCount = pCount + 1; % Increase the peak count by 1
                   time0 = PtsVT(pCount-1,1); 
                   time1 = PtsVT(pCount,1);
                   indTemp = find(time0 <= VtsVT(:,1) & VtsVT(:,1) <= time1); % Check if the new peak has VALLEY in-between
                   errTemp = isempty(indTemp);  % if Value of errTemp is 1 then again there is no valley in-between
                   if(errTemp == 1)
                       flag = 1; % Raise Flag again
                   else
                       flag = 0; % Lower Flag
                   end
               end
           end
           %----------------------------------------------------------- %
           [Actual_score] = find_actual_score(time0,time1,pf_score);    % get the actual score of the 
           %----------------------------------------------------------- %
           ind_prevValley = find(time0 <= VtsVT(:,1) & VtsVT(:,1) <= time1,1);           
           
           ind_currValley = find(time1 <= VtsVT(:,1) & VtsVT(:,1) <= time1+45,1);
           
           V_ts_prev = VtsVT(ind_prevValley,1);V_amp_prev = VtsVT(ind_prevValley,2); % Previous valley amplitude and Time-stamp
           V_ts_curr = VtsVT(ind_currValley,1);V_amp_curr = VtsVT(ind_currValley,2); % Current Valley Amplitude and Time-stamp
           P_ts_curr = PtsVT(pCount,1);P_amp_curr = PtsVT(pCount,2); % Current Peak Amplitude and Time-stamp
           
           T11 = V_ts_prev;T22 = P_ts_curr; % Now get the part between the Prev VALLEY and Current PEAK
           Indx_tstemp = find(T11 <= ts & ts <= T22); 
           tstemp = ts(Indx_tstemp);
           VTtemp = VT(Indx_tstemp);
           
           Sum_pv = P_amp_curr - V_amp_curr; % Current Peak and Valley Difference to find the Ratio for the Adaptive Threshold
           
           Thresh1 = Sum_pv/L_Ratio_VT;  % Threshold 1 % Lower value of mean = This Threshold is the lower mean %
           Thresh2 = Sum_pv/U_Ratio_VT;  % Threshold 2 % Upper value of mean = This Threshold is the upper mean %
           
           Thresh3 = U_Max_VT + Thresh2; % Threshold 3 % Thresh3 = L_Max_AS + Thresh2; % Threshold BELOW which the Apnea Part Should Stay
           Thresh4 = U_Min_VT - Thresh1; % Threshold 4 % Thresh4 = L_Min_VT + Thresh1; % Threshold ABOVE which the Apnea Part Should Stay
           
           [ ts_ZVT, z00 ] = intersections( tstemp, VTtemp, [tstemp(1) tstemp(length(tstemp))], [0.0 0.0] ); % Intersection of the ZERO Line with VT
           
           [ ts_VTth1, z11 ] = intersections( tstemp, VTtemp, [tstemp(1) tstemp(length(tstemp))], [Thresh1 Thresh1] );  % This Threshold is the Lower one, so its intersection with VT is LVTT (First)
           
           [ ts_VTth2, z12 ] = intersections( tstemp, VTtemp, [tstemp(1) tstemp(length(tstemp))], [Thresh2 Thresh2] );  % This Threshold is the Upper one, so its intersection with VT is FIRST (Last)
           
           if( isempty(ts_VTth1) )
               ts_VTth1 = ts_ZVT(1); % This is the First Intersection
           else
               ts_VTth1 = ts_VTth1(1); % If it is not empty use the first element of the Lower Threshold intersection with VT
           end
           
           if( isempty(ts_VTth2) )
               ts_VTth2 = ts_ZVT(length(ts_ZVT));
           else
               ts_VTth2 = ts_VTth2(length(ts_VTth2)); % If it is not empty use the last element of the Upper Threshold intersection with VT
           end
           
           START = ts_VTth2;END = ts_VTth1;
           TD = START - END; % < this should be +ve VALUE
           
           if(TD >= L_TD_VT && TD <= U_TD_VT)  % Now check if the Time Difference is between the Lower TD and Upper TD; If yes proceed
               Indx_tstemp2 = find(END <= ts & ts <= START); % Now get the part between the START and the END
               tstemp2 = ts(Indx_tstemp2);VTtemp2 = VT(Indx_tstemp2);
               
               [ts_VTth3,z13] = intersections( tstemp2, VTtemp2, [tstemp2(1) tstemp2(length(tstemp2))], [Thresh3 Thresh3] ); % Check if there is an Intersection between Maximum Threshold and Air-Flow
               [ts_VTth4,z14] = intersections( tstemp2, VTtemp2, [tstemp2(1) tstemp2(length(tstemp2))], [Thresh4 Thresh4] ); % Check if there is an Intersection between Minimum Threshold and Air-Flow
               err45 = isempty(ts_VTth3);err55 = isempty(ts_VTth4);
               
               if(err45 == 1 && err55 == 1) % If both the Thresholds do not intersect with the Air_Flow signal then it is likely a apnea
                   Predicted_Score = +1;
                   [u1] = Determine_Score(Actual_score,Predicted_Score);  % <|------ This function calculates the number of True Positives, False Negative and False Positive
                   figure(2);gcf;
                   if( Actual_score == Predicted_Score )
                       gcf;plot([temp1 temp2],[0.08 0.08],'-*r')
                   end
                   plot([END END],[Thresh4 Thresh3],'-k','LineWidth',2);plot([END START],[Thresh3 Thresh3],'-k','LineWidth',2);plot([START START],[Thresh3 Thresh4],'-k','LineWidth',2);plot([START END],[Thresh4 Thresh4],'-k','LineWidth',2);
               else
                   Predicted_Score = -1; 
                   [u1] = Determine_Score(Actual_score,Predicted_Score);
               end              
           end
           
           pCount = pCount + 1;
       end
       % After the whole LAB_Session is complete Calculate the TP, FP and
       % FN's
       Prec = 0;Rec = 0;F1score = 0;
       Prec = (Counter_TP/(Counter_TP + Counter_FP));
       Rec = (Counter_TP/(length(pf_score)));
       F1score = 2*((Prec*Rec)/(Prec + Rec));
       %-------------------- For Tidal Volume Signal ---------------------%
       if(LS == 1)
           LS1_Table_VT_Adaptive(I,:) = [F1score*100 Prec*100 Rec*100 Counter_TP  (length(pf_score)-Counter_TP) Counter_FP length(pf_score) ((ts(length(ts))-ts(1))/60)];
       elseif(LS == 2)
           LS2_Table_VT_Adaptive(I,:) = [F1score*100 Prec*100 Rec*100 Counter_TP  (length(pf_score)-Counter_TP) Counter_FP length(pf_score) ((ts(length(ts))-ts(1))/60)];
       end
       
       if( LS == 1 )
           LS = 2;
       elseif( LS == 2 )
           LS = 1; 
       end
       
       COUNTER = COUNTER + 1;  % Counter to Lab_Session which goes from 1 to 2
    %end
    
    I = I + 1;
    
    LS = 1;
    
    
%end













