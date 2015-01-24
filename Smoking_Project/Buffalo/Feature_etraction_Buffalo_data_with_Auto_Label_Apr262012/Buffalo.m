tic
%                          Buffalo                                      %
%***********************************************************************%
clc; clear all; close all;
sf = 101.73;
load 'PACT_108.mat'
I = 1;

hamp = 1:4:20000; ha = 1;  %% indices for the structure %%

Data = PACT_108; L = length(Data); ts = (1:L)/sf; ts = ts';
PS = Data(:,2); PS = PS/(max(PS));
%PS = merge_function1(PS,ts,0.046,0.5,8,1.2);
% Index = find(PS >= 0.046);
%temp = zeros(L,1); temp(Index) = 1; PS = temp;
figure(1)
plot(ts,PS,'y');grid on; hold on;

RC = (Data(:,3))/max(Data(:,3)); AB = (Data(:,4))/max(Data(:,4));

VT = (AB + RC)/2;% VT = VT - mean(VT);
%VT = -1 * VT; VT = VT + mean(VT);

VT = idealfilter(VT,0.1,1000,sf); VT = fastsmooth(VT,25,1,0); 

AS = diff(VT)./diff(ts); AS = [AS;0]; %AS = fastsmooth(AS,45,1,0);

[LpVT,MpVT] = peakfinder(VT,0.0099,-0.02,1);
LpVT = LpVT/sf;

[LvVT,MvVT] = peakfinder(VT,0.0099,0.02,-1);
LvVT = LvVT/sf;

[LpAS,MpAS] = peakfinder(AS,0.0099,-0.02,1);
LpAS = LpAS/sf;

[LvAS,MvAS] = peakfinder(AS,0.0099,0.02,-1);
LvAS = LvAS/sf;

% =============== PLOTS ======================= %
plot(ts,AS,'b');hold on; grid on;     % AS signal %
plot(LpAS,MpAS,'+m');grid on;hold on; % Peaks for AS signal %
plot(LvAS,MvAS,'+r');grid on;hold on; % Valleys for AS signal %
plot(ts,VT,'k');hold on; grid on;     % VT signal %
plot(LpVT,MpVT,'om');grid on;hold on; % Peaks for VT signal %
plot(LvVT,MvVT,'or');grid on;hold on; % Valleys for VT signal %
% ============================================ %


[inttsPS,y111] = intersections(ts,PS,[ts(1) ts(length(ts),1)],[0.1 0.1],1);
length(y111)
length(inttsPS)

SEtsPS(:,1) = inttsPS(1:2:(length(inttsPS))); %%START in Column 1 
SEtsPS(:,2) = inttsPS(2:2:(length(inttsPS))); %%END in Column 2
EtsPS = SEtsPS(:,2);
%SEtsPS = cat(1,SORTtsPS1,SORTtsPS2); %% Contains time stamps for START && END of PS 
%EtsPS = cat(1,SORTtsPS1(:,2),SORTtsPS2(:,2));  %% Contains only time stamp for END of PS 

%*************  IMPORTANT MATRICES FOR VT SIGNALS **************%
PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 
%*************  IMPORTANT MATRICES FOR AS SIGNALS **************%
PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];
%+++++++++++++++ POSITIVE 10% MEDIAN THRESHOLD ++++++++++++++++++%
thp10 = 0.0075 * ( + 0.1);
[tsintthp10AS,ampintthp10AS] = intersections(ts,AS,[0 ts(length(ts),1)],[thp10 thp10],1);
%--------------- NEGATIVE 10% MEDIAN THRESHOLD ------------------%
thm10 = 0.0075 * ( - 0.1);
[tsintthm10AS,ampintthm10AS] = intersections(ts,AS,[0 ts(length(ts),1)],[thm10 thm10],1);
%============= INTERSECTION of ZERO line with VT ==============%
[tsintZVT,ampintZVT] = intersections(ts,VT,[0 ts(length(ts),1)],[1e-7 1e-7],1); 
%============= INTERSECTION of ZERO line with AS ==============%
[tsintZAS,ampintZAS] = intersections(ts,AS,[0 ts(length(ts),1)],[1e-7 1e-7],1); 

