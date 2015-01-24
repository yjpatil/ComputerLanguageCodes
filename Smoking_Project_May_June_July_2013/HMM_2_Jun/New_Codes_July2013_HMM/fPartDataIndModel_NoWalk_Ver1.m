function[TrainData,TrLabels,TestData,TstLabels] = fPartDataIndModel_NoWalk_Ver1(VTEnCod,I,PartitionType)
% This function Partitions the data set into train and test
% Partition Type = '1' Divide the half-half data into trian and test
%                  '2' Use the whole data into test


FullSit = length(VTEnCod(I).Sit);
FullRead = length(VTEnCod(I).Read);
FullSmk = length(VTEnCod(I).Smk);

HalfSit = round(FullSit/2);
HalfRead = round(FullRead/2);
HalfSmk = round(FullSmk/2);      

if(PartitionType == 1)
    % ======= Train & Labels Data Set ======== %    
    TrainData.Sit = VTEnCod(I).Sit(1 : HalfSit);
    TrLabels.Sit = 1 * ones(length(TrainData.Sit),1); % XXXX Sit XXXX
    
    TrainData.Read = VTEnCod(I).Read(1 : HalfRead);
    TrLabels.Read = 2 * ones(length(TrainData.Read),1); % XXXX Read XXXX        
    
    TrainData.Smk = VTEnCod(I).Smk(1 : HalfSmk);     
    TrLabels.Smk = 3 * ones(length(TrainData.Smk),1); % XXXX Smk XXXX
    
    % ======= Test Data Set ========= %
    TestData.Sit = VTEnCod(I).Sit((HalfSit + 1):FullSit);
    TstLabels.Sit = 1 * ones(length(TestData.Sit),1); % XXXX Sit XXXX
    
    TestData.Read = VTEnCod(I).Read((HalfRead + 1):FullRead);
    TstLabels.Read = 2 * ones(length(TestData.Read),1); % XXXX Read XXXX
        
    TestData.Smk = VTEnCod(I).Smk((HalfSmk + 1):FullSmk);     
    TstLabels.Smk = 3 * ones(length(TestData.Smk),1); % XXXX Smk XXXX
    
elseif(PartitionType == 2)
    
    TrainData = [];TrLabels = [];
    % ======= Test Data Set ========= %
    TestData.Sit = VTEnCod(I).Sit;
    TstLabels.Sit = 1 * ones(length(TestData.Sit),1); % XXXX Sit XXXX
    
    TestData.Read = VTEnCod(I).Read;
    TstLabels.Read = 2 * ones(length(TestData.Read),1); % XXXX Read XXXX       
    
    TestData.Smk = VTEnCod(I).Smk;     
    TstLabels.Smk = 3 * ones(length(TestData.Smk),1); % XXXX Smk XXXX    
    
end


end






