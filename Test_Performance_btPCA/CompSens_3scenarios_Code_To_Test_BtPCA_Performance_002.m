% This code is to check the working of the BTPCA algorithm 
% if it works or not for the given scenarios 

% This code uses the Compressive Sensing Technique

% **** NOTICE :: The Code works for 8x8 blocks, for 4 Latent Vectors, 14 minimum samples **** %


clc;clear all;close all;

global FigNum;

% ---------- 
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\Functions');
% --------- Construct the LDPC Matrix -------- %
D = 15; % Length of each code
Blocks = (8*8);

LDPC = gen_ldpc(D,Blocks);
%LPDC = LPDC'

% --------------------- Data ------------------------ %
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\Functions');
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\DataSet\Scenario001Dataset');
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\DataSet\Scenario002Dataset');
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\DataSet\Scenario003Dataset');

load('Tr0101');
load('Tr0102');
load('Tr0103');
load('Tr0201');
load('Tr0301');

Tr01 = Tr0101;
Tr02 = Tr0201;
Tr03 = Tr0301; % PPT but close presenter
Tr0302 = Tr0102;
Tr0301 = Tr0103;

%Tr03 = zeros(8,8,18);

% ---- Reshaping all the 3D matrices ------- %
[NewTr01] = fReshapingMats(Tr01);
[NewTr02] = fReshapingMats(Tr02);
[NewTr03] = fReshapingMats(Tr03);
[NewTr0302] = fReshapingMats(Tr0302);
[NewTr0301] = fReshapingMats(Tr0301);
% ----- Reassign Original Ones ------ %
Tr01 = NewTr01; % Tr01 --> Meeting
Tr02 = NewTr02; % Tr02 ---> Watch
Tr03 = NewTr03;% Tr03 ---> PPT but close presenter
Tr0302 = NewTr0302;% Tr0302 ----> PPT but far presenter
Tr0301 = NewTr0301; % Tr0301-----> Eat

% ----- Apply the Compressive Sensing Techniques ------ %

[CSTr01,CSTr02,CSTr03,CSTr0302,CSTr0301] = fComSenCreateTrData02(LDPC,Tr01,Tr02,Tr03,Tr0302,Tr0301);

Tr01 = CSTr01;
Tr02 = CSTr02;
Tr03 = CSTr03;
Tr0302 = CSTr0302;
Tr0301 = CSTr0301;
% ------- Common Parameters ------ %
MiXComp = 1;RunTransInv = 1;ShowImg = 0;


% -------- BUILD MODELS -------- %
% Scenario # 0101 %
% Number of Latent Variables %
LV =3;FigNum = 101;
[LogLMeet,ModelMeet]=BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg); %%(:,:,1:14)

% Scenario # 0201 %
% Number of Latent Variables %
LV =3;FigNum = 201;
[LogLWatch,ModelWatch]=BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg); %%(:,:,1:14)

% Scenario # 0102 %
% Number of Latent Variables %
LV = 3;FigNum = 102;
[LogLPPT,ModelPPT]=BTPCA(Tr03,LV,MiXComp,RunTransInv,ShowImg); %%(:,:,1:14)

% Scenario # 0103 %
% Number of Latent Variables %
LV =3;FigNum = 103;
[LogLPPT02,ModelPPT02]=BTPCA(Tr0302,LV,MiXComp,RunTransInv,ShowImg); %%(:,:,1:14)

% Scenario # 0301 %
% Number of Latent Variables %
LV = 3;FigNum = 301;
[LogLEAT02,ModelEAT01]=BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg); %%(:,:,1:14)


% ----------- Turn off the 
ShowImg = 0;
% --------TEST MODELS -------- %
% Scenario # 1 %

