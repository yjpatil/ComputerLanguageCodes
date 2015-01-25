function[Label] = Auto_Label(SEtsPS,Score,H)
% This function checks if the Given Hand Gesture (HG) belongs to Smoking or
% normal HG. The Start and End instances of the HG is given by "SEtsPS".
% The "Score" contains the puff scores. "H" is a scalar which represents
% the particular HG under consideration

index1 = find( SEtsPS(H,1)-3 <= Score(:,3) & Score(:,3) <= SEtsPS(H,1)+4 );

index2 = find( SEtsPS(H,1)-3 <= Score(:,4) & Score(:,4) <= SEtsPS(H,1)+4 );

if( isempty(index1) && isempty(index2) )
    Label = -1;% Not a Smoking HG
elseif( ~isempty(index1) || ~isempty(index2) )
    Label = +1;% Smoking HG
end


end
