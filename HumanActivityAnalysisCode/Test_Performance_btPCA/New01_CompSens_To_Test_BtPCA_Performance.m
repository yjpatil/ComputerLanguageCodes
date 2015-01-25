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

% ---- Reshaping all the 3D matrices ------- %
[NewTr0101] = fReshapingMats(Tr0101);
[NewTr0102] = fReshapingMats(Tr0102);
[NewTr0103] = fReshapingMats(Tr0103);

[NewTr0201] = fReshapingMats(Tr0201);

[NewTr0301] = fReshapingMats(Tr0301);
% ----- Reassign Original Ones ------ %
Tr0101 = NewTr0101;
Tr0102 = NewTr0102;
Tr0103 = NewTr0103;

Tr0201 = NewTr0201;

Tr0301 = NewTr0301;

% ----- Apply the Compressive Sensing Techniques ------ %

[CSTr0101,CSTr0102,CSTr0103,CSTr0201,CSTr0301] = fComSenCreateTrData02(LDPC,Tr0101,Tr0102,Tr0103,Tr0201,Tr0301);

Tr0101 = CSTr0101;
Tr0102 = CSTr0102;
Tr0103 = CSTr0103;
Tr0201 = CSTr0201;
Tr0301 = CSTr0301;

% Common Parameters %
MiXComp = 1;RunTransInv = 1;ShowImg = 0;

% -------- BUILD MODELS -------- %

% ------------------ Scenario # 0101 -------------------- %
% Number of Latent Variables %
LV = 5;FigNum = 101;
[LogL0101,Model0101]=BTPCA(Tr0101,LV,MiXComp,RunTransInv,ShowImg); % Re-train the model untill the Loglikelihood decreases as small as possible
%[LogL0101,Model0101]=BTPCA(Tr0101,LV,MiXComp,RunTransInv,ShowImg,Model0101);

% Scenario # 0102 %
% Number of Latent Variables %
LV = 5;FigNum = 102;
[LogL0102,Model0102]=BTPCA(Tr0102,LV,MiXComp,RunTransInv,ShowImg);
%[LogL0102,Model0102]=BTPCA(Tr0102,LV,MiXComp,RunTransInv,ShowImg,Model0102);

% Scenario # 0103 %
% Number of Latent Variables %
LV = 5;FigNum = 103;
[LogL0103,Model0103]=BTPCA(Tr0103,LV,MiXComp,RunTransInv,ShowImg);
%[LogL0103,Model0103]=BTPCA(Tr0103,LV,MiXComp,RunTransInv,ShowImg,Model0103);

% ------------------- Scenario # 0201 --------------------- %
% Number of Latent Variables %
LV = 5;FigNum = 201;
[LogL0201,Model0201]=BTPCA(Tr0201,LV,MiXComp,RunTransInv,ShowImg);
%[LogL0201,Model0201]=BTPCA(Tr0201,LV,MiXComp,RunTransInv,ShowImg,Model0201);

% -------------------- Scenario # 0301 ---------------------- %
% Number of Latent Variables %
LV = 5;FigNum = 301;
[LogL0301,Model0301]=BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg);
%[LogL0301,Model0301]=BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,Model0301);


% ----------- Turn off the Printing ------------- %
ShowImg = 0;

% ------------------------------------------TEST MODELS ------------------------------------------------ %

% ===== Using Model develop from Scenario # 0101 ===== %

[TestLogL0101_11,Model0101,qcn] = BTPCA(Tr0101,LV,MiXComp,RunTransInv,ShowImg,Model0101);
[TestLogL0102_11,Model0101,qcn] = BTPCA(Tr0102,LV,MiXComp,RunTransInv,ShowImg,Model0101);
[TestLogL0103_11,Model0101,qcn] = BTPCA(Tr0103,LV,MiXComp,RunTransInv,ShowImg,Model0101);

[TestLogL0201_11,Model0101,qcn] = BTPCA(Tr0201,LV,MiXComp,RunTransInv,ShowImg,Model0101);

[TestLogL0301_11,Model0101,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,Model0101);

