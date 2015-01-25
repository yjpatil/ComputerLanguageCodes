% This code creates the LPDC codes % 

clc;clear all;close all;

% ----------- Initialization -------------- %
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bPCA\Main_Functions\');

D = 4; % Length of each code
Blocks = 16;

LPDC = gen_ldpc(D,Blocks);
LPDC = LPDC'; % These codes are right adjacent block codes

%%LPDC = gen_ldpc(Blocks,D);

% 
CodeMatrix(1,:) = 1:4;
CodeMatrix(2,:) = 5:8;
CodeMatrix(3,:) = 9:12;
CodeMatrix(4,:) = 13:16;


% ----------------- Training Stage ---------------------- %
Case = 4;   % Case = 4 means that you have 4 subjects in a group
TrScenario01 = [];
LV = 3;
% Training Data for Scenario 1 %
[TrScenario01] = fGetBlockCode([1,1],[1,2],[2,1],[2,2],CodeMatrix,TrScenario01,LPDC,1,Case); % Input the coordinates of each sub position or block | Serial # for each block | 3D Data matrix  
[TrScenario01] = fGetBlockCode([1,3],[1,4],[2,3],[2,4],CodeMatrix,TrScenario01,LPDC,2,Case);
[TrScenario01] = fGetBlockCode([3,1],[3,2],[4,1],[4,2],CodeMatrix,TrScenario01,LPDC,3,Case);
[TrScenario01] = fGetBlockCode([3,3],[3,4],[4,3],[4,4],CodeMatrix,TrScenario01,LPDC,4,Case);
% ------ Train your btPCA model for Scenario 1 ----- %
[LogL01,MoFA01,qcn01,RelChange01] = BTPCA_modify(TrScenario01,LV,1,1,0);
figure(1);hold on;title('LogLikelihood for Different Scenarios')
Legend1 = plot(LogL01,'r','LineWidth',2.0);
xlabel('iterations');ylabel('Log-likelihood')

Case = 4;
TrScenario02 = [];
% Training Data for Scenario 2 %
[TrScenario02] = fGetBlockCode([1,1],[1,2],[1,3],[1,4],CodeMatrix,TrScenario02,LPDC,1,Case);
[TrScenario02] = fGetBlockCode([2,1],[2,2],[2,3],[2,4],CodeMatrix,TrScenario02,LPDC,2,Case);
[TrScenario02] = fGetBlockCode([3,1],[3,2],[3,3],[3,4],CodeMatrix,TrScenario02,LPDC,3,Case);
[TrScenario02] = fGetBlockCode([4,1],[4,2],[4,3],[4,4],CodeMatrix,TrScenario02,LPDC,4,Case);
% ------ Train your btPCA model for Scenario 2 ----- %
[LogL02,MoFA02,qcn02,RelChange02] = BTPCA_modify(TrScenario02,LV,1,1,0);
figure(1);
Legend2 = plot(LogL02,'b','LineWidth',2.0);

Case = 3;
TrScenario03 = [];
% Training Data for Scenario 3 %
[TrScenario03] = fGetBlockCode([1,1],[2,1],[2,2],[0,0],CodeMatrix,TrScenario03,LPDC,1,Case);
[TrScenario03] = fGetBlockCode([1,3],[2,3],[2,4],[0,0],CodeMatrix,TrScenario03,LPDC,2,Case);
[TrScenario03] = fGetBlockCode([3,1],[4,1],[4,2],[0,0],CodeMatrix,TrScenario03,LPDC,3,Case);
[TrScenario03] = fGetBlockCode([3,3],[4,3],[4,4],[0,0],CodeMatrix,TrScenario03,LPDC,4,Case);
% ------ Train your btPCA model for Scenario 3 ----- %
[LogL03,MoFA03,qcn03,RelChange03] = BTPCA_modify(TrScenario03,LV,1,1,0);
figure(1);
Legend3 = plot(LogL03,'k','LineWidth',2.0);