NHG = length(SEtsPS);fprintf('Number of Hand Gestures = %d',NHG);
H = 1;
while(H <= length(SEtsPS))
    %***********  PARA # 4  ***************%
    S(I).h(hamp(ha),4) = SEtsPS(H,2) - SEtsPS(H,1); % amplitude %
    subject(I).features(H,4) = S(I).h(hamp(ha),4);
    S(I).h(hamp(ha) + 1,4) = SEtsPS(H,1);   % Start Time %
    S(I).h(hamp(ha) + 2,4) = SEtsPS(H,2);   % End Time %
    S(I).h(hamp(ha) + 3,4) = 0;   % Error %
    %**********  PARA # 14  ***************%
    clear 'ind14'
    ps14 = Data(:,2)/max(Data(:,2));
    ind14 = find(SEtsPS(H,1) <= ts & ts <= SEtsPS(H,2));
    ps141 = zeros(length(ts),1);
    ps141(ind14) = 1;
    ps142 = ps14 .* ps141;
    s14 = sum(ps142);
    l14 = length(ind14);
    mean14 = s14/l14;  %===== mean amplitude of PS for the given HG ======%
    S(I).h(hamp(ha),14) = mean14; % amplitude %
    subject(I).features(H,14) = S(I).h(hamp(ha),14);
    S(I).h(hamp(ha) + 1,14) = SEtsPS(H,1);   % Start Time %
    S(I).h(hamp(ha) + 2,14) = SEtsPS(H,2);   % End Time %
    S(I).h(hamp(ha) + 3,14) = 0;   % Error %
    %**********  PARA # 6  ***************%
    %clear 'ind6'
    ind6 = find(EtsPS(H) - 0.25 <= LpAS & LpAS <= EtsPS(H) + 25,1);
    err6 = isempty(ind6);
    if(err6 == 0) %% the "end" and "else" for this "if" is in FFE_EXT_Part2
        S(I).h(hamp(ha),6) = PtsAS(ind6,2); % amplitude %
        subject(I).features(H,6) = S(I).h(hamp(ha),6);
        S(I).h(hamp(ha) + 1,6) = SEtsPS(H,1);   % Start Time %
        S(I).h(hamp(ha) + 2,6) = PtsAS(ind6,1);   % End Time %
        S(I).h(hamp(ha) + 3,6) = err6;   % Error %
        %************ PARA # 5 ************%
        ind5 = find(S(I).h(hamp(ha) + 2,6) <= LpVT & LpVT <= S(I).h(hamp(ha) + 2,6) + 25,1);
        err5 = isempty(ind5);
        if(err5 == 0) 
            S(I).h(hamp(ha),5) = PtsVT(ind5,2); % amplitude %
            subject(I).features(H,5) = S(I).h(hamp(ha),5);
            S(I).h(hamp(ha) + 1,5) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,5) = PtsVT(ind5,1);   % End Time %
            S(I).h(hamp(ha) + 3,5) = err5;   % Error %
        else
            S(I).h(hamp(ha),5) = 0; % amplitude %
            subject(I).features(H,5) = S(I).h(hamp(ha),5);
            S(I).h(hamp(ha) + 1,5) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,5) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,5) = err5;   % Error %
        end
        % ************ PARA # 11 ************ %
        ind11 = find(S(I).h(hamp(ha) + 2,5) <= LvVT & LvVT <= S(I).h(hamp(ha) + 2,5) + 25,1);
        err11 = isempty(ind11);
        if(err11 == 0)
            S(I).h(hamp(ha),11) = VtsVT(ind11,2); % amplitude %
            subject(I).features(H,11) = S(I).h(hamp(ha),11);
            S(I).h(hamp(ha) + 1,11) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,11) = VtsVT(ind11,1);   % End Time %
            S(I).h(hamp(ha) + 3,11) = err11;   % Error %
        else
            S(I).h(hamp(ha),11) = 0; % amplitude %
            subject(I).features(H,11) = S(I).h(hamp(ha),11);
            S(I).h(hamp(ha) + 1,11) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,11) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,11) = err11;   % Error %
        end
        % ************ PARA # 13 ************ %
        ind13 = find(S(I).h(hamp(ha) + 2,6) <= LvAS & LvAS <= S(I).h(hamp(ha) + 2,6) + 25,1);
        err13 = isempty(ind13);
        if(err13 == 0)
            S(I).h(hamp(ha),13) = VtsAS(ind13,2); % amplitude %
            subject(I).features(H,13) = S(I).h(hamp(ha),13);
            S(I).h(hamp(ha) + 1,13) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,13) = VtsAS(ind13,1);   % End Time %
            S(I).h(hamp(ha) + 3,13) = err13;   % Error %
        else
            S(I).h(hamp(ha),13) = 0; % amplitude %
            subject(I).features(H,13) = S(I).h(hamp(ha),13);
            S(I).h(hamp(ha) + 1,13) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,13) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,13) = err13;   % Error %
        end
        % ************* PARA # 12 *********** %
        ind12 = find(S(I).h(hamp(ha) + 2,11) <= tsintZVT & tsintZVT <= S(I).h(hamp(ha) + 2,11) + 25,1);
        err12 = isempty(ind12);
        if(err12 == 0)
            S(I).h(hamp(ha),12) = tsintZVT(ind12) - S(I).h(hamp(ha)+2,11); % amplitude %
            subject(I).features(H,12) = S(I).h(hamp(ha),12);
            S(I).h(hamp(ha) + 1,12) = S(I).h(hamp(ha)+2,11);   % Start Time %
            S(I).h(hamp(ha) + 2,12) = tsintZVT(ind12);   % End Time %
            S(I).h(hamp(ha) + 3,12) = err13;   % Error %
        else
            S(I).h(hamp(ha),12) = 0; % amplitude %
            subject(I).features(H,12) = S(I).h(hamp(ha),12);
            S(I).h(hamp(ha) + 1,12) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,12) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,12) = err12;   % Error %
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
        % ************* PARA # 10 ************* %
        ind10 = find(S(I).h(hamp(ha)+2,9) <= tsintZAS & tsintZAS >= S(I).h(hamp(ha)+2,9),1);
        err10 = isempty(ind10);
        if(err10 == 0)
            S(I).h(hamp(ha),10) = tsintZAS(ind10) - S(I).h(hamp(ha)+2,9);
            subject(I).features(H,10) = S(I).h(hamp(ha),10);
            S(I).h(hamp(ha)+1,10) = S(I).h(hamp(ha)+2,9);
            S(I).h(hamp(ha)+2,10) = tsintZAS(ind10);
            S(I).h(hamp(ha)+3,10) = err10;
        else
            S(I).h(hamp(ha),10) = 0;
            subject(I).features(H,10) = S(I).h(hamp(ha),10);
            S(I).h(hamp(ha)+ 1,10) = SEtsPS(H,1);
            S(I).h(hamp(ha)+ 2,10) = SEtsPS(H,2);
            S(I).h(hamp(ha)+ 3,10) = err10;
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
    else%%% Else statement for problem # 6
        S(I).h(hamp(ha),6) = 0; % amplitude %
        subject(I).features(H,6) = S(I).h(hamp(ha),6);
        S(I).h(hamp(ha) + 1,6) = SEtsPS(H,1);   % Start Time %
        S(I).h(hamp(ha) + 2,6) = SEtsPS(H,2);   % End Time %
        S(I).h(hamp(ha) + 3,6) = err6;   % Error %
        %**********  PARA # 05  ***************%
        ind51 = find(EtsPS(H) <= LpVT & LpVT <= EtsPS(H) + 25,1);
        err51 = isempty(ind51);
        if(err51 == 0)
            S(I).h(hamp(ha),5) = PtsVT(ind51,2); % amplitude %
            subject(I).features(H,5) = S(I).h(hamp(ha),5);
            S(I).h(hamp(ha) + 1,5) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,5) = PtsVT(ind51,1);   % End Time %
            S(I).h(hamp(ha) + 3,5) = err5;   % Error %
        else
            S(I).h(hamp(ha),5) = 0; % amplitude %
            subject(I).features(H,5) = S(I).h(hamp(ha),5);
            S(I).h(hamp(ha) + 1,5) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,5) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,5) = err5;   % Error %
        end
        %**********  PARA # 11  ***************%
        ind111 = find(EtsPS(H) <= LvVT & LvVT <= EtsPS(H) + 25,1);
        err111 = isempty(ind111);
        if(err111 == 0)
            S(I).h(hamp(ha),11) = VtsVT(ind111,2); % amplitude %
            subject(I).features(H,11) = S(I).h(hamp(ha),11);
            S(I).h(hamp(ha) + 1,11) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,11) = VtsVT(ind111,1);   % End Time %
            S(I).h(hamp(ha) + 3,11) = err111;   % Error %
        else
            S(I).h(hamp(ha),11) = 0; % amplitude %
            subject(I).features(H,11) = S(I).h(hamp(ha),11);
            S(I).h(hamp(ha) + 1,11) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,11) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,11) = err111;   % Error %
        end
        %**********  PARA # 13  ***************%
        ind131 = find(EtsPS(H) <= LvAS & LvAS <= EtsPS(H) + 25,1);
        err131 = isempty(ind131);
        if(err131 == 0)
            S(I).h(hamp(ha),13) = VtsAS(ind131,2); % amplitude %
            subject(I).features(H,13) = S(I).h(hamp(ha),13);
            S(I).h(hamp(ha) + 1,13) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,13) = VtsVT(ind131,1);   % End Time %
            S(I).h(hamp(ha) + 3,13) = err131;   % Error %
        else
            S(I).h(hamp(ha),13) = 0; % amplitude %
            subject(I).features(H,13) = S(I).h(hamp(ha),13);
            S(I).h(hamp(ha) + 1,13) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,13) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,13) = err131;   % Error %
        end
        %**********  PARA # 12  ***************%
        ind121 = find(EtsPS(H)+3 <= tsintZVT & tsintZVT <= EtsPS(H) + 25,1);
        err121 = isempty(ind121);
        if(err121 == 0)
            S(I).h(hamp(ha),12) = tsintZVT(ind121) - S(I).h(hamp(ha)+2,11); % amplitude %
            subject(I).features(H,12) = S(I).h(hamp(ha),12);
            S(I).h(hamp(ha) + 1,12) = S(I).h(hamp(ha)+2,11);   % Start Time %
            S(I).h(hamp(ha) + 2,12) = tsintZVT(ind121);   % End Time %
            S(I).h(hamp(ha) + 3,12) = err121;   % Error %
        else
            S(I).h(hamp(ha),12) = 0; % amplitude %
            subject(I).features(H,12) = S(I).h(hamp(ha),12);
            S(I).h(hamp(ha) + 1,12) = SEtsPS(H,1);   % Start Time %
            S(I).h(hamp(ha) + 2,12) = SEtsPS(H,2);   % End Time %
            S(I).h(hamp(ha) + 3,12) = err121;   % Error %
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
        %**********  PARA # 10  ***************%
        ind101 = find(EtsPS(H)+2 <= tsintZAS & tsintZAS <= EtsPS(H)+25,1);
        err101 = isempty(ind101);
        if(err101 == 0)
            S(I).h(hamp(ha),10) = tsintZAS(ind101) - S(I).h(hamp(ha)+2,9);
            subject(I).features(H,10) = S(I).h(hamp(ha),10);
            S(I).h(hamp(ha)+1,10) = S(I).h(hamp(ha)+2,9);
            S(I).h(hamp(ha)+2,10) = tsintZAS(ind101);
            S(I).h(hamp(ha)+3,10) = err101;
        else
            S(I).h(hamp(ha),10) = 0;
            subject(I).features(H,10) = S(I).h(hamp(ha),10);
            S(I).h(hamp(ha)+ 1,10) = SEtsPS(H,1);
            S(I).h(hamp(ha)+ 2,10) = SEtsPS(H,2);
            S(I).h(hamp(ha)+ 3,10) = err10;
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
        S(I).h(hamp(ha)+ 3,8) = err9b1;
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
    if mod(H,2) == 0
        subject(I).labels(H,1) = 1;%number is even
    else
        subject(I).labels(H,1) = -1;%number is odd
    end 
    %subject(I).labels(H,1) = 1; %<==================== Label Assignment %%
    subject(I).plot(H,1) = SEtsPS(H,1);subject(I).plot(H,2) = SEtsPS(H,2);
