function[MixData,StatsMixData] = fMixedORedData(Source1,Source2,PertbMax);
% Create Mixed ORed noisy data %
MixData = [];Pertb = randperm(PertbMax);

for i = 1 : 1 : PertbMax + 1
    if(i == 1)
        MixData(i,:) = Source1|Source2;
        StatsMixData(i,:) = fCal_Stats(MixData(i,:));
    else
        X1 = [];X2 = [];
        X1 = fperturb01(Source1,Pertb(i-1));
        X2 = fperturb01(Source2,Pertb(i-1));
        MixData(i,:) = X1 | X2;
        StatsMixData(i,:) = fCal_Stats(MixData(i,:));
    end
end









end



