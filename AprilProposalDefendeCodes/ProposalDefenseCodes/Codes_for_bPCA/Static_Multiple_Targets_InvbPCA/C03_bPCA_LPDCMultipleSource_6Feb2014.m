% Code generates the LPDC codes and

clc;clear all;close all;

% ----------- Initialization -------------- %
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bPCA\Main_Functions\');

figure(1);hold on;title('Latent = 1,LogLikelihood for Different Scenarios');xlabel('iterations');ylabel('Log-likelihood')
figure(2);hold on;title('Latent = 2,LogLikelihood for Different Scenarios');xlabel('iterations');ylabel('Log-likelihood')
figure(3);hold on;title('Latent = 3,LogLikelihood for Different Scenarios');xlabel('iterations');ylabel('Log-likelihood')

D = 4; % Length of each code
Blocks = 16;

LPDC = gen_ldpc(D,Blocks)
LPDC = LPDC'; % These codes are right adjacent block codes

%%LPDC = gen_ldpc(Blocks,D);

% Code matrix tells you which block is the subject standing %
CodeMatrix(1,:) = 1:4; % This is the coding of the blocks of 4 x 4
CodeMatrix(2,:) = 5:8; % This is the coding of the blocks of 4 x 4
CodeMatrix(3,:) = 9:12; % This is the coding of the blocks of 4 x 4
CodeMatrix(4,:) = 13:16; % This is the coding of the blocks of 4 x 4

% ----------------- Training Stage ---------------------- %

   % Case = 4 means that you have 4 subjects in a group
LV = 1;
[TrSc01,TrSc02,TrSc03,TrSc04] = fCreateScenData(CodeMatrix,LPDC,LV);
% <> ------------- <> ---------------- <><> ------------- <> ---------------- <>
% ------ Train your btPCA model for Scenario 1 ----- %
% [LLSc01LV1,MSc01LV1,qcn01,RelChangeSc01LV1] = BTPCA_modify(TrSc01,LV,1,1,0);
% figure(1);Legend1 = plot(LLSc01LV1,'r','LineWidth',2.0);
% % ------ Train your btPCA model for Scenario 2 ----- %
% [LLSc02LV1,MSc02LV1,qcn02,RelChangeSc02LV1] = BTPCA_modify(TrSc02,LV,1,1,0);
% figure(1);Legend2 = plot(LLSc02LV1,'b','LineWidth',2.0);
% % ------ Train your btPCA model for Scenario 3 ----- %
% [LLSc03LV1,MSc03LV1,qcn03,RelChangeSc03LV1] = BTPCA_modify(TrSc03,LV,1,1,0);
% figure(1);Legend3 = plot(LLSc03LV1,'k','LineWidth',2.0);
% % ------ Train your btPCA model for Scenario 4 ----- %
% [LLSc04LV1,MSc04LV1,qcn04,RelChangeSc04LV1] = BTPCA_modify(TrSc04,LV,1,1,0);
% figure(1);Legend4 = plot(LLSc04LV1,'c','LineWidth',2.0);
% 
% legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'})
% <> ------------- <> ---------------- <><> ------------- <> ---------------- <>

LV = 2;
% ------ Train your btPCA model for Scenario 1 ----- %
[LLSc01LV2,MSc01LV2,qcn01,RelChangeSc01LV2] = BTPCA_modify(TrSc01,LV,1,1,0);
figure(2);Legend1 = plot(LLSc01LV2,'r','LineWidth',2.0);
% ------ Train your btPCA model for Scenario 2 ----- %
[LLSc02LV2,MSc02LV2,qcn02,RelChangeSc02LV2] = BTPCA_modify(TrSc02,LV,1,1,0);
figure(2);Legend2 = plot(LLSc02LV2,'b','LineWidth',2.0);
% ------ Train your btPCA model for Scenario 3 ----- %
[LLSc03LV2,MSc03LV2,qcn03,RelChangeSc03LV2] = BTPCA_modify(TrSc03,LV,1,1,0);
figure(2);Legend3 = plot(LLSc03LV2,'k','LineWidth',2.0);
% ------ Train your btPCA model for Scenario 4 ----- %
[LLSc04LV2,MSc04LV2,qcn04,RelChangeSc04LV2] = BTPCA_modify(TrSc04,LV,1,1,0);
figure(2);Legend4 = plot(LLSc04LV2,'c','LineWidth',2.0);

legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'})
% <> ------------- <> ---------------- <><> ------------- <> ---------------- <>

% LV = 3;
% % ------ Train your btPCA model for Scenario 1 ----- %
% [LLSc01LV3,MSc01LV3,qcn01,RelChangeSc01LV3] = BTPCA_modify(TrSc01,LV,1,1,0);
% figure(3);Legend1 = plot(LLSc01LV3,'r','LineWidth',2.0);
% % ------ Train your btPCA model for Scenario 2 ----- %
% [LLSc02LV3,MSc02LV3,qcn02,RelChangeSc02LV3] = BTPCA_modify(TrSc02,LV,1,1,0);
% figure(3);Legend2 = plot(LLSc02LV3,'b','LineWidth',2.0);
% % ------ Train your btPCA model for Scenario 3 ----- %
% [LLSc03LV3,MSc03LV3,qcn03,RelChangeSc03LV3] = BTPCA_modify(TrSc03,LV,1,1,0);
% figure(3);Legend3 = plot(LLSc03LV3,'k','LineWidth',2.0);
% % ------ Train your btPCA model for Scenario 4 ----- %
% [LLSc04LV3,MSc04LV3,qcn04,RelChangeSc04LV3] = BTPCA_modify(TrSc04,LV,1,1,0);
% figure(3);Legend4 = plot(LLSc04LV3,'c','LineWidth',2.0);
% 
% legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'})

% <> ------------ <> --------------- <><> ------------ <> -------------- <>
%                              Generate Test Data                         %
[TstD1Sc1,TstD2Sc1,TstD3Sc1,TstD1Sc2,TstD2Sc2,TstD3Sc2,TstD1Sc3,TstD2Sc3,TstD3Sc3] = fGetTestDataDiffScene(CodeMatrix,LPDC);
% <> ------------ <> --------------- <><> ------------ <> -------------- <>

MSc01LV1;MSc02LV1;MSc03LV1;MSc04LV1;
MSc01LV2;MSc02LV2;MSc03LV2;MSc04LV2;

[tstLL01Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc01,LV,1,1,0,MSc01LV2);
[tstLL02Lv2,tstMSc02LV2,tstqcn02,tstRelChange02] = BTPCA_modify(TrSc01,LV,1,1,0,MSc02LV2);
[tstLL03Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc01(1:3,:,:),LV,1,1,0,MSc03LV2);
%%[tstLL04Lv2,tstMSc02LV2,tstqcn02,tstRelChange02] = BTPCA_modify(TrSc01(1:3,:,:),LV,1,1,0,MSc04LV2);

[tstLL01Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD1Sc1,LV,1,1,0,MSc01LV2);
[tstLL02Lv2,tstMSc02LV2,tstqcn02,tstRelChange02] = BTPCA_modify(TstD1Sc1,LV,1,1,0,MSc02LV2);


[tstLL01Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD1Sc1,LV,1,1,0,MSc01LV2);
[tstLL02Lv2,tstMSc02LV2,tstqcn02,tstRelChange02] = BTPCA_modify(TstD1Sc1,LV,1,1,0,MSc02LV2);

[tstLL03Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD1Sc1(1:3,:,:),LV,1,1,0,MSc03LV2);


[tstLL01Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD3Sc1,LV,1,1,0,MSc01LV2);
[tstLL02Lv2,tstMSc02LV2,tstqcn02,tstRelChange02] = BTPCA_modify(TstD3Sc1,LV,1,1,0,MSc02LV2);

[tstLL03Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD3Sc1(1:3,:,:),LV,1,1,0,MSc03LV2);

tstLL01Lv2(end)
tstLL02Lv2(end)
tstLL03Lv2(end)

