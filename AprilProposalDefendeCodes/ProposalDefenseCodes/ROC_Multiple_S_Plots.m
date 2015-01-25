% Code to plot the ROC curves for different Subjects, Scenarios, %
clc;clear all;close all;
%%addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bICA\ROC_function')
FontSize = 17.0;
%ML=ML*500;
% % figure(1)
% % Plot_MLo_HistFit('MAP', ML, 1);
figure(2);hold on;
H1 = Plot_MLo_ROC01(ML,FontSize)
title('ROC for Different Scenario Estimation','FontSize',FontSize);
clear 'ML'
H2 = Plot_MLo_ROC01(ML,FontSize)
clear 'ML'
H3 = Plot_MLo_ROC01(ML,FontSize)
clear 'ML'

H4 = Plot_MLo_ROC01(ML,FontSize)


legend([H1 H2 H3 H4],{'Scenario01' 'Scenario02' 'Scenario03' 'Scenario04'})





