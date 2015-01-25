function[TstD1Sc1,TstD2Sc1,TstD3Sc1,TstD1Sc2,TstD2Sc2,TstD3Sc2,TstD1Sc3,TstD2Sc3,TstD3Sc3,TstD1Sc4,TstD2Sc4,TstD3Sc4] = fGetTestDataDiffScene002(CodeMatrix,LPDC);

% ----------------- Testing Stage Data 1 for Sc1 ---------------------- %
Case = 4;
TstD1Sc1 = [];
% Testing Data # 1 for Scenario # 1 %
[TstD1Sc1] = fGetBlockCode([1,1],[1,2],[2,1],[2,2],CodeMatrix,TstD1Sc1,LPDC,1,Case);
[TstD1Sc1] = fGetBlockCode([1,3],[1,4],[2,3],[2,4],CodeMatrix,TstD1Sc1,LPDC,2,Case);
[TstD1Sc1] = fGetBlockCode([3,1],[3,2],[4,1],[4,2],CodeMatrix,TstD1Sc1,LPDC,3,Case);
[TstD1Sc1] = fGetBlockCode([3,3],[3,4],[4,3],[4,4],CodeMatrix,TstD1Sc1,LPDC,4,Case);
[TstD1Sc1] = fGetBlockCode([1,2],[1,3],[2,2],[2,3],CodeMatrix,TstD1Sc1,LPDC,5,Case);
[TstD1Sc1] = fGetBlockCode([1,4],[1,5],[2,4],[2,5],CodeMatrix,TstD1Sc1,LPDC,6,Case);
[TstD1Sc1] = fGetBlockCode([2,1],[2,2],[3,1],[3,2],CodeMatrix,TstD1Sc1,LPDC,7,Case);
[TstD1Sc1] = fGetBlockCode([2,3],[2,4],[3,3],[3,4],CodeMatrix,TstD1Sc1,LPDC,8,Case);
[TstD1Sc1] = fGetBlockCode([2,4],[2,5],[3,4],[3,5],CodeMatrix,TstD1Sc1,LPDC,9,Case);
% ----------------- Testing Stage Data 2 for Sc1 ---------------------- %
Case = 4;
TstD2Sc1 = [];
% Testing Data # 2 for Scenario # 1 %
[TstD2Sc1] = fGetBlockCode([4,1],[4,2],[5,1],[5,2],CodeMatrix,TstD2Sc1,LPDC,1,Case);
[TstD2Sc1] = fGetBlockCode([2,2],[2,3],[3,2],[3,3],CodeMatrix,TstD2Sc1,LPDC,2,Case);
[TstD2Sc1] = fGetBlockCode([2,3],[2,4],[3,3],[3,4],CodeMatrix,TstD2Sc1,LPDC,3,Case);
[TstD2Sc1] = fGetBlockCode([2,4],[2,5],[3,4],[3,5],CodeMatrix,TstD2Sc1,LPDC,4,Case);
[TstD2Sc1] = fGetBlockCode([3,1],[3,2],[4,1],[4,2],CodeMatrix,TstD2Sc1,LPDC,5,Case);
[TstD2Sc1] = fGetBlockCode([3,3],[3,4],[4,3],[4,4],CodeMatrix,TstD2Sc1,LPDC,6,Case);
[TstD2Sc1] = fGetBlockCode([3,4],[3,5],[4,4],[4,5],CodeMatrix,TstD2Sc1,LPDC,7,Case);
[TstD2Sc1] = fGetBlockCode([4,1],[4,2],[5,1],[5,2],CodeMatrix,TstD2Sc1,LPDC,8,Case);
[TstD2Sc1] = fGetBlockCode([4,3],[4,4],[5,3],[5,4],CodeMatrix,TstD2Sc1,LPDC,9,Case);
% ----------------- Testing Stage Data 3 for Sc1 ---------------------- %
Case = 4;
TstD3Sc1 = [];
% Testing Data # 3 for Scenario # 1 %
[TstD3Sc1] = fGetBlockCode([1,1],[1,2],[2,1],[2,2],CodeMatrix,TstD3Sc1,LPDC,1,Case);
[TstD3Sc1] = fGetBlockCode([1,2],[1,3],[2,2],[2,3],CodeMatrix,TstD3Sc1,LPDC,2,Case);
[TstD3Sc1] = fGetBlockCode([1,3],[1,4],[2,3],[2,4],CodeMatrix,TstD3Sc1,LPDC,3,Case);
[TstD3Sc1] = fGetBlockCode([3,3],[3,4],[4,3],[4,4],CodeMatrix,TstD3Sc1,LPDC,4,Case);
[TstD3Sc1] = fGetBlockCode([3,3],[3,4],[4,3],[4,4],CodeMatrix,TstD3Sc1,LPDC,5,Case);
[TstD3Sc1] = fGetBlockCode([3,4],[3,5],[4,4],[4,5],CodeMatrix,TstD3Sc1,LPDC,6,Case);
[TstD3Sc1] = fGetBlockCode([4,1],[4,2],[5,1],[5,2],CodeMatrix,TstD3Sc1,LPDC,7,Case);
[TstD3Sc1] = fGetBlockCode([4,3],[4,4],[5,3],[5,4],CodeMatrix,TstD3Sc1,LPDC,8,Case);
[TstD3Sc1] = fGetBlockCode([4,4],[4,5],[5,4],[5,5],CodeMatrix,TstD3Sc1,LPDC,9,Case);
% ----------------- Testing Stage Data 1 for Sc2 ---------------------- %
% % ******* Not Giving Good Results ******* % %
Case = 4;
TstD1Sc2 = [];
% Testing Data # 1 for Scenario # 2 %
[TstD1Sc2] = fGetBlockCode([1,1],[1,2],[1,3],[1,4],CodeMatrix,TstD1Sc2,LPDC,1,Case);
[TstD1Sc2] = fGetBlockCode([1,4],[1,3],[1,2],[1,1],CodeMatrix,TstD1Sc2,LPDC,2,Case);
[TstD1Sc2] = fGetBlockCode([1,2],[1,3],[1,4],[1,5],CodeMatrix,TstD1Sc2,LPDC,3,Case);
[TstD1Sc2] = fGetBlockCode([1,5],[1,4],[1,3],[1,2],CodeMatrix,TstD1Sc2,LPDC,4,Case);

