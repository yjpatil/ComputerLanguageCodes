%***********************************************************************%
%                          Buffalo                                      %
%  April,15 2012 Friday To test on Buffalo data using 25 features       %
%                                                                       %
%***********************************************************************%

%   Note: Paulo has already normalized data   %
clc; clear all; close all;

load 'DATA_PACT_108.mat'
sf = 101.73;
Data = Signals;
L = length(Data);

%%%********* SENSORS signals
ts = Signals(:,1);        % time-stamps with proper offset values
AB = Signals(:,2);        % Normalized VT signals with pre-processing applied
RC = Signals(:,3);        % Normalized AS signals with pre-processing applied
PS = Signals(:,5);        % Proximity Signal normalised, thresholded, eliminated SD and LD signals
%proximity_square = Signals(:,5); % Rectify proximity signal to high '1' and low '0' above 5% of amplitude
%%%*********************

%PS = Data(:,2); PS = PS/(max(PS));  %% Not need to normalize         %% <----Dont need this step if you are using Paulos data
%PS = merge_function(PS,ts,0.046,0.5,8,1.2);
%Index = find(PS >= 0.046);

I = 1;

hamp = 1:4:20000; ha = 1;    % indices for the structure %


figure(1)  % Common Figure for all plots %
%plot(ts,PS,'-r');grid on; hold on;
% *********************************************************************** %
% The folowing part checks if there are incomplete HG's in the PS signals %
% *********************************************************************** %
dat = PS;    % dat contains the PS signal
flag = 1;
while(flag == 1)
    if(dat(1) == 1)
        i = 1; temp = 1;
        while(temp ~= 0)
            temp = dat(i);
            dat(i) = 0;
            i = i + 1;
        end
        flag = 0;
    else
        flag = 0;
    end
end

flag = 1;
while(flag == 1)
    if(dat(length(dat)) == 1)
        i = length(dat); temp = 1;
        while(temp ~= 0)
            temp = dat(i);
            dat(i) = 0;
            i = i - 1;
        end
        flag = 0;
    else
        flag = 0;
    end
end

PS = dat;   % assigning back PS signals to variable PS %
plot(ts,PS,'-k');grid on; hold on;
O = ones(size(puff_score,1));
plot(puff_score(:,1),O,'*y');
% *********************************************************************** %

RC = RC/max(RC); AB = AB/max(AB);    %% <----Dont need this step if you are using Paulos data

VT = (AB + RC)/2; VT = VT - mean(VT);                                %% <----Dont need this step if you are using Paulos data
VT = -1 * VT; VT = VT + mean(VT);                                    %% <----Dont need this step if you are using Paulos data

VT = idealfilter(VT,0.1,1000,sf); VT = fastsmooth(VT,25,1,0);        %% <----Dont need this step if you are using Paulos data

AS = diff(VT)./diff(ts); AS = [AS;0]; AS = fastsmooth(AS,45,1,0);    %% <----Dont need this step if you are using Paulos data

% ============================================================================ %
ASts = [ts AS];  % time stamps in 1st Column and Amplitude of AS in 2nd Column %
VTts = [ts VT];  % time stamps in 1st Column and Amplitude of VT in 2nd Column %
% ============================================================================ %

% ======================================================================= %
% In the following steps you find the peaks & valleys of AS and VT signals
% ======================================================================= %
[LpVT,MpVT] = peakfinder(VT,0.0099,-0.02,1);
LpVT = VTts(LpVT,1);

[LvVT,MvVT] = peakfinder(VT,0.0099,0.02,-1);
LvVT = VTts(LvVT,1);

[LpAS,MpAS] = peakfinder(AS,0.0099,-0.02,1);
LpAS = ASts(LpAS,1);

[LvAS,MvAS] = peakfinder(AS,0.0099,0.02,-1);
LvAS = ASts(LvAS,1);
% ======================================================================= %
% =============== PLOTS ======================= %
plot(ts,AS,'b');hold on; grid on;     % AS signal %
plot(LpAS,MpAS,'+m');grid on;hold on; % Peaks for AS signal %
plot(LvAS,MvAS,'+c');grid on;hold on; % Valleys for AS signal %
plot(ts,VT,'g');hold on; grid on;     % VT signal %
plot(LpVT,MpVT,'oc');grid on;hold on; % Peaks for VT signal %
plot(LvVT,MvVT,'oy');grid on;hold on; % Valleys for VT signal %
% ============================================ %

% This is the part where the Number of HG's are found %
% Matrix 'SEtsPS' contians the start and ends of HG's and 'EtsPS' only ends
[inttsPS,y111] = intersections(ts,PS,[0 ts(length(ts),1)],[0.1 0.1],1);
% length(y111);
% length(inttsPS);

SEtsPS(:,1) = inttsPS(1:2:(length(inttsPS)));  %START in Column 1 of SEtsPS
SEtsPS(:,2) = inttsPS(2:2:(length(inttsPS)));  %END in Column 2 of SEtsPS
EtsPS = SEtsPS(:,2);
%SEtsPS = cat(1,SORTtsPS1,SORTtsPS2); %% Contains time stamps for START && END of PS 
%EtsPS = cat(1,SORTtsPS1(:,2),SORTtsPS2(:,2));  %% Contains only time stamp for END of PS 

%*************  IMPORTANT MATRICES FOR VT SIGNALS **************%
PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 

%*************  IMPORTANT MATRICES FOR AS SIGNALS **************%
PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];

%+++++++++++++++ POSITIVE 10% MEDIAN THRESHOLD ++++++++++++++++++%
thp10 = 0.0075 * ( + 0.1); % The value 0.0075 is achieved by averaging from 20 subjects
[tsintthp10AS,ampintthp10AS] = intersections(ts,AS,[0 ts(length(ts),1)],[thp10 thp10],1);
%--------------- NEGATIVE 10% MEDIAN THRESHOLD ------------------%
thm10 = 0.0075 * ( - 0.1); % The value 0.0075 is achieved by averaging from 20 subjects
[tsintthm10AS,ampintthm10AS] = intersections(ts,AS,[0 ts(length(ts),1)],[thm10 thm10],1);

%============= INTERSECTION of ZERO line with VT ==============%
[tsintZVT,ampintZVT] = intersections(ts,VT,[0 ts(length(ts),1)],[1e-7 1e-7],1); 
%============= INTERSECTION of ZERO line with AS ==============%
[tsintZAS,ampintZAS] = intersections(ts,AS,[0 ts(length(ts),1)],[1e-7 1e-7],1); 

