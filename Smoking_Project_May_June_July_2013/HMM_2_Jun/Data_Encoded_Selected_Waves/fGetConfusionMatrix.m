function[CfMtx,OverallAcc] = fGetConfusionMatrix(EstLabels)
% This function Creates the Confusion Matrix whose Size is equal to max
% number in "EstLabel"
% EstLabel = [True Lablel Actual Label]

% For Example, if there are '4' classes then the max value in 'Estlabel' is
% '4', Use this info to get the size of the 'Confusion Matrix'

Size = max(max(EstLabels));

% Initialize Confusion Matrix

CfMtx = zeros(Size);

S1 = size(EstLabels,1);


for i = 1 : 1 : S1
    e1 = EstLabels(i,1); % Get teh True_Label in 1st Column
    e2 = EstLabels(i,2); % Get teh Est_Label in 2nd Column
    
    if(e1 == e2)
        CfMtx(e1,e2) = CfMtx(e1,e2) + 1;
    elseif(e1 ~= e2)
        CfMtx(e1,e2) = CfMtx(e1,e2) + 1;
    end
    
    
end


OverallAcc = sum(diag(CfMtx))/(sum(sum(CfMtx)));



end