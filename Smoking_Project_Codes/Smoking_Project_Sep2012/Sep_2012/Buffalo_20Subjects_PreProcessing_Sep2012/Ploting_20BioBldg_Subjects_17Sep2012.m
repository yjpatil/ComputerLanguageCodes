% Task : This function plots the 20 Biology Bldg Subjects
% Note : It has no normalization technique 
% Date : 17 Sep 2012



clc;clear all; close all;
sf=101.73; 

path = char('C:\Users\student\Documents\MATLAB\Biology_bldg_20subjects\');
list = char('sub_003','sub_004','sub_005','sub_006','sub_007','sub_008','sub_009','sub_010','sub_011','sub_012','sub_013','sub_014','sub_015','sub_016','sub_017','sub_019','sub_020','sub_021','sub_022','sub_023');

s = size(list,1);

I = 2;   %% Iteration for subject (here, 1 <= I <= 20) %%

load(strcat(path,list(I,:),'.mat'))

clear ('L','ts');

L = length(Data); ts = [1:L]/sf; ts = ts'; ts = ts-Activities(1,2);

clear ('Z','Z1','Z2');
Z = zeros(L,1); Z1 = zeros(L,1); Z2 = zeros(L,1);

clear ('ind1','ind2');

ind1 = find(Activities(11,1)- 126 <= ts & ts <= Activities(11,2) + 126); Z(ind1) = 1; Z1(ind1) = 1;

ind2 = find(Activities(13,1) - 126 <= ts & ts <= Activities(13,2) + 126); Z(ind2) = 1; Z2(ind2) = 1;
clear ('PB','PS31','ind0','PS');    

PB = (Data(:,1))/max(Data(:,1)); PB = PB .* Z;

% PS31 = (Data(:,2))/max(Data(:,2)); PS31 = PS31.* Z; 
% PS = merge_function1(PS31,ts,0.046,0.5,8,1.2);
%ind0 = find(PS1 >= 0.046); clear 'PS1';      
%clear ('PS','PS2');
%PS2 = zeros(L,1); PS2(ind0) = 1; 
%PS = merge_func(ts,PS2,1.2); % merging of close pulses

figure(1);grid on;hold on;title(list(I,:));
%plot(ts,PS,'r');hold on;grid on;
clear ('ASa','RC','AB','VT1','ind3','nvt1','Mvt');
ASa = (Data(:,3))/max(Data(:,3)); 

RC = (Data(:,4))/max(Data(:,4));
AB = (Data(:,5))/max(Data(:,5));

RC = RC .* Z; AB = AB .* Z; VT1 = (AB + RC)/2;

ind3 = find(VT1 > 0); nvt1 = length(ind3); Mvt = (sum(VT1))/nvt1;  %% Procedure to find the mean-value %%

clear ('VT','AS');
VT = VT1 - Mvt; VT = -1 * VT; VT = VT + Mvt; VT = VT .* Z;   %% Inverted VT signal %%

VT = idealfilter(VT,0.1,1000,sf); VT = VT .* Z;
VT = fastsmooth(VT,45,1,0); 
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
H1 = plot(ts,AS,'b');hold on; grid on;     % AS signal %
%plot(LpAS,MpAS,'+m');grid on;hold on; % Peaks for AS signal %
%plot(LvAS,MvAS,'+r');grid on;hold on; % Valleys for AS signal %
H2 = plot(ts,VT,'k');hold on; grid on;     % VT signal %
%plot(LpVT,MpVT,'om');grid on;hold on; % Peaks for VT signal %
%plot(LvVT,MvVT,'or');grid on;hold on; % Valleys for VT signal %
% ============================================ %
%*************  IMPORTANT MATRICES FOR VT SIGNALS **************%
PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 
%*************  IMPORTANT MATRICES FOR AS SIGNALS **************%
PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];
%***************************************************************%

% ============= Plots for Manual Scoring ============ %
pl1 = length(Score(:,3));pl2 = length(Score(:,4));
zpl1 = 0.23*ones(pl1,1);zpl2 = 0.23*ones(pl2,1);
Ps1 = plot(Score(:,3),zpl1,'or');Ps2 = plot(Score(:,4),zpl2,'ob');

%legend([H1 H2 Ps1(1) Ps2(2)],{'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'})
legend([H1 H2],{'Air Flow' 'Tidal Volume'})
% =================================================== %