NHG = length(SEtsPS);fprintf('Number of Hand Gestures = %d',NHG);
I = 1; % Here I == 1,   since # of subjects is just 1
H = 1; % Initializing the HG count to 1. Later on it is incremented by 1 as H = H + 1 %
while(H <= length(SEtsPS))
    %         fprintf('\nThe hand gesture #:%d\n',H);
    %************  PARA # 4  *****************%
    S(I).h(hamp(ha),4) = SEtsPS(H,2) - SEtsPS(H,1);   % TIME Difference between the start and end of HG in structure****S.h*** %%
    subject(I).features(H,4) = S(I).h(hamp(ha),4);    % same value stored in****subject.features**** %%
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
    subject(I).features(H,14) = S(I).h(hamp(ha),14);   % mean-amplitude %
    S(I).h(hamp(ha) + 1,14) = SEtsPS(H,1);   % 1 has the Start Time of HG %
    S(I).h(hamp(ha) + 2,14) = SEtsPS(H,2);   % 2 has the End Time of HG %
    S(I).h(hamp(ha) + 3,14) = 0;   % This is useful when Automatic Scoring software is used!!%
    S(I).h(hamp(ha),15) = para15;
    subject(I).features(H,15) = S(I).h(hamp(ha),15);   % max-amplitude %
    S(I).h(hamp(ha) + 1,15) = SEtsPS(H,1);   % 1 has the Start Time of HG %
    S(I).h(hamp(ha) + 2,15) = SEtsPS(H,2);   % 2 has the End Time of HG %
    S(I).h(hamp(ha) + 3,15) = 0;   % This is useful when Automatic Scoring software is used!!%
    
    %**********  PARA # 6  # 20 # 21 ***************%  
    %FEATURE EXTRACTION Depends on this feature. So if this feature is
    %not present, future features can be extracted, irrespective to
    %this feature. So we have "if(err6 == 0) else "
    ind6 = find(EtsPS(H) - 0.25 <= LpAS & LpAS <= EtsPS(H) + 25,1);  %% Find TIME STAMPS for Amplitude PEAKS of AIRFLOW signal after end of HG%%
    err6 = isempty(ind6); %% These error variables play an important role!! To help to extract other features
    if(err6 == 0) %% the "end" and "else" for this "if" is in FFE_EXT_Part2
        S(I).h(hamp(ha),6) = PtsAS(ind6,2); % amplitude of AIRFLOW signal %
        subject(I).features(H,6) = S(I).h(hamp(ha),6);  % amplitude of AIRFLOW signal %
        S(I).h(hamp(ha) + 1,6) = SEtsPS(H,1);   % 1 has the Start Time of HG %
        S(I).h(hamp(ha) + 2,6) = PtsAS(ind6,1);   % 2 has the End Time of HG %
        S(I).h(hamp(ha) + 3,6) = err6;   % This is useful when Automatic Scoring software is used!!%
        
        if(ind6+1 ~= length(PtsAS)+1)
            %S(I).h(hamp(ha),20) = abs(PtsAS(ind6,2)-PtsAS(ind6+1,2));
            S(I).h(hamp(ha),20) = (PtsAS(ind6,2)-PtsAS(ind6+1,2));
            subject(I).features(H,20) = S(I).h(hamp(ha),20);  % amplitude of AIRFLOW signal %
            S(I).h(hamp(ha) + 1,20) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,20) = PtsAS(ind6+1,1);   % 2 has the End Time of HG %
            S(I).h(hamp(ha) + 3,20) = err6;   % This is useful when Automatic Scoring software is used!!%
        else
            S(I).h(hamp(ha),20) = 0;
            subject(I).features(H,20) = S(I).h(hamp(ha),20);  % amplitude of AIRFLOW signal %
            S(I).h(hamp(ha) + 1,20) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,20) = SEtsPS(H,2);   % 2 has the End Time of HG %
            S(I).h(hamp(ha) + 3,20) = err6;   % This is useful when Automatic Scoring software is used!!%
        end
        
        %S(I).h(hamp(ha),21) = abs(PtsAS(ind6,2)-PtsAS(ind6-1,2));
        S(I).h(hamp(ha),21) = (PtsAS(ind6,2)-PtsAS(ind6-1,2));
        subject(I).features(H,21) = S(I).h(hamp(ha),21);  % amplitude of AIRFLOW signal %
        S(I).h(hamp(ha) + 1,21) = SEtsPS(H,1);   % 1 has the Start Time of HG %
        S(I).h(hamp(ha) + 2,21) = PtsAS(ind6-1,1);   % 2 has the End Time of HG %
        S(I).h(hamp(ha) + 3,21) = err6;   % This is useful when Automatic Scoring software is used!!%
        
        %************ PARA # 5 # 16 #17 ************%
        ind5 = find(S(I).h(hamp(ha) + 2,6) <= LpVT & LpVT <= S(I).h(hamp(ha) + 2,6) + 25,1); %% Get the time location of peak of VT immediately
        err5 = isempty(ind5);   %% ... after peak of AIRFLOW signal
        if(err5 == 0) 
            S(I).h(hamp(ha),5) = PtsVT(ind5,2); % PEAK amplitude of VT signal %
            subject(I).features(H,5) = S(I).h(hamp(ha),5);  % PEAK amplitude of VT signal %
            S(I).h(hamp(ha) + 1,5) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,5) = PtsVT(ind5,1);  % 2 has the End Time of HG %
            S(I).h(hamp(ha) + 3,5) = err5;   % This is useful when Automatic Scoring software is used!!%
            
            if(ind5+1 ~= length(PtsVT)+1)
                %S(I).h(hamp(ha),16) = abs(PtsVT(ind5,2)-PtsVT(ind5+1,2)); % PEAK amplitude of VT signal %
                S(I).h(hamp(ha),16) = (PtsVT(ind5,2)-PtsVT(ind5+1,2)); % PEAK amplitude of VT signal %
                subject(I).features(H,16) = S(I).h(hamp(ha),16);  % PEAK amplitude of VT signal %
                S(I).h(hamp(ha) + 1,16) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,16) = PtsVT(ind5+1,1);  % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,16) = err5;   % This is useful when Automatic Scoring software is used!!%
            else
                S(I).h(hamp(ha),16) = 0; % PEAK amplitude of VT signal %
                subject(I).features(H,16) = S(I).h(hamp(ha),16);  % PEAK amplitude of VT signal %
                S(I).h(hamp(ha) + 1,16) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,16) = SEtsPS(H,2);  % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,16) = err5;   % This is useful when Automatic Scoring software is used!!%
            end
            
            if(ind5 ~= 1)
                %S(I).h(hamp(ha),17) = abs(PtsVT(ind5,2)-PtsVT(ind5-1,2)); % PEAK amplitude of VT signal %
                S(I).h(hamp(ha),17) = (PtsVT(ind5,2)-PtsVT(ind5-1,2)); % PEAK amplitude of VT signal %
                subject(I).features(H,17) = S(I).h(hamp(ha),17);  % PEAK amplitude of VT signal %
                S(I).h(hamp(ha) + 1,17) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,17) = PtsVT(ind5-1,1);  % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,17) = err5;   % This is useful when Automatic Scoring software is used!!%
            else
                S(I).h(hamp(ha),17) = 0; % PEAK amplitude of VT signal %
                subject(I).features(H,17) = S(I).h(hamp(ha),17);  % PEAK amplitude of VT signal %
                S(I).h(hamp(ha) + 1,17) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,17) = SEtsPS(H,2);  % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,17) = err5;   % This is useful when Automatic Scoring software is used!!%
            end
        else
            S(I).h(hamp(ha),5) = 0; % if the amplitude is not found its amplitude = ZERO %
            subject(I).features(H,5) = S(I).h(hamp(ha),5);
            S(I).h(hamp(ha) + 1,5) = SEtsPS(H,1);   % 1 has the Start Time of HG%
            S(I).h(hamp(ha) + 2,5) = SEtsPS(H,2);   % 2 has the End Time of HG%
            S(I).h(hamp(ha) + 3,5) = err5;   % This is useful when Automatic Scoring software is used!!%
            
            S(I).h(hamp(ha),16) = 0; % if the amplitude is not found its amplitude = ZERO %
            subject(I).features(H,16) = S(I).h(hamp(ha),16);
            S(I).h(hamp(ha) + 1,16) = SEtsPS(H,1);   % 1 has the Start Time of HG%
            S(I).h(hamp(ha) + 2,16) = SEtsPS(H,2);   % 2 has the End Time of HG%
            S(I).h(hamp(ha) + 3,16) = err5;   % This is useful when Automatic Scoring software is used!!%
            
            S(I).h(hamp(ha),17) = 0; % if the amplitude is not found its amplitude = ZERO %
            subject(I).features(H,17) = S(I).h(hamp(ha),17);
            S(I).h(hamp(ha) + 1,17) = SEtsPS(H,1);   % 1 has the Start Time of HG%
            S(I).h(hamp(ha) + 2,17) = SEtsPS(H,2);   % 2 has the End Time of HG%
            S(I).h(hamp(ha) + 3,17) = err5;   % This is useful when Automatic Scoring software is used!!%
        end
        
        % ************ PARA # 11 # 18 # 19 ************ %
        ind11 = find(S(I).h(hamp(ha) + 2,5) <= LvVT & LvVT <= S(I).h(hamp(ha) + 2,5) + 25,1); %% time location of valley after peak of VT signal
        err11 = isempty(ind11);   %% These error variables play an important role!! To help to extract other features
        if(err11 == 0)
            S(I).h(hamp(ha),11) = VtsVT(ind11,2); % Valley amplitude %
            subject(I).features(H,11) = S(I).h(hamp(ha),11);
            S(I).h(hamp(ha) + 1,11) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,11) = VtsVT(ind11,1);   % 2 has the End Time of HG %
            S(I).h(hamp(ha) + 3,11) = err11;   % This is useful when Automatic Scoring software is used!!%
            
            if(ind11+1 ~= length(VtsVT)+1)
                %S(I).h(hamp(ha),18) = abs(VtsVT(ind11,2)-VtsVT(ind11+1,2)); % Valley amplitude %
                S(I).h(hamp(ha),18) = (VtsVT(ind11,2)-VtsVT(ind11+1,2)); % Valley amplitude %
                subject(I).features(H,18) = S(I).h(hamp(ha),18);
                S(I).h(hamp(ha) + 1,18) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,18) = VtsVT(ind11+1,1);   % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,18) = err11;   % This is useful when Automatic Scoring software is used!!%
            else
                S(I).h(hamp(ha),18) = 0; % Valley amplitude %
                subject(I).features(H,18) = S(I).h(hamp(ha),18);
                S(I).h(hamp(ha) + 1,18) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,18) = SEtsPS(H,2);   % 2 has the End Time of HG %
                S(I).h(hamp(ha) + 3,18) = err11;   % This is useful when Automatic Scoring software is used!!%
            end
            
            %S(I).h(hamp(ha),19) = abs(VtsVT(ind11,2)-VtsVT(ind11-1,2)); % Valley amplitude %
            S(I).h(hamp(ha),19) = (VtsVT(ind11,2)-VtsVT(ind11-1,2)); % Valley amplitude %
            subject(I).features(H,19) = S(I).h(hamp(ha),19);
            S(I).h(hamp(ha) + 1,19) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,19) = VtsVT(ind11-1,1);   % 2 has the End Time of HG %
            S(I).h(hamp(ha) + 3,19) = err11;   % This is useful when Automatic Scoring software is used!!%
        else
            S(I).h(hamp(ha),11) = 0; % amplitude %
            subject(I).features(H,11) = S(I).h(hamp(ha),11);
            S(I).h(hamp(ha) + 1,11) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,11) = SEtsPS(H,2);   % 2 has the End Time of HG %
            S(I).h(hamp(ha) + 3,11) = err11;  % This is useful when Automatic Scoring software is used!!%
            
            
            S(I).h(hamp(ha),18) = 0; % amplitude %
            subject(I).features(H,18) = S(I).h(hamp(ha),18);
            S(I).h(hamp(ha) + 1,18) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,18) = SEtsPS(H,2);   % 2 has the End Time of HG %
            S(I).h(hamp(ha) + 3,18) = err11;  % This is useful when Automatic Scoring software is used!!%
            
            S(I).h(hamp(ha),19) = 0; % amplitude %
            subject(I).features(H,19) = S(I).h(hamp(ha),19);
            S(I).h(hamp(ha) + 1,19) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,19) = SEtsPS(H,2);   % 2 has the End Time of HG %
            S(I).h(hamp(ha) + 3,19) = err11;  % This is useful when Automatic Scoring software is used!!%
        end
        
        % ************ PARA # 13 # 22 # 23 ************ %
        ind13 = find(S(I).h(hamp(ha) + 2,6) <= LvAS & LvAS <= S(I).h(hamp(ha) + 2,6) + 25,1);  %% time location of valley after peak of AS signal
        err13 = isempty(ind13); %% These error variables play an important role!! To help to extract other features
        if(err13 == 0)
            S(I).h(hamp(ha),13) = VtsAS(ind13,2); % Valley amplitude %
            subject(I).features(H,13) = S(I).h(hamp(ha),13);
            S(I).h(hamp(ha) + 1,13) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,13) = VtsAS(ind13,1);  % 2 has the occurence of Valley
            S(I).h(hamp(ha) + 3,13) = err13;   % Error %
            
            if(ind13+1 ~= length(VtsAS)+1)
                %S(I).h(hamp(ha),22) = abs(VtsAS(ind13,2) - VtsAS(ind13+1,2)); % Valley amplitude %
                S(I).h(hamp(ha),22) = (VtsAS(ind13,2) - VtsAS(ind13+1,2)); % Valley amplitude %
                subject(I).features(H,22) = S(I).h(hamp(ha),22);
                S(I).h(hamp(ha) + 1,22) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,22) = VtsAS(ind13+1,1);  % 2 has the occurence of Valley
                S(I).h(hamp(ha) + 3,22) = err13;   % Error %
            else
                S(I).h(hamp(ha),22) = 0; % Valley amplitude %
                subject(I).features(H,22) = S(I).h(hamp(ha),22);
                S(I).h(hamp(ha) + 1,22) = SEtsPS(H,1);   % 1 has the Start Time of HG %
                S(I).h(hamp(ha) + 2,22) = SEtsPS(H,1);  % 2 has the occurence of Valley
                S(I).h(hamp(ha) + 3,22) = err13;   % Error %
            end
            
            %S(I).h(hamp(ha),23) = abs(VtsAS(ind13,2) - VtsAS(ind13-1,2)); % Valley amplitude %
            S(I).h(hamp(ha),23) = (VtsAS(ind13,2) - VtsAS(ind13-1,2)); % Valley amplitude %
            subject(I).features(H,23) = S(I).h(hamp(ha),23);
            S(I).h(hamp(ha) + 1,23) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,23) = VtsAS(ind13-1,1);  % 2 has the occurence of Valley
            S(I).h(hamp(ha) + 3,23) = err13;   % Error %
        else
            S(I).h(hamp(ha),13) = 0; % amplitude %
            subject(I).features(H,13) = S(I).h(hamp(ha),13);
            S(I).h(hamp(ha) + 1,13) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,13) = SEtsPS(H,2);   % 2 has the END Time of HG %
            S(I).h(hamp(ha) + 3,13) = err13;  %% These error variables play an important role!! To help to extract other features
            
            S(I).h(hamp(ha),22) = 0; % amplitude %
            subject(I).features(H,22) = S(I).h(hamp(ha),22);
            S(I).h(hamp(ha) + 1,22) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,22) = SEtsPS(H,2);   % 2 has the END Time of HG %
            S(I).h(hamp(ha) + 3,22) = err13;  %% These error variables play an important role!! To help to extract other features
            
            S(I).h(hamp(ha),23) = 0; % amplitude %
            subject(I).features(H,23) = S(I).h(hamp(ha),23);
            S(I).h(hamp(ha) + 1,23) = SEtsPS(H,1);   % 1 has the Start Time of HG %
            S(I).h(hamp(ha) + 2,23) = SEtsPS(H,2);   % 2 has the END Time of HG %
            S(I).h(hamp(ha) + 3,23) = err13;  %% These error variables play an important role!! To help to extract other features
        end
        
        % ************* PARA # 12 # 25 *********** %
        ind12 = find(S(I).h(hamp(ha) + 2,11) <= tsintZVT & tsintZVT <= S(I).h(hamp(ha) + 2,11) + 25,1);
        err12 = isempty(ind12); %% These error variables play an important role!! To help to extract other features too
        if(err12 == 0)
            S(I).h(hamp(ha),12) = tsintZVT(ind12) - S(I).h(hamp(ha)+2,11); % amplitude %
            subject(I).features(H,12) = S(I).h(hamp(ha),12);
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
                subject(I).features(H,25) = S(I).h(hamp(ha),25);
                S(I).h(hamp(ha) + 1,25) = tsintZVT(ind12+1);   % Start Time %
                S(I).h(hamp(ha) + 2,25) = tsintZVT(ind12+2);   % End Time %
                S(I).h(hamp(ha) + 3,25) = err13;   % Error %
            else
                S(I).h(hamp(ha),25) = 0; % amplitude %
                subject(I).features(H,25) = S(I).h(hamp(ha),25);
                S(I).h(hamp(ha) + 1,25) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,25) = SEtsPS(H,1);   % End Time %
                S(I).h(hamp(ha) + 3,25) = err13;   % Error %
            end
        else
            S(I).h(hamp(ha),12) = 0; % amplitude %
            subject(I).features(H,12) = S(I).h(hamp(ha),12);
            S(I).h(hamp(ha) + 1,12) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,12) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,12) = err12;   % Error %
            
            S(I).h(hamp(ha),25) = 0; % amplitude %
            subject(I).features(H,25) = S(I).h(hamp(ha),25);
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
                subject(I).features(H,9) = S(I).h(hamp(ha),9);
                S(I).h(hamp(ha)+ 1,9) = tsintthp10AS(ind9a);
                S(I).h(hamp(ha)+ 2,9) = tsintthm10AS(ind9b);
                S(I).h(hamp(ha)+ 3,9) = err9a + err9b;
            else
                S(I).h(hamp(ha),9) = 0;
                subject(I).features(H,9) = S(I).h(hamp(ha),9);
                S(I).h(hamp(ha)+ 1,9) = SEtsPS(H,1);
                S(I).h(hamp(ha)+ 2,9) = SEtsPS(H,2);
                S(I).h(hamp(ha)+ 3,9) = err9a;
            end
        else
            S(I).h(hamp(ha),9) = 0;
            subject(I).features(H,9) = S(I).h(hamp(ha),9);
            S(I).h(hamp(ha)+ 1,9) = SEtsPS(H,1);
            S(I).h(hamp(ha)+ 2,9) = SEtsPS(H,2);
            S(I).h(hamp(ha)+ 3,9) = err9a;
        end
        
        % ************* PARA # 10 # 24 ************* %
        ind10 = find(S(I).h(hamp(ha)+2,9) <= tsintZAS & tsintZAS >= S(I).h(hamp(ha)+2,9),1);
        err10 = isempty(ind10);
        if(err10 == 0)
            S(I).h(hamp(ha),10) = tsintZAS(ind10) - S(I).h(hamp(ha)+2,9);
            subject(I).features(H,10) = S(I).h(hamp(ha),10);
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
                subject(I).features(H,24) = S(I).h(hamp(ha),24);
                S(I).h(hamp(ha)+1,24) = tsintZAS(ind10+1);
                S(I).h(hamp(ha)+2,24) = tsintZAS(ind10+2);
                S(I).h(hamp(ha)+3,24) = err10;
            else
                S(I).h(hamp(ha),24) = 0;
                subject(I).features(H,24) = S(I).h(hamp(ha),24);
                S(I).h(hamp(ha)+1,24) = SEtsPS(H,1);
                S(I).h(hamp(ha)+2,24) = SEtsPS(H,2);
                S(I).h(hamp(ha)+3,24) = err10;
            end
        else
            S(I).h(hamp(ha),10) = 0;
            subject(I).features(H,10) = S(I).h(hamp(ha),10);
            S(I).h(hamp(ha)+ 1,10) = SEtsPS(H,1);
            S(I).h(hamp(ha)+ 2,10) = SEtsPS(H,2);
            S(I).h(hamp(ha)+ 3,10) = err10;
            
            S(I).h(hamp(ha),24) = 0;
            subject(I).features(H,24) = S(I).h(hamp(ha),24);
            S(I).h(hamp(ha)+1,24) = SEtsPS(H,1);
            S(I).h(hamp(ha)+2,24) = SEtsPS(H,1);
            S(I).h(hamp(ha)+3,24) = err10;
        end
        
        %**********  PARA # 02  ***************%
        S(I).h(hamp(ha),2) = S(I).h(hamp(ha)+2,6) - SEtsPS(H,1);
        subject(I).features(H,2) = S(I).h(hamp(ha),2);
        S(I).h(hamp(ha)+ 1,2) = SEtsPS(H,1);
        S(I).h(hamp(ha)+ 2,2) = S(I).h(hamp(ha)+2,6);
        S(I).h(hamp(ha)+ 3,2) = 0;
        
        %**********  PARA # 08  ***************%
        S(I).h(hamp(ha),8) = S(I).h(hamp(ha)+2,9) - EtsPS(H);
        subject(I).features(H,8) = S(I).h(hamp(ha),8);
        S(I).h(hamp(ha)+ 1,8) = EtsPS(H);
        S(I).h(hamp(ha)+ 2,8) = S(I).h(hamp(ha)+2,9);
        S(I).h(hamp(ha)+ 3,8) = err9b;
        
        %**********  PARA # 03  ***************%
        ind3 = find(SEtsPS(H,1) <= tsintthp10AS & tsintthp10AS <= S(I).h(hamp(ha)+2,6),1,'last');
        err3 = isempty(ind3);
        if(err3 == 0)
            S(I).h(hamp(ha),3) = tsintthp10AS(ind3) - SEtsPS(H,1);
            subject(I).features(H,3) = S(I).h(hamp(ha),3);
            S(I).h(hamp(ha)+1,3) = SEtsPS(H,1);
            S(I).h(hamp(ha)+2,3) = tsintthp10AS(ind3);
            S(I).h(hamp(ha)+3,3) = err3;
        else
            S(I).h(hamp(ha),3) = 0;
            subject(I).features(H,3) = S(I).h(hamp(ha),3);
            S(I).h(hamp(ha)+ 1,3) = SEtsPS(H,1);
            S(I).h(hamp(ha)+ 2,3) = SEtsPS(H,2);
            S(I).h(hamp(ha)+ 3,3) = err3;
        end
        
        %**********  PARA # 07  ***************%
        if(err3 == 0 && err9b == 0)
            S(I).h(hamp(ha),7) = tsintthm10AS(ind9b) - tsintthp10AS(ind3);
            subject(I).features(H,7) = S(I).h(hamp(ha),7);
            S(I).h(hamp(ha)+1,7) = tsintthp10AS(ind3);
            S(I).h(hamp(ha)+2,7) = tsintthm10AS(ind9b);
            S(I).h(hamp(ha)+3,7) = err9b;
        else
            S(I).h(hamp(ha),7) = 0;
            subject(I).features(H,7) = S(I).h(hamp(ha),7);
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
                subject(I).features(H,1) = S(I).h(hamp(ha),1);
                S(I).h(hamp(ha)+1,1) = tsintZAS(ind1b);
                S(I).h(hamp(ha)+2,1) = SEtsPS(H,1);
                S(I).h(hamp(ha)+3,1) = err1b;
            else
                S(I).h(hamp(ha),1) = 0;
                subject(I).features(H,1) = S(I).h(hamp(ha),1);
                S(I).h(hamp(ha)+1,1) = SEtsPS(H,1);
                S(I).h(hamp(ha)+2,1) = SEtsPS(H,2);
                S(I).h(hamp(ha)+3,1) = err1a + err1b;
            end
        else
            S(I).h(hamp(ha),1) = 0;
            subject(I).features(H,1) = S(I).h(hamp(ha),1);
            S(I).h(hamp(ha)+1,1) = SEtsPS(H,1);
            S(I).h(hamp(ha)+2,1) = SEtsPS(H,2);
            S(I).h(hamp(ha)+3,1) = err1a;
        end
        
    else%%% +++++++++++++Else statement for problem # 6 # 20 # 21+++++++++++++
        S(I).h(hamp(ha),6) = 0; % amplitude %
        subject(I).features(H,6) = S(I).h(hamp(ha),6);
        S(I).h(hamp(ha) + 1,6) = SEtsPS(H,1);   % Start Time %
        S(I).h(hamp(ha) + 2,6) = SEtsPS(H,2);   % End Time %
        S(I).h(hamp(ha) + 3,6) = err6;   % Error %
        
        S(I).h(hamp(ha),20) = 0; % amplitude %
        subject(I).features(H,20) = S(I).h(hamp(ha),20);
        S(I).h(hamp(ha) + 1,20) = SEtsPS(H,1);   % Start Time %
        S(I).h(hamp(ha) + 2,20) = SEtsPS(H,2);   % End Time %
        S(I).h(hamp(ha) + 3,20) = err6;   % Error %
        
        S(I).h(hamp(ha),21) = 0; % amplitude %
        subject(I).features(H,21) = S(I).h(hamp(ha),21);
        S(I).h(hamp(ha) + 1,21) = SEtsPS(H,1);   % Start Time %
        S(I).h(hamp(ha) + 2,21) = SEtsPS(H,2);   % End Time %
        S(I).h(hamp(ha) + 3,21) = err6;   % Error %
        
        %**********  PARA # 05 #16 #17 ***************% 
        ind51 = find(EtsPS(H) <= LpVT & LpVT <= EtsPS(H) + 25,1);
        err51 = isempty(ind51);
        if(err51 == 0)
            S(I).h(hamp(ha),5) = PtsVT(ind51,2); % amplitude %
            subject(I).features(H,5) = S(I).h(hamp(ha),5);
            S(I).h(hamp(ha) + 1,5) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,5) = PtsVT(ind51,1);   % End Time %
            S(I).h(hamp(ha) + 3,5) = err5;   % Error %
            
            %S(I).h(hamp(ha),16) = abs(PtsVT(ind51,2)-PtsVT(ind51+1,2)); % amplitude %
            S(I).h(hamp(ha),16) = (PtsVT(ind51,2)-PtsVT(ind51+1,2)); % amplitude %
            subject(I).features(H,16) = S(I).h(hamp(ha),16);
            S(I).h(hamp(ha) + 1,16) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,16) = PtsVT(ind51+1,1);   % End Time %
            S(I).h(hamp(ha) + 3,16) = err5;   % Error %
            
            %S(I).h(hamp(ha),17) = abs(PtsVT(ind51,2)-PtsVT(ind51-1,2)); % amplitude %
            S(I).h(hamp(ha),17) = (PtsVT(ind51,2)-PtsVT(ind51-1,2)); % amplitude %
            subject(I).features(H,17) = S(I).h(hamp(ha),17);
            S(I).h(hamp(ha) + 1,17) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,17) = PtsVT(ind51-1,1);   % End Time %
            S(I).h(hamp(ha) + 3,17) = err5;   % Error %
        else
            S(I).h(hamp(ha),5) = 0; % amplitude %
            subject(I).features(H,5) = S(I).h(hamp(ha),5);
            S(I).h(hamp(ha) + 1,5) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,5) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,5) = err5;   % Error %
            
            S(I).h(hamp(ha),16) = 0; % amplitude %
            subject(I).features(H,16) = S(I).h(hamp(ha),16);
            S(I).h(hamp(ha) + 1,16) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,16) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,16) = err5;   % Error %
            
            S(I).h(hamp(ha),17) = 0; % amplitude %
            subject(I).features(H,17) = S(I).h(hamp(ha),17);
            S(I).h(hamp(ha) + 1,17) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,17) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,17) = err5;   % Error %
        end
        
        %**********  PARA # 11 #18 #19 ***************%
        ind111 = find(EtsPS(H) <= LvVT & LvVT <= EtsPS(H) + 25,1);
        err111 = isempty(ind111);
        if(err111 == 0)
            S(I).h(hamp(ha),11) = VtsVT(ind111,2); % amplitude %
            subject(I).features(H,11) = S(I).h(hamp(ha),11);
            S(I).h(hamp(ha) + 1,11) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,11) = VtsVT(ind111,1);   % End Time %
            S(I).h(hamp(ha) + 3,11) = err111;   % Error %
            
            %S(I).h(hamp(ha),18) = abs(VtsVT(ind111,2)-VtsVT(ind111+1,2)); % amplitude %
            S(I).h(hamp(ha),18) = (VtsVT(ind111,2)-VtsVT(ind111+1,2)); % amplitude %
            subject(I).features(H,18) = S(I).h(hamp(ha),18);
            S(I).h(hamp(ha) + 1,18) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,18) = VtsVT(ind111+1,1);   % End Time %
            S(I).h(hamp(ha) + 3,18) = err111;   % Error %
            
            %S(I).h(hamp(ha),19) = abs(VtsVT(ind111,2)-VtsVT(ind111-1,2)); % amplitude %
            S(I).h(hamp(ha),19) = (VtsVT(ind111,2)-VtsVT(ind111-1,2)); % amplitude %
            subject(I).features(H,19) = S(I).h(hamp(ha),19);
            S(I).h(hamp(ha) + 1,19) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,19) = VtsVT(ind111-1,1);   % End Time %
            S(I).h(hamp(ha) + 3,19) = err111;   % Error %
        else
            S(I).h(hamp(ha),11) = 0; % amplitude %
            subject(I).features(H,11) = S(I).h(hamp(ha),11);
            S(I).h(hamp(ha) + 1,11) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,11) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,11) = err111;   % Error %
            
            S(I).h(hamp(ha),18) = 0; % amplitude %
            subject(I).features(H,18) = S(I).h(hamp(ha),18);
            S(I).h(hamp(ha) + 1,18) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,18) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,18) = err111;   % Error %
            
            S(I).h(hamp(ha),19) = 0; % amplitude %
            subject(I).features(H,19) = S(I).h(hamp(ha),19);
            S(I).h(hamp(ha) + 1,19) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,19) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,19) = err111;   % Error %
        end
        
        %**********  PARA # 13 # 22 # 23  ***************%
        ind131 = find(EtsPS(H) <= LvAS & LvAS <= EtsPS(H) + 25,1);
        err131 = isempty(ind131);
        if(err131 == 0)
            S(I).h(hamp(ha),13) = VtsAS(ind131,2); % amplitude %
            subject(I).features(H,13) = S(I).h(hamp(ha),13);
            S(I).h(hamp(ha) + 1,13) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,13) = VtsAS(ind131,1);   % End Time %
            S(I).h(hamp(ha) + 3,13) = err131;   % Error %
            
            if(ind131+1 ~= length(VtsAS)+1)
                %S(I).h(hamp(ha),22) = abs(VtsAS(ind131,2)-VtsAS(ind131+1,2)); % amplitude %
                S(I).h(hamp(ha),22) = (VtsAS(ind131,2)-VtsAS(ind131+1,2)); % amplitude %
                subject(I).features(H,22) = S(I).h(hamp(ha),22);
                S(I).h(hamp(ha) + 1,22) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,22) = VtsAS(ind131+1,1);   % End Time %
                S(I).h(hamp(ha) + 3,22) = err131;   % Error %
            else
                S(I).h(hamp(ha),22) = 0; % amplitude %
                subject(I).features(H,22) = S(I).h(hamp(ha),22);
                S(I).h(hamp(ha) + 1,22) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,22) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,22) = err131;   % Error %
            end
            
            %S(I).h(hamp(ha),23) = abs(VtsAS(ind131,2)-VtsAS(ind131-1,2)); % amplitude %
            S(I).h(hamp(ha),23) = (VtsAS(ind131,2)-VtsAS(ind131-1,2)); % amplitude %
            subject(I).features(H,23) = S(I).h(hamp(ha),23);
            S(I).h(hamp(ha) + 1,23) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,23) = VtsAS(ind131-1,1);   % End Time %
            S(I).h(hamp(ha) + 3,23) = err131;   % Error %
        else
            S(I).h(hamp(ha),13) = 0; % amplitude %
            subject(I).features(H,13) = S(I).h(hamp(ha),13);
            S(I).h(hamp(ha) + 1,13) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,13) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,13) = err131;   % Error %
            
            S(I).h(hamp(ha),22) = 0; % amplitude %
            subject(I).features(H,22) = S(I).h(hamp(ha),22);
            S(I).h(hamp(ha) + 1,22) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,22) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,22) = err131;   % Error %
            
            S(I).h(hamp(ha),23) = 0; % amplitude %
            subject(I).features(H,23) = S(I).h(hamp(ha),23);
            S(I).h(hamp(ha) + 1,23) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,23) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,23) = err131;   % Error %
        end
        
        %**********  PARA # 12 # 25 ***************%
        ind121 = find(EtsPS(H)+3 <= tsintZVT & tsintZVT <= EtsPS(H) + 25,1);
        err121 = isempty(ind121);
        if(err121 == 0)
            S(I).h(hamp(ha),12) = tsintZVT(ind121) - S(I).h(hamp(ha)+2,11); % amplitude %
            subject(I).features(H,12) = S(I).h(hamp(ha),12);
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
                subject(I).features(H,25) = S(I).h(hamp(ha),25);
                S(I).h(hamp(ha) + 1,25) = tsintZVT(ind12+1);   % Start Time %
                S(I).h(hamp(ha) + 2,25) = tsintZVT(ind12+2);   % End Time %
                S(I).h(hamp(ha) + 3,25) = err13;   % Error %
            else
                S(I).h(hamp(ha),25) = 0; % amplitude %
                subject(I).features(H,25) = S(I).h(hamp(ha),25);
                S(I).h(hamp(ha) + 1,25) = SEtsPS(H,1);   % Start Time %
                S(I).h(hamp(ha) + 2,25) = SEtsPS(H,2);   % End Time %
                S(I).h(hamp(ha) + 3,25) = err13;   % Error %
            end
        else
            S(I).h(hamp(ha),12) = 0; % amplitude %
            subject(I).features(H,12) = S(I).h(hamp(ha),12);
            S(I).h(hamp(ha) + 1,12) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,12) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,12) = err121;   % Error %
            
            S(I).h(hamp(ha),25) = 0; % amplitude %
            subject(I).features(H,25) = S(I).h(hamp(ha),25);
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
                subject(I).features(H,9) = S(I).h(hamp(ha),9);
                S(I).h(hamp(ha)+ 1,9) = tsintthp10AS(ind9a1);
                S(I).h(hamp(ha)+ 2,9) = tsintthm10AS(ind9b1);
                S(I).h(hamp(ha)+ 3,9) = err9a1 + err9b1;
            else
                S(I).h(hamp(ha),9) = 0;
                subject(I).features(H,9) = S(I).h(hamp(ha),9);
                S(I).h(hamp(ha)+ 1,9) = SEtsPS(H,1);
                S(I).h(hamp(ha)+ 2,9) = SEtsPS(H,2);
                S(I).h(hamp(ha)+ 3,9) = err9a1 + err9b1;
            end
        else
            S(I).h(hamp(ha),9) = 0;
            subject(I).features(H,9) = S(I).h(hamp(ha),9);
            S(I).h(hamp(ha)+ 1,9) = SEtsPS(H,1);
            S(I).h(hamp(ha)+ 2,9) = SEtsPS(H,2);
            S(I).h(hamp(ha)+ 3,9) = err9a1;
        end
        
        %**********  PARA # 10 #24 ***************%
        ind101 = find(EtsPS(H)+2 <= tsintZAS & tsintZAS <= EtsPS(H)+25,1);
        err101 = isempty(ind101);
        if(err101 == 0)
            S(I).h(hamp(ha),10) = tsintZAS(ind101) - S(I).h(hamp(ha)+2,9);
            subject(I).features(H,10) = S(I).h(hamp(ha),10);
            S(I).h(hamp(ha)+1,10) = S(I).h(hamp(ha)+2,9);
            S(I).h(hamp(ha)+2,10) = tsintZAS(ind101);
            S(I).h(hamp(ha)+3,10) = err101;
            
            index24 = find(S(I).h(hamp(ha)+2,9) <= ASts(:,1) & ASts(:,1) <= tsintZAS(ind10)); 
            L2_1 = norm(ASts(index24,2));
            L2_2 = 0;index24 = [];
            if(ind10 ~= length(tsintZAS) && (ind10+1) ~= length(tsintZAS))
                zas1 = tsintZAS(ind10+1);
                zas2 = tsintZAS(ind10+2);
                ind0241 = find(ASts(:,1) >= zas1,1);
                ind0242 = find(ASts(:,1) >= zas2,1);
                index24 = find(ind0241 <=ASts(:,1) & ASts(:,1) <= ind0242);
                L2_2 = 0;
                L2_2 = norm(ASts(index24,2));
                
                S(I).h(hamp(ha),24) = L2_1 - L2_2;
                subject(I).features(H,24) = S(I).h(hamp(ha),24);
                S(I).h(hamp(ha)+1,24) = tsintZAS(ind10+1);
                S(I).h(hamp(ha)+2,24) = tsintZAS(ind10+2);
                S(I).h(hamp(ha)+3,24) = err10;
            else
                S(I).h(hamp(ha),24) = 0;
                subject(I).features(H,24) = S(I).h(hamp(ha),24);
                S(I).h(hamp(ha)+1,24) = SEtsPS(H,1);
                S(I).h(hamp(ha)+2,24) = SEtsPS(H,2);
                S(I).h(hamp(ha)+3,24) = err10;
            end
        else
            S(I).h(hamp(ha),10) = 0;
            subject(I).features(H,10) = S(I).h(hamp(ha),10);
            S(I).h(hamp(ha)+ 1,10) = SEtsPS(H,1);
            S(I).h(hamp(ha)+ 2,10) = SEtsPS(H,2);
            S(I).h(hamp(ha)+ 3,10) = err10;
            
            S(I).h(hamp(ha),24) = 0;
            subject(I).features(H,24) = S(I).h(hamp(ha),24);
            S(I).h(hamp(ha)+ 1,24) = SEtsPS(H,1);
            S(I).h(hamp(ha)+ 2,24) = SEtsPS(H,2);
            S(I).h(hamp(ha)+ 3,24) = err10;
        end
        
        %**********  PARA # 02  ***************%
        S(I).h(hamp(ha),2) = S(I).h(hamp(ha)+2,6) - SEtsPS(H,1);
        subject(I).features(H,2) = S(I).h(hamp(ha),2);
        S(I).h(hamp(ha)+ 1,2) = SEtsPS(H,1);
        S(I).h(hamp(ha)+ 2,2) = S(I).h(hamp(ha)+2,6);
        S(I).h(hamp(ha)+ 3,2) = err6;
        
        %**********  PARA # 08  ***************%
        S(I).h(hamp(ha),8) = S(I).h(hamp(ha)+2,9) - EtsPS(H);
        subject(I).features(H,8) = S(I).h(hamp(ha),8);
        S(I).h(hamp(ha)+ 1,8) = EtsPS(H);
        S(I).h(hamp(ha)+ 2,8) = S(I).h(hamp(ha)+2,9);
        S(I).h(hamp(ha)+ 3,8) = 0;
        
        %**********  PARA # 03  ***************%
        ind31 = find(SEtsPS(H,1)+1 <= tsintthp10AS & tsintthp10AS <= S(I).h(hamp(ha)+2,6),1,'last');
        err31 = isempty(ind31);
        if(err31 == 0)
            S(I).h(hamp(ha),3) = tsintthp10AS(ind31) - SEtsPS(H,1);
            subject(I).features(H,3) = S(I).h(hamp(ha),3);
            S(I).h(hamp(ha)+1,3) = SEtsPS(H,1);
            S(I).h(hamp(ha)+2,3) = tsintthp10AS(ind31);
            S(I).h(hamp(ha)+3,3) = err31;
        else
            S(I).h(hamp(ha),3) = 0;
            subject(I).features(H,3) = S(I).h(hamp(ha),3);
            S(I).h(hamp(ha)+ 1,3) = SEtsPS(H,1);
            S(I).h(hamp(ha)+ 2,3) = SEtsPS(H,2);
            S(I).h(hamp(ha)+ 3,3) = err31;
        end
        
        %**********  PARA # 07  ***************%
        if(err31 == 0 && err9b1 == 0)
            S(I).h(hamp(ha),7) = tsintthm10AS(ind9b1) - tsintthp10AS(ind31);
            subject(I).features(H,7) = S(I).h(hamp(ha),7);
            S(I).h(hamp(ha)+1,7) = tsintthp10AS(ind31);
            S(I).h(hamp(ha)+2,7) = tsintthm10AS(ind9b1);
            S(I).h(hamp(ha)+3,7) = err9b1;
        else
            S(I).h(hamp(ha),7) = 0;
            subject(I).features(H,7) = S(I).h(hamp(ha),7);
            S(I).h(hamp(ha)+1,7) = SEtsPS(H,1);
            S(I).h(hamp(ha)+2,7) = SEtsPS(H,2);
            S(I).h(hamp(ha)+3,7) = 0;
        end
        
        %**********  PARA # 01  ***************%
        ind1a1 = find(SEtsPS(H,1) >= LvAS & LvAS >= SEtsPS(H,1) - 25,1,'last');
        err1a1 = isempty(ind1a1);
        if(err1a1 == 0)
            ind1b1 = find(VtsAS(ind1a1) >= tsintZAS & tsintZAS >= VtsAS(ind1a1) - 25,1,'last');
            err1b1 = isempty(ind1b1);
            if(err1b1 == 0)
                S(I).h(hamp(ha),1) = SEtsPS(H,1) - tsintZAS(ind1b1);
                subject(I).features(H,1) = S(I).h(hamp(ha),1);
                S(I).h(hamp(ha)+1,1) = tsintZAS(ind1b1);
                S(I).h(hamp(ha)+2,1) = SEtsPS(H,1);
                S(I).h(hamp(ha)+3,1) = err1b1;
            else
                S(I).h(hamp(ha),1) = 0;
                subject(I).features(H,1) = S(I).h(hamp(ha),1);
                S(I).h(hamp(ha)+1,1) = SEtsPS(H,1);
                S(I).h(hamp(ha)+2,1) = SEtsPS(H,2);
                S(I).h(hamp(ha)+3,1) = err1a1+err1b1;
            end
        else
            S(I).h(hamp(ha),1) = 0;
            subject(I).features(H,1) = S(I).h(hamp(ha),1);
            S(I).h(hamp(ha)+1,1) = SEtsPS(H,1);
            S(I).h(hamp(ha)+2,1) = SEtsPS(H,2);
            S(I).h(hamp(ha)+3,1) = err1a1;
        end
        
    end%%%end for Paramter 6 problem
    
    % This part of code assigns labels to each HG. If it is even HG# assign
    % a value +1 or else -1    
    if mod(H,2) == 0
        subject(I).labels(H,1) = 1;    %number is even
    else
        subject(I).labels(H,1) = -1;    %number is odd
    end 
    %subject(I).labels(H,1) = 1; %<==================== Label Assignment %%
    subject(I).plot(H,1) = SEtsPS(H,1);subject(I).plot(H,2) = SEtsPS(H,2);

H  = H + 1;
ha = ha + 1;
end

load 'model_25feat.mat'
%load 'model_13.mat'
%load 'model_16.mat'

%load 'feat16best_GA.mat'
%feat = feat16best_GA;
feat = 1:25;

%load 'model_25feat.mat'
%load 'model_best16feats.mat'
model = model_25feat;
%load 'model.mat'
Test_F = subject.features(:,feat);
Test_L = subject.labels;



[predict_label_L, accuracy_L, dec_values_L] = svmpredict(Test_L,Test_F, model);

LL = length(predict_label_L);

for i = 1 : 1 : LL
    if predict_label_L(i) == 1
        plot(SEtsPS(i,1),1,'hc')
        grid on; hold on;
    else
    end
end






