function[AB,RC] = process_AB_RC(Case,RC1,AB1)
% Created: May 19 2012. 
% Function: to invert the abdominal and rib-cage signals
% Note : But no Normalization untill ideal - filtering
if(Case == 1)
    RC = RC1;
    AB = AB1;
elseif(Case == 2)
    M1 = median(RC1);    %mean(RC1)
    RC = -1* RC1 + 2* M1;
    M2 = median(AB1);
    AB = -1* AB1 + 2* M2;
else
end


end