[TstD1Sc2] = fGetBlockCode([2,1],[2,2],[2,3],[2,4],CodeMatrix,TstD1Sc2,LPDC,5,Case);
[TstD1Sc2] = fGetBlockCode([2,4],[2,3],[2,2],[2,1],CodeMatrix,TstD1Sc2,LPDC,6,Case);
[TstD1Sc2] = fGetBlockCode([2,2],[2,3],[2,4],[2,5],CodeMatrix,TstD1Sc2,LPDC,7,Case);
[TstD1Sc2] = fGetBlockCode([2,5],[2,4],[2,3],[2,2],CodeMatrix,TstD1Sc2,LPDC,8,Case);

[TstD1Sc2] = fGetBlockCode([3,1],[3,2],[3,3],[3,4],CodeMatrix,TstD1Sc2,LPDC,9,Case);
% ----------------- Testing Stage Data 2 for Sc2 ---------------------- %
% % ******* Giving Good Results ******* % %
Case = 4;
TstD2Sc2 = [];
% Testing Data # 2 for Scenario # 2 %
[TstD2Sc2] = fGetBlockCode([1,5],[1,4],[1,3],[1,2],CodeMatrix,TstD2Sc2,LPDC,1,Case);
[TstD2Sc2] = fGetBlockCode([2,1],[2,2],[2,3],[2,4],CodeMatrix,TstD2Sc2,LPDC,2,Case);
[TstD2Sc2] = fGetBlockCode([2,4],[2,3],[2,2],[2,1],CodeMatrix,TstD2Sc2,LPDC,3,Case);
[TstD2Sc2] = fGetBlockCode([2,2],[2,3],[2,4],[2,5],CodeMatrix,TstD2Sc2,LPDC,4,Case);
[TstD2Sc2] = fGetBlockCode([2,5],[2,4],[2,3],[2,2],CodeMatrix,TstD2Sc2,LPDC,5,Case);

