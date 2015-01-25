% ---                                                --- %
% ---                   Description                  --- %
% ---                                                --- %

% This code is used to develop a "8 x 8 grid structure", coded by using
% LDPC code. The geometry of the individual is recognized using the
% low-dimensional vectors 

% Date :: 29 Oct 2014

% Create :: (rand(1,25)<0.2)

clc;clear all;close all;

% ----------- Initialization -------------- %
%addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bPCA\Main_Functions\');
addpath('C:\Users\Yuri\Dropbox\Walker_Coding\AprilProposalDefendeCodes\ProposalDefenseCodes\Codes_for_bPCA\Main_Functions\');
addpath('C:\Users\3003\Dropbox\Walker_Coding\AprilProposalDefendeCodes\ProposalDefenseCodes\Codes_for_bPCA\Main_Functions\');

clc;

LineWidth = 1.5;FontSize = 13.0;

% figure(1);hold on;box on;title('Latent = 1,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(2);hold on;box on;title('Latent = 2,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(3);hold on;box on;title('Latent = 3,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(4);hold on;box on;title('Latent = 4,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(5);hold on;box on;title('Latent = 5,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(6);hold on;box on;title('Latent = 6,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(7);hold on;box on;title('Latent = 7,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(8);hold on;box on;title('Latent = 8,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(9);hold on;box on;title('Latent = 9,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(10);hold on;box on;title('Latent = 10,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(11);hold on;box on;title('Latent = 11,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(12);hold on;box on;title('Latent = 12,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(13);hold on;box on;title('Latent = 13,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(14);hold on;box on;title('Latent = 14,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(15);hold on;box on;title('Latent = 15,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(16);hold on;box on;title('Latent = 16,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);


D = 15; % Length of each code
Blocks = (5*5);

LDPC = gen_ldpc(D,Blocks);
%LPDC = LPDC'

% ----- Data for scenario 1 ------ %
%[TrSc01,TrSc02,TrSc03,TrSc04] = fComSenCreateData002(LDPC,Blocks);
[TrSc01,TrSc02,TrSc03,TrSc04,TstSc01,TstSc02,TstSc03,TstSc04] = fComSenCreateTrTest002(LDPC,Blocks);
% <> ------------- <> --------------- <><> ------------ <> ---------- <>  %

%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==1 -----
%%%LineWidth,FontSize,
LV = 1;fig = 1;Plot = 0;
[MSc01LV1,MSc02LV1,MSc03LV1,MSc04LV1,LLSc01LV1,LLSc02LV1,LLSc03LV1,LLSc04LV1] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==2 ----- %
LV = 2;fig = 2;Plot = 0;
[MSc01LV2,MSc02LV2,MSc03LV2,MSc04LV2,LLSc01LV2,LLSc02LV2,LLSc03LV2,LLSc04LV2] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==3 ----- %
LV = 3;fig = 3;Plot = 0;
[MSc01LV3,MSc02LV3,MSc03LV3,MSc04LV3,LLSc01LV3,LLSc02LV3,LLSc03LV3,LLSc04LV3] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==4 ----- %
LV = 4;fig = 4;Plot = 0;
[MSc01LV4,MSc02LV4,MSc03LV4,MSc04LV4,LLSc01LV4,LLSc02LV4,LLSc03LV4,LLSc04LV4] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==5 ----- %
LV = 5;fig = 5;Plot = 0;
[MSc01LV5,MSc02LV5,MSc03LV5,MSc04LV5,LLSc01LV5,LLSc02LV5,LLSc03LV5,LLSc04LV5] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==6 ----- %
LV = 6;fig = 6;Plot = 0;
[MSc01LV6,MSc02LV6,MSc03LV6,MSc04LV6,LLSc01LV6,LLSc02LV6,LLSc03LV6,LLSc04LV6] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==7 ----- %
LV = 7;fig = 7;Plot = 0;
[MSc01LV7,MSc02LV7,MSc03LV7,MSc04LV7,LLSc01LV7,LLSc02LV7,LLSc03LV7,LLSc04LV7] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==8 ----- %
LV = 8;fig = 8;Plot = 0;
[MSc01LV8,MSc02LV8,MSc03LV8,MSc04LV8,LLSc01LV8,LLSc02LV8,LLSc03LV8,LLSc04LV8] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==9 ----- %
LV = 9;fig = 9;Plot = 0;
[MSc01LV9,MSc02LV9,MSc03LV9,MSc04LV9,LLSc01LV9,LLSc02LV9,LLSc03LV9,LLSc04LV9] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==10 ----- %
LV = 10;fig = 10;Plot = 0;
[MSc01LV10,MSc02LV10,MSc03LV10,MSc04LV10,LLSc01LV10,LLSc02LV10,LLSc03LV10,LLSc04LV10] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==11 ----- %
LV = 11;fig = 11;Plot = 0;
[MSc01LV11,MSc02LV11,MSc03LV11,MSc04LV11,LLSc01LV11,LLSc02LV11,LLSc03LV11,LLSc04LV11] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==12 ----- %
LV = 12;fig = 12;Plot = 0;
[MSc01LV12,MSc02LV12,MSc03LV12,MSc04LV12,LLSc01LV12,LLSc02LV12,LLSc03LV12,LLSc04LV12] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==13 ----- %
LV = 13;fig = 13;Plot = 0;
[MSc01LV13,MSc02LV13,MSc03LV13,MSc04LV13,LLSc01LV13,LLSc02LV13,LLSc03LV13,LLSc04LV13] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==14 ----- %
LV = 14;fig = 14;Plot = 0;
[MSc01LV14,MSc02LV14,MSc03LV14,MSc04LV14,LLSc01LV14,LLSc02LV14,LLSc03LV14,LLSc04LV14] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==15 ----- %
LV = 15;fig = 15;Plot = 0;
[MSc01LV15,MSc02LV15,MSc03LV15,MSc04LV15,LLSc01LV15,LLSc02LV15,LLSc03LV15,LLSc04LV15] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==16 ----- %
LV = 16;fig = 16;Plot = 0;
[MSc01LV16,MSc02LV16,MSc03LV16,MSc04LV16,LLSc01LV16,LLSc02LV16,LLSc03LV16,LLSc04LV16] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==17 ----- %
LV = 17;fig = 17;Plot = 0;
[MSc01LV17,MSc02LV17,MSc03LV17,MSc04LV17,LLSc01LV17,LLSc02LV17,LLSc03LV17,LLSc04LV17] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==18 ----- %
LV = 18;fig = 18;Plot = 0;
[MSc01LV18,MSc02LV18,MSc03LV18,MSc04LV18,LLSc01LV18,LLSc02LV18,LLSc03LV18,LLSc04LV18] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==19 ----- %
LV = 19;fig = 19;Plot = 0;
[MSc01LV19,MSc02LV19,MSc03LV19,MSc04LV19,LLSc01LV19,LLSc02LV19,LLSc03LV19,LLSc04LV19] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);
%%------ Train your btPCA model for Scn 1,2,3,4 using LV ==19 ----- %
LV = 20;fig = 20;Plot = 0;
[MSc01LV20,MSc02LV20,MSc03LV20,MSc04LV20,LLSc01LV20,LLSc02LV20,LLSc03LV20,LLSc04LV20] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04);


% --------------------------<><><><><>----------------------------------- %
clc;

R1_TrLL = [max(LLSc01LV1), max(LLSc02LV1), max(LLSc03LV1), max(LLSc04LV1);
           max(LLSc01LV2), max(LLSc02LV2), max(LLSc03LV2), max(LLSc04LV2);
           max(LLSc01LV3), max(LLSc02LV3), max(LLSc03LV3), max(LLSc04LV3);
           max(LLSc01LV4), max(LLSc02LV4), max(LLSc03LV4), max(LLSc04LV4);
           max(LLSc01LV5), max(LLSc02LV5), max(LLSc03LV5), max(LLSc04LV5);
           max(LLSc01LV6), max(LLSc02LV6), max(LLSc03LV6), max(LLSc04LV6);
           max(LLSc01LV7), max(LLSc02LV7), max(LLSc03LV7), max(LLSc04LV7);
           max(LLSc01LV8), max(LLSc02LV8), max(LLSc03LV8), max(LLSc04LV8);
           max(LLSc01LV9), max(LLSc02LV9), max(LLSc03LV9), max(LLSc04LV9);
           max(LLSc01LV10), max(LLSc02LV10), max(LLSc03LV10), max(LLSc04LV10);
           max(LLSc01LV11), max(LLSc02LV11), max(LLSc03LV11), max(LLSc04LV11);
           max(LLSc01LV12), max(LLSc02LV12), max(LLSc03LV12), max(LLSc04LV12);
           max(LLSc01LV13), max(LLSc02LV13), max(LLSc03LV13), max(LLSc04LV13);
           max(LLSc01LV14), max(LLSc02LV14), max(LLSc03LV14), max(LLSc04LV14);
           max(LLSc01LV15), max(LLSc02LV15), max(LLSc03LV15), max(LLSc04LV15);
           max(LLSc01LV16), max(LLSc02LV16), max(LLSc03LV16), max(LLSc04LV16);
           max(LLSc01LV17), max(LLSc02LV17), max(LLSc03LV17), max(LLSc04LV17);
           max(LLSc01LV18), max(LLSc02LV18), max(LLSc03LV18), max(LLSc04LV18);
           max(LLSc01LV19), max(LLSc02LV19), max(LLSc03LV19), max(LLSc04LV19);
           max(LLSc01LV20), max(LLSc02LV20), max(LLSc03LV20), max(LLSc04LV20)];
printmat(R1_TrLL,'LogLikVsScs', 'BVs1 BVs2 BVs3 BVs4 BVs5 BVs6 BVs7 BVs8 BVs9 BVs10 BVs11 BVs12 BVs13 BVs14 BVs15 BVs16 BVs17 BVs18 BVs19 BVs20','Scenario1 Scenario2 Scenario3 Scenario4' )

% --------------------------<><><><><>----------------------------------- %

% <> ------------ <> --------------- <><> ------------ <> -------------- <>
%                              Generate Test Data                         %
%[] = fGetTestDataDiffScene002(CodeMatrix,LPDC);
% % <> ------------ <> --------------- <><> ------------ <> -------------- <>

%%$$ <>--<> Selected Model List <>--<> *** Do Not Forget to change this ***
MSc01 = MSc01LV7;
MSc02 = MSc02LV7;
MSc03 = MSc03LV7;
MSc04 = MSc04LV7;

LV = [];
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

R2_TrLL = [max(LL01TrSc1), max(LL02TrSc1), max(LL03TrSc1);
           max(LL01TrSc2), max(LL02TrSc2), max(LL03TrSc2);
           max(LL01TrSc3), max(LL02TrSc3), max(LL03TrSc3)];
printmat(R2_TrLL, 'Re-Test Train Data', 'TrSc01 TrSc02 TrSc03', 'Sc01_Model Sc02_Model Sc03_Model' )

fig1 = 1011;fig2 = 1012
Tr1 = TrSc01;
Basis1 = MSc01LV8.W;
[plt] = fplotbtPCA(Tr1,Basis1,fig1,fig2)

fig1 = 1013;fig2 = 1014
Tr2 = TrSc02;
Basis2 = MSc02LV8.W;
[plt] = fplotbtPCA(Tr2,Basis2,fig1,fig2)

fig1 = 1015;fig2 = 1016
Tr3 = TrSc03;
Basis3 = MSc03LV8.W;
[plt] = fplotbtPCA(Tr3,Basis3,fig1,fig2)



% % <> ------- Test Using Testing Data ------- <> % %
[LL01TstSc1,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstSc01,LV,1,1,0,MSc01);
[LL02TstSc1,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstSc01,LV,1,1,0,MSc02);
[LL03TstSc1,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstSc01,LV,1,1,0,MSc03);

[LL01TstSc2,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstSc02,LV,1,1,0,MSc01);
[LL02TstSc2,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstSc02,LV,1,1,0,MSc02);
[LL03TstSc2,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstSc02,LV,1,1,0,MSc03);

[LL01TstSc3,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstSc03,LV,1,1,0,MSc01);
[LL02TstSc3,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstSc03,LV,1,1,0,MSc02);
[LL03TstSc3,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstSc03,LV,1,1,0,MSc03);

R1_TstLL = [max(LL01TstSc1), max(LL02TstSc1), max(LL03TstSc1);
           max(LL01TstSc2), max(LL02TstSc2), max(LL03TstSc2);
           max(LL01TstSc3), max(LL02TstSc3), max(LL03TstSc3)];
printmat(R1_TstLL, 'Re-Test Train Data', 'TstSc01 TstSc02 TstSc03', 'Sc01_Model Sc02_Model Sc03_Model' )

fig1 = 2011;fig2 = 2012
Tst1 = TstSc01;
Basis1 = MSc01LV8.W;
[plt] = fplotbtPCA(Tst1,Basis1,fig1,fig2)

fig1 = 2013;fig2 = 2014
Tst2 = TstSc02;
Basis2 = MSc02LV8.W;
[plt] = fplotbtPCA(Tst2,Basis2,fig1,fig2)

fig1 = 2015;fig2 = 2016
Tst3 = TstSc03;
Basis3 = MSc03LV8.W;
[plt] = fplotbtPCA(Tst3,Basis3,fig1,fig2)

clc;
printmat(R1_TrLL,'LogLikVsScs', 'BVs1 BVs2 BVs3 BVs4 BVs5 BVs6 BVs7 BVs8 BVs9 BVs10 BVs11 BVs12 BVs13 BVs14 BVs15 BVs16 BVs17 BVs18 BVs19 BVs20','Scenario1 Scenario2 Scenario3 Scenario4' )
printmat(R2_TrLL, 'Re-Test Train Data', 'TrSc01 TrSc02 TrSc03', 'Sc01_Model Sc02_Model Sc03_Model' )
printmat(R1_TstLL, 'Re-Test Train Data', 'TstSc01 TstSc02 TstSc03', 'Sc01_Model Sc02_Model Sc03_Model' )


% Plot the U matrix of the BTPCA

figure,plot(MSc01LV8.U);




% % ----------------------------------
% Train Data % ROC
Outputs = [];

Outputs = R1_TrLL;

Targets = [1,0,0;0,1,0;0,0,1];

% % % [tpr,fpr] = roc(Targets,Outputs);
% % % 
% % % figure(11);hold on;box on;
% % % title('ROC curve');xlabel('False Positive Rate');
% % % ylabel('True Positive Rate');
% % % plot(fpr,tpr)
% % % 
% % % 
% % % % % ----------------------------------
% % % % Test Data % ROC
% % % Outputs = [];
% % % 
% % % Outputs = R1_TstLL;
% % % 
% % % Targets = [1,0,0;0,1,0;0,0,1];
% % % 
% % % [tpr,fpr] = roc(Targets,Outputs);
% % % 
% % % figure(22);hold on;box on;
% % % title('ROC curve');xlabel('False Positive Rate');
% % % ylabel('True Positive Rate');
% % % plot(fpr,tpr)
% % % 
% % % 
% % % 
% % % 
% % % % % ----------------------------------
% % % % Train-Test Data % ROC
% % % Outputs = [];
% % % 
% % % Outputs = cat(R1_TrLL,R1_TstLL,2);
% % % 
% % % Targets = cat([1,0,0;0,1,0;0,0,1],[1,0,0;0,1,0;0,0,1],2);
% % % 
% % % [tpr,fpr] = roc(Targets,Outputs);
% % % 
% % % figure(22);hold on;box on;
% % % title('ROC curve');xlabel('False Positive Rate');
% % % ylabel('True Positive Rate');
% % % plot(fpr,tpr)















