function[TimeDividedSUB,ASDividedSUB,VTDividedSUB] = fDivideSUBusingWnos(TimeDividedSUB,ASDividedSUB,VTDividedSUB,I,SubWNos,SUB,ComSubWNos)
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

if(length(Names1) == length(Names2))  % Check if the number of fields are same in both structs 1,2
elseif(length(Names1) ~= length(Names2))  % If not stop, there is some issue in the initialization of structs 1,2
    fprintf('\n\n Fields in Divided SUB and SubWNOs are not same\n');
    fprintf('\n\n Check function "fDivideSUBusingWnos" \n')
    dbquit;
end

for i = 1 : 1 : length(Names1)    % Now start copying data from the same field in struct 1 to struct 2
    Array = getfield(ComSubWNos(I),Names1{i});  % Get the data of the ith field
    Ind = find(ismember(SUB(I).WaveNo, Array));    % First check if ith field in struct 1 has the same name as that of that ith field in struct 2 
    if(isequal(Names1{i},Names2{i})) 
        VTDividedSUB(I).(Names1{i}){1,:} = SUB(I).CodeVT{Ind};  % This contain for VT and not for AS %
        ASDividedSUB(I).(Names1{i}){1,:} = SUB(I).CodeAS{Ind};
        TimeDividedSUB(I).(Names1{i}){1,:} = SUB(I).TimeInst(Ind,:);  % This contains the time instances
    else
        fprintf('\n\n Fields in Divided SUB and SubWNOs are not same\n');
        fprintf('\n\n Check function "fDivideSUBusingWnos" \n')
        dbquit;
    end
end



end