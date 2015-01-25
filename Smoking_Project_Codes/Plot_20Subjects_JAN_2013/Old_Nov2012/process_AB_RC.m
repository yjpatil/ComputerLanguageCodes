function[AB,RC] = process_AB_RC(Case,RC1,AB1)
% Created: May 19 2012. 
% Function: to invert the abdominal and rib-cage signals
% Note : But no Normalization untill ideal - filtering
if(Case == 1)
    RC = RC1;
    AB = AB1;
elseif(Case == 2)
    %M1 = median(RC1);    %mean(RC1)
    M1 = mean(RC1);
    RC = -1* RC1 + 2* M1;
    %M2 = median(AB1);
    M2 = mean(AB1);
    AB = -1* AB1 + 2* M2;
elseif(Case == 3)
    M1 = mean(RC1);
    RC2 = RC1 - M1;
    RC3 = -1 * RC2;
    RC = RC3 + M1;
    
    M2 = mean(AB1);
    AB2 = AB1 - M2;
    AB3 = -1 * AB2;
    AB = AB3 + M2;
end


end