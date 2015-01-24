% This code plots the Buffalo Data files (Files updated on Jan 2013)
% Future Improvements : Use puff scores to extract features at that instant
% only
% Created : 8 Jan 2013
clc;clear all;close all;

global sf ts;
sf = 101.73;

path = char('C:\Users\student\Documents\MATLAB\Data update Buffalo 08-Jan-2013\');

list = char('DATA_PACT_105','DATA_PACT_107','DATA_PACT_108','DATA_PACT_109','DATA_PACT_114','DATA_PACT_117','DATA_PACT_118','DATA_PACT_120','DATA_PACT_122','DATA_PACT_124','DATA_PACT_127','DATA_PACT_128','DATA_PACT_129','DATA_PACT_132','DATA_PACT_134','DATA_PACT_136','DATA_PACT_138','DATA_PACT_140');

%list = char('DATA_PACT_105','DATA_PACT_109','DATA_PACT_117','DATA_PACT_129','DATA_PACT_136','DATA_PACT_138');

I = 18
list(I,:)

load(strcat(path(1,:),list(I,:),'.mat'));

PSraw = Signals(:,4)/max(Signals(:,4));

PS = Signals(:,5);

ts = Signals(:,1); 

[AB,RC] = process_AB_RC(1,Signals(:,2),Signals(:,3));   % 1 = no-inversion, 2 = invert 3 = invert...2

[ASr,VTr] = get_AS_VT(0,AB,RC,1,4);

ASts = [ts ASr];VTts = [ts VTr];

[ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal

PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 
PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS]; 

[ASnorm,VTnorm] = Normalization_Second_stage(ASts(:,2),VTts(:,2),1,VtsAS(:,2),PtsAS(:,2),VtsVT(:,2),PtsVT(:,2),[-1 +1]);  % Check if the choice for min/max is "MEDIAN == 1" or "MEAN == 2"    

ASts = []; VTts = [];    

ASts = [ts ASnorm];VTts = [ts VTnorm];    

[ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal    

PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 
PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS]; 

% Now get the part of the signal for First Lab Session only;

Lab1_T1 = Lab_sessions(1,1);Lab1_T2 = Lab_sessions(1,2);

Lab2_T1 = Lab_sessions(2,1);Lab2_T2 = Lab_sessions(2,2);

Index = find(Lab1_T1 <= ts & ts <= Lab1_T2);
PS_Index = find(Lab1_T1 <= puff_score(:,2) & puff_score(:,2) <= Lab1_T2);

ts = ts(Index);
PSraw = 5*PSraw(Index);
ASts = ASts(Index,:);
VTts = VTts(Index,:);
puff_score = puff_score(PS_Index,:);


figure;hold on;grid on;title(strcat('First Lab Session Data for Subject',' ',list(I,11:13),' (2 cigarettes)'));xlabel('Time \it s');ylabel('Air Flow, Tidal Vol, Hand Proximity Signal')    

% plot([Lab_sessions(1,1) Lab_sessions(1,1)],[-5 5],'color','r','Linewidth',2);
% plot([Lab_sessions(1,2) Lab_sessions(1,2)],[-5 5],'color','r','Linewidth',2);
% 
% plot([Lab_sessions(2,1) Lab_sessions(2,1)],[-5 5],'color','r','Linewidth',2);
% plot([Lab_sessions(2,2) Lab_sessions(2,2)],[-5 5],'color','r','Linewidth',2);

Hraw = plot(ts,PSraw,'g');         
% 
% H0 = plot(ts,10*PS,'Color',[0.0 1.0 0.0]);    

H1 = plot(ASts(:,1),ASts(:,2),'-c');
% plot(PtsAS(:,1),PtsAS(:,2),'+k');grid on;hold on;
% plot(VtsAS(:,1),VtsAS(:,2),'+r');grid on;hold on; 
H2 = plot(VTts(:,1),VTts(:,2),'-b');
% % plot(PtsVT(:,1),PtsVT(:,2),'ob');grid on;hold on;
% % plot(VtsVT(:,1),VtsVT(:,2),'ok');grid on;hold on;      
% 
O = 0.01*ones(size(puff_score,1));
H3 = plot(puff_score(:,1),O,'ob');
H4 = plot(puff_score(:,2),O,'or');        

legend([Hraw H1 H2 H3(1) H4(1)],{'Raw ProxSensor' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});  

% legend([H0 H1 H2 H3(1) H4(1)],{'Proximity Sensor' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});    
% legend([Hraw H0 H1 H2 H3(1) H4(1)],{'Raw ProxSen' 'Processed ProxSen' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});  
















