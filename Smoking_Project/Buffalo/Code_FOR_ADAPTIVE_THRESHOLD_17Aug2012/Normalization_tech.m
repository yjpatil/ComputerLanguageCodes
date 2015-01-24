function [S1norm,S2norm] = Normalization_tech(S1,S2,case_value,thS1,thS2,range)
% The threshold values are most probably less than 1.0
% This function intakes the waveforms that need to be normalized and then
% returns the nomralized signals.
% case_value = 1, min-max normalization
% case_value = 2, mean-std normalization
% range = [r1 r2] = [min maX],e.g. range = [-1 +1],then r1 = +1 and r2 = -1
% Created : 21 July 2012

r1 = range(1);
r2 = range(2);

[S1,S2] = check_max_min_values(S1,thS1,S2,thS2);

if(case_value == 1)
    min_S1 = min(S1);
    max_S1 = max(S1);
    S1norm = (((S1 - min_S1)./(max_S1 - min_S1)) .* (r2 - r1)) + (r1);
    %S1norm = S1norm - mean(S1norm);
    S1norm = S1norm - median(S1norm);
    
    min_S2 = min(S2);
    max_S2 = max(S2);
    S2norm = (((S2 - min_S2)./(max_S2 - min_S2)) .* (r2 - r1)) + (r1);
    %S2norm = S2norm - mean(S2norm);
    S2norm = S2norm - median(S2norm);    
elseif(case_value == 2)
    S1norm = (S1 - mean(S1))./std(S1);
    S2norm = (S2 - mean(S2))./std(S2);
    S1norm = S1norm./max(S1norm);
    S2norm = S2norm./max(S2norm);
elseif(case_value==3)
else
    printf('Invalid case value');
end