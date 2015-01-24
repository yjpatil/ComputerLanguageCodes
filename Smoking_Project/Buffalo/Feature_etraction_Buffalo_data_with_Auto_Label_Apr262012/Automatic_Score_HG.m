function[value] = Automatic_Score_HG(S,E,puff_score,PtsAS,sel_ASpeak_ts)
% This function finds if the feature extracted for a "*Hand Gesture*" 
% belong to a manual (puff_score) score or not. If yes, return value = +1 
% or else value = -1

index = find(S <= puff_score(:,1) & puff_score(:,1) <= E);

if(isempty(index))
    value = -1;
else
    temp1 = puff_score(index(length(index)),2);
    index1 = find(PtsAS(:,1) >= temp1,1);
    if(PtsAS(index1,1) == sel_ASpeak_ts)
        value = +1;
    else
        value = -1;
    end
end


end