function[TrScenario01,TrScenario02,TrScenario03,TrScenario04] = fCreateScenData(CodeMatrix,LPDC);
% This function creates teh Different scenario data for the Trans Inv
% Binary PCA
% Date: 5 Feb 2014

% <>----------- Data for Scenario 1 -----------<>
Case = 4;
TrScenario01 = [];
% Training Data for Scenario 1 % Coordinates for each block % Use CodeMatrix to determine there position
                               % Coordinates of each sub position or block | Serial # for each block | 3D Data matrix
[TrScenario01] = fGetBlockCode([1,1],[1,2],[2,1],[2,2],CodeMatrix,TrScenario01,LPDC,1,Case);   
[TrScenario01] = fGetBlockCode([1,3],[1,4],[2,3],[2,4],CodeMatrix,TrScenario01,LPDC,2,Case);
[TrScenario01] = fGetBlockCode([3,1],[3,2],[4,1],[4,2],CodeMatrix,TrScenario01,LPDC,3,Case);
[TrScenario01] = fGetBlockCode([3,3],[3,4],[4,3],[4,4],CodeMatrix,TrScenario01,LPDC,4,Case);

% <>----------- Data for Scenario 2 -----------<>
Case = 4;
TrScenario02 = [];
% Training Data for Scenario 2 %
[TrScenario02] = fGetBlockCode([1,1],[1,2],[1,3],[1,4],CodeMatrix,TrScenario02,LPDC,1,Case);
[TrScenario02] = fGetBlockCode([2,1],[2,2],[2,3],[2,4],CodeMatrix,TrScenario02,LPDC,2,Case);
[TrScenario02] = fGetBlockCode([3,1],[3,2],[3,3],[3,4],CodeMatrix,TrScenario02,LPDC,3,Case);
[TrScenario02] = fGetBlockCode([4,1],[4,2],[4,3],[4,4],CodeMatrix,TrScenario02,LPDC,4,Case);

% <>----------- Data for Scenario 3 -----------<>
Case = 3;
TrScenario03 = [];
% Training Data for Scenario 3 %
[TrScenario03] = fGetBlockCode([1,1],[2,1],[2,2],[0,0],CodeMatrix,TrScenario03,LPDC,1,Case);
[TrScenario03] = fGetBlockCode([1,3],[2,3],[2,4],[0,0],CodeMatrix,TrScenario03,LPDC,2,Case);
[TrScenario03] = fGetBlockCode([3,1],[4,1],[4,2],[0,0],CodeMatrix,TrScenario03,LPDC,3,Case);
[TrScenario03] = fGetBlockCode([3,3],[4,3],[4,4],[0,0],CodeMatrix,TrScenario03,LPDC,4,Case);

% <>----------- Data for Scenario 4 -----------<>
Case = 3;
TrScenario04 = [];
% Training Data for Scenario 4 %
[TrScenario04] = fGetBlockCode([1,1],[1,2],[1,3],[0,0],CodeMatrix,TrScenario04,LPDC,1,Case);
[TrScenario04] = fGetBlockCode([2,1],[2,2],[2,3],[0,0],CodeMatrix,TrScenario04,LPDC,2,Case);
[TrScenario04] = fGetBlockCode([3,1],[3,2],[3,3],[0,0],CodeMatrix,TrScenario04,LPDC,3,Case);
[TrScenario04] = fGetBlockCode([4,1],[4,2],[4,3],[0,0],CodeMatrix,TrScenario04,LPDC,4,Case);









end