%         plot([S(I).h(hamp(ha) + 1,1) S(I).h(hamp(ha) + 2,1)],[0 0],'-k');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,2) S(I).h(hamp(ha) + 2,2)],[0.4 0.4],'-y');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,3) S(I).h(hamp(ha) + 2,3)],[0 0],'-k');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,4) S(I).h(hamp(ha) + 2,4)],[1 1],'y');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,5) S(I).h(hamp(ha) + 2,5)],[S(I).h(hamp(ha),5) S(I).h(hamp(ha),5)],'-.m');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,6) S(I).h(hamp(ha) + 2,6)],[S(I).h(hamp(ha),6) S(I).h(hamp(ha),6)],'-.k');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,7) S(I).h(hamp(ha) + 2,7)],[0.17 0.17],'--y');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,8) S(I).h(hamp(ha) + 2,8)],[0.1 0.1],'-r');grid on; hold on; %===Plot===%       
%         plot([S(I).h(hamp(ha) + 1,9) S(I).h(hamp(ha) + 2,9)],[0.02 0.02],'-g');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,10) S(I).h(hamp(ha) + 2,10)],[0.001 0.001],'-c');grid on; hold on; %===Plot===%        
%         plot([S(I).h(hamp(ha) + 1,11) S(I).h(hamp(ha) + 2,11)],[S(I).h(hamp(ha),11) S(I).h(hamp(ha),11)],'-.m');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,12) S(I).h(hamp(ha) + 2,12)],[0 0],'-y');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,13) S(I).h(hamp(ha) + 2,13)],[S(I).h(hamp(ha),13) S(I).h(hamp(ha),13)],'-.m');grid on; hold on; %===Plot===%
%         plot([S(I).h(hamp(ha) + 1,14) S(I).h(hamp(ha) + 2,14)],[mean14 mean14],'m');grid on; hold on; %===Plot===%
H  = H + 1;
ha = ha + 1;
end

load 'model.mat'

Test_F = subject.features;
Test_L = subject.labels;

p1 = 9; p2 = 10;
Cval = num2str(exp(p1));
gval = num2str(exp(p2));
options = [' -s ',' 0 ',' -t ',' 2 ',' -c ',Cval,' -g ',gval];

[predict_label_L, accuracy_L, dec_values_L] = svmpredict(Test_L,Test_F, model);

LL = length(predict_label_L);

for i = 1 : 1 : LL
    if predict_label_L(i) == 1
        plot([SEtsPS(i,1) SEtsPS(i,2)],[1 1],'*r')
        grid on; hold on;
    else
    end
end
toc















