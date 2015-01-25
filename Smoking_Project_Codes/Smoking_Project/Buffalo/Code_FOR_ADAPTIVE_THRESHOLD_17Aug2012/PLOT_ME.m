function [H1,H3,H4] = PLOT_ME(pf_score,Wts,PtsW,VtsW)
% TASK : This function plots the AirFlow/TidalVolume signal
% DATE : 19 August 2012
gcf;
O = 0.38*ones(size(pf_score,1));%plot(pf_score(:,1),O,'or')
plot(pf_score(:,2),O,'og');

O = 0.28*ones(size(pf_score,1));

H3 = plot(pf_score(:,1),O,'or');
H4 = plot(pf_score(:,2),O,'ob');

H1 = plot(Wts(:,1),Wts(:,2),'Color',[0.4 0.3 0.9]);

plot(PtsW(:,1),PtsW(:,2),'om');grid on;hold on;
plot(VtsW(:,1),VtsW(:,2),'+r');grid on;hold on;    



end