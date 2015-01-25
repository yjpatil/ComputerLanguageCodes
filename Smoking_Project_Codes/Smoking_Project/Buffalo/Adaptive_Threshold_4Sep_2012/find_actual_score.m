function[actual_score] = find_actual_score(start,end1,PF)
% This code determines whether a given predicted score is accurately
% predicted are not
% Created : 24 July 2012

index = find(start <= PF & PF <= end1);

if(isempty(index))
    actual_score = -1;
else
    actual_score = +1;
end

end