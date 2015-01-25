function[Delta00,Delta01,Delta10,Delta11] = fGet_deltas_mats(x)
% This function creates the four deltas function for the HMM data
% Probabilistic Data

for i = 1 : 1 : size(x,1)
    
    Temp0 = [];Temp1 = [];Temp2 = [];
    
    Temp0 = x(i,:); % Get the ith Prob Mixture
    Temp1 = circshift(Temp0,[-1 -1]); % Circular shift the ith Mixture by 1 to LEFT (-1)
    Temp2 = cat(1,Temp0,Temp1);  % 
    
    Delta00(i,:) = (Temp2(1,:) == 0 & Temp2(2,:) == 0);
    Delta01(i,:) = (Temp2(1,:) == 0 & Temp2(2,:) == 1);
    Delta10(i,:) = (Temp2(1,:) == 1 & Temp2(2,:) == 0);
    Delta11(i,:) = (Temp2(1,:) == 1 & Temp2(2,:) == 1);


end