[LogLSelfTestMeet,ModelMeet,qcn] = BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg,ModelMeet);
[LogLTestMeet01,ModelMeet,qcn] = BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg,ModelMeet);
[LogLTestMeet02,ModelMeet,qcn] = BTPCA(Tr03,LV,MiXComp,RunTransInv,ShowImg,ModelMeet);
[LogLTestMeet03,ModelMeet,qcn] = BTPCA(Tr0302,LV,MiXComp,RunTransInv,ShowImg,ModelMeet);
[LogLTestMeet0301,ModelMeet,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,ModelMeet);

 % Scenario # 2 %
 [LogLTestWatch01,ModelWatch,qcn] = BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg,ModelWatch);
 [LogLSelfTestWatch,ModelWatch,qcn] = BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg,ModelWatch);
 [LogLTestWatch02,ModelWatch,qcn] = BTPCA(Tr03,LV,MiXComp,RunTransInv,ShowImg,ModelWatch);
 [LogLTestWatch03,ModelWatch,qcn] = BTPCA(Tr0302,LV,MiXComp,RunTransInv,ShowImg,ModelWatch);
 [LogLTestWatch0301,ModelWatch,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,ModelWatch);
 
 % Scenario # 3 %
 [LogLTestPPT01,ModelPPT,qcn] = BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg,ModelPPT);
 [LogLTestPPT02,ModelPPT,qcn] = BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg,ModelPPT);
 [LogLSelfTestPPT,ModelPPT,qcn] = BTPCA(Tr03,LV,MiXComp,RunTransInv,ShowImg,ModelPPT);
 [LogLTestPPT03,ModelPPT,qcn] = BTPCA(Tr0302,LV,MiXComp,RunTransInv,ShowImg,ModelPPT);
 [LogLTestPPT0301,ModelPPT,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,ModelPPT);
 
 % Scenario # 0302 %
 [LogLTestPPT0102,ModelPPT02,qcn] = BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg,ModelPPT02);
 [LogLTestPPT0202 ,ModelPPT02,qcn] = BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg,ModelPPT02);
 [LogLSelfTestPPT02,ModelPPT02,qcn] = BTPCA(Tr03,LV,MiXComp,RunTransInv,ShowImg,ModelPPT02);
 [LogLTestPPT0302,ModelPPT02,qcn] = BTPCA(Tr0302,LV,MiXComp,RunTransInv,ShowImg,ModelPPT02);
 [LogLTestPPT03011,ModelPPT02,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,ModelPPT02);

  % Scenario # 0301 %
 [LogLTestEAT0102,ModelEAT01,qcn] = BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg,ModelEAT01);
 [LogLTestEAT0202 ,ModelEAT01,qcn] = BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg,ModelEAT01);
 [LogLTestEAT02,ModelEAT01,qcn] = BTPCA(Tr03,LV,MiXComp,RunTransInv,ShowImg,ModelEAT01);
 [LogLTestEAT0302,ModelEAT01,qcn] = BTPCA(Tr0302,LV,MiXComp,RunTransInv,ShowImg,ModelEAT01);
 [LogLSelTestEAT0301,ModelEAT01,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,ModelEAT01);
 
 
 % Compare the Log Lkhds %
clc;
% TrainMeet = LogLMeet(end);
% TrainWatch = LogLWatch(end);
% TrainPPT = LogLPPT(end);
% TrainPPT02 = LogLPPT02(end);
% % ---- (1) ------ %
% SelfTestMeet = LogLSelfTestMeet(end);
% TestMeet01 = LogLTestMeet01(end);
% TestMeet02 = LogLTestMeet02(end);
% TestMeet03 = LogLTestMeet03(end);
% % ---- (2) ------ %
% SelfTestWatch = LogLSelfTestWatch(end);
% TestWatch01 = LogLTestWatch01(end);
% TestWatch02 = LogLTestWatch02(end);
% TestWatch03 = LogLTestWatch03(end);
% % ---- (3) ------ %
% SelfTestPPT = LogLSelfTestPPT(end);
% TestPPT01 = LogLTestPPT01(end);
% TestPPT02 = LogLTestPPT02(end);
% TestPPT03 = LogLTestPPT03(end);
% % ---- (0302) ------ %
% SelfTestPPT02 = LogLSelfTestPPT02(end);
% TestPPT0102 = LogLTestPPT0102(end);
% TestPPT0202 = LogLTestPPT0202(end);
% TestPPT0302 = LogLTestPPT0302(end);
% ------------------------------------------------------ %


% R1_TrLL = [LogLSelfTestMeet(end),LogLTestMeet01(end),LogLTestMeet02(end),LogLTestMeet03(end);
%                     LogLTestWatch01(end),LogLSelfTestWatch(end),LogLTestWatch02(end),LogLTestWatch03(end);
%                      LogLTestPPT01(end), LogLTestPPT02(end),LogLSelfTestPPT(end), LogLTestPPT03(end);
%                      LogLTestPPT0102(end), LogLTestPPT0202(end), LogLTestPPT0302(end),LogLSelfTestPPT(end)];
% 
% printmat(R1_TrLL, 'LogLikVsScs', 'LogLik_Model1 LogLik_Model2 LogLik_Model3  LogLik_Model302', 'Sc01   Sc02    Sc03   Sc0302 ' )

