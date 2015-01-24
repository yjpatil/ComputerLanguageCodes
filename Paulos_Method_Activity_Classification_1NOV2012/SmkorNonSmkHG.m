function[Ans1] = SmkorNonSmkHG(SEtsPS,Score,H)
% This function checks if the Given Hand Gesture (HG) belongs to Smoking or
% normal HG. The Start and End instances of the HG is given by "SEtsPS".
% The "Score" contains the puff scores. "H" is a scalar which represents
% the particular HG under consideration

index1 = find( SEtsPS(H,1)-3 <= Score(:,3) & Score(:,3) <= SEtsPS(H,1)+4 );

index2 = find( SEtsPS(H,1)-3 <= Score(:,4) & Score(:,4) <= SEtsPS(H,1)+4 );

if( isempty(index1) || isempty(index2) )
    Ans1 = 0;% Not a Smoking HG
else
    Ans1 = 1;% Smoking HG
end

end