Case = 3;
TrScenario04 = [];
% Training Data for Scenario 4 %
[TrScenario04] = fGetBlockCode([1,1],[1,2],[1,3],[0,0],CodeMatrix,TrScenario04,LPDC,1,Case);
[TrScenario04] = fGetBlockCode([2,1],[2,2],[2,3],[0,0],CodeMatrix,TrScenario04,LPDC,2,Case);
[TrScenario04] = fGetBlockCode([3,1],[3,2],[3,3],[0,0],CodeMatrix,TrScenario04,LPDC,3,Case);
[TrScenario04] = fGetBlockCode([4,1],[4,2],[4,3],[0,0],CodeMatrix,TrScenario04,LPDC,4,Case);
% ------ Train your btPCA model for Scenario 4 ----- %
[LogL04,MoFA04,qcn04,RelChange04] = BTPCA_modify(TrScenario04,LV,1,1,0);
figure(1);
Legend4 = plot(LogL04,'c','LineWidth',2.0);

legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'})
% <> ------------- <> ---------------- <><> ------------- <> ---------------- <>
% ----------------- Testing Stage Data 1 for Sc1 ---------------------- %
Case = 4;
Tst01Scenario01 = [];
% Training Data for Scenario 1 %
[Tst01Scenario01] = fGetBlockCode([1,1],[1,2],[2,1],[2,2],CodeMatrix,Tst01Scenario01,LPDC,1,Case);
[Tst01Scenario01] = fGetBlockCode([1,3],[1,4],[2,3],[2,4],CodeMatrix,Tst01Scenario01,LPDC,2,Case);
[Tst01Scenario01] = fGetBlockCode([3,1],[3,2],[4,1],[4,2],CodeMatrix,Tst01Scenario01,LPDC,3,Case);
[Tst01Scenario01] = fGetBlockCode([3,3],[3,4],[4,3],[4,4],CodeMatrix,Tst01Scenario01,LPDC,4,Case);