% R1_TrLL = [LogLSelfTestMeet(end),LogLTestMeet01(end),LogLTestMeet0301(end);
%                     LogLTestWatch01(end),LogLSelfTestWatch(end),LogLTestWatch0301(end);
%                      LogLTestPPT01(end), LogLTestPPT02(end),LogLTestPPT0301(end);
%                      LogLTestPPT0102(end), LogLTestPPT0202(end),LogLTestPPT03011(end);
%                      LogLTestPPT0102(end),LogLTestPPT0202(end),LogLTestPPT03012(end)];
% 
% printmat(R1_TrLL, 'LogLikVsScs', 'LogLik_Sc101  LogLik_Sc02 LogLik_Sc102 LogLik_Sc103 LogLik_Sc301', 'Sc01   Sc02  Sc03 ' )



Vec = [LogLTestMeet01(end),LogLTestMeet02(end),LogLTestMeet03(end),LogLTestMeet0301(end)];


R2_TrLL = [LogLSelfTestMeet(end),LogLTestMeet01(end),LogLTestMeet0301(end);% Model Meet applied on Data from Sc0101(Meet), Data from Sc0201(Watch), Data from Sc0301(Eat) 
                    LogLTestWatch01(end),LogLSelfTestWatch(end),LogLTestWatch0301(end); % Model Watch applied on Data from Sc0101(Meet), Data from Sc0201(Watch), Data from Sc0301(Eat) 
                     LogLTestMeet02(end), LogLTestPPT02(end),LogLTestPPT0301(end);% Model PPT(close) applied on Data from Sc0101(Meet), Data from Sc0201(Watch), Data from Sc0301(Eat) 
                     LogLTestMeet03(end), LogLTestPPT0202(end),LogLTestPPT03011(end);% Model  PPT(far) applied on Data from Sc0101(Meet), Data from Sc0201(Watch), Data from Sc0301(Eat)
                     LogLTestEAT0102(end),LogLTestEAT0202(end),LogLSelTestEAT0301(end)];

printmat(R2_TrLL, 'LogLikVsScs', 'ModelMeet  ModelWatch ModelPPT1 ModelPPT2 ModelEat', 'D_Meet   D_Watch  D_Eat ' )



R3_TrLL = [LogLTestPPT01(end),LogLTestMeet01(end),LogLTestMeet0301(end);% Model Meet applied on Data from Sc0101(Meet), Data from Sc0201(Watch), Data from Sc0301(Eat) 
                    LogLTestWatch01(end),LogLSelfTestWatch(end),LogLTestWatch0301(end); % Model Watch applied on Data from Sc0101(Meet), Data from Sc0201(Watch), Data from Sc0301(Eat) 
                    LogLSelfTestPPT(end), LogLTestPPT02(end),LogLTestPPT0301(end);% Model PPT(close) applied on Data from Sc0101(Meet), Data from Sc0201(Watch), Data from Sc0301(Eat) 
                    LogLTestPPT03(end), LogLTestPPT0202(end),LogLTestPPT03011(end);% Model  PPT(far) applied on Data from Sc0101(Meet), Data from Sc0201(Watch), Data from Sc0301(Eat)
                     LogLTestEAT0102(end),LogLTestEAT0202(end),LogLSelTestEAT0301(end)];

printmat(R3_TrLL, 'LogLikVsScs', 'ModelMeet  ModelWatch ModelPPT1 ModelPPT2 ModelEat', 'D_Meet   D_Watch  D_Eat ' )




R4_TrLL = [LogLTestPPT0102(end),LogLTestMeet01(end),LogLTestMeet0301(end);% Model Meet applied on Data from Sc0101(Meet), Data from Sc0201(Watch), Data from Sc0301(Eat) 
                    LogLTestWatch01(end),LogLSelfTestWatch(end),LogLTestWatch0301(end); % Model Watch applied on Data from Sc0101(Meet), Data from Sc0201(Watch), Data from Sc0301(Eat) 
                    LogLSelfTestPPT02(end), LogLTestPPT02(end),LogLTestPPT0301(end);% Model PPT(close) applied on Data from Sc0101(Meet), Data from Sc0201(Watch), Data from Sc0301(Eat) 
                    LogLTestPPT0302(end), LogLTestPPT0202(end),LogLTestPPT03011(end);% Model  PPT(far) applied on Data from Sc0101(Meet), Data from Sc0201(Watch), Data from Sc0301(Eat)
                     LogLTestEAT0102(end),LogLTestEAT0202(end),LogLSelTestEAT0301(end)];

printmat(R4_TrLL, 'LogLikVsScs', 'ModelMeet  ModelWatch ModelPPT1 ModelPPT2 ModelEat', 'D_Meet   D_Watch  D_Eat ' )











