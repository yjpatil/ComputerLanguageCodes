% This code extracts feature from a given activity for classification     %
%  purpose.
% Date: 5 Nov 2012

clc;clear all;close all;
global sf ts;
sf = 101.73;

Subject.Activity.Sitting.AS_feat = [];% Structure Initialization for 
Subject.Activity.Sitting.VT_feat = [];

path = char('C:\Users\student\Documents\MATLAB\Biology_bldg_20subjects\');

%list = char('Sub_003','Sub_004','Sub_005','Sub_006','Sub_007','Sub_008','Sub_009','Sub_010','Sub_011','Sub_012','Sub_013','Sub_014','Sub_015','Sub_016','Sub_017','Sub_019','Sub_020','Sub_021','Sub_022','Sub_023');

list = char('Sub_003','Sub_004','Sub_006','Sub_007','Sub_009','Sub_010','Sub_011','Sub_012','Sub_013','Sub_014','Sub_015','Sub_016','Sub_017','Sub_019','Sub_020','Sub_021','Sub_022','Sub_023');

Size_List = size(list,1);

I = 1;

%while(I <= Size_List)
   
    load(strcat(path(1,:),list(I,:),'.mat'));
    
    Subject(I).Activity.Name = list(I,:);
    
    L = length(Data);
    
    ts = [1:L]/sf;ts = ts';ts = ts-(Activities(1,2));
    
    dat = Data(:,2)/max(Data(:,2)); % Normalized Proximity Sensor before passing to merge function
    PS = merge_function(dat,ts,0.046,0.5,8,1.2);    
    
    [AB,RC] = process_AB_RC(3,Data(:,4),Data(:,5));    % 2 & 3 = Invert the Signals 
    
    [ASr,VTr] = get_AS_VT(0,AB,RC,1,4);        % 0 = (AB+RC)/2,  1 = RC,  2 = AB.% + Filtering using Ideal Filter = 1 or WT filter = 2. ALso the threshold value (4) for the component removal    
    
    %[AS,VT] = Normalization_tech(ASr,VTr,2,600,600,[-1 +1]);
    
    ASts = [ts ASr];VTts = [ts VTr];
    
    [ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal
    
    PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; %% Peaks and Valleys for TIDAL VOLUME(VT) signal %%
    PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS]; %% Peaks and Valleys for AIR FLOW(AF) signal %% 
    
    [ASnorm,VTnorm] = Normalization_Second_stage(ASts(:,2),VTts(:,2),2,VtsAS(:,2),PtsAS(:,2),VtsVT(:,2),PtsVT(:,2),[-1 +1]);
    
    ASts = []; VTts = [];
    
    ASts = [ts ASnorm];VTts = [ts VTnorm];
    
    [ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal
    
    PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; %% Peaks and Valleys for TIDAL VOLUME(VT) signal %%
    PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS]; %% Peaks and Valleys for AIR FLOW(AF) signal %% 
    
    %================== INTERSECTION of ZERO line with VT ================%
    [tsintZVT,ampintZVT] = intersections(VTts(:,1),VTts(:,2),[ts(1) ts(length(ts))],[1e-7 1e-7],1); 
    %================== INTERSECTION of ZERO line with AS ================%
    [tsintZAS,ampintZAS] = intersections(ASts(:,1),ASts(:,2),[ts(1) ts(length(ts))],[1e-7 1e-7],1); 
    
% % %     figure;hold on;grid on;title(strcat(list(I,:)));xlabel('Time \it s');
% % %     
% % %     H0 = plot(ts,PS,'Color',[0.1 0.3 0.9]);    
% % %     H1 = plot(ASts(:,1),ASts(:,2),'Color',[0.7 0.3 0.6]);
% % %     plot(LpAS,MpAS,'+k');grid on;hold on;
% % %     plot(LvAS,MvAS,'+r');grid on;hold on; 
% % %     H2 = plot(VTts(:,1),VTts(:,2),'Color',[0.1 0.7 0.5]);
% % %     plot(LpVT,MpVT,'ob');grid on;hold on;
% % %     plot(LvVT,MvVT,'ok');grid on;hold on; 
% % %     
% % %     %%plot(tsintZVT,ampintZVT,'or');
% % %     %%plot(tsintZAS,ampintZAS,'ob');
% % %     
% % %     O = 0.28*ones(size(Score,1));
% % %     H3 = plot(Score(:,4),O,'ob');
% % %     H4 = plot(Score(:,5),O,'or');    
% % %     
% % %     legend([H0 H1 H2 H3(1) H4(1)],{'Proximity Sensor' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});
    
    it1 = 2;
    while(it1 <= length(Activities))
        Tstart = [];Tend = [];
        Index1 = [];Index2 = [];Index3 = [];Index4 = [];Index5 = [];Index6 = [];
        PtsAS_temp = [];VtsAS_temp = [];
        PtsVT_temp = [];VtsVT_temp = [];
        
        Tstart = Activities(it1,1);Tend = Activities(it1,2);
        
        Index1 = find(Tstart <= PtsAS(:,1) & PtsAS(:,1) <= Tend);
        PtsAS_temp = PtsAS(Index1,:);
        Index2 = find(Tstart <= VtsAS(:,1) & VtsAS(:,1) <= Tend);
        VtsAS_temp = VtsAS(Index2,:);
        Index3 = find(Tstart <= PtsVT(:,1) & PtsVT(:,1) <= Tend);
        PtsVT_temp = PtsVT(Index3,:);
        Index4 = find(Tstart <= VtsVT(:,1) & VtsVT(:,1) <= Tend);
        VtsVT_temp = VtsVT(Index4,:);
        Index5 = find(Tstart <= tsintZAS & tsintZAS <= Tend);
        tsintZAS_temp = tsintZAS(Index5,1);
        Index6 = find(Tstart <= tsintZVT & tsintZVT <= Tend);
        tsintZVT_temp = tsintZVT(Index6,1);
        
        pCount = 4;featCount = 1;
        while(pCount<=size( PtsAS_temp,1) - 5)
            time0 = PtsAS_temp(pCount-1,1);
            time1 = PtsAS_temp(pCount,1);
            indTemp = find(time0 <= VtsAS_temp(:,1) & VtsAS_temp(:,1) <= time1);
            err0 = isempty(indTemp);
            if(err0 == 1)
                flag = 1;
                while(flag == 1 )
                    pCount = pCount + 1;
                    time0 = PtsAS_temp(pCount-1,1);
                    time1 = PtsAS_temp(pCount,1);
                    indTemp = find(time0 <= VtsAS_temp(:,1) & VtsAS_temp(:,1) <= time1); 
                    errTemp = isempty(indTemp);
                    if(errTemp == 1)
                        flag = 1;
                    else
                        flag = 0; % Lower Flag
                    end
                end
            end
            
            ind_prevValley = find(time0 <= VtsAS_temp(:,1) & VtsAS_temp(:,1) <= time1,1,'last');
            ind_nextValley = find(time1 <= VtsAS_temp(:,1) & VtsAS_temp(:,1) <= time1+75,1);
            
            PrevValley_ts_AS = VtsAS_temp(ind_prevValley,1);
            PrevValley_amp_AS = VtsAS_temp(ind_prevValley,2);
            
            CurrPeak_ts_AS = PtsAS_temp(pCount,1);
            CurrPeak_amp_AS = PtsAS_temp(pCount,2);
            
            NextValley_ts_AS = VtsAS_temp(ind_nextValley,1);
            NextValley_amp_AS = VtsAS_temp(ind_nextValley,2);
            
            AS_S1 = (CurrPeak_amp_AS - PrevValley_amp_AS)/(CurrPeak_ts_AS - PrevValley_ts_AS);
            
            AS_S2 = (NextValley_amp_AS - CurrPeak_amp_AS)/(NextValley_ts_AS - CurrPeak_ts_AS);
            
            AS_PV = abs(CurrPeak_amp_AS) + abs(NextValley_amp_AS);
            
            ind_prev_intZAS = find(PrevValley_ts_AS <= tsintZAS_temp & tsintZAS_temp <= CurrPeak_ts_AS,1);
            
            ind_next_intZAS = find(CurrPeak_ts_AS <= tsintZAS_temp & tsintZAS_temp <= NextValley_ts_AS,1);
            
            AS_T1 = CurrPeak_ts_AS - tsintZAS_temp(ind_prev_intZAS);
            
            AS_T2 = tsintZAS_temp(ind_next_intZAS) - CurrPeak_ts_AS;
            
            AS_Tadd = AS_T1 + AS_T2;
            
            AS_Tsub = (AS_T1 - AS_T2 );
            
            % Now Tidal Volume Signal
            
            ind_Curr_VTpeak = find(CurrPeak_ts_AS <= PtsVT_temp(:,1) & PtsVT_temp(:,1) <= CurrPeak_ts_AS + 75,1);
            CurrPeak_ts_VT = PtsVT_temp(ind_Curr_VTpeak,1);
            CurrPeak_amp_VT = PtsVT_temp(ind_Curr_VTpeak,2);
            
            ind_Prev_VTvalley = find(CurrPeak_ts_VT - 75 <= VtsVT_temp(:,1) & VtsVT_temp(:,1) <= CurrPeak_ts_VT,1,'last');
            PrevValley_ts_VT = VtsVT_temp(ind_Prev_VTvalley,1);
            PrevValley_amp_VT = VtsVT_temp(ind_Prev_VTvalley,2);
            
            ind_next_VTvalley = find(CurrPeak_ts_VT <= VtsVT_temp(:,1) & VtsVT_temp(:,1) <= CurrPeak_ts_VT + 75,1);
            NextValley_ts_VT = VtsVT_temp(ind_next_VTvalley,1);
            NextValley_amp_VT = VtsVT_temp(ind_next_VTvalley,2);
            
            VT_S1 = (CurrPeak_amp_VT - PrevValley_amp_VT)/(CurrPeak_ts_VT - PrevValley_ts_VT);
            
            VT_S2 = (NextValley_amp_VT - CurrPeak_amp_VT)/(NextValley_ts_VT - CurrPeak_ts_VT);
            
            VT_PV = (CurrPeak_amp_VT) + (NextValley_amp_VT);
            
            ind_prev_intZVT = find(PrevValley_ts_VT <= tsintZVT_temp & tsintZVT_temp <= CurrPeak_ts_VT,1);
            
            ind_next_intZVT = find(CurrPeak_ts_VT <= tsintZVT_temp & tsintZVT_temp <= NextValley_ts_VT,1);
            
            VT_T1 = CurrPeak_ts_VT - tsintZVT_temp(ind_prev_intZVT);
            
            VT_T2 = tsintZVT_temp(ind_next_intZVT) - CurrPeak_ts_VT;
            
            VT_Tadd = VT_T1 + VT_T2;
            
            VT_Tsub = VT_T1 - VT_T2;
            
            % Now add them in appropriate activity
            % Gather the features
             Feat_AS = [];Feat_VT = [];
             
             Feat_AS = [AS_S1 AS_S2 AS_PV AS_T1 AS_T2 AS_Tadd AS_Tsub];
             
             Feat_VT = [VT_S1 VT_S2 VT_PV VT_T1 VT_T2 VT_Tadd VT_Tsub];
             
             [Subject] = Activity_Feat_Assign(it1,I,featCount,Subject,Feat_AS,Feat_VT);
            
            pCount = pCount + 1;
            featCount = featCount + 1;
        end
        it1 = it1 + 1;
    end
    % plotting PDE function for different Activities within a subject
    [I]=Plot_PDE_AS(Subject,I,list(I,:),6);  % 1 last is the feat number,e.g. 1 =  S1, 2 = S2, 3 = PV, ...
    [I]=Plot_PDE_VT(Subject,I,list(I,:),6);  % 1 last is the feat number,e.g. 1 =  S1, 2 = S2, 3 = PV, ...
    
    I = I + 1;
%end


