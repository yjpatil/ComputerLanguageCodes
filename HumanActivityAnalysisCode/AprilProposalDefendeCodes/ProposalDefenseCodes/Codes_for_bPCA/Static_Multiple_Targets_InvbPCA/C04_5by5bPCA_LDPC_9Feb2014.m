% Code generates the LPDC codes and
% data01 Tested with 5BV
% data02 Tested with 4BV
% data03 Tested with 4BV
% data04 Tested with 6BV

clc;clear all;close all;

% ----------- Initialization -------------- %
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bPCA\Main_Functions\');
%addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bPCA\Main_Functions\');
clc;

LineWidth = 1.5;FontSize = 13.0;

% figure(1);hold on;title('Latent = 1,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(2);hold on;title('Latent = 2,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(3);hold on;title('Latent = 3,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(4);hold on;title('Latent = 4,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(5);hold on;title('Latent = 5,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(6);hold on;title('Latent = 6,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(7);hold on;title('Latent = 7,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);
% figure(8);hold on;title('Latent = 8,LogLikelihood for Different Scenarios','FontSize',FontSize);xlabel('iterations','FontSize',FontSize);ylabel('Log-likelihood','FontSize',FontSize);%colormap(gray);

D = 10; % Length of each code
Blocks = 25;

LPDC = gen_ldpc(D,Blocks);
LPDC = LPDC'; % These codes are right adjacent block codes

%%LPDC = gen_ldpc(Blocks,D);

% Code matrix tells you which block is the subject standing %
% For Example:: CodeMatrix(1,1)=Block#1 , CodeMatrix(4,3)=Block#15
CodeMatrix(1,:) = 1:5; % This is the coding of the blocks of 5 x 5
CodeMatrix(2,:) = 6:10; % This is the coding of the blocks of 5 x 5
CodeMatrix(3,:) = 11:15; % This is the coding of the blocks of 5 x 5
CodeMatrix(4,:) = 16:20; % This is the coding of the blocks of 5 x 5
CodeMatrix(5,:) = 21:25;% This is the coding of the blocks of 5 x 5
% ----------------- Training Stage ---------------------- %

   % Case = 4 means that you have 4 subjects in a group

[TrSc01,TrSc02,TrSc03,TrSc04] = fCreateScenData002(CodeMatrix,LPDC);
% %% <> ------------- <> ---------------- <><> ------------- <> ---------------- <>
LV = 1;
%%------ Train your btPCA model for Scenario 1 ----- %
[LLSc01LV1,MSc01LV1,qcn01,RelChangeSc01LV1] = BTPCA_modify(TrSc01,LV,1,0,0);
figure(1);Legend1 = plot(LLSc01LV1,'--k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 2 ----- %
[LLSc02LV1,MSc02LV1,qcn02,RelChangeSc02LV1] = BTPCA_modify(TrSc02,LV,1,0,0);
figure(1);Legend2 = plot(LLSc02LV1,'-.k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 3 ----- %
[LLSc03LV1,MSc03LV1,qcn03,RelChangeSc03LV1] = BTPCA_modify(TrSc03,LV,1,0,0);
figure(1);Legend3 = plot(LLSc03LV1,':k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 4 ----- %
[LLSc04LV1,MSc04LV1,qcn04,RelChangeSc04LV1] = BTPCA_modify(TrSc04,LV,1,0,0);
figure(1);Legend4 = plot(LLSc04LV1,'-k','LineWidth',LineWidth);

legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'},'FontSize',FontSize)
% %% <> ------------- <> ---------------- <><> ------------- <> ---------------- <>
LV = 2;
% ------ Train your btPCA model for Scenario 1 ----- %
[LLSc01LV2,MSc01LV2,qcn01,RelChangeSc01LV2] = BTPCA_modify(TrSc01,LV,1,0,1);
figure(2);Legend1 = plot(LLSc01LV2,'--k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 2 ----- %
[LLSc02LV2,MSc02LV2,qcn02,RelChangeSc02LV2] = BTPCA_modify(TrSc02,LV,1,0,1);
figure(2);Legend2 = plot(LLSc02LV2,'-.k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 3 ----- %
[LLSc03LV2,MSc03LV2,qcn03,RelChangeSc03LV2] = BTPCA_modify(TrSc03,LV,1,0,1);
figure(2);Legend3 = plot(LLSc03LV2,':k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 4 ----- %
[LLSc04LV2,MSc04LV2,qcn04,RelChangeSc04LV2] = BTPCA_modify(TrSc04,LV,1,0,1);
figure(2);Legend4 = plot(LLSc04LV2,'-k','LineWidth',LineWidth);
legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'},'FontSize',FontSize)
% % %<> ------------- <> ---------------- <><> ------------- <> ---------------- <>
LV = 3;
% ------ Train your btPCA model for Scenario 1 ----- %
[LLSc01LV3,MSc01LV3,qcn01,RelChangeSc01LV3] = BTPCA_modify(TrSc01,LV,1,1,0);
figure(3);Legend1 = plot(LLSc01LV3,'--k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 2 ----- %
[LLSc02LV3,MSc02LV3,qcn02,RelChangeSc02LV3] = BTPCA_modify(TrSc02,LV,1,1,0);
figure(3);Legend2 = plot(LLSc02LV3,'-.k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 3 ----- %
[LLSc03LV3,MSc03LV3,qcn03,RelChangeSc03LV3] = BTPCA_modify(TrSc03,LV,1,1,0);
figure(3);Legend3 = plot(LLSc03LV3,':k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 4 ----- %
[LLSc04LV3,MSc04LV3,qcn04,RelChangeSc04LV3] = BTPCA_modify(TrSc04,LV,1,1,0);
figure(3);Legend4 = plot(LLSc04LV3,'-k','LineWidth',LineWidth);
legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'},'FontSize',FontSize)
% % %<> ------------- <> ---------------- <><> ------------- <> ---------------- <>
LV = 4;
% ------ Train your btPCA model for Scenario 1 ----- %
[LLSc01LV4,MSc01LV4,qcn01,RelChangeSc01LV3] = BTPCA_modify(TrSc01,LV,1,1,0);
figure(4);Legend1 = plot(LLSc01LV4,'--k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 2 ----- %
[LLSc02LV4,MSc02LV4,qcn02,RelChangeSc02LV3] = BTPCA_modify(TrSc02,LV,1,1,0);
figure(4);Legend2 = plot(LLSc02LV4,'-.k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 3 ----- %
[LLSc03LV4,MSc03LV4,qcn03,RelChangeSc03LV3] = BTPCA_modify(TrSc03,LV,1,1,0);
figure(4);Legend3 = plot(LLSc03LV4,':k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 4 ----- %
[LLSc04LV4,MSc04LV4,qcn04,RelChangeSc04LV3] = BTPCA_modify(TrSc04,LV,1,1,0);
figure(4);Legend4 = plot(LLSc04LV4,'-k','LineWidth',LineWidth);
legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'},'FontSize',FontSize)
% % %<> ------------- <> ---------------- <><> ------------- <> ---------------- <>
LV = 5;
% ------ Train your btPCA model for Scenario 1 ----- %
[LLSc01LV5,MSc01LV5,qcn01,RelChangeSc01LV3] = BTPCA_modify(TrSc01,LV,1,1,0);
figure(5);Legend1 = plot(LLSc01LV5,'--k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 2 ----- %
[LLSc02LV5,MSc02LV5,qcn02,RelChangeSc02LV3] = BTPCA_modify(TrSc02,LV,1,1,0);
figure(5);Legend2 = plot(LLSc02LV5,'-.k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 3 ----- %
[LLSc03LV5,MSc03LV5,qcn03,RelChangeSc03LV3] = BTPCA_modify(TrSc03,LV,1,1,0);
figure(5);Legend3 = plot(LLSc03LV5,':k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 4 ----- %
[LLSc04LV5,MSc04LV5,qcn04,RelChangeSc04LV3] = BTPCA_modify(TrSc04,LV,1,1,0);
figure(5);Legend4 = plot(LLSc04LV5,'-k','LineWidth',LineWidth);
legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'},'FontSize',FontSize)
% % %<> ------------- <> ---------------- <><> ------------- <> ---------------- <>
LV = 6;
% ------ Train your btPCA model for Scenario 1 ----- %
[LLSc01LV6,MSc01LV6,qcn01,RelChangeSc01LV3] = BTPCA_modify(TrSc01,LV,1,1,0);
figure(6);Legend1 = plot(LLSc01LV6,'--k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 2 ----- %
[LLSc02LV6,MSc02LV6,qcn02,RelChangeSc02LV3] = BTPCA_modify(TrSc02,LV,1,1,0);
figure(6);Legend2 = plot(LLSc02LV6,'-.k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 3 ----- %
[LLSc03LV6,MSc03LV6,qcn03,RelChangeSc03LV3] = BTPCA_modify(TrSc03,LV,1,1,0);
figure(6);Legend3 = plot(LLSc03LV6,':k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 4 ----- %
[LLSc04LV6,MSc04LV6,qcn04,RelChangeSc04LV3] = BTPCA_modify(TrSc04,LV,1,1,0);
figure(6);Legend4 = plot(LLSc04LV6,'-k','LineWidth',LineWidth);
legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'},'FontSize',FontSize)
% % %<> ------------- <> ---------------- <><> ------------- <> ---------------- <>
LV = 7;
% ------ Train your btPCA model for Scenario 1 ----- %
[LLSc01LV7,MSc01LV7,qcn01,RelChangeSc01LV3] = BTPCA_modify(TrSc01,LV,1,1,0);
figure(7);Legend1 = plot(LLSc01LV7,'--k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 2 ----- %
[LLSc02LV7,MSc02LV7,qcn02,RelChangeSc02LV3] = BTPCA_modify(TrSc02,LV,1,1,0);
figure(7);Legend2 = plot(LLSc02LV7,'-.k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 3 ----- %
[LLSc03LV7,MSc03LV7,qcn03,RelChangeSc03LV3] = BTPCA_modify(TrSc03,LV,1,1,0);
figure(7);Legend3 = plot(LLSc03LV7,':k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 4 ----- %
[LLSc04LV7,MSc04LV7,qcn04,RelChangeSc04LV3] = BTPCA_modify(TrSc04,LV,1,1,0);
figure(7);Legend4 = plot(LLSc04LV7,'-k','LineWidth',LineWidth);
legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'},'FontSize',FontSize)
% % %<> ------------- <> ---------------- <><> ------------- <> ---------------- <>
LV = 8;
% ------ Train your btPCA model for Scenario 1 for 8 Latent Vectors ----- %
[LLSc01LV8,MSc01LV8,qcn01,RelChangeSc01LV3] = BTPCA_modify(TrSc01,LV,1,1,0);
figure(8);Legend1 = plot(LLSc01LV8,'--k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 2 ----- %
[LLSc02LV8,MSc02LV8,qcn02,RelChangeSc02LV3] = BTPCA_modify(TrSc02,LV,1,1,0);
figure(8);Legend2 = plot(LLSc02LV8,'-.k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 3 ----- %
[LLSc03LV8,MSc03LV8,qcn03,RelChangeSc03LV3] = BTPCA_modify(TrSc03,LV,1,1,0);
figure(8);Legend3 = plot(LLSc03LV8,':k','LineWidth',LineWidth);
% ------ Train your btPCA model for Scenario 4 ----- %
[LLSc04LV8,MSc04LV8,qcn04,RelChangeSc04LV3] = BTPCA_modify(TrSc04,LV,1,1,0);
figure(8);Legend4 = plot(LLSc04LV8,'-k','LineWidth',LineWidth);
legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'},'FontSize',FontSize)
% % %<> ------------- <> ---------------- <><> ------------- <> ---------------- <>

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

% <> ------------ <> --------------- <><> ------------ <> -------------- <>
%                              Generate Test Data                         %
[TstD1Sc1,TstD2Sc1,TstD3Sc1,TstD1Sc2,TstD2Sc2,TstD3Sc2,TstD1Sc3,TstD2Sc3,TstD3Sc3,TstD1Sc4,TstD2Sc4,TstD3Sc4] = fGetTestDataDiffScene002(CodeMatrix,LPDC);
% % <> ------------ <> --------------- <><> ------------ <> -------------- <>

%%$$ <>--<> Selected Model List <>--<> *** Do Not Forget to change this ***
MSc01LV3 = MSc01LV5;
MSc02LV3 = MSc02LV5;
MSc03LV3 = MSc03LV5;
MSc04LV3 = MSc04LV5;
%%$$ <>--<> Selected Model List <>--<> *** Do Not Forget to change this ***


% % <> ------- Re-Test Using Training Data ------- <> % %
[LL01TrSc1,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc01,LV,1,1,0,MSc01LV3);
[LL02TrSc1,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TrSc01,LV,1,1,0,MSc02LV3);
[LL03TrSc1,tstMSc03LV1,tstqcn03,tstRelChange01] = BTPCA_modify(TrSc01,LV,1,1,0,MSc03LV3);
[LL04TrSc1,tstMSc04LV1,tstqcn04,tstRelChange02] = BTPCA_modify(TrSc01,LV,1,1,0,MSc04LV3);

[LL01TrSc2,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc02,LV,1,1,0,MSc01LV3);
[LL02TrSc2,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TrSc02,LV,1,1,0,MSc02LV3);
[LL03TrSc2,tstMSc03LV1,tstqcn03,tstRelChange01] = BTPCA_modify(TrSc02,LV,1,1,0,MSc03LV3);
[LL04TrSc2,tstMSc04LV1,tstqcn04,tstRelChange02] = BTPCA_modify(TrSc02,LV,1,1,0,MSc04LV3);

[LL01TrSc3,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc03,LV,1,1,0,MSc01LV3);
[LL02TrSc3,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TrSc03,LV,1,1,0,MSc02LV3);
[LL03TrSc3,tstMSc03LV1,tstqcn03,tstRelChange01] = BTPCA_modify(TrSc03,LV,1,1,0,MSc03LV3);
[LL04TrSc3,tstMSc04LV1,tstqcn04,tstRelChange02] = BTPCA_modify(TrSc03,LV,1,1,0,MSc04LV3);

[LL01TrSc4,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc04,LV,1,1,0,MSc01LV3);
[LL02TrSc4,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TrSc04,LV,1,1,0,MSc02LV3);
[LL03TrSc4,tstMSc03LV1,tstqcn03,tstRelChange01] = BTPCA_modify(TrSc04,LV,1,1,0,MSc03LV3);
[LL04TrSc4,tstMSc04LV1,tstqcn04,tstRelChange02] = BTPCA_modify(TrSc04,LV,1,1,0,MSc04LV3);

% R1_TrLL = [max(LL01TrSc1), max(LL02TrSc1), max(LL03TrSc1), max(LL04TrSc1);
%            max(LL01TrSc2), max(LL02TrSc2), max(LL03TrSc2), max(LL04TrSc2);
%            max(LL01TrSc3), max(LL02TrSc3), max(LL03TrSc3), max(LL04TrSc3);
%            max(LL01TrSc4), max(LL02TrSc4), max(LL03TrSc4), max(LL04TrSc4)];
% printmat(R1_TrLL, 'Re-Test Train Data', 'TrSc01 TrSc02 TrSc03 TrSc04 ', 'Sc01_Model Sc02_Model Sc03_Model Sc04_Model' )

% % <> ------- Test Using Testing Data ------- <> % %
% % % <>--------------Scenario # 1 testing Data ------------- <> % % % 

[LL01D1Sc1,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstD1Sc1,LV,1,1,0,MSc01LV3);
[LL02D1Sc1,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstD1Sc1,LV,1,1,0,MSc02LV3);
[LL03D1Sc1,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstD1Sc1,LV,1,1,0,MSc03LV3);
[LL04D1Sc1,tstMSc04LV1,tstqcn04,tstRelChange04] = BTPCA_modify(TstD1Sc1,LV,1,1,0,MSc04LV3);

[LL01D2Sc1,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstD2Sc1,LV,1,1,0,MSc01LV3);
[LL02D2Sc1,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstD2Sc1,LV,1,1,0,MSc02LV3);
[LL03D2Sc1,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstD2Sc1,LV,1,1,0,MSc03LV3);
[LL04D2Sc1,tstMSc04LV1,tstqcn04,tstRelChange04] = BTPCA_modify(TstD2Sc1,LV,1,1,0,MSc04LV3);

[LL01D3Sc1,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstD3Sc1,LV,1,1,0,MSc01LV3);
[LL02D3Sc1,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstD3Sc1,LV,1,1,0,MSc02LV3);
[LL03D3Sc1,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstD3Sc1,LV,1,1,0,MSc03LV3);
[LL04D3Sc1,tstMSc04LV1,tstqcn04,tstRelChange04] = BTPCA_modify(TstD3Sc1,LV,1,1,0,MSc04LV3);

% R2_TstLLSc1 = [max(LL01D1Sc1), max(LL02D1Sc1), max(LL03D1Sc1), max(LL04D1Sc1);
%                max(LL01D2Sc1), max(LL02D2Sc1), max(LL03D2Sc1), max(LL04D2Sc1);
%                max(LL01D3Sc1), max(LL02D3Sc1), max(LL03D3Sc1), max(LL04D3Sc1)];
% printmat(R2_TstLLSc1, 'Sc01 Test Data', 'TrSc01 TrSc02 TrSc03 TrSc04 ', 'Sc01_Model Sc02_Model Sc03_Model Sc04_Model' )

% % % <>--------------Scenario # 2 testing Data ------------- <> % % % 
[LL01D1Sc2,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstD1Sc2,LV,1,1,0,MSc01LV3);
[LL02D1Sc2,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstD1Sc2,LV,1,1,0,MSc02LV3);
[LL03D1Sc2,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstD1Sc2,LV,1,1,0,MSc03LV3);
[LL04D1Sc2,tstMSc04LV1,tstqcn04,tstRelChange04] = BTPCA_modify(TstD1Sc2,LV,1,1,0,MSc04LV3);

[LL01D2Sc2,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstD2Sc2,LV,1,1,0,MSc01LV3);
[LL02D2Sc2,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstD2Sc2,LV,1,1,0,MSc02LV3);
[LL03D2Sc2,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstD2Sc2,LV,1,1,0,MSc03LV3);
[LL04D2Sc2,tstMSc04LV1,tstqcn04,tstRelChange04] = BTPCA_modify(TstD2Sc2,LV,1,1,0,MSc04LV3);

[LL01D3Sc2,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstD3Sc2,LV,1,1,0,MSc01LV3);
[LL02D3Sc2,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstD3Sc2,LV,1,1,0,MSc02LV3);
[LL03D3Sc2,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstD3Sc2,LV,1,1,0,MSc03LV3);
[LL04D3Sc2,tstMSc04LV1,tstqcn04,tstRelChange04] = BTPCA_modify(TstD3Sc2,LV,1,1,0,MSc04LV3);

% R3_TstLLSc2 = [max(LL01D1Sc2), max(LL02D1Sc2), max(LL03D1Sc2), max(LL04D1Sc2);
%                max(LL01D2Sc2), max(LL02D2Sc2), max(LL03D2Sc2), max(LL04D2Sc2);
%                max(LL01D3Sc2), max(LL02D3Sc2), max(LL03D3Sc2), max(LL04D3Sc2)];
% printmat(R3_TstLLSc2, 'Sc02 Test Data', 'TrSc01 TrSc02 TrSc03 TrSc04 ', 'Sc01_Model Sc02_Model Sc03_Model Sc04_Model' )

% % % <>-------------- Scenario # 3 testing Data ----------- <> % % % 
[LL01D1Sc3,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstD1Sc3,LV,1,1,0,MSc01LV3);
[LL02D1Sc3,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstD1Sc3,LV,1,1,0,MSc02LV3);
[LL03D1Sc3,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstD1Sc3,LV,1,1,0,MSc03LV3);
[LL04D1Sc3,tstMSc04LV1,tstqcn04,tstRelChange04] = BTPCA_modify(TstD1Sc3,LV,1,1,0,MSc04LV3);

[LL01D2Sc3,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstD2Sc3,LV,1,1,0,MSc01LV3);
[LL02D2Sc3,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstD2Sc3,LV,1,1,0,MSc02LV3);
[LL03D2Sc3,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstD2Sc3,LV,1,1,0,MSc03LV3);
[LL04D2Sc3,tstMSc04LV1,tstqcn04,tstRelChange04] = BTPCA_modify(TstD2Sc3,LV,1,1,0,MSc04LV3);

[LL01D3Sc3,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstD3Sc3,LV,1,1,0,MSc01LV3);
[LL02D3Sc3,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstD3Sc3,LV,1,1,0,MSc02LV3);
[LL03D3Sc3,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstD3Sc3,LV,1,1,0,MSc03LV3);
[LL04D3Sc3,tstMSc04LV1,tstqcn04,tstRelChange04] = BTPCA_modify(TstD3Sc3,LV,1,1,0,MSc04LV3);

% R4_TstLLSc3 = [max(LL01D1Sc3), max(LL02D1Sc3), max(LL03D1Sc3), max(LL04D1Sc3);
%                max(LL01D2Sc3), max(LL02D2Sc3), max(LL03D2Sc3), max(LL04D2Sc3);
%                max(LL01D3Sc3), max(LL02D3Sc3), max(LL03D3Sc3), max(LL04D3Sc3)];
% printmat(R4_TstLLSc3, 'Sc03 Test Data', 'TrSc01 TrSc02 TrSc03 TrSc04 ', 'Sc01_Model Sc02_Model Sc03_Model Sc04_Model' )

% % % <>-------------- Scenario # 4 testing Data ----------- <> % % % 
[LL01D1Sc4,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstD1Sc4,LV,1,1,0,MSc01LV3);
[LL02D1Sc4,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstD1Sc4,LV,1,1,0,MSc02LV3);
[LL03D1Sc4,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstD1Sc4,LV,1,1,0,MSc03LV3);
[LL04D1Sc4,tstMSc04LV1,tstqcn04,tstRelChange04] = BTPCA_modify(TstD1Sc4,LV,1,1,0,MSc04LV3);

[LL01D2Sc4,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstD2Sc4,LV,1,1,0,MSc01LV3);
[LL02D2Sc4,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstD2Sc4,LV,1,1,0,MSc02LV3);
[LL03D2Sc4,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstD2Sc4,LV,1,1,0,MSc03LV3);
[LL04D2Sc4,tstMSc04LV1,tstqcn04,tstRelChange04] = BTPCA_modify(TstD2Sc4,LV,1,1,0,MSc04LV3);

[LL01D3Sc4,tstMSc01LV1,tstqcn01,tstRelChange01] = BTPCA_modify(TstD3Sc4,LV,1,1,0,MSc01LV3);
[LL02D3Sc4,tstMSc02LV1,tstqcn02,tstRelChange02] = BTPCA_modify(TstD3Sc4,LV,1,1,0,MSc02LV3);
[LL03D3Sc4,tstMSc03LV1,tstqcn03,tstRelChange03] = BTPCA_modify(TstD3Sc4,LV,1,1,0,MSc03LV3);
[LL04D3Sc4,tstMSc04LV1,tstqcn04,tstRelChange04] = BTPCA_modify(TstD3Sc4,LV,1,1,0,MSc04LV3);

% R5_TstLLSc4 = [max(LL01D1Sc4), max(LL02D1Sc4), max(LL03D1Sc4), max(LL04D1Sc4);
%                max(LL01D2Sc4), max(LL02D2Sc4), max(LL03D2Sc4), max(LL04D2Sc4);
%                max(LL01D3Sc4), max(LL02D3Sc4), max(LL03D3Sc4), max(LL04D3Sc4)];
% printmat(R5_TstLLSc4, 'Sc04 Test Data', 'TrSc01 TrSc02 TrSc03 TrSc04 ', 'Sc01_Model Sc02_Model Sc03_Model Sc04_Model' )

clc;
fprintf('\n\t <><> ----------- Training Results ------------- <><>\n')
R1_TrLL = [max(LLSc01LV1), max(LLSc02LV1), max(LLSc03LV1), max(LLSc04LV1);
           max(LLSc01LV2), max(LLSc02LV2), max(LLSc03LV2), max(LLSc04LV2);
           max(LLSc01LV3), max(LLSc02LV3), max(LLSc03LV3), max(LLSc04LV3);
           max(LLSc01LV4), max(LLSc02LV4), max(LLSc03LV4), max(LLSc04LV4);
           max(LLSc01LV5), max(LLSc02LV5), max(LLSc03LV5), max(LLSc04LV5);
           max(LLSc01LV6), max(LLSc02LV6), max(LLSc03LV6), max(LLSc04LV6);
           max(LLSc01LV7), max(LLSc02LV7), max(LLSc03LV7), max(LLSc04LV7);
           max(LLSc01LV8), max(LLSc02LV8), max(LLSc03LV8), max(LLSc04LV8)];
printmat(R1_TrLL, 'LogLikVsScs', 'Basis_V1 Basis_V2 Basis_V3 Basis_V4 Basis_V5 Basis_V6 Basis_V7 Basis_V8', 'Scenario1 Scenario2 Scenario3 Scenario4' )

fprintf('\n\t <><> ----------- Test Results ------------- <><>\n')
R1_TrLL = [max(LL01TrSc1), max(LL02TrSc1), max(LL03TrSc1), max(LL04TrSc1);
           max(LL01TrSc2), max(LL02TrSc2), max(LL03TrSc2), max(LL04TrSc2);
           max(LL01TrSc3), max(LL02TrSc3), max(LL03TrSc3), max(LL04TrSc3);
           max(LL01TrSc4), max(LL02TrSc4), max(LL03TrSc4), max(LL04TrSc4)];
printmat(R1_TrLL, 'Re-Test Train Data', 'TrSc01 TrSc02 TrSc03 TrSc04 ', 'Sc01_Model Sc02_Model Sc03_Model Sc04_Model' )

R2_TstLLSc1 = [max(LL01D1Sc1), max(LL02D1Sc1), max(LL03D1Sc1), max(LL04D1Sc1);
               max(LL01D2Sc1), max(LL02D2Sc1), max(LL03D2Sc1), max(LL04D2Sc1);
               max(LL01D3Sc1), max(LL02D3Sc1), max(LL03D3Sc1), max(LL04D3Sc1)];
printmat(R2_TstLLSc1, 'Sc01 Test Data', 'TrSc01 TrSc02 TrSc03 TrSc04 ', 'Sc01_Model Sc02_Model Sc03_Model Sc04_Model' )

R3_TstLLSc2 = [max(LL01D1Sc2), max(LL02D1Sc2), max(LL03D1Sc2), max(LL04D1Sc2);
               max(LL01D2Sc2), max(LL02D2Sc2), max(LL03D2Sc2), max(LL04D2Sc2);
               max(LL01D3Sc2), max(LL02D3Sc2), max(LL03D3Sc2), max(LL04D3Sc2)];
printmat(R3_TstLLSc2, 'Sc02 Test Data', 'TrSc01 TrSc02 TrSc03 TrSc04 ', 'Sc01_Model Sc02_Model Sc03_Model Sc04_Model' )


R4_TstLLSc3 = [max(LL01D1Sc3), max(LL02D1Sc3), max(LL03D1Sc3), max(LL04D1Sc3);
               max(LL01D2Sc3), max(LL02D2Sc3), max(LL03D2Sc3), max(LL04D2Sc3);
               max(LL01D3Sc3), max(LL02D3Sc3), max(LL03D3Sc3), max(LL04D3Sc3)];
printmat(R4_TstLLSc3, 'Sc03 Test Data', 'TrSc01 TrSc02 TrSc03 TrSc04 ', 'Sc01_Model Sc02_Model Sc03_Model Sc04_Model' )

R5_TstLLSc4 = [max(LL01D1Sc4), max(LL02D1Sc4), max(LL03D1Sc4), max(LL04D1Sc4);
               max(LL01D2Sc4), max(LL02D2Sc4), max(LL03D2Sc4), max(LL04D2Sc4);
               max(LL01D3Sc4), max(LL02D3Sc4), max(LL03D3Sc4), max(LL04D3Sc4)];
printmat(R5_TstLLSc4, 'Sc04 Test Data', 'TrSc01 TrSc02 TrSc03 TrSc04 ', 'Sc01_Model Sc02_Model Sc03_Model Sc04_Model' )