[TstD2Sc2] = fGetBlockCode([3,1],[3,2],[3,3],[3,4],CodeMatrix,TstD2Sc2,LPDC,6,Case);
[TstD2Sc2] = fGetBlockCode([3,2],[3,3],[3,4],[3,5],CodeMatrix,TstD2Sc2,LPDC,7,Case);
[TstD2Sc2] = fGetBlockCode([4,1],[4,2],[4,3],[4,4],CodeMatrix,TstD2Sc2,LPDC,8,Case);
[TstD2Sc2] = fGetBlockCode([4,2],[4,3],[4,4],[4,5],CodeMatrix,TstD2Sc2,LPDC,9,Case);
% ----------------- Testing Stage Data 3 for Sc2 ---------------------- %
% % ******* Giving Good Results ******* % %
Case = 4;
TstD3Sc2 = [];
% Testing Data # 3 for Scenario # 2 %
[TstD3Sc2] = fGetBlockCode([3,1],[3,2],[3,3],[3,4],CodeMatrix,TstD3Sc2,LPDC,1,Case);
[TstD3Sc2] = fGetBlockCode([4,1],[4,2],[4,3],[4,4],CodeMatrix,TstD3Sc2,LPDC,2,Case);
[TstD3Sc2] = fGetBlockCode([1,1],[1,2],[1,3],[1,4],CodeMatrix,TstD3Sc2,LPDC,3,Case);
[TstD3Sc2] = fGetBlockCode([2,1],[2,2],[2,3],[2,4],CodeMatrix,TstD3Sc2,LPDC,4,Case);
[TstD3Sc2] = fGetBlockCode([1,5],[1,4],[1,3],[1,2],CodeMatrix,TstD3Sc2,LPDC,5,Case);
[TstD3Sc2] = fGetBlockCode([2,1],[2,2],[2,3],[2,4],CodeMatrix,TstD3Sc2,LPDC,6,Case);
[TstD3Sc2] = fGetBlockCode([2,4],[2,3],[2,2],[2,1],CodeMatrix,TstD3Sc2,LPDC,7,Case);
[TstD3Sc2] = fGetBlockCode([2,2],[2,3],[2,4],[2,5],CodeMatrix,TstD3Sc2,LPDC,8,Case);
[TstD3Sc2] = fGetBlockCode([2,5],[2,4],[2,3],[2,2],CodeMatrix,TstD3Sc2,LPDC,9,Case);
% ----------------- Testing Stage Data 1 for Sc3 ---------------------- %
Case = 4;
TstD1Sc3 = [];
% Testing Data # 1 for Scenario # 3 %
[TstD1Sc3] = fGetBlockCode([2,1],[3,1],[3,2],[3,3],CodeMatrix,TstD1Sc3,LPDC,1,Case);
[TstD1Sc3] = fGetBlockCode([2,2],[3,2],[3,3],[3,4],CodeMatrix,TstD1Sc3,LPDC,2,Case);
[TstD1Sc3] = fGetBlockCode([2,3],[3,3],[3,4],[3,5],CodeMatrix,TstD1Sc3,LPDC,3,Case);

[TstD1Sc3] = fGetBlockCode([1,1],[2,1],[2,2],[2,3],CodeMatrix,TstD1Sc3,LPDC,4,Case);
[TstD1Sc3] = fGetBlockCode([1,2],[2,2],[2,3],[2,4],CodeMatrix,TstD1Sc3,LPDC,5,Case);
[TstD1Sc3] = fGetBlockCode([1,3],[2,3],[2,4],[2,5],CodeMatrix,TstD1Sc3,LPDC,6,Case);

[TstD1Sc3] = fGetBlockCode([3,1],[4,1],[4,2],[4,3],CodeMatrix,TstD1Sc3,LPDC,7,Case);
[TstD1Sc3] = fGetBlockCode([3,2],[4,2],[4,3],[4,4],CodeMatrix,TstD1Sc3,LPDC,8,Case);
[TstD1Sc3] = fGetBlockCode([4,1],[5,1],[5,2],[5,3],CodeMatrix,TstD1Sc3,LPDC,9,Case);

