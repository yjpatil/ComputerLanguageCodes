function [x] = correct_angle_range(x)
%%x = truncate(x);
if (x < 0)
    while (x < 0)
        x = 360 + (x);
    end
elseif (x > 0)
    while (x > 0)
        x = x - 360;
    end
    x = x + 360;
else
    x = 0;
end


end