% Task : This code plots the Buffalo Data using very simple Normalization
% Technique
% Date : 17 Sep 2012

clc;clear all; close all;
sf=101.73; 

path = char('C:\Users\student\Documents\MATLAB\Buffalo_data_mat_files\');

list = char('DATA_PACT_105','DATA_PACT_107','DATA_PACT_108','DATA_PACT_109','DATA_PACT_114','DATA_PACT_117','DATA_PACT_118','DATA_PACT_120','DATA_PACT_122','DATA_PACT_124','DATA_PACT_127','DATA_PACT_128','DATA_PACT_129','DATA_PACT_132','DATA_PACT_134','DATA_PACT_136','DATA_PACT_138','DATA_PACT_140');

Size_List = size(list,1);

I = 7;    % Counter for Subjects

load(strcat(path(1,:),list(I,:),'.mat'));


ts = Signals(:,1);

figure(1);grid on;hold on;title(list(I,:));

RC = Signals(:,2)/max(Signals(:,2));

AB = (Signals(:,3))/max(Signals(:,3));

%%RC = RC .* Z; AB = AB .* Z; 

VT = (AB + RC)/2;

% %% ind3 = find(VT1 > 0); nvt1 = length(ind3); Mvt = (sum(VT1))/nvt1;  %% Procedure to find the mean-value %%

% % clear ('VT','AS');
% % VT = VT1 - Mvt; VT = -1 * VT; VT = VT + Mvt; VT = VT .* Z;   %% Inverted VT signal %%

VT = idealfilter(VT,0.1,1000,sf);%% VT = VT .* Z;
VT = fastsmooth(VT,45,1,0); 
%%ts1 = ts .* Z; 

AS = diff(VT)./diff(ts);
AS = [AS;0];

% % for i1 = 1:1:L
% %     if (Z(i1,1) == 0)
% %         AS(i1,1) = 0;
% %     else
% %         AS(i1,1) = AS(i1,1);
% %     end
% % end

AS = fastsmooth(AS,45,1,0);

% % % % clear ('LpVT','MpVT','LvVT','MvVT','LpAS','MpAS','LvAS','MvAS');
% % % % [LpVT,MpVT] = peakfinder(VT,0.0099,-0.02,1);
% % % % LpVT = LpVT/sf;
% % % % LpVT = LpVT-(Activities(1,2));
% % % % 
% % % % [LvVT,MvVT] = peakfinder(VT,0.0099,0.02,-1);
% % % % LvVT = LvVT/sf;
% % % % LvVT = LvVT-(Activities(1,2));    
% % % % 
% % % % [LpAS,MpAS] = peakfinder(AS,0.0099,-0.02,1);
% % % % LpAS = LpAS/sf;
% % % % LpAS = LpAS-(Activities(1,2));
% % % % 
% % % % [LvAS,MvAS] = peakfinder(AS,0.0099,0.02,-1);
% % % % LvAS = LvAS/sf;
% % % % LvAS = LvAS-(Activities(1,2));
% =============== PLOTS ======================= %
H1 = plot(ts,AS,'b');hold on; grid on;     % AS signal %
%plot(LpAS,MpAS,'+m');grid on;hold on; % Peaks for AS signal %
%plot(LvAS,MvAS,'+r');grid on;hold on; % Valleys for AS signal %
H2 = plot(ts,VT,'r');hold on; grid on;     % VT signal %
%plot(LpVT,MpVT,'om');grid on;hold on; % Peaks for VT signal %
%plot(LvVT,MvVT,'or');grid on;hold on; % Valleys for VT signal %
% ============================================ %
%*************  IMPORTANT MATRICES FOR VT SIGNALS **************%
% % PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 
% % %*************  IMPORTANT MATRICES FOR AS SIGNALS **************%
% % PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];
%***************************************************************%

% ============= Plots for Manual Scoring ============ %
O = 0.18*ones(size(puff_score,1));

H3 = plot(puff_score(:,1),O,'or');
H4 = plot(puff_score(:,2),O,'ob');

O = 0.48*ones(size(puff_score,1));
H3 = plot(puff_score(:,1),O,'og');
H4 = plot(puff_score(:,2),O,'og');

%legend([H1 H2 Ps1(1) Ps2(2)],{'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'})
legend([H1 H2],{'Air Flow' 'Tidal Volume'})
% =================================================== %




