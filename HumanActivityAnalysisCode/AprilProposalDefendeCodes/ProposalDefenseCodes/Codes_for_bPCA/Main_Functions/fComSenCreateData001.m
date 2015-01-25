function[TrScenario01,TrScenario02,TrScenario03,TrScenario04] = fComSenCreateData001(LDPC,Blocks)
% This function creates different scenario train-data %

Choice = 1;
ScenarioData01 = fScenarioData01(Choice,Blocks);

for i = 1 : 1 : 10;%ssize(ScenarioData01,2)
    TrScenario01(:,1,i) = mod(LDPC*ScenarioData01(:,i),2);
end
    

Choice = 2;
ScenarioData02 = fScenarioData01(Choice,Blocks);

for i = 1 : 1 : size(ScenarioData02,2)
    TrScenario02(:,1,i) = mod(LDPC*ScenarioData02(:,i),2);
end

Choice = 3;
ScenarioData03 = fScenarioData01(Choice,Blocks);

for i = 1 : 1 : size(ScenarioData03,2)
    TrScenario03(:,1,i) = mod(LDPC*ScenarioData03(:,i),2);
end


TrScenario04 = [];



end