% Copies = 4;SampleNo = 4;
% [EinTrSc01] = fCreateMultCopSingleData(TrSc01,SampleNo,Copies);

% [tstLL01Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(EinTrSc01,LV,1,1,0,MSc01LV2);
% [tstLL02Lv2,tstMSc02LV2,tstqcn02,tstRelChange02] = BTPCA_modify(EinTrSc01,LV,1,1,0,MSc02LV2);
% <> ------------ <> --------------- <><> ------------ <> -------------- <>

[tstLL01Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc02,LV,1,1,0,MSc01LV1);
[tstLL02Lv2,tstMSc02LV2,tstqcn02,tstRelChange02] = BTPCA_modify(TrSc02,LV,1,1,0,MSc02LV2);

[tstLL03Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc02(1:3,:,:),LV,1,1,0,MSc03LV2);

[tstLL01Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD1Sc2,LV,1,1,0,MSc01LV1);
[tstLL02Lv2,tstMSc02LV2,tstqcn02,tstRelChange02] = BTPCA_modify(TstD1Sc2,LV,1,1,0,MSc02LV2);

[tstLL03Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD1Sc2(1:3,:,:),LV,1,1,0,MSc03LV2);

[tstLL01Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD2Sc2,LV,1,1,0,MSc01LV1);
[tstLL02Lv2,tstMSc02LV2,tstqcn02,tstRelChange02] = BTPCA_modify(TstD2Sc2,LV,1,1,0,MSc02LV2);

[tstLL03Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD2Sc2(1:3,:,:),LV,1,1,0,MSc03LV2);

[tstLL01Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD3Sc2,LV,1,1,0,MSc01LV2);
[tstLL02Lv2,tstMSc02LV2,tstqcn02,tstRelChange02] = BTPCA_modify(TstD3Sc2,LV,1,1,0,MSc02LV2);

[tstLL03Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD3Sc2(1:3,:,:),LV,1,1,0,MSc03LV2);


tstLL01Lv2(end)
tstLL02Lv2(end)
tstLL03Lv2(end)
% <> ------------ <> --------------- <><> ------------ <> -------------- <>

[tstLL01Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc03,LV,1,1,0,MSc01LV1);
[tstLL02Lv2,tstMSc02LV2,tstqcn02,tstRelChange02] = BTPCA_modify(TrSc03,LV,1,1,0,MSc02LV1);

[tstLL03Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TrSc03,LV,1,1,0,MSc03LV2);

[tstLL01Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD1Sc3,LV,1,1,0,MSc01LV1);
[tstLL02Lv2,tstMSc02LV2,tstqcn02,tstRelChange02] = BTPCA_modify(TstD1Sc3,LV,1,1,0,MSc02LV1);

[tstLL03Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD1Sc3,LV,1,1,0,MSc03LV2);

[tstLL01Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD2Sc3,LV,1,1,0,MSc01LV1);
[tstLL02Lv2,tstMSc02LV2,tstqcn02,tstRelChange02] = BTPCA_modify(TstD2Sc3,LV,1,1,0,MSc02LV1);

[tstLL03Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD2Sc3,LV,1,1,0,MSc03LV2);

[tstLL01Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD3Sc3,LV,1,1,0,MSc01LV1);
[tstLL02Lv2,tstMSc02LV2,tstqcn02,tstRelChange02] = BTPCA_modify(TstD3Sc3,LV,1,1,0,MSc02LV1);

[tstLL03Lv2,tstMSc01LV2,tstqcn01,tstRelChange01] = BTPCA_modify(TstD3Sc3,LV,1,1,0,MSc03LV2);


tstLL01Lv2(end)
tstLL02Lv2(end)
tstLL03Lv2(end)


Accuracy = [87.5,90,85.71];
Xaxis = ['Scenario1' 'Scenario2' 'Scenario3']

figure(111);hold on;title('Recognition Rate vs Scenarios');xlabel('Scenarios');ylabel('Recognition Rate');
%bar(Accuracy,0.3);
bar(Accuracy,0.3);
ylim([0,100])



















