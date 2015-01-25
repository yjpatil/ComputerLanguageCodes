function[Stats] = fCal_Stats(Vector)
% This function calculates the Statistical Distribution of the given Binary
% Vector
% Input : Vector = a binary vector
% Output : Stats = [p00 p01 p10 p11]

p00 = 0;p01 = 0;p10 = 0;p11 = 0;

PC = Vector;

for i = 1 : 1 : length(PC)-1
    temp1 = [];
    temp2 = [];
    temp1 = PC(i);
    temp2 = PC(i+1);
    if(temp1 == 0 && temp2 == 0)
        p00 = p00 + 1;
    elseif(temp1 == 0 && temp2 == 1)
        p01 = p01 + 1;
    elseif(temp1 == 1 && temp2 == 0)
        p10 = p10 + 1;
    elseif(temp1 == 1 && temp2 == 1)
        p11 = p11 + 1;
    else
    end
end

Len11 = length(PC) - 1;

p00 = p00/Len11;
p01 = p01/Len11;
p10 = p10/Len11;
p11 = p11/Len11;

%p00 + p01 + p10 + p11

Stats = [p00 p01 p10 p11];



end