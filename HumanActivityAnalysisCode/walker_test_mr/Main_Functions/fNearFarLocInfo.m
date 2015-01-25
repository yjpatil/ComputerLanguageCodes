function[Same,Near,Far,InteractionTime,tempSame] = fNearFarLocInfo(temp1,temp2,temp3,Same,Near,Far,InteractionTime,tempSame)
% This function calculates the times whether the people were interacting on
% the same location, nearby or where far-away location, i.e. not interacting
% InteractionTime = counter that increases at iterations where the two
% groups are found at same location
% tempSame = carries the value of Same at previous iteration

switch temp1
    case 1
        Array1 = [2,6,7];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(1,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 2
        Array1 = [1,3,6,7,8];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(2,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 3
        Array1 = [2,4,7,8,9];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(3,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 4
        Array1 = [3,5,8,9,10];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(4,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 5
        Array1 = [4,9,10];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(5,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 6
        Array1 = [1,2,7,11,12];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(6,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 7
        Array1 = [1,2,3,6,8,11,12,13];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(7,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 8
        Array1 = [2,3,4,7,9,12,13,14];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(8,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 9
        Array1 = [3,4,5,8,10,13,14,15];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(9,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 10
        Array1 = [4,5,9,14,15];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(10,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 11
        Array1 = [6,7,12,16,17];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(11,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 12
        Array1 = [6,7,8,11,13,16,17,18];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(12,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 13
        Array1 = [7,8,9,12,14,17,18,19];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(13,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 14
        Array1 = [8,9,10,13,15,18,19,20];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(14,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 15
        Array1 = [9,10,14,19,20];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(15,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 16
        Array1 = [11,12,17,21,22];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(16,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 17
        Array1 = [11,12,13,16,18,21,22,23];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(17,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 18
        Array1 = [12,13,14,17,19,22,23,24];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(18,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 19
        Array1 = [13,14,15,18,20,23,24,25];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(19,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 20
        Array1 = [14,15,19,24,25];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(20,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 21
        Array1 = [16,17,22];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(21,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 22
        Array1 = [16,17,18,21,23];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(22,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 23
        Array1 = [17,18,19,22,24];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(23,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 24
        Array1 = [18,19,20,23,25];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(24,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    case 25
        Array1 = [19,20,24];% Location 1 has location 2,7,6 as nearby locations
        Sum1 = sum(ismember(25,[temp2,temp3]));
        Sum2 = sum(ismember(Array1,[temp2,temp3]));
        if(Sum1 ~= 0)
            Same = Same + 1;
        elseif(Sum2 ~= 0)
            Near = Near + 1;
        else
            Far = Far + 1;
        end
    otherwise
            fprintf('Check the Location Matrix');
end       


if(Same == 1 && InteractionTime == 0)
    InteractionTime = 1;
    tempSame = Same;
elseif(Same > tempSame)
    InteractionTime = InteractionTime + 1;
    tempSame = Same;
end
    

end









