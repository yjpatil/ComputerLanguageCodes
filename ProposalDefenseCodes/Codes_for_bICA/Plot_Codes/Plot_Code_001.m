% This code creates the plots for the results obtained from bICA codes %
close all;clear all

% Plot for Bernoulli recognition rate %
% % % <>------------ (1) ---------------<> % % % 
% Results01 = [86.96,90.91,85,81];
% figure;
% H1 = bar(Results01,.2,'w');
% % H1 = bar(Results,.2,'w','LineStyle','--');
% set(gca,'XTickLabel',{'Sub01','Sub02','Sub03','Sub04'});
% ylabel('Recognition Rate','FontSize',13.0);
% title('Recognition Rate for Different Subjects using Bernoulli Data','FontSize',13.0)
% set(gca,'FontSize',13.0)
% ylim([0 100])
% hold on;grid on;
% % % % <>------------ (2) ---------------<> % % % 
% Results02 = [100,42.86;
%              100,57.14;
%              100,42.86;
%              100,42.86];
% figure;
% H2 = bar(Results02);%,'Grouped',.2,'w');
% % H1 = bar(Results,.2,'w','LineStyle','--');
% colormap(gray);
% l = cell(1,2);
% l{1}='Group1 [0-25%Noise Level]'; l{2}='Group1 [26-50%Noise Level]';    
% legend(H2,l);
% set(gca,'XTickLabel',{'Sub01','Sub02','Sub03','Sub04'});
% ylabel('Recognition Rate','FontSize',13.0);
% title('Recognition Rate for Different Noise Level','FontSize',13.0)
% set(gca,'FontSize',13.0)
% ylim([0 130])
% hold on;grid on;


% Plot for Markov Process Recognition Rate %
% % % <>------------ (1) ---------------<> % % % 
Results01 = [86.96,90.91,85,81];
figure;
H1 = bar(Results01,.2,'w');
% H1 = bar(Results,.2,'w','LineStyle','--');
set(gca,'XTickLabel',{'Sub01','Sub02','Sub03','Sub04'});
ylabel('Recognition Rate','FontSize',13.0);
title('Recognition Rate for Different Subjects using Bernoulli Data','FontSize',13.0)
set(gca,'FontSize',13.0)
ylim([0 100])
hold on;grid on;
% % % <>------------ (2) ---------------<> % % % 
Results02 = [100,42.86;
             100,57.14;
             100,42.86;
             100,42.86];
figure;
H2 = bar(Results02);%,'Grouped',.2,'w');
% H1 = bar(Results,.2,'w','LineStyle','--');
colormap(gray);
l = cell(1,2);
l{1}='Group1 [0-25%Noise Level]'; l{2}='Group1 [26-50%Noise Level]';    
legend(H2,l);
set(gca,'XTickLabel',{'Sub01','Sub02','Sub03','Sub04'});
ylabel('Recognition Rate','FontSize',13.0);
title('Recognition Rate for Different Noise Level','FontSize',13.0)
set(gca,'FontSize',13.0)
ylim([0 130])
hold on;grid on;






