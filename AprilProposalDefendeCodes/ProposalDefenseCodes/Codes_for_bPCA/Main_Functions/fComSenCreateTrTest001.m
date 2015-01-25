function[TrSc01,TrSc02,TrSc03,TrSc04,TstSc01,TstSc02,TstSc03,TstSc04] = fComSenCreateTrTest001(LDPC,Blocks)
% This function creates different scenario train-data %


%ScenarioData01 = fScenarioData01(Blocks);

[Sc01,Sc02,Sc03,Info] = fScenarioData_8by8(Blocks);


% <> -------
TrArr1 = [1:30]; % 40 samples
TstArr1 = [4:33]; % 17 samples

for i = 1 : 1 : length(TrArr1)%Info(1);%ssize(ScenarioData01,2)
    TrSc01(:,1,i) = mod(LDPC*Sc01(:,TrArr1(i)),2);
end
    
for j = 1 : 1 : length(TstArr1)%Info(1);%ssize(ScenarioData01,2)
    TstSc01(:,1,j) = mod(LDPC*Sc01(:,TstArr1(j)),2);
end


%ScenarioData02 = fScenarioData01(Blocks);
TrArr2 = [1:30]; % 30 samples
TstArr2 = [4:33]; % 17 samples

for i = 1 : 1 : length(TrArr2)%30%Info(2);
    TrSc02(:,1,i) = mod(LDPC*Sc02(:,TrArr2(i)),2);
end

for j = 1 : 1 : length(TstArr2)%30%Info(2);
    TstSc02(:,1,j) = mod(LDPC*Sc02(:,TstArr2(j)),2);
end

%ScenarioData03 = fScenarioData01(Blocks);
TrArr3 = [1:30]; % 40 samples
TstArr3 = [4:33]; % 17 samples

for i = 1 : 1 : length(TrArr3)%30%Info(3);
    TrSc03(:,1,i) = mod(LDPC*Sc03(:,TrArr3(i)),2);
end

for j = 1 : 1 : length(TstArr3)%30%Info(3);
    TstSc03(:,1,j) = mod(LDPC*Sc03(:,TstArr3(j)),2);
end

TrSc04 = [];

TstSc04 = [];

end