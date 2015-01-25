function[TrScenario01,TrScenario02,TrScenario03,TrScenario04] = fCreateScenData002(CodeMatrix,LPDC);
% This function creates teh Different scenario data for the Trans Inv
% Binary PCA
% Date: 9 Feb 2014

% <>----------- Data for Scenario 1 -----------<>
Case = 4;
TrScenario01 = [];
% Training Data for Scenario 1 % Coordinates for each block % Use CodeMatrix to determine there position
                               % Coordinates of each sub position or block | Serial # for each block | 3D Data matrix
[TrScenario01] = fGetBlockCode([1,1],[1,2],[2,1],[2,2],CodeMatrix,TrScenario01,LPDC,1,Case);   
[TrScenario01] = fGetBlockCode([1,3],[1,4],[2,3],[2,4],CodeMatrix,TrScenario01,LPDC,2,Case);
[TrScenario01] = fGetBlockCode([1,4],[1,5],[2,4],[2,5],CodeMatrix,TrScenario01,LPDC,3,Case);
[TrScenario01] = fGetBlockCode([3,1],[3,2],[4,1],[4,2],CodeMatrix,TrScenario01,LPDC,4,Case);
[TrScenario01] = fGetBlockCode([3,3],[3,4],[4,3],[4,4],CodeMatrix,TrScenario01,LPDC,5,Case);
[TrScenario01] = fGetBlockCode([3,4],[3,5],[4,4],[4,5],CodeMatrix,TrScenario01,LPDC,6,Case);
[TrScenario01] = fGetBlockCode([4,1],[4,2],[5,1],[5,2],CodeMatrix,TrScenario01,LPDC,7,Case);
[TrScenario01] = fGetBlockCode([4,3],[4,4],[5,3],[5,4],CodeMatrix,TrScenario01,LPDC,8,Case);
[TrScenario01] = fGetBlockCode([4,4],[4,5],[5,4],[5,5],CodeMatrix,TrScenario01,LPDC,9,Case);
% <>----------- Data for Scenario 2 -----------<>
Case = 4;
TrScenario02 = [];
% Training Data for Scenario 2 %
[TrScenario02] = fGetBlockCode([1,1],[1,2],[1,3],[1,4],CodeMatrix,TrScenario02,LPDC,1,Case);
[TrScenario02] = fGetBlockCode([1,4],[1,3],[1,2],[1,1],CodeMatrix,TrScenario02,LPDC,2,Case);
[TrScenario02] = fGetBlockCode([1,2],[1,3],[1,4],[1,5],CodeMatrix,TrScenario02,LPDC,3,Case);
[TrScenario02] = fGetBlockCode([1,5],[1,4],[1,3],[1,2],CodeMatrix,TrScenario02,LPDC,4,Case);

[TrScenario02] = fGetBlockCode([2,1],[2,2],[2,3],[2,4],CodeMatrix,TrScenario02,LPDC,5,Case);
[TrScenario02] = fGetBlockCode([2,4],[2,3],[2,2],[2,1],CodeMatrix,TrScenario02,LPDC,6,Case);
[TrScenario02] = fGetBlockCode([2,2],[2,3],[2,4],[2,5],CodeMatrix,TrScenario02,LPDC,7,Case);
[TrScenario02] = fGetBlockCode([2,5],[2,4],[2,3],[2,2],CodeMatrix,TrScenario02,LPDC,8,Case);

