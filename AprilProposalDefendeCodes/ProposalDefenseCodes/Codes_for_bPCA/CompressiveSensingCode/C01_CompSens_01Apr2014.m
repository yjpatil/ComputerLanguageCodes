% ---                                                --- %
% ---                   Description                  --- %
% ---                                                --- %

% This code is used to develop a "8 x 8 grid structure", coded by using
% LDPC code. The geometry of the individual is recognized using the
% low-dimensional vectors 

% Date :: 1 Apr 2014

% Create :: (rand(1,25)<0.2)

clc;clear all;close all;

% ----------- Initialization -------------- %
%addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bPCA\Main_Functions\');
addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bPCA\Main_Functions\');

clc;

LineWidth = 1.5;FontSize = 13.0;

figure(1);hold on;title('Latent = 1,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
figure(2);hold on;title('Latent = 2,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
figure(3);hold on;title('Latent = 3,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
figure(4);hold on;title('Latent = 4,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
figure(5);hold on;title('Latent = 5,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
figure(6);hold on;title('Latent = 6,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
figure(7);hold on;title('Latent = 7,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
figure(8);hold on;title('Latent = 8,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);

D = 40; % Length of each code
Blocks = 36;

LDPC = gen_ldpc(D,Blocks);
%LPDC = LPDC'

% ----- Data for scenario 1 ------ %
[TrSc01,TrSc02,TrSc03,TrSc04] = fComSenCreateData001(LDPC,Blocks);

% <> ------------- <> --------------- <><> ------------ <> ---------- <>  %

%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==1 -----
%%%LineWidth,FontSize,
LV = 1;fig = 1;Plot = 1;
[MSc01LV1,MSc02LV1,MSc03LV1,MSc04LV1,LLSc01LV1,LLSc02LV1,LLSc03LV1,LLSc04LV1] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==2 ----- %
LV = 2;fig = 2;Plot = 1;
[MSc01LV2,MSc02LV2,MSc03LV2,MSc04LV2,LLSc01LV2,LLSc02LV2,LLSc03LV2,LLSc04LV2] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==3 ----- %
LV = 3;fig = 3;Plot = 1;
[MSc01LV3,MSc02LV3,MSc03LV3,MSc04LV3,LLSc01LV3,LLSc02LV3,LLSc03LV3,LLSc04LV3] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==4 ----- %
LV = 4;fig = 4;Plot = 1;
[MSc01LV4,MSc02LV4,MSc03LV4,MSc04LV4,LLSc01LV4,LLSc02LV4,LLSc03LV4,LLSc04LV4] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==5 ----- %
LV = 5;fig = 5;Plot = 1;
[MSc01LV5,MSc02LV5,MSc03LV5,MSc04LV5,LLSc01LV5,LLSc02LV5,LLSc03LV5,LLSc04LV5] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==6 ----- %
LV = 6;fig = 6;Plot = 1;
[MSc01LV6,MSc02LV6,MSc03LV6,MSc04LV6,LLSc01LV6,LLSc02LV6,LLSc03LV6,LLSc04LV6] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==7 ----- %
LV = 7;fig = 7;Plot = 1;
[MSc01LV7,MSc02LV7,MSc03LV7,MSc04LV7,LLSc01LV7,LLSc02LV7,LLSc03LV7,LLSc04LV7] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==8 ----- %
LV = 8;fig = 8;Plot = 1;
[MSc01LV8,MSc02LV8,MSc03LV8,MSc04LV8,LLSc01LV8,LLSc02LV8,LLSc03LV8,LLSc04LV8] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
% --------------------------<><><><><>----------------------------------- %
clc;

R1_TrLL = [max(LLSc01LV1), max(LLSc02LV1), max(LLSc03LV1), max(LLSc04LV1);
           max(LLSc01LV2), max(LLSc02LV2), max(LLSc03LV2), max(LLSc04LV2);
           max(LLSc01LV3), max(LLSc02LV3), max(LLSc03LV3), max(LLSc04LV3);
           max(LLSc01LV4), max(LLSc02LV4), max(LLSc03LV4), max(LLSc04LV4);
           max(LLSc01LV5), max(LLSc02LV5), max(LLSc03LV5), max(LLSc04LV5);
           max(LLSc01LV6), max(LLSc02LV6), max(LLSc03LV6), max(LLSc04LV6);
           max(LLSc01LV7), max(LLSc02LV7), max(LLSc03LV7), max(LLSc04LV7);
           max(LLSc01LV8), max(LLSc02LV8), max(LLSc03LV8), max(LLSc04LV8)];
printmat(R1_TrLL, 'LogLikVsScs', 'Basis_V1 Basis_V2 Basis_V3 Basis_V4 Basis_V5 Basis_V6 Basis_V7 Basis_V8', 'Scenario1 Scenario2 Scenario3 Scenario4' )

% --------------------------<><><><><>----------------------------------- %

% <> ------------ <> --------------- <><> ------------ <> -------------- <>
%                              Generate Test Data                         %
%[] = fGetTestDataDiffScene002(CodeMatrix,LPDC);
% % <> ------------ <> --------------- <><> ------------ <> -------------- <>

%%$$ <>--<> Selected Model List <>--<> *** Do Not Forget to change this ***
MSc01 = MSc01LV6;
MSc02 = MSc02LV6;
MSc03 = MSc03LV6;
MSc04 = MSc04LV6;


% % <> ------- Re-Test Using Training Data ------- <> % %
[LL01TrSc1,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc01,LV,1,1,0,MSc01);
[LL02TrSc1,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TrSc01,LV,1,1,0,MSc02);
[LL03TrSc1,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TrSc01,LV,1,1,0,MSc03);

[LL01TrSc2,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc02,LV,1,1,0,MSc01);
[LL02TrSc2,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TrSc02,LV,1,1,0,MSc02);
[LL03TrSc2,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TrSc02,LV,1,1,0,MSc03);

[LL01TrSc3,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc03,LV,1,1,0,MSc01);
[LL02TrSc3,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TrSc03,LV,1,1,0,MSc02);
[LL03TrSc3,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TrSc03,LV,1,1,0,MSc03);

R1_TrLL = [max(LL01TrSc1), max(LL02TrSc1), max(LL03TrSc1);
           max(LL01TrSc2), max(LL02TrSc2), max(LL03TrSc2);
           max(LL01TrSc3), max(LL02TrSc3), max(LL03TrSc3)];
printmat(R1_TrLL, 'Re-Test Train Data', 'TrSc01 TrSc02 TrSc03', 'Sc01_Model Sc02_Model Sc03_Model' )












