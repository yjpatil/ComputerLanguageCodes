%************************************************************************%
%*******            Final Code for Feature_Extraction              ******%
%************************************************************************%

clc;clear all; close all;
sf=101.73; 
H=1;oo = 10;
list = char('sub_003','sub_004','sub_005','sub_006','sub_007','sub_008','sub_009','sub_010','sub_011','sub_012','sub_013','sub_014','sub_015','sub_016','sub_017','sub_019','sub_020','sub_021','sub_022','sub_023');
%list = char('sub_017','sub_019','sub_020','sub_021','sub_022','sub_023');
s = size(list);s = s(1,1);I = 1;   %% Iteration for subject (here, 1 <= I <= 20) %%

while(I <= s)
    fprintf('\nThe Subject# is:%d\n',I);
    hamp = 1:4:400; ha = 1;  %% indices for the structure %%
    %load(strcat(list(I,1),list(I,2),list(I,3),list(I,4),list(I,5),list(I,6),list(I,7),'.mat'))
    load(strcat(list(I,:),'.mat'));
    clear ('L','ts');
    L = length(Data); ts = [1:L]/sf; ts = ts'; ts = ts-Activities(1,2);
    
    clear ('Z');%,'Z1','Z2','Z3','Z4','Z5','Z6','Z7','Z8','Z9','Z10','Z11','Z12');
    Z = zeros(L,1);% Z1 = zeros(L,1); Z2 = zeros(L,1);
    
    clear ('ind1','i');%,'ind2');
    for i = 2:1:length(Activities)
        if(i == 11 || i == 13)
        ind1 = Activities(i,1) <= ts & ts <= Activities(i,2);
        Z(ind1) = 0;
        else
        ind1 = find(Activities(i,1) <= ts & ts <= Activities(i,2));
        Z(ind1) = 1;
        clear 'ind1';
        end
    end
    %figure(222)
    %plot(ts,Z);grid on;%hold on;
    %ind1 = find(Activities(11,1) <= ts & ts <= Activities(11,2)); Z(ind1) = 1; Z1(ind1) = 1;
    
    %ind2 = find(Activities(13,1) <= ts & ts <= Activities(13,2)); Z(ind2) = 1; Z2(ind2) = 1;
    clear ('PS31','ind0','PS');%,'PB');    
    %PB = (Data(:,1))/max(Data(:,1)); PB = PB .* Z;
    
    PS31 = (Data(:,2))/max(Data(:,2)); PS31 = PS31.* Z;
    %plot(ts,PS31);grid on;hold on;
    PS = merge_function1(PS31,ts,0.046,0.5,8,1.2);
    %ind0 = find(PS1 >= 0.046); clear 'PS1';      
    %clear ('PS','PS2');
    %PS2 = zeros(L,1); PS2(ind0) = 1; 
    %PS = merge_func(ts,PS2,1.2); % merging of close pulses
    figure(1)
    plot(ts,PS,'r');hold on;grid on;
    clear ('ASa','RC','AB','VT1','ind3','nvt1','Mvt');
    ASa = (Data(:,3))/max(Data(:,3)); 
    RC = (Data(:,4))/max(Data(:,4));
    AB = (Data(:,5))/max(Data(:,5));
    
    RC = RC .* Z; AB = AB .* Z; VT1 = (AB + RC)/2;
    
    ind3 = find(VT1 > 0); nvt1 = length(ind3); Mvt = (sum(VT1))/nvt1;  %% Procedure to find the mean-value %%
    
    clear ('VT','AS');
    VT = VT1 - Mvt; VT = -1 * VT; VT = VT + Mvt; VT = VT .* Z;   %% Inverted VT signal %%
    
    VT = idealfilter(VT,0.1,1000,sf); VT = VT .* Z;
    VT = fastsmooth(VT,25,1,0); 
    ts1 = ts .* Z; 
    
    AS = diff(VT)./diff(ts1);
    AS = [AS;0];
    
    for i1 = 1:1:L
        if (Z(i1,1) == 0)
            AS(i1,1) = 0;
        else
            AS(i1,1) = AS(i1,1);
        end
    end
    
    AS = fastsmooth(AS,45,1,0);
    
    % =============================================================================== %
    ASts = [ts AS];  %% time stamps in 1st Column and Amplitude of AS in 2nd Column %%
    VTts = [ts VT];  %% time stamps in 1st Column and Amplitude of VT in 2nd Column %%
    % =============================================================================== %
    
    clear ('LpVT','MpVT','LvVT','MvVT','LpAS','MpAS','LvAS','MvAS');
    [LpVT,MpVT] = peakfinder(VT,0.0099,-0.02,1);
    LpVT = LpVT/sf;
    LpVT = LpVT-(Activities(1,2));
    
    [LvVT,MvVT] = peakfinder(VT,0.0099,0.02,-1);
    LvVT = LvVT/sf;
    LvVT = LvVT-(Activities(1,2));    
    
    [LpAS,MpAS] = peakfinder(AS,0.0099,-0.02,1);
    LpAS = LpAS/sf;
    LpAS = LpAS-(Activities(1,2));
    
    [LvAS,MvAS] = peakfinder(AS,0.0099,0.02,-1);
    LvAS = LvAS/sf;
    LvAS = LvAS-(Activities(1,2));
    % =============== PLOTS ======================= %
%     plot(ts,AS,'b');hold on; grid on;     % AS signal %
%     plot(LpAS,MpAS,'+m');grid on;hold on; % Peaks for AS signal %
%     plot(LvAS,MvAS,'+r');grid on;hold on; % Valleys for AS signal %
%     
%     plot(ts,VT,'k');hold on; grid on;     % VT signal %
%     plot(LpVT,MpVT,'om');grid on;hold on; % Peaks for VT signal %
%     plot(LvVT,MvVT,'or');grid on;hold on; % Valleys for VT signal %
    % ============================================ %
    %clear ('PS5','PS6');
    %PS5 = PS.*Z1;
    [inttsPS1,y111] = intersections(ts,PS,[0 ts(length(ts),1)],[0.1 0.1],1);
    
    %PS6 = PS.*Z2;
    %[inttsPS2,y112] = intersections(ts,PS6,[0 ts(length(ts),1)],[0.1 0.1],1);
    
    clear ('err1int');%,'err2int');
    err1int = mod(length(inttsPS1),2);
    if err1int == 0
    else
        disp('Error in INTERSECTION of Proximity Sensor (Sittiing PART)with Thres (ODD #)');
        stop;    
    end
    
%     err2int = mod(length(inttsPS2),2);
%     if err2int == 0
%     else
%         disp('Error in INTERSECTION of Proximity Sensor (Standing PART) with Thres (ODD #)');
%         stop;
%     end
    
    clear ('SORTtsPS1');%,'SORTtsPS2','SEtsPS','EtsPS');
    SORTtsPS1(:,1) = inttsPS1(1:2:(length(inttsPS1))); %%START in Column 1 
    SORTtsPS1(:,2) = inttsPS1(2:2:(length(inttsPS1))); %%END in Column 2
    
