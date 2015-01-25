function[AllData] = fPrtbdNoisyData(Trans1,Emis1,MaxSensors,Data, Prtbd)
% This function takes the Maximum number of sensors that will be used to
% test the Averaging Method accuracy and  the length of the GroundTruth 
% Rho = percentage of Ones in Noisy Data

N = length(Data);

AllData = zeros(MaxSensors,N);


for i = 1 : 1 : MaxSensors
    Pos1 = randperm(length(Prtbd)); 
    t1 = Prtbd(Pos1(1)); % To randomly select a perturbation value
    t2 = Prtbd(Pos1(4)); % To randomly select a perturbation value
    [NoisyORedData] = fPrtbdData(Trans1,Emis1,t1,t2,N);
    AllData(i,:) = NoisyORedData;
end




end


