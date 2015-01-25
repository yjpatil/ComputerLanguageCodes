function[TimeDividedSUB,ASDividedSUB,VTDividedSUB] = fDivideSUBusingWnosVER2(TimeDividedSUB,ASDividedSUB,VTDividedSUB,I,SubWNos,SUB,ComSubWNos)
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

Names2 = fieldnames(VTDividedSUB(I));  % Get the list of the fields in (2) "VTDividedSUB"


for i = 1 : 1 : length(Names1)    % Now start copying data from the same field in struct 1 to struct 2
    Array = getfield(ComSubWNos(I),Names1{i});  % Get the data of the ith field, which is the wave numbers
    Array = sort(Array);
    %Ind = find(ismember(SUB(I).WaveNo, Array));    % First check if ith field in struct 1 has the same name as that of that ith field in struct 2
    if(isempty(Array))
        VTDividedSUB(I).(Names1{i}) = num2cell([]);
        ASDividedSUB(I).(Names1{i}) = num2cell([]);
        TimeDividedSUB(I).(Names1{i}) = num2cell([]);
    else
        L = length(Array);
        for j = 1 : 1 : L
            VTDividedSUB(I).(Names1{i}){j} = SUB(I).CodeVT{Array(j)};  % This contain for VT and not for AS %
            ASDividedSUB(I).(Names1{i}){j} = SUB(I).CodeAS{Array(j)};
            TimeDividedSUB(I).(Names1{i}){j} = SUB(I).TimeInst(Array(j),:);  % This contains the time instances
        end
    end
    
end



end