% This code is to check the number of LATENT VARIABLES required %

% The Code works for 8x8 blocks, for 4 Latent Vectors, 14 minimum samples %


clc;clear all;close all;

global FigNum;

addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\Functions');
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\DataSet\Scenario001Dataset');
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\DataSet\Scenario002Dataset');
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\DataSet\Scenario003Dataset');
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\DataSet\Scenario00302Dataset');

load('Tr01');
load('Tr02');
load('Tr03');
load('Tr0302');

%Tr03 = zeros(8,8,18);

% ---- Reshaping all the 3D matrices ------- %
[NewTr01] = fReshapingMats(Tr01);
[NewTr02] = fReshapingMats(Tr02);

% ----- Reassign Original Ones ------ %
Tr01 = NewTr01;
Tr02 = NewTr02;


% ------- Common Parameters ------ %
MiXComp = 1;RunTransInv = 1;ShowImg = 0;


% -------- BUILD MODELS -------- %

% % ------- Number of Latent Variables == 1 --------- % %
% Scenario # 1 %
LV = 1;FigNum = 1111;
[LogLMeet1,ModelMeet]=BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg);

% Scenario # 2 %
LV = 1;FigNum = 2222;
[LogLWatch1,ModelWatch]=BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg);

% % ------- Number of Latent Variables == 2 --------- % %
% Scenario # 1 %
LV = 2;%FigNum = 1111;
[LogLMeet2,ModelMeet]=BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg);

% Scenario # 2 %
LV = 2;%FigNum = 2222;
[LogLWatch2,ModelWatch]=BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg);

% % ------- Number of Latent Variables == 3 --------- % %
% Scenario # 1 %
LV = 3;%FigNum = 1111;
[LogLMeet3,ModelMeet]=BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg);

% Scenario # 2 %
LV = 3;%FigNum = 2222;
[LogLWatch3,ModelWatch]=BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg);

% % ------- Number of Latent Variables == 4 --------- % %
% Scenario # 1 %
LV = 4;%FigNum = 1111;
[LogLMeet4,ModelMeet]=BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg);

% Scenario # 2 %
LV = 4;%FigNum = 2222;
[LogLWatch4,ModelWatch]=BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg);

% % ------- Number of Latent Variables == 5 --------- % %
% Scenario # 1 %
LV = 5;%FigNum = 1111;
[LogLMeet5,ModelMeet]=BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg);

% Scenario # 2 %
LV = 5;%FigNum = 2222;
[LogLWatch5,ModelWatch]=BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg);

% % ------- Number of Latent Variables == 6 --------- % %
% Scenario # 1 %
LV = 6;%FigNum = 1111;
[LogLMeet6,ModelMeet]=BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg);

% Scenario # 2 %
LV = 6;%FigNum = 2222;
[LogLWatch6,ModelWatch]=BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg);


% ---------- PLOT THE Lowest LogLkhd for each LV  ----------- %
% % <>---- Plot for Scenario Recognition Rate Code # 04 %  ---<> % % 
FontSize = 19.0;
Data01 = [max(LogLMeet1)	max(LogLWatch1);
max(LogLMeet2)	max(LogLWatch2);
max(LogLMeet3)	max(LogLWatch3);
max(LogLMeet4)	max(LogLWatch4);
max(LogLMeet5)	max(LogLWatch5);
max(LogLMeet6)	max(LogLWatch6)];
LineWidth = 1.5;FontSize = 15.0;
figure;hold on;%%
title('Training LogLikelihood Values for Different Basis Vector','FontSize',FontSize);
xlabel('Basis Vector','FontSize',FontSize);ylabel('Log-likelihood Values','FontSize',FontSize);
Legend1 = plot(Data01(:,1),'--ok','LineWidth',LineWidth);
Legend2 = plot(Data01(:,2),'--*k','LineWidth',LineWidth);
% Legend3 = plot(Data01(:,3),'--sk','LineWidth',LineWidth);
% Legend4 = plot(Data01(:,4),'--pk','LineWidth',LineWidth);
% legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'},'FontSize',FontSize)

legend([Legend1 Legend2],{'Scenario1' 'Scenario2'},'FontSize',FontSize)




















