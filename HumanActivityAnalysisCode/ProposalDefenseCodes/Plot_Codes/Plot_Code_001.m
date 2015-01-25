% This code creates the plots for the results obtained from bICA codes %
close all;clear all;
FontSize = 17.0;

% Plot for Bernoulli recognition rate %
% % % <>------------ (1) ---------------<> % % % 
% Results01 = [.8196,.9091,.85,.81];
% figure;
% H1 = bar(Results01,.2,'w');
% % H1 = bar(Results,.2,'w','LineStyle','--');
% set(gca,'XTickLabel',{'Sub01','Sub02','Sub03','Sub04'});
% ylabel('Recognition Rate','FontSize',FontSize);
% title('Recognition Rate using Bernoulli Data','FontSize',FontSize)
% set(gca,'FontSize',FontSize)
% ylim([0 1.00])
% hold on;box on;%grid on;
% set(gca,'visible','on')
% % % % <>------------ (2) ---------------<> % % % 
% Results02 = [1.00,.4286;
%              1.00,.5714;
%              1.00,.4286;
%              1.00,.4286];
% figure;
% H2 = bar(Results02);%,'Grouped',.2,'w');
% % %%H1 = bar(Results,.2,'w','LineStyle','--');
% colormap(gray);
% caxis([-3.2 2])
% l = cell(1,2);
% l{1}='Group1 [0-25%Noise Level]'; l{2}='Group1 [26-50%Noise Level]';    
% legend(H2,l);
% set(gca,'XTickLabel',{'Sub01','Sub02','Sub03','Sub04'});
% ylabel('Recognition Rate','FontSize',FontSize);
% title('Recognition Rate for Different Noise Level','FontSize',FontSize)
% set(gca,'FontSize',FontSize)
% ylim([0 1.20])
% hold on;box on;
%%%%%%%grid on;


% Plot for Markov Process Recognition Rate %
% % % <>------------ (1) ---------------<> % % % 
% Results03 = [.826,0.950,.8571,.826];
% figure;hold on; box on;
% H1 = bar(Results03,.2,'w');
% % %H1 = bar(Results,.2,'w','LineStyle','--');
% set(gca,'XTickLabel',{'Sub01','Sub02','Sub03','Sub04'});
% ylabel('Recognition Rate','FontSize',FontSize);
% title('Recognition Rate using Markov Process Data','FontSize',FontSize)
% set(gca,'FontSize',FontSize)
% ylim([0 1.10])
% hold on;%grid on;
% box on;
% % % % <>------------ (2) ---------------<> % % % 
% Results04 = [.85,.60;
%              1.00,1.00;
%              .85,.50;
%              .90,.60];
% figure;
% H2 = bar(Results04);%,'Grouped',.2,'w');
% % H1 = bar(Results,.2,'w','LineStyle','--');
% colormap(gray);
% caxis([-3.2 2])
% l = cell(1,2);
% l{1}='Group1 [0-25%Noise Level]'; l{2}='Group1 [26-50%Noise Level]';    
% legend(H2,l);
% set(gca,'XTickLabel',{'Sub01','Sub02','Sub03','Sub04'});
% ylabel('Recognition Rate','FontSize',FontSize);
% title('Recognition Rate for Different Noise Level','FontSize',FontSize)
% set(gca,'FontSize',FontSize)
% ylim([0 1.20])
% hold on;%grid on;


% % <>---- Plot for Scenario Recognition Rate Code # 04 %  ---<> % % 
% Data01 = [];
% LineWidth = 1.5;FontSize = 15.0;
% figure;hold on;title('Training LogLikelihood Values for Different Basis Vector','FontSize',FontSize);
% xlabel('Basis Vector','FontSize',FontSize);ylabel('Log-likelihood Values','FontSize',FontSize);
% Legend1 = plot(Data01(:,1),'--ok','LineWidth',LineWidth);
% Legend2 = plot(Data01(:,2),'--*k','LineWidth',LineWidth);
% Legend3 = plot(Data01(:,3),'--sk','LineWidth',LineWidth);
% Legend4 = plot(Data01(:,4),'--pk','LineWidth',LineWidth);
% legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'},'FontSize',FontSize)


