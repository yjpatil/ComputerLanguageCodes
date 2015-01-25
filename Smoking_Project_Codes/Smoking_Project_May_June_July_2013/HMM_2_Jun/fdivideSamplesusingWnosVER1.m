function[Sit,Read,Walk,Smk,ASDividedSUB,VTDividedSUB] = fdivideSamplesusingWnosVER1(Sit,Read,Walk,Smk,ASDividedSUB,VTDividedSUB,I,SubWNos,SUB,ComSubWNos)
% This function Partitions the data in 'SUB' based on the numbers in 
% 'SubWNos' structure in fields like Sit1, Sit2, Sit3, ...

% Final Output : 'VTDividedSUB' contains the encoded waves from "SUB" but
% separated using the information in "SubWNos" fields
% e.g. struct 'VTDividedSUB' contains fields same as SubWNos, but codes
% instead of wave numbers from the struct SUB.CodeVT field

% Date: 25 Jun 2013

% Useful Funcs %
% 'fieldnames' = Gives you the list of the fields in the Structure
% 'getfield' = Gives the data in the given field referenced by the name
% 'ismember' = 


Names1 = fieldnames(SubWNos(I));  % Get the list of the fields in (1) "SubWNos"


for i = 1 : 1 : length(Names1)    % Now start copying data from the same field in struct 1 to struct 2
    Array = getfield(ComSubWNos(I),Names1{i});  % Get the data of the ith field, which is the wave numbers
    Array = sort(Array);
    
    if(isempty(Array))
        VTDividedSUB(I).(Names1{i}) = [0 0];
        ASDividedSUB(I).(Names1{i}) = [0 0];
    else
        VTDividedSUB(I).(Names1{i})(1,1) = mean(SUB(I).SamplesVT(Array));   
        VTDividedSUB(I).(Names1{i})(1,2) = std(SUB(I).SamplesVT(Array));  
        ASDividedSUB(I).(Names1{i})(1,1) =  mean(SUB(I).SamplesAS(Array));
        ASDividedSUB(I).(Names1{i})(1,2) =  std(SUB(I).SamplesAS(Array));
    end   
    
    if(strcmp(Names1{i},'Sit'))
        Sit(I,1) = VTDividedSUB(I).(Names1{i})(1,1);
        Sit(I,2) = VTDividedSUB(I).(Names1{i})(1,2);
    elseif(strcmp(Names1{i},'Read'))
        Read(I,1) = VTDividedSUB(I).(Names1{i})(1,1);
        Read(I,2) = VTDividedSUB(I).(Names1{i})(1,2);
    elseif(strcmp(Names1{i},'Walk'))
        Walk(I,1) = VTDividedSUB(I).(Names1{i})(1,1);
        Walk(I,2) = VTDividedSUB(I).(Names1{i})(1,2);
    elseif(strcmp(Names1{i},'Smk'))
        Smk(I,1) = VTDividedSUB(I).(Names1{i})(1,1);
        Smk(I,2) = VTDividedSUB(I).(Names1{i})(1,2);
    end
    
end



end