% [Tst01Scenario01] = fGetBlockCode([1,2],[1,3],[2,2],[2,3],CodeMatrix,Tst01Scenario01,LPDC,1,Case);
% [Tst01Scenario01] = fGetBlockCode([2,2],[2,3],[3,2],[3,3],CodeMatrix,Tst01Scenario01,LPDC,2,Case);
% [Tst01Scenario01] = fGetBlockCode([3,2],[3,3],[4,2],[4,3],CodeMatrix,Tst01Scenario01,LPDC,3,Case);
% [Tst01Scenario01] = fGetBlockCode([2,1],[2,2],[3,1],[3,2],CodeMatrix,Tst01Scenario01,LPDC,4,Case);
clc;
[tstLogL01,tstMoFA01,tstqcn01,tstRelChange01] = BTPCA_modify(Tst01Scenario01,LV,1,1,0,MoFA01);
[tstLogL02,tstMoFA02,tstqcn02,tstRelChange02] = BTPCA_modify(Tst01Scenario01,LV,1,1,0,MoFA02);
[tstLogL03,tstMoFA03,tstqcn03,tstRelChange03] = BTPCA_modify(Tst01Scenario01(1:3,:,:),LV,1,1,0,MoFA03);
[tstLogL04,tstMoFA04,tstqcn04,tstRelChange04] = BTPCA_modify(Tst01Scenario01(1:3,:,:),LV,1,1,0,MoFA04);
clc;Result = [tstLogL01(end);tstLogL02(end);tstLogL03(end);tstLogL04(end)];
Pred(1) = find(Result == max(Result));
True(1) = 1;
% ----------------- Testing Stage Data 2 for Sc1 ---------------------- %
Case = 4;
Tst02Scenario01 = [];
% Training Data for Scenario 1 %
[Tst02Scenario01] = fGetBlockCode([2,1],[2,2],[3,1],[3,2],CodeMatrix,Tst02Scenario01,LPDC,1,Case);
[Tst02Scenario01] = fGetBlockCode([2,2],[2,3],[3,2],[3,3],CodeMatrix,Tst02Scenario01,LPDC,2,Case);
[Tst02Scenario01] = fGetBlockCode([2,3],[2,4],[3,3],[3,4],CodeMatrix,Tst02Scenario01,LPDC,3,Case);
[Tst02Scenario01] = fGetBlockCode([3,3],[3,4],[4,3],[4,4],CodeMatrix,Tst02Scenario01,LPDC,4,Case);
clc;
[tst02LogL01,tst02MoFA01,tst02qcn01,tst02RelChange01] = BTPCA_modify(Tst02Scenario01,LV,1,1,0,MoFA01);
[tst02LogL02,tst02MoFA02,tst02qcn02,tst02RelChange02] = BTPCA_modify(Tst02Scenario01,LV,1,1,0,MoFA02);
[tst02LogL03,tst02MoFA03,tst02qcn03,tst02RelChange03] = BTPCA_modify(Tst02Scenario01(1:3,:,:),LV,1,1,0,MoFA03);
[tst02LogL04,tst02MoFA04,tst02qcn04,tst02RelChange04] = BTPCA_modify(Tst02Scenario01(1:3,:,:),LV,1,1,0,MoFA04);
clc;Result = [tst02LogL01(end);tst02LogL02(end);tst02LogL03(end);tst02LogL04(end)];
Pred(2) = find(Result == max(Result));
True(2) = 1;
% ----------------- Testing Stage Data 3 for Sc1 ---------------------- %
Case = 4;
Tst03Scenario01 = [];
% Training Data for Scenario 1 %
[Tst03Scenario01] = fGetBlockCode([1,1],[1,2],[2,1],[2,2],CodeMatrix,Tst03Scenario01,LPDC,1,Case);
[Tst03Scenario01] = fGetBlockCode([1,2],[1,3],[2,2],[2,3],CodeMatrix,Tst03Scenario01,LPDC,2,Case);
[Tst03Scenario01] = fGetBlockCode([1,3],[1,4],[2,3],[2,4],CodeMatrix,Tst03Scenario01,LPDC,3,Case);
[Tst03Scenario01] = fGetBlockCode([3,3],[3,4],[4,3],[4,4],CodeMatrix,Tst03Scenario01,LPDC,4,Case);
clc;
[tst03LogL01,tst03MoFA01,tst03qcn01,tst03RelChange01] = BTPCA_modify(Tst03Scenario01,LV,1,1,0,MoFA01);
[tst03LogL02,tst03MoFA02,tst03qcn02,tst03RelChange02] = BTPCA_modify(Tst03Scenario01,LV,1,1,0,MoFA02);
[tst03LogL03,tst03MoFA03,tst03qcn03,tst03RelChange03] = BTPCA_modify(Tst03Scenario01(1:3,:,:),LV,1,1,0,MoFA03);
[tst03LogL04,tst03MoFA04,tst03qcn04,tst03RelChange04] = BTPCA_modify(Tst03Scenario01(1:3,:,:),LV,1,1,0,MoFA04);
clc;Result = [tst03LogL01(end);tst03LogL02(end);tst03LogL03(end);tst03LogL04(end)];
Pred(3) = find(Result == max(Result));
True(3) = 1;
% ----------------- Testing Stage Data 1 for Sc2 ---------------------- %
Case = 4;
Tst12Scenario02 = [];
% Training Data for Scenario 1 %
[Tst12Scenario02] = fGetBlockCode([4,1],[4,2],[4,3],[4,4],CodeMatrix,Tst12Scenario02,LPDC,1,Case);
[Tst12Scenario02] = fGetBlockCode([3,1],[3,2],[3,3],[3,4],CodeMatrix,Tst12Scenario02,LPDC,2,Case);
[Tst12Scenario02] = fGetBlockCode([2,1],[2,2],[2,3],[2,4],CodeMatrix,Tst12Scenario02,LPDC,3,Case);
[Tst12Scenario02] = fGetBlockCode([1,1],[1,2],[1,3],[1,4],CodeMatrix,Tst12Scenario02,LPDC,4,Case);
clc;
[tst12LogL01,tst03MoFA01,tst03qcn01,tst02RelChange01] = BTPCA_modify(Tst12Scenario02,LV,1,1,0,MoFA01);
[tst12LogL02,tst03MoFA02,tst03qcn02,tst02RelChange02] = BTPCA_modify(Tst12Scenario02,LV,1,1,0,MoFA02);
[tst12LogL03,tst03MoFA03,tst03qcn03,tst02RelChange03] = BTPCA_modify(Tst12Scenario02(1:3,:,:),LV,1,1,0,MoFA03);
[tst12LogL04,tst03MoFA04,tst03qcn04,tst02RelChange04] = BTPCA_modify(Tst12Scenario02(1:3,:,:),LV,1,1,0,MoFA04);
clc;Result = [tst12LogL01(end);tst12LogL02(end);tst12LogL03(end);tst12LogL04(end)];
Pred(4) = find(Result == max(Result));
True(4) = 2;
% ----------------- Testing Stage Data 2 for Sc2 ---------------------- %
Case = 4;
Tst22Scenario02 = [];
% Training Data for Scenario 1 %
[Tst22Scenario02] = fGetBlockCode([1,1],[1,2],[1,3],[1,4],CodeMatrix,Tst22Scenario02,LPDC,1,Case);
[Tst22Scenario02] = fGetBlockCode([2,1],[2,2],[2,3],[2,4],CodeMatrix,Tst22Scenario02,LPDC,2,Case);
[Tst22Scenario02] = fGetBlockCode([3,1],[3,2],[3,3],[3,4],CodeMatrix,Tst22Scenario02,LPDC,3,Case);
[Tst22Scenario02] = fGetBlockCode([4,1],[4,2],[4,3],[4,4],CodeMatrix,Tst22Scenario02,LPDC,4,Case);
clc;
[tst22LogL01,tst03MoFA01,tst03qcn01,tst02RelChange01] = BTPCA_modify(Tst22Scenario02,LV,1,1,0,MoFA01);
[tst22LogL02,tst03MoFA02,tst03qcn02,tst02RelChange02] = BTPCA_modify(Tst22Scenario02,LV,1,1,0,MoFA02);
[tst22LogL03,tst03MoFA03,tst03qcn03,tst02RelChange03] = BTPCA_modify(Tst22Scenario02(1:3,:,:),LV,1,1,0,MoFA03);
[tst22LogL04,tst03MoFA04,tst03qcn04,tst02RelChange04] = BTPCA_modify(Tst22Scenario02(1:3,:,:),LV,1,1,0,MoFA04);
clc;Result = [tst22LogL01(end);tst22LogL02(end);tst22LogL03(end);tst22LogL04(end)];
Pred(5) = find(Result == max(Result));
True(5) = 2;
% ----------------- Testing Stage Data 3 for Sc2 ---------------------- %
Case = 4;
Tst32Scenario02 = [];
% Training Data for Scenario 1 %
[Tst32Scenario02] = fGetBlockCode([3,1],[3,2],[3,3],[3,4],CodeMatrix,Tst32Scenario02,LPDC,1,Case);
[Tst32Scenario02] = fGetBlockCode([4,1],[4,2],[4,3],[4,4],CodeMatrix,Tst32Scenario02,LPDC,2,Case);
[Tst32Scenario02] = fGetBlockCode([1,1],[1,2],[1,3],[1,4],CodeMatrix,Tst32Scenario02,LPDC,3,Case);
[Tst32Scenario02] = fGetBlockCode([2,1],[2,2],[2,3],[2,4],CodeMatrix,Tst32Scenario02,LPDC,4,Case);
clc;
[tst32LogL01,tst03MoFA01,tst03qcn01,tst02RelChange01] = BTPCA_modify(Tst32Scenario02,LV,1,1,0,MoFA01);
[tst32LogL02,tst03MoFA02,tst03qcn02,tst02RelChange02] = BTPCA_modify(Tst32Scenario02,LV,1,1,0,MoFA02);
[tst32LogL03,tst03MoFA03,tst03qcn03,tst02RelChange03] = BTPCA_modify(Tst32Scenario02(1:3,:,:),LV,1,1,0,MoFA03);
[tst32LogL04,tst03MoFA04,tst03qcn04,tst02RelChange04] = BTPCA_modify(Tst32Scenario02(1:3,:,:),LV,1,1,0,MoFA04);
clc;Result = [tst32LogL01(end);tst32LogL02(end);tst32LogL03(end);tst32LogL04(end)];
Pred(6) = find(Result == max(Result));
True(6) = 2;
% ----------------- Testing Stage Data 1 for Sc3 ---------------------- %
Case = 4;
Tst13Scenario03 = [];
% Training Data for Scenario 1 %
[Tst13Scenario03] = fGetBlockCode([1,1],[2,1],[2,2],[1,2],CodeMatrix,Tst13Scenario03,LPDC,1,Case);
[Tst13Scenario03] = fGetBlockCode([1,2],[2,2],[2,3],[1,3],CodeMatrix,Tst13Scenario03,LPDC,2,Case);
[Tst13Scenario03] = fGetBlockCode([2,2],[3,2],[3,3],[2,3],CodeMatrix,Tst13Scenario03,LPDC,3,Case);
[Tst13Scenario03] = fGetBlockCode([2,3],[3,3],[3,4],[2,4],CodeMatrix,Tst13Scenario03,LPDC,4,Case);
clc;
[tst13LogL01,tst03MoFA01,tst03qcn01,tst02RelChange01] = BTPCA_modify(Tst13Scenario03,LV,1,1,0,MoFA01);
[tst13LogL02,tst03MoFA02,tst03qcn02,tst02RelChange02] = BTPCA_modify(Tst13Scenario03,LV,1,1,0,MoFA02);
[tst13LogL03,tst03MoFA03,tst03qcn03,tst02RelChange03] = BTPCA_modify(Tst13Scenario03(1:3,:,:),LV,1,1,0,MoFA03);
[tst13LogL04,tst03MoFA04,tst03qcn04,tst02RelChange04] = BTPCA_modify(Tst13Scenario03(1:3,:,:),LV,1,1,0,MoFA04);
clc;Result = [tst13LogL01(end);tst13LogL02(end);tst13LogL03(end);tst13LogL04(end)];
Pred(7) = find(Result == max(Result));
True(7) = 3;
% % ----------------- Testing Stage Data 2 for Sc3 ---------------------- %
Case = 4;
Tst23Scenario03 = [];
% Training Data for Scenario 1 %
[Tst23Scenario03] = fGetBlockCode([2,1],[3,1],[3,2],[2,2],CodeMatrix,Tst23Scenario03,LPDC,1,Case);
[Tst23Scenario03] = fGetBlockCode([2,2],[3,2],[3,3],[2,3],CodeMatrix,Tst23Scenario03,LPDC,2,Case);
[Tst23Scenario03] = fGetBlockCode([2,3],[3,3],[3,4],[2,4],CodeMatrix,Tst23Scenario03,LPDC,3,Case);
[Tst23Scenario03] = fGetBlockCode([3,1],[4,1],[4,2],[3,2],CodeMatrix,Tst23Scenario03,LPDC,4,Case);
clc;
[tst23LogL01,tst03MoFA01,tst03qcn01,tst02RelChange01] = BTPCA_modify(Tst23Scenario03,LV,1,1,0,MoFA01);
[tst23LogL02,tst03MoFA02,tst03qcn02,tst02RelChange02] = BTPCA_modify(Tst23Scenario03,LV,1,1,0,MoFA02);
[tst23LogL03,tst03MoFA03,tst03qcn03,tst02RelChange03] = BTPCA_modify(Tst23Scenario03(1:3,:,:),LV,1,1,0,MoFA03);
[tst23LogL04,tst03MoFA04,tst03qcn04,tst02RelChange04] = BTPCA_modify(Tst23Scenario03(1:3,:,:),LV,1,1,0,MoFA04);
clc;Result = [tst23LogL01(end);tst23LogL02(end);tst23LogL03(end);tst23LogL04(end)];
Pred(8) = find(Result == max(Result));
True(8) = 3;
% ----------------- Testing Stage Data 3 for Sc3 ---------------------- %
Case = 4;
Tst33Scenario03 = [];
% Training Data for Scenario 1 %
[Tst33Scenario03] = fGetBlockCode([3,3],[4,3],[4,4],[3,4],CodeMatrix,Tst33Scenario03,LPDC,1,Case);
[Tst33Scenario03] = fGetBlockCode([3,2],[4,2],[4,3],[3,3],CodeMatrix,Tst33Scenario03,LPDC,2,Case);
[Tst33Scenario03] = fGetBlockCode([2,3],[3,3],[3,4],[2,4],CodeMatrix,Tst33Scenario03,LPDC,3,Case);
[Tst33Scenario03] = fGetBlockCode([3,1],[4,1],[4,2],[3,2],CodeMatrix,Tst33Scenario03,LPDC,4,Case);
clc;
[tst33LogL01,tst03MoFA01,tst03qcn01,tst02RelChange01] = BTPCA_modify(Tst33Scenario03,LV,1,1,0,MoFA01);
[tst33LogL02,tst03MoFA02,tst03qcn02,tst02RelChange02] = BTPCA_modify(Tst33Scenario03,LV,1,1,0,MoFA02);
[tst33LogL03,tst03MoFA03,tst03qcn03,tst02RelChange03] = BTPCA_modify(Tst33Scenario03(1:3,:,:),LV,1,1,0,MoFA03);
[tst33LogL04,tst03MoFA04,tst03qcn04,tst02RelChange04] = BTPCA_modify(Tst33Scenario03(1:3,:,:),LV,1,1,0,MoFA04);
clc;Result = [tst33LogL01(end);tst33LogL02(end);tst33LogL03(end);tst33LogL04(end)];
Pred(9) = find(Result == max(Result));
True(9) = 3;
% % ----------------- Testing Stage Data 1 for Sc4 ---------------------- %
Case = 4;
Tst14Scenario04 = [];
% Training Data for Scenario 1 %
[Tst14Scenario04] = fGetBlockCode([1,1],[1,2],[1,3],[1,4],CodeMatrix,Tst14Scenario04,LPDC,1,Case);
[Tst14Scenario04] = fGetBlockCode([2,1],[2,2],[2,3],[2,4],CodeMatrix,Tst14Scenario04,LPDC,2,Case);
[Tst14Scenario04] = fGetBlockCode([3,1],[3,2],[3,3],[3,4],CodeMatrix,Tst14Scenario04,LPDC,3,Case);
[Tst14Scenario04] = fGetBlockCode([4,1],[4,2],[4,3],[4,4],CodeMatrix,Tst14Scenario04,LPDC,4,Case);
clc;
[tst14LogL01,tst03MoFA01,tst03qcn01,tst02RelChange01] = BTPCA_modify(Tst14Scenario04,LV,1,1,0,MoFA01);
[tst14LogL02,tst03MoFA02,tst03qcn02,tst02RelChange02] = BTPCA_modify(Tst14Scenario04,LV,1,1,0,MoFA02);
[tst14LogL03,tst03MoFA03,tst03qcn03,tst02RelChange03] = BTPCA_modify(Tst14Scenario04(1:3,:,:),LV,1,1,0,MoFA03);
[tst14LogL04,tst03MoFA04,tst03qcn04,tst02RelChange04] = BTPCA_modify(Tst14Scenario04(1:3,:,:),LV,1,1,0,MoFA04);
clc;Result = [tst14LogL01(end);tst14LogL02(end);tst14LogL03(end);tst14LogL04(end)];
Pred(10) = find(Result == max(Result));
True(10) = 4;
% ----------------- Testing Stage Data 2 for Sc4 ---------------------- %
Case = 4;
Tst24Scenario04 = [];
% Training Data for Scenario 1 %
[Tst24Scenario04] = fGetBlockCode([3,1],[3,2],[3,3],[3,4],CodeMatrix,Tst24Scenario04,LPDC,1,Case);
[Tst24Scenario04] = fGetBlockCode([4,1],[4,2],[4,3],[4,4],CodeMatrix,Tst24Scenario04,LPDC,2,Case);
[Tst24Scenario04] = fGetBlockCode([1,1],[1,2],[1,3],[1,4],CodeMatrix,Tst24Scenario04,LPDC,3,Case);
[Tst24Scenario04] = fGetBlockCode([2,1],[2,2],[2,3],[2,4],CodeMatrix,Tst24Scenario04,LPDC,4,Case);
clc;
[tst24LogL01,tst03MoFA01,tst03qcn01,tst02RelChange01] = BTPCA_modify(Tst24Scenario04,LV,1,1,0,MoFA01);
[tst24LogL02,tst03MoFA02,tst03qcn02,tst02RelChange02] = BTPCA_modify(Tst24Scenario04,LV,1,1,0,MoFA02);
[tst24LogL03,tst03MoFA03,tst03qcn03,tst02RelChange03] = BTPCA_modify(Tst24Scenario04(1:3,:,:),LV,1,1,0,MoFA03);
[tst24LogL04,tst03MoFA04,tst03qcn04,tst02RelChange04] = BTPCA_modify(Tst24Scenario04(1:3,:,:),LV,1,1,0,MoFA04);
clc;Result = [tst24LogL01(end);tst24LogL02(end);tst24LogL03(end);tst24LogL04(end)];
Pred(11) = find(Result == max(Result));
True(11) = 4;
% ----------------- Testing Stage Data 3 for Sc4 ---------------------- %
Case = 4;
Tst34Scenario04 = [];
% Training Data for Scenario 1 %
[Tst34Scenario04] = fGetBlockCode([3,1],[3,2],[3,3],[3,4],CodeMatrix,Tst34Scenario04,LPDC,1,Case);
[Tst34Scenario04] = fGetBlockCode([1,1],[1,2],[1,3],[1,4],CodeMatrix,Tst34Scenario04,LPDC,2,Case);
[Tst34Scenario04] = fGetBlockCode([4,1],[4,2],[4,3],[4,4],CodeMatrix,Tst34Scenario04,LPDC,3,Case);
[Tst34Scenario04] = fGetBlockCode([2,1],[2,2],[2,3],[2,4],CodeMatrix,Tst34Scenario04,LPDC,4,Case);
clc;
[tst34LogL01,tst03MoFA01,tst03qcn01,tst02RelChange01] = BTPCA_modify(Tst34Scenario04,LV,1,1,0,MoFA01);
[tst34LogL02,tst03MoFA02,tst03qcn02,tst02RelChange02] = BTPCA_modify(Tst34Scenario04,LV,1,1,0,MoFA02);
[tst34LogL03,tst03MoFA03,tst03qcn03,tst02RelChange03] = BTPCA_modify(Tst34Scenario04(1:3,:,:),LV,1,1,0,MoFA03);
[tst34LogL04,tst03MoFA04,tst03qcn04,tst02RelChange04] = BTPCA_modify(Tst34Scenario04(1:3,:,:),LV,1,1,0,MoFA04);
clc;Result = [tst34LogL01(end);tst34LogL02(end);tst34LogL03(end);tst34LogL04(end)];
Pred(12) = find(Result == max(Result));
True(12) = 4;
% ----------------------------------------------------------------------- %
% <> ------------- <> ---------------- <><> ------------- <> ----------- <>

