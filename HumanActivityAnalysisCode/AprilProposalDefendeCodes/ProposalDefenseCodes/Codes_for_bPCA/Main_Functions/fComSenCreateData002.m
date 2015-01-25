function[TrSc01,TrSc02,TrSc03,TrSc04] = fComSenCreateData002(LDPC,Blocks)
% This function creates different scenario train-data %


%ScenarioData01 = fScenarioData01(Blocks);

[Sc01,Sc02,Sc03,Info] = fScenarioData_8by8(Blocks);

for i = 1 : 1 : 30%Info(1);%ssize(ScenarioData01,2)
    TrSc01(:,1,i) = mod(LDPC*Sc01(:,i),2);
end
    


%ScenarioData02 = fScenarioData01(Blocks);

for i = 1 : 1 : 30%Info(2);
    TrSc02(:,1,i) = mod(LDPC*Sc02(:,i),2);
end


%ScenarioData03 = fScenarioData01(Blocks);

for i = 1 : 1 : 30%Info(3);
    TrSc03(:,1,i) = mod(LDPC*Sc03(:,i),2);
end


TrSc04 = [];



end