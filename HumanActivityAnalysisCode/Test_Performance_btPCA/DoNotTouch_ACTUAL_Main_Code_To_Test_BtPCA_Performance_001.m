% This code is to check the working of the BTPCA algorithm 
% if it works or not for the given scenarios 
clc;clear all;close all;

global FigNum;

addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\Functions');
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\DataSet\Scenario001Dataset');
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\DataSet\Scenario002Dataset');
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\DataSet\Scenario003Dataset');

load('Tr0101');
load('Tr0201');
load('Tr0102');
load('Tr0103');

%Tr03 = zeros(8,8,18);

% ---- Reshaping all the 3D matrices ------- %
[h,w,l]=size(Tr01);
for i = 1 : 1 : l
    TempMat = Tr01(:,:,i);
    TempMat = reshape(TempMat,h*w,1);    
    NewTr01(:,1,i) = TempMat;
end

[h,w,l]=size(Tr02);
for i = 1 : 1 : l
    TempMat = Tr02(:,:,i);
    TempMat = reshape(TempMat,h*w,1);    
    NewTr02(:,1,i) = TempMat;
end

[h,w,l]=size(Tr03);
for i = 1 : 1 : l
    TempMat = Tr03(:,:,i);
    TempMat = reshape(TempMat,h*w,1);    
    NewTr03(:,1,i) = TempMat;
end

[h,w,l]=size(Tr0302);
for i = 1 : 1 : l
    TempMat = Tr0302(:,:,i);
    TempMat = reshape(TempMat,h*w,1);    
    NewTr0302(:,1,i) = TempMat;
end

% ----- Reassign Original Ones ------ %
Tr01 = NewTr01;
Tr02 = NewTr02;
Tr03 = NewTr03;
Tr0302 = NewTr0302;


% Common Parameters %
MiXComp = 1;RunTransInv = 1;ShowImg = 0;

% -------- BUILD MODELS -------- %
% Scenario # 1 %
% Number of Latent Variables %
LV = 4;FigNum = 1111;
[LogLMeet,ModelMeet]=BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg);

% Scenario # 2 %
% Number of Latent Variables %
LV = 4;FigNum = 2222;
[LogLWatch,ModelWatch]=BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg);

% Scenario # 3 %
% Number of Latent Variables %
LV = 4;FigNum = 3333;
[LogLPPT,ModelPPT]=BTPCA(Tr03,LV,MiXComp,RunTransInv,ShowImg);

% Scenario # 0302 %
% Number of Latent Variables %
LV = 4;FigNum = 3302;
[LogLPPT02,ModelPPT02]=BTPCA(Tr0302,LV,MiXComp,RunTransInv,ShowImg);

% ----------- Turn off the 
ShowImg = 0;
% --------TEST MODELS -------- %
% Scenario # 1 %

[LogLSelfTestMeet,ModelMeet,qcn] = BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg,ModelMeet);
[LogLTestMeet01,ModelMeet,qcn] = BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg,ModelMeet);
[LogLTestMeet02,ModelMeet,qcn] = BTPCA(Tr03,LV,MiXComp,RunTransInv,ShowImg,ModelMeet);
[LogLTestMeet03,ModelMeet,qcn] = BTPCA(Tr0302,LV,MiXComp,RunTransInv,ShowImg,ModelMeet);

 % Scenario # 2 %
 [LogLTestWatch01,ModelWatch,qcn] = BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg,ModelWatch);
 [LogLSelfTestWatch,ModelWatch,qcn] = BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg,ModelWatch);
 [LogLTestWatch02,ModelWatch,qcn] = BTPCA(Tr03,LV,MiXComp,RunTransInv,ShowImg,ModelWatch);
 [LogLTestWatch03,ModelWatch,qcn] = BTPCA(Tr0302,LV,MiXComp,RunTransInv,ShowImg,ModelWatch);
 
 % Scenario # 3 %
 [LogLTestPPT01,ModelPPT,qcn] = BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg,ModelPPT);
 [LogLTestPPT02,ModelPPT,qcn] = BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg,ModelPPT);
 [LogLSelfTestPPT,ModelPPT,qcn] = BTPCA(Tr03,LV,MiXComp,RunTransInv,ShowImg,ModelPPT);
 [LogLTestPPT03,ModelPPT,qcn] = BTPCA(Tr0302,LV,MiXComp,RunTransInv,ShowImg,ModelPPT);
 
 % Scenario # 0302 %
 [LogLTestPPT0102,ModelPPT02,qcn] = BTPCA(Tr01,LV,MiXComp,RunTransInv,ShowImg,ModelPPT02);
 [LogLTestPPT0202 ,ModelPPT02,qcn] = BTPCA(Tr02,LV,MiXComp,RunTransInv,ShowImg,ModelPPT02);
 [LogLSelfTestPPT02,ModelPPT02,qcn] = BTPCA(Tr03,LV,MiXComp,RunTransInv,ShowImg,ModelPPT02);
 [LogLTestPPT0302,ModelPPT02,qcn] = BTPCA(Tr0302,LV,MiXComp,RunTransInv,ShowImg,ModelPPT02);
 
 
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



R1_TrLL = [LogLSelfTestMeet(end),LogLTestMeet01(end);
                    LogLTestWatch01(end),LogLSelfTestWatch(end);
                     LogLTestPPT01(end), LogLTestPPT02(end);
                     LogLTestPPT0102(end), LogLTestPPT0202(end)];

printmat(R1_TrLL, 'LogLikVsScs', 'LogLik_Sc101  LogLik_Sc02 LogLik_Sc102 LogLik_Sc103', 'Sc01   Sc02   ' )





