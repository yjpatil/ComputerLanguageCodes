function[PS] = check_PS(dat)
% *********************************************************************** %
% The folowing part checks if there are incomplete HG's in the PS signals %
% *********************************************************************** %
%dat = PS;    % dat contains the PS signal
flag = 1;
while(flag == 1)
    if(dat(1) == 1)
        i = 1; temp = 1;
        while(temp ~= 0)
            temp = dat(i);
            dat(i) = 0;
            i = i + 1;
        end
        flag = 0;
    else
        flag = 0;
    end
end

flag = 1;
while(flag == 1)
    if(dat(length(dat)) == 1)
        i = length(dat); temp = 1;
        while(temp ~= 0)
            temp = dat(i);
            dat(i) = 0;
            i = i - 1;
        end
        flag = 0;
    else
        flag = 0;
    end
end
PS = dat;
end