% % ----------------- Testing Stage Data 2 for Sc3 ---------------------- %
Case = 4;
TstD2Sc3 = [];
% Testing Data # 2 for Scenario # 3 %
[TstD2Sc3] = fGetBlockCode([3,1],[4,1],[4,2],[4,3],CodeMatrix,TstD2Sc3,LPDC,1,Case);
[TstD2Sc3] = fGetBlockCode([3,2],[4,2],[4,3],[4,4],CodeMatrix,TstD2Sc3,LPDC,2,Case);
[TstD2Sc3] = fGetBlockCode([3,3],[4,3],[4,4],[4,5],CodeMatrix,TstD2Sc3,LPDC,3,Case);
[TstD2Sc3] = fGetBlockCode([4,1],[5,1],[5,2],[5,3],CodeMatrix,TstD2Sc3,LPDC,4,Case);
[TstD2Sc3] = fGetBlockCode([4,2],[5,2],[5,3],[5,4],CodeMatrix,TstD2Sc3,LPDC,5,Case);
[TstD2Sc3] = fGetBlockCode([4,3],[5,3],[5,4],[5,5],CodeMatrix,TstD2Sc3,LPDC,6,Case);
[TstD2Sc3] = fGetBlockCode([1,2],[2,2],[2,3],[2,4],CodeMatrix,TstD2Sc3,LPDC,7,Case);
[TstD2Sc3] = fGetBlockCode([2,2],[3,2],[3,3],[3,4],CodeMatrix,TstD2Sc3,LPDC,8,Case);
[TstD2Sc3] = fGetBlockCode([2,2],[3,2],[3,3],[3,4],CodeMatrix,TstD2Sc3,LPDC,9,Case);
% ----------------- Testing Stage Data 3 for Sc3 ---------------------- %
Case = 4;
TstD3Sc3 = [];
% Testing Data # 3 for Scenario # 3 %
[TstD3Sc3] = fGetBlockCode([1,1],[1,2],[1,3],[1,4],CodeMatrix,TstD3Sc3,LPDC,1,Case);
[TstD3Sc3] = fGetBlockCode([2,1],[2,2],[2,3],[2,4],CodeMatrix,TstD3Sc3,LPDC,2,Case);
[TstD3Sc3] = fGetBlockCode([2,2],[3,2],[3,3],[3,4],CodeMatrix,TstD3Sc3,LPDC,3,Case);
[TstD3Sc3] = fGetBlockCode([2,3],[3,3],[3,4],[3,5],CodeMatrix,TstD3Sc3,LPDC,4,Case);
[TstD3Sc3] = fGetBlockCode([3,3],[4,3],[4,4],[4,5],CodeMatrix,TstD3Sc3,LPDC,5,Case);
[TstD3Sc3] = fGetBlockCode([3,2],[4,2],[4,3],[4,4],CodeMatrix,TstD3Sc3,LPDC,6,Case);
[TstD3Sc3] = fGetBlockCode([3,1],[4,1],[4,2],[4,3],CodeMatrix,TstD3Sc3,LPDC,7,Case);
[TstD3Sc3] = fGetBlockCode([1,2],[2,2],[2,3],[2,4],CodeMatrix,TstD3Sc3,LPDC,8,Case);
[TstD3Sc3] = fGetBlockCode([1,2],[2,2],[2,3],[2,4],CodeMatrix,TstD3Sc3,LPDC,9,Case);
% % ----------------- Testing Stage Data 1 for Sc4 ---------------------- %
% % ******* Not Giving Good Results ******* % %
Case = 4;
TstD1Sc4 = [];
% Testing Data # 1 for Scenario # 4 %
[TstD1Sc4] = fGetBlockCode([2,1],[3,2],[4,1],[3,1],CodeMatrix,TstD1Sc4,LPDC,1,Case);
[TstD1Sc4] = fGetBlockCode([2,2],[3,3],[4,2],[3,2],CodeMatrix,TstD1Sc4,LPDC,2,Case);
[TstD1Sc4] = fGetBlockCode([2,3],[3,4],[4,3],[3,3],CodeMatrix,TstD1Sc4,LPDC,3,Case);

[TstD1Sc4] = fGetBlockCode([1,1],[2,2],[3,1],[2,1],CodeMatrix,TstD1Sc4,LPDC,4,Case);
[TstD1Sc4] = fGetBlockCode([1,2],[2,3],[3,2],[2,2],CodeMatrix,TstD1Sc4,LPDC,5,Case);
[TstD1Sc4] = fGetBlockCode([1,3],[2,4],[3,3],[2,3],CodeMatrix,TstD1Sc4,LPDC,6,Case);

