% This code is to check the working of the BTPCA algorithm 
% if it works or not for the given scenarios 
clc;clear all;close all;

global FigNum;

addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\Functions');
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\DataSet\Scenario001Dataset');
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\DataSet\Scenario002Dataset');
addpath('C:\Users\3003\Dropbox\Walker_Coding\Test_Performance_btPCA\DataSet\Scenario003Dataset');

load('Tr0101');
load('Tr0102');
load('Tr0103');
load('Tr0201');
load('Tr0202');
load('Tr0301');

%Tr03 = zeros(8,8,18);

% ---- Reshaping all the 3D matrices ------- %
[NewTr0101] = fReshapingMats(Tr0101);
[NewTr0102] = fReshapingMats(Tr0102);
[NewTr0103] = fReshapingMats(Tr0103);

[NewTr0201] = fReshapingMats(Tr0201);
[NewTr0202] = fReshapingMats(Tr0202);

[NewTr0301] = fReshapingMats(Tr0301);
% ----- Reassign Original Ones ------ %
Tr0101 = NewTr0101;
Tr0102 = NewTr0102;
Tr0103 = NewTr0103;

Tr0201 = NewTr0201;
Tr0202 = NewTr0202;

Tr0301 = NewTr0301;

% Common Parameters %
MiXComp = 1;RunTransInv = 1;ShowImg = 0;

% -------- BUILD MODELS -------- %

% ------------------ Scenario # 0101 -------------------- %
% Number of Latent Variables %
LV = 4;FigNum = 101;
[LogL0101,Model0101]=BTPCA(Tr0101,LV,MiXComp,RunTransInv,ShowImg);
%[LogL0101,Model0101]=BTPCA(Tr0101,LV,MiXComp,RunTransInv,ShowImg,Model0101);

% Scenario # 0102 %
% Number of Latent Variables %
LV = 4;FigNum = 102;
[LogL0102,Model0102]=BTPCA(Tr0102,LV,MiXComp,RunTransInv,ShowImg);
%[LogL0102,Model0102]=BTPCA(Tr0102,LV,MiXComp,RunTransInv,ShowImg,Model0102);

% Scenario # 0103 %
% Number of Latent Variables %
LV = 4;FigNum = 103;
[LogL0103,Model0103]=BTPCA(Tr0103,LV,MiXComp,RunTransInv,ShowImg);
%[LogL0103,Model0103]=BTPCA(Tr0103,LV,MiXComp,RunTransInv,ShowImg,Model0103);

% ------------------- Scenario # 0201 --------------------- %
% Number of Latent Variables %
LV = 4;FigNum = 201;
[LogL0201,Model0201]=BTPCA(Tr0201,LV,MiXComp,RunTransInv,ShowImg);
%[LogL0201,Model0201]=BTPCA(Tr0201,LV,MiXComp,RunTransInv,ShowImg,Model0201);

% ------------------- Scenario # 0202 --------------------- %
% Number of Latent Variables %
LV = 4;FigNum = 202;
[LogL0202,Model0202]=BTPCA(Tr0202,LV,MiXComp,RunTransInv,ShowImg);
%[LogL0202,Model0202]=BTPCA(Tr0202,LV,MiXComp,RunTransInv,ShowImg,Model0202);

% -------------------- Scenario # 0301 ---------------------- %
% Number of Latent Variables %
LV = 4;FigNum = 301;
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
[TestLogL0202_11,Model0101,qcn] = BTPCA(Tr0202,LV,MiXComp,RunTransInv,ShowImg,Model0101);

[TestLogL0301_11,Model0101,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,Model0101);

% ===== Using Model develop from Scenario # 0102 ===== %

[TestLogL0101_12,Model0102,qcn] = BTPCA(Tr0101,LV,MiXComp,RunTransInv,ShowImg,Model0102);
[TestLogL0102_12,Model0102,qcn] = BTPCA(Tr0102,LV,MiXComp,RunTransInv,ShowImg,Model0102);
[TestLogL0103_12,Model0102,qcn] = BTPCA(Tr0103,LV,MiXComp,RunTransInv,ShowImg,Model0102);

[TestLogL0201_12,Model0102,qcn] = BTPCA(Tr0201,LV,MiXComp,RunTransInv,ShowImg,Model0102);
[TestLogL0202_12,Model0102,qcn] = BTPCA(Tr0202,LV,MiXComp,RunTransInv,ShowImg,Model0102);

[TestLogL0301_12,Model0102,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,Model0102);

% ===== Using Model develop from Scenario # 0103 ===== %

[TestLogL0101_13,Model0103,qcn] = BTPCA(Tr0101,LV,MiXComp,RunTransInv,ShowImg,Model0103);
[TestLogL0102_13,Model0103,qcn] = BTPCA(Tr0102,LV,MiXComp,RunTransInv,ShowImg,Model0103);
[TestLogL0103_13,Model0103,qcn] = BTPCA(Tr0103,LV,MiXComp,RunTransInv,ShowImg,Model0103);

