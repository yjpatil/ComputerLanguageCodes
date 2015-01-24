% Task : This code plots the 20 BIOLOGY BLDG subjects to see there apnea
% behavior
% Date : 14 Sep 2012

clc;clear all; close all;

global ts sf;

sf=101.73; 

path = char('C:\Users\student\Documents\MATLAB\Biology_bldg_20subjects\');

list = char('sub_003','sub_004','sub_005','sub_006','sub_007','sub_008','sub_009','sub_010','sub_011','sub_012','sub_013','sub_014','sub_015','sub_016','sub_017','sub_019','sub_020','sub_021','sub_022','sub_023');

s = size(list,1);

I = 2;   %% Iteration for subject (here, 1 <= I <= 20) %%

%while(I <= s)

load(strcat(path,list(I,:),'.mat'))

clear ('L','ts');

L = length(Data);

ts = [1:L]/sf; ts = ts'; ts = ts-Activities(1,2);

clear ('Z','Z1','Z2');
Z = zeros(L,1); Z1 = zeros(L,1); Z2 = zeros(L,1);

clear ('ind1','ind2');

ind1 = find(Activities(11,1) - 126 <= ts & ts <= Activities(11,2) + 126); Z(ind1) = 1; Z1(ind1) = 1;

ind2 = find(Activities(13,1) - 126 <= ts & ts <= Activities(13,2) + 126); Z(ind2) = 1; Z2(ind2) = 1;

clear ('PB','PS31','ind0','PS');    
%%PB = (Data(:,1))/max(Data(:,1)); PB = PB .* Z;

PS31 = (Data(:,2))/max(Data(:,2)); PS31 = PS31.* Z; 

PS = merge_function(PS31,ts,0.046,0.5,8,1.2);

% figure(1)
% plot(ts,PS,'r');hold on;grid on;
clear ('ASa','RC','AB','VT1','ind3','nvt1','Mvt');

% % ASa = (Data(:,3))/max(Data(:,3)); 
RC1 = (Data(:,4));%/max(Data(:,4));
AB1 = (Data(:,5));%/max(Data(:,5));

AB1 = AB1 .* Z;RC1 = RC1 .* Z;  


[AB,RC] = process_AB_RC(1,AB1,RC1);   % 1 = no-inversion, 2 = invert

% % figure;grid on;hold on;
% % plot(ts,AB,'Color',[0.5 0.1 0.3])
% % plot(ts,RC,'Color',[0.1 0.1 0.8])

% length(ts)

[AS1,VT1] = get_AS_VT(0,AB,RC,1,4,ts);        % 0 = (AB+RC)/2,  1 = RC,  2 = AB.% + Filtering using Ideal Filter = 1 or WT filter = 2. ALso the threshold value (4) for the component removal


[AS1,VT1] = Normalization_tech(AS1,VT1,2,700,700,[-1 +1]);
figure(11);grid on;hold on;title(strcat('Normalized and Filtered',list(I,:)));
for i1 = 1:1:L
    if (Z(i1,1) == 0)
        AS1(i1,1) = 0;
    else
        AS1(i1,1) = AS1(i1,1);
    end
end
figure(1);grid on; hold on;title(strcat('Normalized and Filtered',list(I,:)));
H1 = plot(ts,AS1,'-b');
H2 = plot(ts,VT1,'-k');
% ============= Plots for Manual Scoring ============ %
pl1 = length(Score(:,3));pl2 = length(Score(:,4));

opl1 = 0.23*ones(pl1,1);opl2 = 0.23*ones(pl2,1);
plot(Score(:,3),opl1,'or',Score(:,4),opl2,'ob');grid on; hold on;
% =================================================== %
legend([H1 H2],{'Air Flow' 'Tidal Volume'})

u = 9





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
plot(ts,AS,'b');hold on; grid on;     % AS signal %
plot(LpAS,MpAS,'+m');grid on;hold on; % Peaks for AS signal %
plot(LvAS,MvAS,'+r');grid on;hold on; % Valleys for AS signal %

plot(ts,VT,'k');hold on; grid on;     % VT signal %
plot(LpVT,MpVT,'om');grid on;hold on; % Peaks for VT signal %
plot(LvVT,MvVT,'or');grid on;hold on; % Valleys for VT signal %
% ============================================ %


%*************  IMPORTANT MATRICES FOR VT SIGNALS **************%
PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 
%*************  IMPORTANT MATRICES FOR AS SIGNALS **************%
PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];
%***************************************************************%