[TstD1Sc4] = fGetBlockCode([3,1],[4,2],[5,1],[4,1],CodeMatrix,TstD1Sc4,LPDC,7,Case);
[TstD1Sc4] = fGetBlockCode([3,2],[4,3],[5,2],[4,2],CodeMatrix,TstD1Sc4,LPDC,8,Case);
[TstD1Sc4] = fGetBlockCode([3,3],[4,4],[5,3],[4,3],CodeMatrix,TstD1Sc4,LPDC,9,Case);
% ----------------- Testing Stage Data 2 for Sc4 ---------------------- %
% % ******* Giving Good Results ******* % %
Case = 4;
TstD2Sc4 = [];
% Testing Data # 2 for Scenario # 4 %
[TstD2Sc4] = fGetBlockCode([1,1],[2,2],[3,1],[2,1],CodeMatrix,TstD2Sc4,LPDC,1,Case);
[TstD2Sc4] = fGetBlockCode([1,2],[2,3],[3,2],[2,2],CodeMatrix,TstD2Sc4,LPDC,2,Case);
[TstD2Sc4] = fGetBlockCode([1,3],[2,4],[3,3],[2,3],CodeMatrix,TstD2Sc4,LPDC,3,Case);
[TstD2Sc4] = fGetBlockCode([1,4],[2,5],[3,4],[2,4],CodeMatrix,TstD2Sc4,LPDC,4,Case);

[TstD2Sc4] = fGetBlockCode([2,1],[3,2],[4,1],[3,1],CodeMatrix,TstD2Sc4,LPDC,5,Case);
[TstD2Sc4] = fGetBlockCode([2,2],[3,3],[4,2],[3,2],CodeMatrix,TstD2Sc4,LPDC,6,Case);
[TstD2Sc4] = fGetBlockCode([2,3],[3,4],[4,3],[3,3],CodeMatrix,TstD2Sc4,LPDC,7,Case);
[TstD2Sc4] = fGetBlockCode([2,4],[3,5],[4,4],[3,4],CodeMatrix,TstD2Sc4,LPDC,8,Case);
[TstD2Sc4] = fGetBlockCode([3,1],[4,2],[5,1],[4,1],CodeMatrix,TstD2Sc4,LPDC,9,Case);
% ----------------- Testing Stage Data 3 for Sc4 ---------------------- %
Case = 4;
TstD3Sc4 = [];
% Testing Data # 3 for Scenario # 4 %
[TstD3Sc4] = fGetBlockCode([2,4],[3,5],[4,4],[3,4],CodeMatrix,TstD3Sc4,LPDC,1,Case);
[TstD3Sc4] = fGetBlockCode([3,1],[4,2],[5,1],[4,1],CodeMatrix,TstD3Sc4,LPDC,2,Case);
[TstD3Sc4] = fGetBlockCode([3,2],[4,3],[5,2],[4,2],CodeMatrix,TstD3Sc4,LPDC,3,Case);
[TstD3Sc4] = fGetBlockCode([3,3],[4,4],[5,3],[4,3],CodeMatrix,TstD3Sc4,LPDC,4,Case);

[TstD3Sc4] = fGetBlockCode([2,1],[3,2],[4,1],[3,1],CodeMatrix,TstD3Sc4,LPDC,5,Case);
[TstD3Sc4] = fGetBlockCode([2,2],[3,3],[4,2],[3,2],CodeMatrix,TstD3Sc4,LPDC,6,Case);
[TstD3Sc4] = fGetBlockCode([2,3],[3,4],[4,3],[3,3],CodeMatrix,TstD3Sc4,LPDC,7,Case);

[TstD3Sc4] = fGetBlockCode([1,3],[2,4],[3,3],[2,3],CodeMatrix,TstD3Sc4,LPDC,8,Case);
[TstD3Sc4] = fGetBlockCode([1,4],[2,5],[3,4],[2,4],CodeMatrix,TstD3Sc4,LPDC,9,Case);



% <> ------------- <> ---------------- <><> ------------- <> ---------------- <>
% <> ------------- <> ---------------- <><> ------------- <> ---------------- <>









end