%     SORTtsPS2(:,1) = inttsPS2(1:2:(length(inttsPS2))); %%START in Column 1
%     SORTtsPS2(:,2) = inttsPS2(2:2:(length(inttsPS2))); %%END in Column 2
    
    SEtsPS = SORTtsPS1;     %cat(1,SORTtsPS1,SORTtsPS2); %% Contains time stamps for START && END of PS 
    EtsPS = SORTtsPS1(:,2);%cat(1,SORTtsPS1(:,2),SORTtsPS2(:,2));  %% Contains only time stamp for END of PS 
    
    clear ('PtsVT','VtsVT','PtsAS','VtsAS');
    %*************  IMPORTANT MATRICES FOR VT SIGNALS **************%
    PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 
    %*************  IMPORTANT MATRICES FOR AS SIGNALS **************%
    PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];
    %***************************************************************%
    
    IT = 0; IND = 0; i = 1; %======== To calculate median of AS +-10% Threshold "Roughly" 
    PEAK_AS_INSP = [0 0];
    for IT = 1 : 1 : length(EtsPS)
        IND = find(EtsPS(IT)-0.15 <= LpAS   & LpAS <= EtsPS(IT)+ 3.1,1); 
        ERR1 = isempty(IND);
        if(ERR1 == 1)
        else
            PEAK_AS_INSP(i,1) = PtsAS(IND,1);    %% Contains the TIME STAMPS for PEAK_AS_INSP PARAMETER
            PEAK_AS_INSP(i,2) = PtsAS(IND,2);    %% Contains the PEAK AMPLITUDE VALUES for PEAK_AS_INSP PARAMETER
            i = i + 1;
        end
    end
    clear 'IND'
    %+++++++++++++++ POSITIVE 10% MEDIAN THRESHOLD ++++++++++++++++++%
    clear ('thp10','tsintthp10AS','ampintthp10AS','tsintthm10AS','ampintthm10AS','tsintZVT','ampintZVT','tsintZAS','ampintZAS');
    thp10 = median(PEAK_AS_INSP(:,2)) * ( + 0.1);
    [tsintthp10AS,ampintthp10AS] = intersections(ts,AS,[0 ts(length(ts),1)],[thp10 thp10],1);
    %--------------- NEGATIVE 10% MEDIAN THRESHOLD ------------------%
    thm10 = median(PEAK_AS_INSP(:,2)) * ( - 0.1);
    [tsintthm10AS,ampintthm10AS] = intersections(ts,AS,[0 ts(length(ts),1)],[thm10 thm10],1);
    %============= INTERSECTION of ZERO line with VT ==============%
    [tsintZVT,ampintZVT] = intersections(ts,VT,[0 ts(length(ts),1)],[1e-7 1e-7],1); 
    %============= INTERSECTION of ZERO line with AS ==============%
    [tsintZAS,ampintZAS] = intersections(ts,AS,[0 ts(length(ts),1)],[1e-7 1e-7],1); 
    
    % ============= Plots for Manual Scoring ============ %
%     pl1 = length(Score(:,3));pl2 = length(Score(:,4));
%     zpl1 = zeros(pl1,1);zpl2 = zeros(pl2,1);
%     plot(Score(:,3),zpl1,'hk',Score(:,4),zpl2,'hk');grid on; hold on;
    % =================================================== %
    NHG = length(SEtsPS);fprintf('\nNumber of Hand Gestures = %d',NHG);
    fprintf('\nSubject Number= %d',I);
    %H = 1; oo=10;
    %while(H <= length(SEtsPS) && oo == 10)
    while(H <= length(SEtsPS))
        