[TrScenario02] = fGetBlockCode([3,1],[3,2],[3,3],[3,4],CodeMatrix,TrScenario02,LPDC,9,Case);
% [TrScenario02] = fGetBlockCode([3,2],[3,3],[3,4],[3,5],CodeMatrix,TrScenario02,LPDC,10,Case);
% [TrScenario02] = fGetBlockCode([4,1],[4,2],[4,3],[4,4],CodeMatrix,TrScenario02,LPDC,11,Case);
% [TrScenario02] = fGetBlockCode([4,2],[4,3],[4,4],[4,5],CodeMatrix,TrScenario02,LPDC,12,Case);
% <>----------- Data for Scenario 3 -----------<>
% Case = 3;
% TrScenario03 = [];
% % Training Data for Scenario 3 %
% [TrScenario03] = fGetBlockCode([1,1],[2,1],[2,2],[0,0],CodeMatrix,TrScenario03,LPDC,1,Case);
% [TrScenario03] = fGetBlockCode([1,3],[2,3],[2,4],[0,0],CodeMatrix,TrScenario03,LPDC,2,Case);
% [TrScenario03] = fGetBlockCode([3,1],[4,1],[4,2],[0,0],CodeMatrix,TrScenario03,LPDC,3,Case);
% [TrScenario03] = fGetBlockCode([3,3],[4,3],[4,4],[0,0],CodeMatrix,TrScenario03,LPDC,4,Case);
Case = 4;
TrScenario03 = [];
% Training Data for Scenario 3 %
[TrScenario03] = fGetBlockCode([1,1],[2,1],[2,2],[2,3],CodeMatrix,TrScenario03,LPDC,1,Case);
[TrScenario03] = fGetBlockCode([1,2],[2,2],[2,3],[2,4],CodeMatrix,TrScenario03,LPDC,2,Case);
[TrScenario03] = fGetBlockCode([1,3],[2,3],[2,4],[2,5],CodeMatrix,TrScenario03,LPDC,3,Case);

[TrScenario03] = fGetBlockCode([2,1],[3,1],[3,2],[3,3],CodeMatrix,TrScenario03,LPDC,4,Case);
[TrScenario03] = fGetBlockCode([2,2],[3,2],[3,3],[3,4],CodeMatrix,TrScenario03,LPDC,5,Case);
[TrScenario03] = fGetBlockCode([2,3],[3,3],[3,4],[3,5],CodeMatrix,TrScenario03,LPDC,6,Case);

[TrScenario03] = fGetBlockCode([3,1],[4,1],[4,2],[4,3],CodeMatrix,TrScenario03,LPDC,7,Case);
[TrScenario03] = fGetBlockCode([3,2],[4,2],[4,3],[4,4],CodeMatrix,TrScenario03,LPDC,8,Case);
[TrScenario03] = fGetBlockCode([4,1],[5,1],[5,2],[5,3],CodeMatrix,TrScenario03,LPDC,9,Case);

% <>----------- Data for Scenario 4 -----------<>
% Case = 3;
% TrScenario04 = [];
% % Training Data for Scenario 4 %
% [TrScenario04] = fGetBlockCode([1,1],[1,2],[1,3],[0,0],CodeMatrix,TrScenario04,LPDC,1,Case);
% [TrScenario04] = fGetBlockCode([2,1],[2,2],[2,3],[0,0],CodeMatrix,TrScenario04,LPDC,2,Case);
% [TrScenario04] = fGetBlockCode([3,1],[3,2],[3,3],[0,0],CodeMatrix,TrScenario04,LPDC,3,Case);
% [TrScenario04] = fGetBlockCode([4,1],[4,2],[4,3],[0,0],CodeMatrix,TrScenario04,LPDC,4,Case);
Case = 4;
TrScenario04 = [];
% Training Data for Scenario 4 %
[TrScenario04] = fGetBlockCode([1,1],[2,2],[3,1],[2,1],CodeMatrix,TrScenario04,LPDC,1,Case);
[TrScenario04] = fGetBlockCode([1,2],[2,3],[3,2],[2,2],CodeMatrix,TrScenario04,LPDC,2,Case);
[TrScenario04] = fGetBlockCode([1,3],[2,4],[3,3],[2,3],CodeMatrix,TrScenario04,LPDC,3,Case);

[TrScenario04] = fGetBlockCode([2,1],[3,2],[4,1],[3,1],CodeMatrix,TrScenario04,LPDC,4,Case);
[TrScenario04] = fGetBlockCode([2,2],[3,3],[4,2],[3,2],CodeMatrix,TrScenario04,LPDC,5,Case);
[TrScenario04] = fGetBlockCode([2,3],[3,4],[4,3],[3,3],CodeMatrix,TrScenario04,LPDC,6,Case);

[TrScenario04] = fGetBlockCode([3,1],[4,2],[5,1],[4,1],CodeMatrix,TrScenario04,LPDC,7,Case);
[TrScenario04] = fGetBlockCode([3,2],[4,3],[5,2],[4,2],CodeMatrix,TrScenario04,LPDC,8,Case);
[TrScenario04] = fGetBlockCode([3,3],[4,4],[5,3],[4,3],CodeMatrix,TrScenario04,LPDC,9,Case);





end