Mat1 = [Pred;True]'

TotSc1 = find(Mat1(:,2) == 1);TotSc1 = length(TotSc1);
TotSc2 = find(Mat1(:,2) == 2);TotSc2 = length(TotSc2);
TotSc3 = find(Mat1(:,2) == 3);TotSc3 = length(TotSc3);
TotSc4 = find(Mat1(:,2) == 4);TotSc4 = length(TotSc4);

PredSc1 = find(Mat1(:,1) == 1 & Mat1(:,2) == 1); if(isempty(PredSc1));PredSc1 = 0;else;PredSc1 = length(PredSc1);end

PredSc2 = find(Mat1(:,1) == 2 & Mat1(:,2) == 2); if(isempty(PredSc2));PredSc2 = 0;else;PredSc2 = length(PredSc2);end

PredSc3 = find(Mat1(:,1) == 3 & Mat1(:,2) == 3); if(isempty(PredSc3));PredSc3 = 0;else;PredSc3 = length(PredSc3);end

PredSc4 = find(Mat1(:,1) == 4 & Mat1(:,2) == 4); if(isempty(PredSc4));PredSc4 = 0;else;PredSc4 = length(PredSc4);end

RR1 = (PredSc1/TotSc1)*100;RR2 = (PredSc2/TotSc2)*100;
RR3 = (PredSc3/TotSc3)*100;RR4 = (PredSc4/TotSc4)*100;
yplt =  [RR1,RR2,RR3,RR4];xplt = [1,2,3,4];
figure(2);hold on;xlabel('Scenarios');ylabel('Recognition Rate in %')
bar(xplt,yplt);title('Recognition Rate vs Scenarios')

