%         fprintf('\nThe hand gesture #:%d\n',H);
        
        %***********  PARA # 4  ***************%
        S(I).h(hamp(ha),4) = SEtsPS(H,2) - SEtsPS(H,1); %% TIME Difference between the start and end of HG in structure****S.H*** %%
        subj(I).hg(H,4) = S(I).h(hamp(ha),4);   %% same value stored in****subj.hg**** %%
        S(I).h(hamp(ha) + 1,4) = SEtsPS(H,1);   % 1 has the Start Time of HG %
        S(I).h(hamp(ha) + 2,4) = SEtsPS(H,2);   % 2 has the End Time of HG %
        S(I).h(hamp(ha) + 3,4) = 0;   % This is useful when Automatic Scoring software is used!!%
        
        %**********  PARA # 14 # 15 ***************%
        clear 'ind14'
        ps14 = Data(:,2)/max(Data(:,2)); %% Normalize first the values of TRUE PS signals %%
        ind14 = find(SEtsPS(H,1) <= ts & ts <= SEtsPS(H,2)); %% Get the TRUE amplitudes of signal within the HG %%
        ps141 = zeros(length(ts),1);   %% get another array of length(ts) %%
        ps141(ind14) = 1;              %% In the above array put ones in places where the HG took place %%
        ps142 = ps14 .* ps141;         %% multiply the above array with TRUE PS NORMALIZE signal %%
        para15 = max(ps142);           %% <<++++++++++++++ PARAMETER 15, max of PS signal during a HG %%
        s14 = sum(ps142);              %% take sum of all points of "ps142" %%
        l14 = length(ind14);           %% get the length of the points that lie in the HG %%
        mean14 = s14/l14;  %===== mean amplitude of PS for the given HG ======%
        S(I).h(hamp(ha),14) = mean14; % mean-amplitude %
        subj(I).hg(H,14) = S(I).h(hamp(ha),14);   % mean-amplitude %
        S(I).h(hamp(ha) + 1,14) = SEtsPS(H,1);   % 1 has the Start Time of HG %
        S(I).h(hamp(ha) + 2,14) = SEtsPS(H,2);   % 2 has the End Time of HG %
        S(I).h(hamp(ha) + 3,14) = 0;   % This is useful when Automatic Scoring software is used!!%
        
        S(I).h(hamp(ha),15) = para15;
        subj(I).hg(H,15) = S(I).h(hamp(ha),15);   % max-amplitude %
        S(I).h(hamp(ha) + 1,15) = SEtsPS(H,1);   % 1 has the Start Time of HG %
        S(I).h(hamp(ha) + 2,15) = SEtsPS(H,2);   % 2 has the End Time of HG %
        S(I).h(hamp(ha) + 3,15) = 0;   % This is useful when Automatic Scoring software is used!!%
        %**********  PARA # 6  # 20 # 21 ***************%  ++++++++++++++ FUTURE
        %FEATURE EXTRACTION Depends on this feature. So if this feature is
        %not present, future features can be extracted, irrespective to
        %this feature. So we have "if(err6 == 0) else "+++++++++++++++++
        ind6 = find(EtsPS(H) - 0.25 <= LpAS & LpAS <= EtsPS(H) + 25,1);  %% Find TIME STAMPS for Amplitude PEAKS of AIRFLOW signal after end of HG%%
        err6 = isempty(ind6); %% These error variables play an important role!! To help to extract other features
        if(err6 == 0) %% the "end" and "else" for this "if" is in FFE_EXT_Part2
            S(I).h(hamp(ha),6) = PtsAS(ind6,2); % amplitude of AIRFLOW signal %
            subj(I).hg(H,6) = S(I).h(hamp(ha),6);  % amplitude of AIRFLOW signal %
            S(I).h(hamp(ha) + 1,6) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,6) = PtsAS(ind6,1);   % 2 has the End Time of HG %
            S(I).h(hamp(ha) + 3,6) = err6;   % This is useful when Automatic Scoring software is used!!%
            
            if(ind6+1 ~= length(PtsAS)+1)
                %S(I).h(hamp(ha),20) = abs(PtsAS(ind6,2)-PtsAS(ind6+1,2));
                S(I).h(hamp(ha),20) = (PtsAS(ind6,2)-PtsAS(ind6+1,2));
                subj(I).hg(H,20) = S(I).h(hamp(ha),20);  % amplitude of AIRFLOW signal %
                S(I).h(hamp(ha) + 1,20) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,20) = PtsAS(ind6+1,1);   % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,20) = err6;   % This is useful when Automatic Scoring software is used!!%
            else
                S(I).h(hamp(ha),20) = 0;
                subj(I).hg(H,20) = S(I).h(hamp(ha),20);  % amplitude of AIRFLOW signal %
                S(I).h(hamp(ha) + 1,20) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,20) = SEtsPS(H,2);   % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,20) = err6;   % This is useful when Automatic Scoring software is used!!%
            end
            
            %S(I).h(hamp(ha),21) = abs(PtsAS(ind6,2)-PtsAS(ind6-1,2));
            S(I).h(hamp(ha),21) = (PtsAS(ind6,2)-PtsAS(ind6-1,2));
            subj(I).hg(H,21) = S(I).h(hamp(ha),21);  % amplitude of AIRFLOW signal %
            S(I).h(hamp(ha) + 1,21) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,21) = PtsAS(ind6-1,1);   % 2 has the End Time of HG %
            S(I).h(hamp(ha) + 3,21) = err6;   % This is useful when Automatic Scoring software is used!!%
            %************ PARA # 5 # 16 #17 ************%
            ind5 = find(S(I).h(hamp(ha) + 2,6) <= LpVT & LpVT <= S(I).h(hamp(ha) + 2,6) + 25,1); %% Get the time location of peak of VT immediately
            err5 = isempty(ind5);   %% ... after peak of AIRFLOW signal
            if(err5 == 0) 
                S(I).h(hamp(ha),5) = PtsVT(ind5,2); % PEAK amplitude of VT signal %
                subj(I).hg(H,5) = S(I).h(hamp(ha),5);  % PEAK amplitude of VT signal %
                S(I).h(hamp(ha) + 1,5) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,5) = PtsVT(ind5,1);  % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,5) = err5;   % This is useful when Automatic Scoring software is used!!%
                
                if(ind5+1 ~= length(PtsVT)+1)
                    %S(I).h(hamp(ha),16) = abs(PtsVT(ind5,2)-PtsVT(ind5+1,2)); % PEAK amplitude of VT signal %
                    S(I).h(hamp(ha),16) = (PtsVT(ind5,2)-PtsVT(ind5+1,2)); % PEAK amplitude of VT signal %
                    subj(I).hg(H,16) = S(I).h(hamp(ha),16);  % PEAK amplitude of VT signal %
                    S(I).h(hamp(ha) + 1,16) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                    S(I).h(hamp(ha) + 2,16) = PtsVT(ind5+1,1);  % 2 has the End Time of HG %
                    S(I).h(hamp(ha) + 3,16) = err5;   % This is useful when Automatic Scoring software is used!!%
                else
                    S(I).h(hamp(ha),16) = 0; % PEAK amplitude of VT signal %
                    subj(I).hg(H,16) = S(I).h(hamp(ha),16);  % PEAK amplitude of VT signal %
                    S(I).h(hamp(ha) + 1,16) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                    S(I).h(hamp(ha) + 2,16) = SEtsPS(H,2);  % 2 has the End Time of HG %
                    S(I).h(hamp(ha) + 3,16) = err5;   % This is useful when Automatic Scoring software is used!!%
                end                
                
                %S(I).h(hamp(ha),17) = abs(PtsVT(ind5,2)-PtsVT(ind5-1,2)); % PEAK amplitude of VT signal %
                S(I).h(hamp(ha),17) = (PtsVT(ind5,2)-PtsVT(ind5-1,2)); % PEAK amplitude of VT signal %
                subj(I).hg(H,17) = S(I).h(hamp(ha),17);  % PEAK amplitude of VT signal %
                S(I).h(hamp(ha) + 1,17) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,17) = PtsVT(ind5-1,1);  % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,17) = err5;   % This is useful when Automatic Scoring software is used!!%
            else
                S(I).h(hamp(ha),5) = 0; % if the amplitude is not found its amplitude = ZERO %
                subj(I).hg(H,5) = S(I).h(hamp(ha),5);
                S(I).h(hamp(ha) + 1,5) = SEtsPS(H,1);   % 1 has the Start Time of HG%
                S(I).h(hamp(ha) + 2,5) = SEtsPS(H,2);   % 2 has the End Time of HG%
                S(I).h(hamp(ha) + 3,5) = err5;   % This is useful when Automatic Scoring software is used!!%
                
                S(I).h(hamp(ha),16) = 0; % if the amplitude is not found its amplitude = ZERO %
                subj(I).hg(H,16) = S(I).h(hamp(ha),16);
                S(I).h(hamp(ha) + 1,16) = SEtsPS(H,1);   % 1 has the Start Time of HG%
                S(I).h(hamp(ha) + 2,16) = SEtsPS(H,2);   % 2 has the End Time of HG%
                S(I).h(hamp(ha) + 3,16) = err5;   % This is useful when Automatic Scoring software is used!!%
                
                S(I).h(hamp(ha),17) = 0; % if the amplitude is not found its amplitude = ZERO %
                subj(I).hg(H,17) = S(I).h(hamp(ha),17);
                S(I).h(hamp(ha) + 1,17) = SEtsPS(H,1);   % 1 has the Start Time of HG%
                S(I).h(hamp(ha) + 2,17) = SEtsPS(H,2);   % 2 has the End Time of HG%
                S(I).h(hamp(ha) + 3,17) = err5;   % This is useful when Automatic Scoring software is used!!%
            end
            
            % ************ PARA # 11 #18 #19 ************ %
            ind11 = find(S(I).h(hamp(ha) + 2,5) <= LvVT & LvVT <= S(I).h(hamp(ha) + 2,5) + 25,1); %% time location of valley after peak of VT signal
            err11 = isempty(ind11);   %% These error variables play an important role!! To help to extract other features
            if(err11 == 0)
                S(I).h(hamp(ha),11) = VtsVT(ind11,2); % Valley amplitude %
                subj(I).hg(H,11) = S(I).h(hamp(ha),11);
                S(I).h(hamp(ha) + 1,11) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,11) = VtsVT(ind11,1);   % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,11) = err11;   % This is useful when Automatic Scoring software is used!!%
                
                if(ind11+1 ~= length(VtsVT)+1)
                    %S(I).h(hamp(ha),18) = abs(VtsVT(ind11,2)-VtsVT(ind11+1,2)); % Valley amplitude %
                    S(I).h(hamp(ha),18) = (VtsVT(ind11,2)-VtsVT(ind11+1,2)); % Valley amplitude %
                    subj(I).hg(H,18) = S(I).h(hamp(ha),18);
                    S(I).h(hamp(ha) + 1,18) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                    S(I).h(hamp(ha) + 2,18) = VtsVT(ind11+1,1);   % 2 has the End Time of HG %
                    S(I).h(hamp(ha) + 3,18) = err11;   % This is useful when Automatic Scoring software is used!!%
                else
                    S(I).h(hamp(ha),18) = 0; % Valley amplitude %
                    subj(I).hg(H,18) = S(I).h(hamp(ha),18);
                    S(I).h(hamp(ha) + 1,18) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                    S(I).h(hamp(ha) + 2,18) = SEtsPS(H,2);   % 2 has the End Time of HG %
                    S(I).h(hamp(ha) + 3,18) = err11;   % This is useful when Automatic Scoring software is used!!%
                end
                    
                %S(I).h(hamp(ha),19) = abs(VtsVT(ind11,2)-VtsVT(ind11-1,2)); % Valley amplitude %
                S(I).h(hamp(ha),19) = (VtsVT(ind11,2)-VtsVT(ind11-1,2)); % Valley amplitude %
                subj(I).hg(H,19) = S(I).h(hamp(ha),19);
                S(I).h(hamp(ha) + 1,19) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,19) = VtsVT(ind11-1,1);   % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,19) = err11;   % This is useful when Automatic Scoring software is used!!%
            else
                S(I).h(hamp(ha),11) = 0; % amplitude %
                subj(I).hg(H,11) = S(I).h(hamp(ha),11);
                S(I).h(hamp(ha) + 1,11) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,11) = SEtsPS(H,2);   % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,11) = err11;  % This is useful when Automatic Scoring software is used!!%
                
                S(I).h(hamp(ha),18) = 0; % amplitude %
                subj(I).hg(H,18) = S(I).h(hamp(ha),18);
                S(I).h(hamp(ha) + 1,18) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,18) = SEtsPS(H,2);   % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,18) = err11;  % This is useful when Automatic Scoring software is used!!%
                
                S(I).h(hamp(ha),19) = 0; % amplitude %
                subj(I).hg(H,19) = S(I).h(hamp(ha),19);
                S(I).h(hamp(ha) + 1,19) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,19) = SEtsPS(H,2);   % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,19) = err11;  % This is useful when Automatic Scoring software is used!!%
            end
            
            % ************ PARA # 13 # 22 # 23 ************ %
            ind13 = find(S(I).h(hamp(ha) + 2,6) <= LvAS & LvAS <= S(I).h(hamp(ha) + 2,6) + 25,1);  %% time location of valley after peak of AS signal
            err13 = isempty(ind13); %% These error variables play an important role!! To help to extract other features
            if(err13 == 0)
                S(I).h(hamp(ha),13) = VtsAS(ind13,2); % Valley amplitude %
                subj(I).hg(H,13) = S(I).h(hamp(ha),13);
                S(I).h(hamp(ha) + 1,13) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,13) = VtsAS(ind13,1);  % 2 has the occurence of Valley
                S(I).h(hamp(ha) + 3,13) = err13;   % Error %
                
                if(ind13+1 ~= length(VtsAS)+1)
                    %S(I).h(hamp(ha),22) = abs(VtsAS(ind13,2) - VtsAS(ind13+1,2)); % Valley amplitude %
                    S(I).h(hamp(ha),22) = (VtsAS(ind13,2) - VtsAS(ind13+1,2)); % Valley amplitude %
                    subj(I).hg(H,22) = S(I).h(hamp(ha),22);
                    S(I).h(hamp(ha) + 1,22) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                    S(I).h(hamp(ha) + 2,22) = VtsAS(ind13+1,1);  % 2 has the occurence of Valley
                    S(I).h(hamp(ha) + 3,22) = err13;   % Error %
                else
                    S(I).h(hamp(ha),22) = 0; % Valley amplitude %
                    subj(I).hg(H,22) = S(I).h(hamp(ha),22);
                    S(I).h(hamp(ha) + 1,22) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                    S(I).h(hamp(ha) + 2,22) = SEtsPS(H,1);  % 2 has the occurence of Valley
                    S(I).h(hamp(ha) + 3,22) = err13;   % Error %
                end
                
                %S(I).h(hamp(ha),23) = abs(VtsAS(ind13,2) - VtsAS(ind13-1,2)); % Valley amplitude %
                S(I).h(hamp(ha),23) = (VtsAS(ind13,2) - VtsAS(ind13-1,2)); % Valley amplitude %
                subj(I).hg(H,23) = S(I).h(hamp(ha),23);
                S(I).h(hamp(ha) + 1,23) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,23) = VtsAS(ind13-1,1);  % 2 has the occurence of Valley
                S(I).h(hamp(ha) + 3,23) = err13;   % Error %
            else
                S(I).h(hamp(ha),13) = 0; % amplitude %
                subj(I).hg(H,13) = S(I).h(hamp(ha),13);
                S(I).h(hamp(ha) + 1,13) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,13) = SEtsPS(H,2);   % 2 has the END Time of HG %
                S(I).h(hamp(ha) + 3,13) = err13;  %% These error variables play an important role!! To help to extract other features
                
                S(I).h(hamp(ha),22) = 0; % amplitude %
                subj(I).hg(H,22) = S(I).h(hamp(ha),22);
                S(I).h(hamp(ha) + 1,22) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,22) = SEtsPS(H,2);   % 2 has the END Time of HG %
                S(I).h(hamp(ha) + 3,22) = err13;  %% These error variables play an important role!! To help to extract other features
                
                S(I).h(hamp(ha),23) = 0; % amplitude %
                subj(I).hg(H,23) = S(I).h(hamp(ha),23);
                S(I).h(hamp(ha) + 1,23) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,23) = SEtsPS(H,2);   % 2 has the END Time of HG %
                S(I).h(hamp(ha) + 3,23) = err13;  %% These error variables play an important role!! To help to extract other features
            end
            
            % ************* PARA # 12 # 25 *********** %
            ind12 = find(S(I).h(hamp(ha) + 2,11) <= tsintZVT & tsintZVT <= S(I).h(hamp(ha) + 2,11) + 25,1);
            err12 = isempty(ind12); %% These error variables play an important role!! To help to extract other features too
            if(err12 == 0)
                S(I).h(hamp(ha),12) = tsintZVT(ind12) - S(I).h(hamp(ha)+2,11); % amplitude %
                subj(I).hg(H,12) = S(I).h(hamp(ha),12);
                S(I).h(hamp(ha) + 1,12) = S(I).h(hamp(ha)+2,11);   % Start Time %
                S(I).h(hamp(ha) + 2,12) = tsintZVT(ind12);   % End Time %
                S(I).h(hamp(ha) + 3,12) = err13;   % Error %
                
                e1 = tsintZVT(ind12-1);e2 = tsintZVT(ind12);
                index25 = find(e1 <= VTts(:,1) & VTts(:,1) <= e2);
                L2_1 = norm(VTts(index25,2));
                L2_2 = 0;
                if(ind12 ~= length(tsintZVT) && ind12+1 ~= length(tsintZVT))
                    e1 = tsintZVT(ind12+1);e2 = tsintZVT(ind12+2);
                    index25 = find(e1 <= VTts(:,1) & VTts(:,1) <= e2);
                    L2_2 = norm(VTts(index25,2));
                    
                    S(I).h(hamp(ha),25) = L2_1 - L2_2; % amplitude %
                    subj(I).hg(H,25) = S(I).h(hamp(ha),25);
                    S(I).h(hamp(ha) + 1,25) = tsintZVT(ind12+1);   % Start Time %
                    S(I).h(hamp(ha) + 2,25) = tsintZVT(ind12+2);   % End Time %
                    S(I).h(hamp(ha) + 3,25) = err13;   % Error %
                else
                    S(I).h(hamp(ha),25) = 0; % amplitude %
                    subj(I).hg(H,25) = S(I).h(hamp(ha),25);
                    S(I).h(hamp(ha) + 1,25) = SEtsPS(H,1);   % Start Time %
                    S(I).h(hamp(ha) + 2,25) = SEtsPS(H,1);   % End Time %
                    S(I).h(hamp(ha) + 3,25) = err13;   % Error %
                end
                    
            else
                S(I).h(hamp(ha),12) = 0; % amplitude %
                subj(I).hg(H,12) = S(I).h(hamp(ha),12);
                S(I).h(hamp(ha) + 1,12) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,12) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,12) = err12;   % Error %
                
                S(I).h(hamp(ha),25) = 0; % amplitude %
                subj(I).hg(H,25) = S(I).h(hamp(ha),25);
                S(I).h(hamp(ha) + 1,25) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,25) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,25) = err13;   % Error %
            end
            
            % ************** PARA # 09 ************ %
            ind9a = find(S(I).h(hamp(ha)+2,6) <= tsintthp10AS & tsintthp10AS <= S(I).h(hamp(ha)+2,6) + 25,1);
            err9a = isempty(ind9a);            
            if(err9a == 0)
                ind9b = find(S(I).h(hamp(ha)+2,6) <= tsintthm10AS & tsintthm10AS <= S(I).h(hamp(ha)+2,6) + 25,1);
                err9b = isempty(ind9b);
                if(err9b == 0)
                    S(I).h(hamp(ha),9) = tsintthm10AS(ind9b) - tsintthp10AS(ind9a);
                    subj(I).hg(H,9) = S(I).h(hamp(ha),9);
                    S(I).h(hamp(ha)+ 1,9) = tsintthp10AS(ind9a);
                    S(I).h(hamp(ha)+ 2,9) = tsintthm10AS(ind9b);
                    S(I).h(hamp(ha)+ 3,9) = err9a + err9b;
                else
                    S(I).h(hamp(ha),9) = 0;
                    subj(I).hg(H,9) = S(I).h(hamp(ha),9);
                    S(I).h(hamp(ha)+ 1,9) = SEtsPS(H,1);
                    S(I).h(hamp(ha)+ 2,9) = SEtsPS(H,2);
                    S(I).h(hamp(ha)+ 3,9) = err9a;
                end
            else
                S(I).h(hamp(ha),9) = 0;
                subj(I).hg(H,9) = S(I).h(hamp(ha),9);
                S(I).h(hamp(ha)+ 1,9) = SEtsPS(H,1);
                S(I).h(hamp(ha)+ 2,9) = SEtsPS(H,2);
                S(I).h(hamp(ha)+ 3,9) = err9a;
            end
            
            % ************* PARA # 10 # 24 ************* %
            ind10 = find(S(I).h(hamp(ha)+2,9) <= tsintZAS & tsintZAS >= S(I).h(hamp(ha)+2,9),1);
            err10 = isempty(ind10);
            if(err10 == 0)
                S(I).h(hamp(ha),10) = tsintZAS(ind10) - S(I).h(hamp(ha)+2,9);
                subj(I).hg(H,10) = S(I).h(hamp(ha),10);
                S(I).h(hamp(ha)+1,10) = S(I).h(hamp(ha)+2,9);
                S(I).h(hamp(ha)+2,10) = tsintZAS(ind10);
                S(I).h(hamp(ha)+3,10) = err10;
                
                index24 = find(S(I).h(hamp(ha)+2,9) <= ASts(:,1) & ASts(:,1) <= tsintZAS(ind10)); 
                L2_1 = norm(ASts(index24,2));L2_2 = 0;
                if(ind10 ~= length(tsintZAS) && (ind10+1) ~= length(tsintZAS))
                    zas1 = tsintZAS(ind10+1);
                    zas2 = tsintZAS(ind10+2);
                    ind0241 = find(ASts(:,1) >= zas1,1);
                    ind0242 = find(ASts(:,1) >= zas2,1);
                    index24 = [];
                    index24 = find(ASts(ind0241,1) <=ASts(:,1) & ASts(:,1) <= ASts(ind0242,1));
                    L2_2 = 0;
                    L2_2 = norm(ASts(index24,2));
                    
                    S(I).h(hamp(ha),24) = L2_1 - L2_2;
                    subj(I).hg(H,24) = S(I).h(hamp(ha),24);
                    S(I).h(hamp(ha)+1,24) = tsintZAS(ind10+1);
                    S(I).h(hamp(ha)+2,24) = tsintZAS(ind10+2);
                    S(I).h(hamp(ha)+3,24) = err10;
                else
                    S(I).h(hamp(ha),24) = 0;
                    subj(I).hg(H,24) = S(I).h(hamp(ha),24);
                    S(I).h(hamp(ha)+1,24) = SEtsPS(H,1);
                    S(I).h(hamp(ha)+2,24) = SEtsPS(H,2);
                    S(I).h(hamp(ha)+3,24) = err10;
                end
            else
                S(I).h(hamp(ha),10) = 0;
                subj(I).hg(H,10) = S(I).h(hamp(ha),10);
                S(I).h(hamp(ha)+ 1,10) = SEtsPS(H,1);
                S(I).h(hamp(ha)+ 2,10) = SEtsPS(H,2);
                S(I).h(hamp(ha)+ 3,10) = err10;
                
                S(I).h(hamp(ha),24) = 0;
                subj(I).hg(H,24) = S(I).h(hamp(ha),24);
                S(I).h(hamp(ha)+1,24) = SEtsPS(H,1);
                S(I).h(hamp(ha)+2,24) = SEtsPS(H,1);
                S(I).h(hamp(ha)+3,24) = err10;
            end
            
            %**********  PARA # 02  ***************%
            S(I).h(hamp(ha),2) = S(I).h(hamp(ha)+2,6) - SEtsPS(H,1);
            subj(I).hg(H,2) = S(I).h(hamp(ha),2);
            S(I).h(hamp(ha)+ 1,2) = SEtsPS(H,1);
            S(I).h(hamp(ha)+ 2,2) = S(I).h(hamp(ha)+2,6);
            S(I).h(hamp(ha)+ 3,2) = 0;
            
            %**********  PARA # 08  ***************%
            S(I).h(hamp(ha),8) = S(I).h(hamp(ha)+2,9) - EtsPS(H);
            subj(I).hg(H,8) = S(I).h(hamp(ha),8);
            S(I).h(hamp(ha)+ 1,8) = EtsPS(H);
            S(I).h(hamp(ha)+ 2,8) = S(I).h(hamp(ha)+2,9);
            S(I).h(hamp(ha)+ 3,8) = err9b;
            
            %**********  PARA # 03  ***************%
            ind3 = find(SEtsPS(H,1) <= tsintthp10AS & tsintthp10AS <= S(I).h(hamp(ha)+2,6),1,'last');
            err3 = isempty(ind3);
            if(err3 == 0)
                S(I).h(hamp(ha),3) = tsintthp10AS(ind3) - SEtsPS(H,1);
                subj(I).hg(H,3) = S(I).h(hamp(ha),3);
                S(I).h(hamp(ha)+1,3) = SEtsPS(H,1);
                S(I).h(hamp(ha)+2,3) = tsintthp10AS(ind3);
                S(I).h(hamp(ha)+3,3) = err3;
            else
                S(I).h(hamp(ha),3) = 0;
                subj(I).hg(H,3) = S(I).h(hamp(ha),3);
                S(I).h(hamp(ha)+ 1,3) = SEtsPS(H,1);
                S(I).h(hamp(ha)+ 2,3) = SEtsPS(H,2);
                S(I).h(hamp(ha)+ 3,3) = err3;
            end
            
            %**********  PARA # 07  ***************%
            if(err3 == 0 && err9b == 0)
                S(I).h(hamp(ha),7) = tsintthm10AS(ind9b) - tsintthp10AS(ind3);
                subj(I).hg(H,7) = S(I).h(hamp(ha),7);
                S(I).h(hamp(ha)+1,7) = tsintthp10AS(ind3);
                S(I).h(hamp(ha)+2,7) = tsintthm10AS(ind9b);
                S(I).h(hamp(ha)+3,7) = err9b;
            else
                S(I).h(hamp(ha),7) = 0;
                subj(I).hg(H,7) = S(I).h(hamp(ha),7);
                S(I).h(hamp(ha)+1,7) = SEtsPS(H,1);
                S(I).h(hamp(ha)+2,7) = SEtsPS(H,2);
                S(I).h(hamp(ha)+3,7) = err9b;
            end
            
            %**********  PARA # 01  ***************%
            ind1a = find(SEtsPS(H,1) >= LvAS & LvAS >= SEtsPS(H,1) - 25,1,'last');
            err1a = isempty(ind1a);
            if(err1a == 0)
                ind1b = find(VtsAS(ind1a) >= tsintZAS & tsintZAS >= VtsAS(ind1a) - 25,1,'last');
                err1b = isempty(ind1b);
                if(err1b == 0)
                    S(I).h(hamp(ha),1) = SEtsPS(H,1) - tsintZAS(ind1b);
                    subj(I).hg(H,1) = S(I).h(hamp(ha),1);
                    S(I).h(hamp(ha)+1,1) = tsintZAS(ind1b);
                    S(I).h(hamp(ha)+2,1) = SEtsPS(H,1);
                    S(I).h(hamp(ha)+3,1) = err1b;
                else
                    S(I).h(hamp(ha),1) = 0;
                    subj(I).hg(H,1) = S(I).h(hamp(ha),1);
                    S(I).h(hamp(ha)+1,1) = SEtsPS(H,1);
                    S(I).h(hamp(ha)+2,1) = SEtsPS(H,2);
                    S(I).h(hamp(ha)+3,1) = err1a + err1b;
                end
            else
                S(I).h(hamp(ha),1) = 0;
                subj(I).hg(H,1) = S(I).h(hamp(ha),1);
                S(I).h(hamp(ha)+1,1) = SEtsPS(H,1);
                S(I).h(hamp(ha)+2,1) = SEtsPS(H,2);
                S(I).h(hamp(ha)+3,1) = err1a;
            end
            
        else%%% +++++++++++++Else statement for problem # 6 # 20 # 21+++++++++++++
            S(I).h(hamp(ha),6) = 0; % amplitude %
            subj(I).hg(H,6) = S(I).h(hamp(ha),6);
            S(I).h(hamp(ha) + 1,6) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,6) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,6) = err6;   % Error %
            
            S(I).h(hamp(ha),20) = 0; % amplitude %
            subj(I).hg(H,20) = S(I).h(hamp(ha),20);
            S(I).h(hamp(ha) + 1,20) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,20) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,20) = err6;   % Error %
            
            S(I).h(hamp(ha),21) = 0; % amplitude %
            subj(I).hg(H,21) = S(I).h(hamp(ha),21);
            S(I).h(hamp(ha) + 1,21) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,21) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,21) = err6;   % Error %
            
            %**********  PARA # 05 #16 #17 ***************% 
            ind51 = find(EtsPS(H) <= LpVT & LpVT <= EtsPS(H) + 25,1);
            err51 = isempty(ind51);
            if(err51 == 0)
                S(I).h(hamp(ha),5) = PtsVT(ind51,2); % amplitude %
                subj(I).hg(H,5) = S(I).h(hamp(ha),5);
                S(I).h(hamp(ha) + 1,5) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,5) = PtsVT(ind51,1);   % End Time %
                S(I).h(hamp(ha) + 3,5) = err5;   % Error %
                
                %S(I).h(hamp(ha),16) = abs(PtsVT(ind51,2)-PtsVT(ind51+1,2)); % amplitude %
                S(I).h(hamp(ha),16) = (PtsVT(ind51,2)-PtsVT(ind51+1,2)); % amplitude %
                subj(I).hg(H,16) = S(I).h(hamp(ha),16);
                S(I).h(hamp(ha) + 1,16) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,16) = PtsVT(ind51+1,1);   % End Time %
                S(I).h(hamp(ha) + 3,16) = err5;   % Error %
                
                %S(I).h(hamp(ha),17) = abs(PtsVT(ind51,2)-PtsVT(ind51-1,2)); % amplitude %
                S(I).h(hamp(ha),17) = (PtsVT(ind51,2)-PtsVT(ind51-1,2)); % amplitude %
                subj(I).hg(H,17) = S(I).h(hamp(ha),17);
                S(I).h(hamp(ha) + 1,17) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,17) = PtsVT(ind51-1,1);   % End Time %
                S(I).h(hamp(ha) + 3,17) = err5;   % Error %
            else
                S(I).h(hamp(ha),5) = 0; % amplitude %
                subj(I).hg(H,5) = S(I).h(hamp(ha),5);
                S(I).h(hamp(ha) + 1,5) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,5) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,5) = err5;   % Error %
                
                S(I).h(hamp(ha),16) = 0; % amplitude %
                subj(I).hg(H,16) = S(I).h(hamp(ha),16);
                S(I).h(hamp(ha) + 1,16) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,16) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,16) = err5;   % Error %
                
                S(I).h(hamp(ha),17) = 0; % amplitude %
                subj(I).hg(H,17) = S(I).h(hamp(ha),17);
                S(I).h(hamp(ha) + 1,17) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,17) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,17) = err5;   % Error %
            end
            
            %**********  PARA # 11 #18 #19 ***************%
            ind111 = find(EtsPS(H) <= LvVT & LvVT <= EtsPS(H) + 25,1);
            err111 = isempty(ind111);
            if(err111 == 0)
                S(I).h(hamp(ha),11) = VtsVT(ind111,2); % amplitude %
                subj(I).hg(H,11) = S(I).h(hamp(ha),11);
                S(I).h(hamp(ha) + 1,11) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,11) = VtsVT(ind111,1);   % End Time %
                S(I).h(hamp(ha) + 3,11) = err111;   % Error %
                
                %S(I).h(hamp(ha),18) = abs(VtsVT(ind111,2)-VtsVT(ind111+1,2)); % amplitude %
                S(I).h(hamp(ha),18) = (VtsVT(ind111,2)-VtsVT(ind111+1,2)); % amplitude %
                subj(I).hg(H,18) = S(I).h(hamp(ha),18);
                S(I).h(hamp(ha) + 1,18) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,18) = VtsVT(ind111+1,1);   % End Time %
                S(I).h(hamp(ha) + 3,18) = err111;   % Error %
                
                %S(I).h(hamp(ha),19) = abs(VtsVT(ind111,2)-VtsVT(ind111-1,2)); % amplitude %
                S(I).h(hamp(ha),19) = (VtsVT(ind111,2)-VtsVT(ind111-1,2)); % amplitude %
                subj(I).hg(H,19) = S(I).h(hamp(ha),19);
                S(I).h(hamp(ha) + 1,19) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,19) = VtsVT(ind111-1,1);   % End Time %
                S(I).h(hamp(ha) + 3,19) = err111;   % Error %
            else
                S(I).h(hamp(ha),11) = 0; % amplitude %
                subj(I).hg(H,11) = S(I).h(hamp(ha),11);
                S(I).h(hamp(ha) + 1,11) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,11) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,11) = err111;   % Error %
                
                S(I).h(hamp(ha),18) = 0; % amplitude %
                subj(I).hg(H,18) = S(I).h(hamp(ha),18);
                S(I).h(hamp(ha) + 1,18) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,18) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,18) = err111;   % Error %
                
                S(I).h(hamp(ha),19) = 0; % amplitude %
                subj(I).hg(H,19) = S(I).h(hamp(ha),19);
                S(I).h(hamp(ha) + 1,19) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,19) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,19) = err111;   % Error %
            end
            
            %**********  PARA # 13 # 22 # 23  ***************%
            ind131 = find(EtsPS(H) <= LvAS & LvAS <= EtsPS(H) + 25,1);
            err131 = isempty(ind131);
            if(err131 == 0 && ind131 <= length(VtsAS))
                S(I).h(hamp(ha),13) = VtsAS(ind131,2); % amplitude %
                subj(I).hg(H,13) = S(I).h(hamp(ha),13);
                S(I).h(hamp(ha) + 1,13) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,13) = VtsAS(ind131,1);   % End Time %
                S(I).h(hamp(ha) + 3,13) = err131;   % Error %
                
                if(ind131+1 ~= length(VtsAS)+1)
                    %S(I).h(hamp(ha),22) = abs(VtsAS(ind131,2)-VtsAS(ind131+1,2)); % amplitude %
                    S(I).h(hamp(ha),22) = (VtsAS(ind131,2)-VtsAS(ind131+1,2)); % amplitude %
                    subj(I).hg(H,22) = S(I).h(hamp(ha),22);
                    S(I).h(hamp(ha) + 1,22) = SEtsPS(H,1);   % Start Time %
                    S(I).h(hamp(ha) + 2,22) = VtsAS(ind131+1,1);   % End Time %
                    S(I).h(hamp(ha) + 3,22) = err131;   % Error %
                else
                    S(I).h(hamp(ha),22) = 0; % amplitude %
                    subj(I).hg(H,22) = S(I).h(hamp(ha),22);
                    S(I).h(hamp(ha) + 1,22) = SEtsPS(H,1);   % Start Time %
                    S(I).h(hamp(ha) + 2,22) = SEtsPS(H,2);   % End Time %
                    S(I).h(hamp(ha) + 3,22) = err131;   % Error %
                end
                
                %S(I).h(hamp(ha),23) = abs(VtsAS(ind131,2)-VtsAS(ind131-1,2)); % amplitude %
                S(I).h(hamp(ha),23) = (VtsAS(ind131,2)-VtsAS(ind131-1,2)); % amplitude %
                subj(I).hg(H,23) = S(I).h(hamp(ha),23);
                S(I).h(hamp(ha) + 1,23) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,23) = VtsAS(ind131-1,1);   % End Time %
                S(I).h(hamp(ha) + 3,23) = err131;   % Error %
            else
                S(I).h(hamp(ha),13) = 0; % amplitude %
                subj(I).hg(H,13) = S(I).h(hamp(ha),13);
                S(I).h(hamp(ha) + 1,13) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,13) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,13) = err131;   % Error %
                
                S(I).h(hamp(ha),22) = 0; % amplitude %
                subj(I).hg(H,22) = S(I).h(hamp(ha),22);
                S(I).h(hamp(ha) + 1,22) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,22) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,22) = err131;   % Error %
                
                S(I).h(hamp(ha),23) = 0; % amplitude %
                subj(I).hg(H,23) = S(I).h(hamp(ha),23);
                S(I).h(hamp(ha) + 1,23) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,23) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,23) = err131;   % Error %
            end
            
            %**********  PARA # 12 # 25 ***************%
            ind121 = find(EtsPS(H)+3 <= tsintZVT & tsintZVT <= EtsPS(H) + 25,1);
            err121 = isempty(ind121);
            if(err121 == 0)
                S(I).h(hamp(ha),12) = tsintZVT(ind121) - S(I).h(hamp(ha)+2,11); % amplitude %
                subj(I).hg(H,12) = S(I).h(hamp(ha),12);
                S(I).h(hamp(ha) + 1,12) = S(I).h(hamp(ha)+2,11);   % Start Time %
                S(I).h(hamp(ha) + 2,12) = tsintZVT(ind121);   % End Time %
                S(I).h(hamp(ha) + 3,12) = err121;   % Error %
                
                e1 = tsintZVT(ind121-1);e2 = tsintZVT(ind121);
                index25 = find(e1 <= VTts(:,1) & VTts(:,1) <= e2);
                L2_1 = norm(VTts(index25,2));
                L2_2 = 0;
                if(ind121 ~= length(tsintZVT) && ind121+1 ~= length(tsintZVT))
                    e1 = tsintZVT(ind121+1);e2 = tsintZVT(ind121+2);
                    index25 = find(e1 <= VTts(:,1) & VTts(:,1) <= e2);
                    L2_2 = norm(VTts(index25,2));
                    
                    S(I).h(hamp(ha),25) = L2_1 - L2_2; % amplitude %
                    subj(I).hg(H,25) = S(I).h(hamp(ha),25);
                    S(I).h(hamp(ha) + 1,25) = tsintZVT(ind12+1);   % Start Time %
                    S(I).h(hamp(ha) + 2,25) = tsintZVT(ind12+2);   % End Time %
                    S(I).h(hamp(ha) + 3,25) = err13;   % Error %
                else
                    S(I).h(hamp(ha),25) = 0; % amplitude %
                    subj(I).hg(H,25) = S(I).h(hamp(ha),25);
                    S(I).h(hamp(ha) + 1,25) = SEtsPS(H,1);   % Start Time %
                    S(I).h(hamp(ha) + 2,25) = SEtsPS(H,2);   % End Time %
                    S(I).h(hamp(ha) + 3,25) = err13;   % Error %
                end
            else
                S(I).h(hamp(ha),12) = 0; % amplitude %
                subj(I).hg(H,12) = S(I).h(hamp(ha),12);
                S(I).h(hamp(ha) + 1,12) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,12) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,12) = err121;   % Error %
                
                S(I).h(hamp(ha),25) = 0; % amplitude %
                subj(I).hg(H,25) = S(I).h(hamp(ha),25);
                S(I).h(hamp(ha) + 1,25) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,25) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,25) = err121;   % Error %
            end
            
            %**********  PARA # 09  ***************%
            ind9a1 = find(EtsPS(H) <= tsintthp10AS & tsintthp10AS <= EtsPS(H) + 25,1);
            err9a1 = isempty(ind9a1);           
            if(err9a1 == 0)
                ind9b1 = find(EtsPS(H) <= tsintthm10AS & tsintthm10AS <= EtsPS(H) + 25,1);
                err9b1 = isempty(ind9b1);
                if(err9b1 == 0)
                    S(I).h(hamp(ha),9) = tsintthm10AS(ind9b1) - tsintthp10AS(ind9a1);
                    subj(I).hg(H,9) = S(I).h(hamp(ha),9);
                    S(I).h(hamp(ha)+ 1,9) = tsintthp10AS(ind9a1);
                    S(I).h(hamp(ha)+ 2,9) = tsintthm10AS(ind9b1);
                    S(I).h(hamp(ha)+ 3,9) = err9a1 + err9b1;
                else
                    S(I).h(hamp(ha),9) = 0;
                    subj(I).hg(H,9) = S(I).h(hamp(ha),9);
                    S(I).h(hamp(ha)+ 1,9) = SEtsPS(H,1);
                    S(I).h(hamp(ha)+ 2,9) = SEtsPS(H,2);
                    S(I).h(hamp(ha)+ 3,9) = err9a1 + err9b1;
                end
            else
                err9b1 = 1;
                S(I).h(hamp(ha),9) = 0;
                subj(I).hg(H,9) = S(I).h(hamp(ha),9);
                S(I).h(hamp(ha)+ 1,9) = SEtsPS(H,1);
                S(I).h(hamp(ha)+ 2,9) = SEtsPS(H,2);
                S(I).h(hamp(ha)+ 3,9) = err9a1;
            end
            
            %**********  PARA # 10 #24 ***************%
            ind101 = find(EtsPS(H)+2 <= tsintZAS & tsintZAS <= EtsPS(H)+25,1);
            err101 = isempty(ind101);
            if(err101 == 0)
                S(I).h(hamp(ha),10) = tsintZAS(ind101) - S(I).h(hamp(ha)+2,9);
                subj(I).hg(H,10) = S(I).h(hamp(ha),10);
                S(I).h(hamp(ha)+1,10) = S(I).h(hamp(ha)+2,9);
                S(I).h(hamp(ha)+2,10) = tsintZAS(ind101);
                S(I).h(hamp(ha)+3,10) = err101;
                
                index24 = find(S(I).h(hamp(ha)+2,9) <= ASts(:,1) & ASts(:,1) <= tsintZAS(ind10)); 
                L2_1 = norm(ASts(index24,2));
                L2_2 = 0;index24 = [];
                if(ind10 ~= length(tsintZAS) && (ind10+1) ~= length(tsintZAS))
                    zas1 = tsintZAS(ind10+1);
                    zas2 = tsintZAS(ind10+2);
                    ind0241 = find(ASts(:,1) == zas1);
                    ind0242 = find(ASts(:,1) == zas2);
                    index24 = find(ind0241 <=ASts(:,1) & ASts(:,1) <= ind0242);
                    L2_2 = 0;
                    L2_2 = norm(ASts(index24,2));
                    
                    S(I).h(hamp(ha),24) = L2_1 - L2_2;
                    subj(I).hg(H,24) = S(I).h(hamp(ha),24);
                    S(I).h(hamp(ha)+1,24) = tsintZAS(ind10+1);
                    S(I).h(hamp(ha)+2,24) = tsintZAS(ind10+2);
                    S(I).h(hamp(ha)+3,24) = err10;
                else
                    S(I).h(hamp(ha),24) = 0;
                    subj(I).hg(H,24) = S(I).h(hamp(ha),24);
                    S(I).h(hamp(ha)+1,24) = SEtsPS(H,1);
                    S(I).h(hamp(ha)+2,24) = SEtsPS(H,2);
                    S(I).h(hamp(ha)+3,24) = err10;
                end
            else
                S(I).h(hamp(ha),10) = 0;
                subj(I).hg(H,10) = S(I).h(hamp(ha),10);
                S(I).h(hamp(ha)+ 1,10) = SEtsPS(H,1);
                S(I).h(hamp(ha)+ 2,10) = SEtsPS(H,2);
                S(I).h(hamp(ha)+ 3,10) = err10;
                
                S(I).h(hamp(ha),24) = 0;
                subj(I).hg(H,24) = S(I).h(hamp(ha),24);
                S(I).h(hamp(ha)+ 1,24) = SEtsPS(H,1);
                S(I).h(hamp(ha)+ 2,24) = SEtsPS(H,2);
                S(I).h(hamp(ha)+ 3,24) = err10;
            end
            
            %**********  PARA # 02  ***************%
            S(I).h(hamp(ha),2) = S(I).h(hamp(ha)+2,6) - SEtsPS(H,1);
            subj(I).hg(H,2) = S(I).h(hamp(ha),2);
            S(I).h(hamp(ha)+ 1,2) = SEtsPS(H,1);
            S(I).h(hamp(ha)+ 2,2) = S(I).h(hamp(ha)+2,6);
            S(I).h(hamp(ha)+ 3,2) = err6;
            
            %**********  PARA # 08  ***************%
            S(I).h(hamp(ha),8) = S(I).h(hamp(ha)+2,9) - EtsPS(H);
            subj(I).hg(H,8) = S(I).h(hamp(ha),8);
            S(I).h(hamp(ha)+ 1,8) = EtsPS(H);
            S(I).h(hamp(ha)+ 2,8) = S(I).h(hamp(ha)+2,9);
            S(I).h(hamp(ha)+ 3,8) = err9b1;
            
            %**********  PARA # 03  ***************%
            ind31 = find(SEtsPS(H,1)+1 <= tsintthp10AS & tsintthp10AS <= S(I).h(hamp(ha)+2,6),1,'last');
            err31 = isempty(ind31);
            if(err31 == 0)
                S(I).h(hamp(ha),3) = tsintthp10AS(ind31) - SEtsPS(H,1);
                subj(I).hg(H,3) = S(I).h(hamp(ha),3);
                S(I).h(hamp(ha)+1,3) = SEtsPS(H,1);
                S(I).h(hamp(ha)+2,3) = tsintthp10AS(ind31);
                S(I).h(hamp(ha)+3,3) = err31;
            else
                S(I).h(hamp(ha),3) = 0;
                subj(I).hg(H,3) = S(I).h(hamp(ha),3);
                S(I).h(hamp(ha)+ 1,3) = SEtsPS(H,1);
                S(I).h(hamp(ha)+ 2,3) = SEtsPS(H,2);
                S(I).h(hamp(ha)+ 3,3) = err31;
            end
            
            %**********  PARA # 07  ***************%
            if(err31 == 0 && err9b1 == 0)
                S(I).h(hamp(ha),7) = tsintthm10AS(ind9b1) - tsintthp10AS(ind31);
                subj(I).hg(H,7) = S(I).h(hamp(ha),7);
                S(I).h(hamp(ha)+1,7) = tsintthp10AS(ind31);
                S(I).h(hamp(ha)+2,7) = tsintthm10AS(ind9b1);
                S(I).h(hamp(ha)+3,7) = err9b1;
            else
                S(I).h(hamp(ha),7) = 0;
                subj(I).hg(H,7) = S(I).h(hamp(ha),7);
                S(I).h(hamp(ha)+1,7) = SEtsPS(H,1);
                S(I).h(hamp(ha)+2,7) = SEtsPS(H,2);
                S(I).h(hamp(ha)+3,7) = err9b1;
            end
            
            %**********  PARA # 01  ***************%
            ind1a1 = find(SEtsPS(H,1) >= LvAS & LvAS >= SEtsPS(H,1) - 25,1,'last');
            err1a1 = isempty(ind1a1);
            if(err1a1 == 0)
                ind1b1 = find(VtsAS(ind1a1) >= tsintZAS & tsintZAS >= VtsAS(ind1a1) - 25,1,'last');
                err1b1 = isempty(ind1b1);
                if(err1b1 == 0)
                    S(I).h(hamp(ha),1) = SEtsPS(H,1) - tsintZAS(ind1b1);
                    subj(I).hg(H,1) = S(I).h(hamp(ha),1);
                    S(I).h(hamp(ha)+1,1) = tsintZAS(ind1b1);
                    S(I).h(hamp(ha)+2,1) = SEtsPS(H,1);
                    S(I).h(hamp(ha)+3,1) = err1b1;
                else
                    S(I).h(hamp(ha),1) = 0;
                    subj(I).hg(H,1) = S(I).h(hamp(ha),1);
                    S(I).h(hamp(ha)+1,1) = SEtsPS(H,1);
                    S(I).h(hamp(ha)+2,1) = SEtsPS(H,2);
                    S(I).h(hamp(ha)+3,1) = err1a1+err1b1;
                end
            else
                S(I).h(hamp(ha),1) = 0;
                subj(I).hg(H,1) = S(I).h(hamp(ha),1);
                S(I).h(hamp(ha)+1,1) = SEtsPS(H,1);
                S(I).h(hamp(ha)+2,1) = SEtsPS(H,2);
                S(I).h(hamp(ha)+3,1) = err1a1;
            end
                        
        end%%%end for Paramter 6 problem
        Subj_nsa(I).L(H,1) = -1; %<==================== Label Assignment %%