[TestLogL0201_13,Model0103,qcn] = BTPCA(Tr0201,LV,MiXComp,RunTransInv,ShowImg,Model0103);
[TestLogL0202_13,Model0103,qcn] = BTPCA(Tr0202,LV,MiXComp,RunTransInv,ShowImg,Model0103);

[TestLogL0301_13,Model0103,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,Model0103);

% ===== Using Model develop from Scenario # 0201 ===== %
 [TestLogL0101_21,Model0201,qcn] = BTPCA(Tr0101,LV,MiXComp,RunTransInv,ShowImg,Model0201);
 [TestLogL0102_21,Model0201,qcn] = BTPCA(Tr0102,LV,MiXComp,RunTransInv,ShowImg,Model0201);
 [TestLogL0103_21,Model0201,qcn] = BTPCA(Tr0103,LV,MiXComp,RunTransInv,ShowImg,Model0201);
 
 [TestLogL0201_21,Model0201,qcn] = BTPCA(Tr0201,LV,MiXComp,RunTransInv,ShowImg,Model0201);
 [TestLogL0202_21,Model0201,qcn] = BTPCA(Tr0202,LV,MiXComp,RunTransInv,ShowImg,Model0201);
 
 [TestLogL0301_21,Model0201,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,Model0201);
 
 % ===== Using Model develop from Scenario # 0202 ===== %
 [TestLogL0101_22,Model0202,qcn] = BTPCA(Tr0101,LV,MiXComp,RunTransInv,ShowImg,Model0202);
 [TestLogL0102_22,Model0202,qcn] = BTPCA(Tr0102,LV,MiXComp,RunTransInv,ShowImg,Model0202);
 [TestLogL0103_22,Model0202,qcn] = BTPCA(Tr0103,LV,MiXComp,RunTransInv,ShowImg,Model0202);
 
 [TestLogL0201_22,Model0202,qcn] = BTPCA(Tr0201,LV,MiXComp,RunTransInv,ShowImg,Model0202);
 [TestLogL0202_22,Model0202,qcn] = BTPCA(Tr0202,LV,MiXComp,RunTransInv,ShowImg,Model0202);
 
 [TestLogL0301_22,Model0202,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,Model0202);
 
 % ===== Using Model develop from Scenario # 0301 ===== %
 [TestLogL0101_31,Model0301,qcn] = BTPCA(Tr0101,LV,MiXComp,RunTransInv,ShowImg,Model0301);
 [TestLogL0102_31,Model0301,qcn] = BTPCA(Tr0102,LV,MiXComp,RunTransInv,ShowImg,Model0301);
 [TestLogL0103_31,Model0301,qcn] = BTPCA(Tr0103,LV,MiXComp,RunTransInv,ShowImg,Model0301);
 
 [TestLogL0201_31,Model0301,qcn] = BTPCA(Tr0201,LV,MiXComp,RunTransInv,ShowImg,Model0301);
 [TestLogL0202_31,Model0301,qcn] = BTPCA(Tr0202,LV,MiXComp,RunTransInv,ShowImg,Model0301);
  
[TestLogL0301_31,Model0301,qcn] = BTPCA(Tr0301,LV,MiXComp,RunTransInv,ShowImg,Model0301);
 
% Compare the Log Lkhds %
clc;

% ------------------------------------------------------ %

R1_TrLL = [TestLogL0101_11(end),TestLogL0102_11(end),TestLogL0103_11(end),TestLogL0201_11(end),TestLogL0202_11(end),TestLogL0301_11(end);
                   TestLogL0101_12(end),TestLogL0102_12(end),TestLogL0103_12(end),TestLogL0201_12(end),TestLogL0202_12(end),TestLogL0301_12(end);
                   TestLogL0101_13(end),TestLogL0102_13(end),TestLogL0103_13(end),TestLogL0201_13(end),TestLogL0202_13(end),TestLogL0301_13(end);
                   TestLogL0101_21(end),TestLogL0102_21(end),TestLogL0103_21(end),TestLogL0201_21(end),TestLogL0202_21(end),TestLogL0301_21(end);
                   TestLogL0101_22(end),TestLogL0102_22(end),TestLogL0103_22(end),TestLogL0201_22(end),TestLogL0202_22(end),TestLogL0301_22(end);
                   TestLogL0101_31(end),TestLogL0102_31(end),TestLogL0103_31(end),TestLogL0201_31(end),TestLogL0202_31(end),TestLogL0301_31(end)];

printmat(R1_TrLL, 'Model Vs LogLikhds', 'Model_Sc101 Model_Sc102 Model_Sc103 Model_Sc201 Model_Sc202 Model_Sc301' , ' 101 102 103 201  202 301 ' )


% Test Again %

[h,w,l]=size(Tr0101);
for i = 1 : 1 : l
    TempMat = Tr0101(:,:,3);    
    Test_Tr0101(:,1,i) = TempMat; % a single column in each element
end


[TT0101_21,Model0101,qcn] = BTPCA(Test_Tr0101,LV,MiXComp,RunTransInv,ShowImg,Model0101)