% % <>---- Plot for Scenario Recognition Rate Code # 04 %  ---<> % % 
% Data02 = [.8167,0.970,.8333;
%            0.910,.8533,.75;
%            .76925,.7962,.75;
%            .7877,.8067,.7693];
% figure;
% H2 = bar(Data02);
% colormap(gray);
% caxis([-6.2 3])
% l = cell(1,2);
% l{1}='Code01'; l{2}='Code02';l{3}='Code03';    
% legend(H2,l);
% set(gca,'XTickLabel',{'Scenario01','Scenario02','Scenario03','Scenario04'});
% ylabel('Recognition Rate','FontSize',FontSize);
% title('Recognition Rate for Different Codes','FontSize',FontSize)
% set(gca,'FontSize',FontSize)
% ylim([0 1.20])
% hold on;%grid on;



% % <>---- Plot for Activity Recognition (Sensitivity & Specificity) ---<> % % 
% Results05 = [.93,.97;
%              .89,.88;
%              1.00,1.00;
%              .81,1.00];
% A = figure;
% H2 = bar(Results05);
% colormap(gray);
% caxis([-3.2 2])
% l = cell(1,2);
% l{1}='Sensitivity'; l{2}='Specificity';    
% legend(H2,l);
% set(gca,'XTickLabel',{'Activity1','Activity2','Activity3','Activity4'});
% ylabel('Accuracy Level','FontSize',FontSize);
% title('Different Activities Detection using SVM','FontSize',FontSize)
% set(gca,'FontSize',FontSize)
% ylim([0 1.20])
% hold on;%grid on;

% 
% <>---------- Plot for Interaction Recognition Rate  ---------------<> %  
% Results06 = [0.92857,0.88889,1.00,0.8125];
% figure;
% H6 = bar(Results06,.2,'w');
% % H6 = bar(Results,.2,'w','LineStyle','--');
% set(gca,'XTickLabel',{'Interacts01','Interacts02','Interacts03','Interacts04'});
% ylabel('Recognition Rate','FontSize',FontSize);
% title('Recognition Rate for Different Interactions','FontSize',FontSize)
% set(gca,'FontSize',FontSize)
% ylim([0 1.20])
% hold on;box on;

% % <>---- Plot for Activity Recognition (linear & sigmoid SVM) ---<> % % 
% Results05 = [0.8125,0.8125;
%              0.92857,0.92857;
%              0.970,.9700
%              0.88889,0.88889];
% A = figure;
% H2 = bar(Results05);
% colormap(gray);
% caxis([-3.2 2])
% l = cell(1,2);
% l{1}='Linear SVM'; l{2}='Sigmoid SVM';    
% legend(H2,l);
% set(gca,'XTickLabel',{'Interacts01','Interacts02','Interacts03','Interacts04'});
% ylabel('Accuracy Level','FontSize',FontSize);
% title('Different Interactions Detection using Linear and Sigmoid SVM','FontSize',FontSize)
% set(gca,'FontSize',FontSize)
% ylim([0 1.20])
% hold on;%grid on;

% ---------------------- Bayesian Network ------------------------------ %
%  Static Bayesian Network   %
Results03 = [0.8333,0.9167,0.8182];
figure;hold on; box on;
H1 = bar(Results03,.2,'w');
% %H1 = bar(Results,.2,'w','LineStyle','--');
ylabel('Recognition Rate','FontSize',FontSize);
title('Recognition Rate for Behavior Estimation','FontSize',FontSize)
set(gca,'FontSize',FontSize)
ylim([0 1.10]);xlim([0 4])
hold on;
set(gca,'XTickLabel',{'','Extrovert','Social','Introvert',''});