%         plot([S(I).h(hamp(ha) + 1,1) S(I).h(hamp(ha) + 2,1)],[0.2 0.2],'-k');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,2) S(I).h(hamp(ha) + 2,2)],[0.4 0.4],'-g');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,3) S(I).h(hamp(ha) + 2,3)],[0.2 0.2],'-y');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,4) S(I).h(hamp(ha) + 2,4)],[0.7 0.7],'-k');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,5) S(I).h(hamp(ha) + 2,5)],[S(I).h(hamp(ha),5) S(I).h(hamp(ha),5)],'-.m');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,6) S(I).h(hamp(ha) + 2,6)],[S(I).h(hamp(ha),6) S(I).h(hamp(ha),6)],'-.k');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,7) S(I).h(hamp(ha) + 2,7)],[0.17 0.17],'--y');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,8) S(I).h(hamp(ha) + 2,8)],[0.1 0.1],'-r');grid on; hold on; %===Plot===%       
%         plot([S(I).h(hamp(ha) + 1,9) S(I).h(hamp(ha) + 2,9)],[0.02 0.02],'-g');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,10) S(I).h(hamp(ha) + 2,10)],[0.28 0.28],'-g');grid on; hold on; %===Plot===%        
%         plot([S(I).h(hamp(ha) + 1,11) S(I).h(hamp(ha) + 2,11)],[S(I).h(hamp(ha),11) S(I).h(hamp(ha),11)],'-.m');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,12) S(I).h(hamp(ha) + 2,12)],[0 0],'-y');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,13) S(I).h(hamp(ha) + 2,13)],[S(I).h(hamp(ha),13) S(I).h(hamp(ha),13)],'-.m');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,14) S(I).h(hamp(ha) + 2,14)],[mean14 mean14],'pm');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,15) mean([S(I).h(hamp(ha) + 1,15),S(I).h(hamp(ha) + 2,15)]) S(I).h(hamp(ha) + 2,15)],[para15 para15 para15],'*b');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,16) S(I).h(hamp(ha) + 2,16)],[0.4 0.4],'pg');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,17) S(I).h(hamp(ha) + 2,17)],[0.45 0.45],'pk');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,18) S(I).h(hamp(ha) + 2,18)],[-0.14 -0.14],'pg');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,19) S(I).h(hamp(ha) + 2,19)],[-0.145 -0.145],'pk');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,20) S(I).h(hamp(ha) + 2,20)],[0.50 0.50],'hr');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,21) S(I).h(hamp(ha) + 2,21)],[0.55 0.55],'hy');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,22) S(I).h(hamp(ha) + 2,22)],[-0.15 -0.15],'*m');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,23) S(I).h(hamp(ha) + 2,23)],[-0.155 -0.155],'*c');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,24) S(I).h(hamp(ha) + 2,24)],[0.255 0.255],'-k');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,25) S(I).h(hamp(ha) + 2,25)],[0.355 0.355],'-r');grid on; hold on; %===Plot===%
        H  = H + 1;
        ha = ha + 1;
        %oo = input('\nType 10 and press enter to continue:');
        
    end
    %hold off;
    EMPTY_CHK = isempty(subj(I).hg);
    disp(EMPTY_CHK);
    %oo = input('\n End of HGs, Type 10 and press enter to delete plot:');
  H= 1;ha = 1;gca;clf;  
I = I + 1;    
    
end%%While loop end
