function[xScenario] = fGetBlockCode(Sub1,Sub2,Sub3,Sub4,CodeMatrix,xScenario,LPDC,itr,Case)
% This function intakes the position of each subject and then extracts the
% code from each block define by LPDC. CodeMatrix just gives the position
% information of each block (their coordinates)

if(Case == 3)
    Code1 = LPDC(CodeMatrix(Sub1(1),Sub1(2)),:);
    Code2 = LPDC(CodeMatrix(Sub2(1),Sub2(2)),:);
    Code3 = LPDC(CodeMatrix(Sub3(1),Sub3(2)),:);
    
    xScenario(:,:,itr) = [Code1;Code2;Code3;Code3];
elseif(Case == 4)
    Code1 = LPDC(CodeMatrix(Sub1(1),Sub1(2)),:);% 
    Code2 = LPDC(CodeMatrix(Sub2(1),Sub2(2)),:);
    Code3 = LPDC(CodeMatrix(Sub3(1),Sub3(2)),:);
    Code4 = LPDC(CodeMatrix(Sub4(1),Sub4(2)),:);
    
    xScenario(:,:,itr) = [Code1;Code2;Code3;Code4];
end






end