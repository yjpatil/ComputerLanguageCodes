% ---------------------- <> <> <> <> <> <> ------------------------------ %
%
%
% ---------------------- <> <> <> <> <> <> ------------------------------ %
clc;clear all;close all;

% Accuracy1 = [84.21];Accuracy2 = [94.73];Accuracy3 = [88.89];Accuracy4 = [85];Accuracy = [84.21,94.73,88.88,85];
% figure(111);hold on;title('Recognition Rate vs Different Cases');xlabel('Different Subjects Combination');ylabel('Recognition Rate');
% L1 = bar(1,Accuracy1,.3,'r');L2 = bar(2,Accuracy2,.3,'b');L3 = bar(3,Accuracy3,.3,'k');L4 = bar(4,Accuracy4,.3,'m')
% legend([L1 L2 L3 L4],{'Sub2,3,4,5 present' 'Sub1,2,3 present' 'Sub1,3,4 present' 'Sub1,2,3,4,5 present 6 absent'});ylim([0,100])

addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bICA\MainFunctions\')

mult1 = 100;mult2 = 100;
N = 10000;  % Number of Observations
MaxSensors = 1;  % Total number of Maximum Sensors

%[Data1,Data2,Data3,Data4,Data5,Data6,StatsData1,StatsData2,StatsData3,StatsData4,StatsData5,StatsData6] = fCreate_4Sub_MarkovPData(N,MaxSensors);
[Data1,Data2,Data3,Data4,Data5,Data6,Data7,Data8,StatsData11,StatsData22,StatsData33,StatsData44,StatsData55,StatsData66,StatsData77,StatsData88] = fCreate_4Sub_MarkovPData02(N,MaxSensors);

X1orig = Data8; % ---(1) Medium-Small 1's --- %
X2orig = Data3; % ---(2) Largest 1's --- %
X3orig = Data6; % ---(3) Very Small 1's --- %
X4orig = Data7; % ---(4) Medium-Large 1's --- %
X5orig = Data4; % ---(5) Medium 1's --- %

StatsData1 = StatsData88;    
StatsData2 = StatsData33;
StatsData3 = StatsData66;
StatsData4 = StatsData77;

StatsData5 = StatsData44;

PerbRate = 0; % <>-------- Perturbation Rate % of bits flipping <>||
NoPerbRate = 0;

[X1] = fperturb01(X1orig,PerbRate);
[X2] = fperturb01(X2orig,PerbRate);
[X3] = fperturb01(X3orig,NoPerbRate);
[X4] = fperturb01(X4orig,NoPerbRate);

[X5] = fperturb01(X5orig,NoPerbRate);

% <> ----- <> 
X = [X1;X2];  % <>------------------ Which Sources are present <>
Sources00 = [StatsData1(1);StatsData2(1);StatsData4(1)];
Sources01 = [StatsData1(2);StatsData2(2);StatsData4(2)];
Sources10 = [StatsData1(3);StatsData2(3);StatsData4(3)];
Sources11 = [StatsData1(4);StatsData2(4);StatsData4(4)];
% <> ----------------- <> ------------------ <> %

% p = [];
% verbose = 0;
% 
% ind = 1;
% l = [];
% tol = 1e-3;
% inner_iter = 5;

% ============= CHANGES MADE BELOW ============== %

Nmix = 40;  

MixCoeff = rand(Nmix,1); % Randomly create their distribution value

mfeat = sum([MixCoeff,1-MixCoeff,zeros(Nmix,1)]);

[MixData00,BernStats,Pie] = fCreateProbMixtureData(MixCoeff,X);

x = MixData00;

% --------- END ---- Start of bICA for Markov Process --------- %
[T,N]=size(x);

[Delta00,Delta01,Delta10,Delta11] = fGet_deltas_mats(x); % To get the delta functions for HMM data [p00,p01,p10,p11]
% ----------------------------------------------------------------------- %

[A] = fbICA_MarkovProcess(T,N,mult1,mult2,Sources00,Sources01,Sources10,Sources11,Delta00,Delta01,Delta10,Delta11);

A = sum(A);

clearvars -except 'A' 'mfeat'
