% ===== Using Model develop from Scenario # 0102 ===== %

[TestLogL0101_12,Model0102,qcn] = BTPCA(Tr0101,LV,MiXComp,RunTransInv,ShowImg,Model0102);
[TestLogL0102_12,Model0102,qcn] = BTPCA(Tr0102,LV,MiXComp,RunTransInv,ShowImg,Model0102);
[TestLogL0103_12,Model0102,qcn] = BTPCA(Tr0103,LV,MiXComp,RunTransInv,ShowImg,Model0102);

[TestLogL0201_12,Model0102,qcn] = BTPCA(Tr0201,LV,MiXComp,RunTransInv,ShowImg,Model0102);

[TestLogL0301_12,Model0102,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,Model0102);

% ===== Using Model develop from Scenario # 0103 ===== %

[TestLogL0101_13,Model0103,qcn] = BTPCA(Tr0101,LV,MiXComp,RunTransInv,ShowImg,Model0103);
[TestLogL0102_13,Model0103,qcn] = BTPCA(Tr0102,LV,MiXComp,RunTransInv,ShowImg,Model0103);
[TestLogL0103_13,Model0103,qcn] = BTPCA(Tr0103,LV,MiXComp,RunTransInv,ShowImg,Model0103);

[TestLogL0201_13,Model0103,qcn] = BTPCA(Tr0201,LV,MiXComp,RunTransInv,ShowImg,Model0103);

[TestLogL0301_13,Model0103,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,Model0103);

% ===== Using Model develop from Scenario # 0201 ===== %
 [TestLogL0101_21,Model0201,qcn] = BTPCA(Tr0101,LV,MiXComp,RunTransInv,ShowImg,Model0201);
 [TestLogL0102_21,Model0201,qcn] = BTPCA(Tr0102,LV,MiXComp,RunTransInv,ShowImg,Model0201);
 [TestLogL0103_21,Model0201,qcn] = BTPCA(Tr0103,LV,MiXComp,RunTransInv,ShowImg,Model0201);
 
 [TestLogL0201_21,Model0201,qcn] = BTPCA(Tr0201,LV,MiXComp,RunTransInv,ShowImg,Model0201);
 
 [TestLogL0301_21,Model0201,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,Model0201);
 
 % ===== Using Model develop from Scenario # 0301 ===== %
 [TestLogL0101_31,Model0301,qcn] = BTPCA(Tr0101,LV,MiXComp,RunTransInv,ShowImg,Model0301);
 [TestLogL0102_31,Model0301,qcn] = BTPCA(Tr0102,LV,MiXComp,RunTransInv,ShowImg,Model0301);
 [TestLogL0103_31,Model0301,qcn] = BTPCA(Tr0103,LV,MiXComp,RunTransInv,ShowImg,Model0301);
 
 [TestLogL0201_31,Model0301,qcn] = BTPCA(Tr0201,LV,MiXComp,RunTransInv,ShowImg,Model0301);
 
[TestLogL0301_31,Model0301,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,Model0301);
 
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



R2_TrLL = [TestLogL0101_11(end),TestLogL0102_11(end),TestLogL0103_11(end),TestLogL0201_11(end),TestLogL0301_11(end);
                   TestLogL0101_12(end),TestLogL0102_12(end),TestLogL0103_12(end),TestLogL0201_12(end),TestLogL0301_12(end);
                   TestLogL0101_13(end),TestLogL0102_13(end),TestLogL0103_13(end),TestLogL0201_13(end),TestLogL0301_13(end);
                   TestLogL0101_21(end),TestLogL0102_21(end),TestLogL0103_21(end),TestLogL0201_21(end),TestLogL0301_21(end);
                   TestLogL0101_31(end),TestLogL0102_31(end),TestLogL0103_31(end),TestLogL0201_31(end),TestLogL0301_31(end)];

printmat(R2_TrLL, 'Model Vs LogLikhds', 'Model_Sc101 Model_Sc102 Model_Sc103 Model_Sc201 Model_Sc202 Model_Sc301' , ' 101 102 103 201  202 301 ' )



















