function [PerturbX] = fperturb01(X,PerctPerturb)
% This function just flips the bits of the input "X". The Perturbation
% depends on the "PerctPerturb" 

N = length(X);

Perturb = round((PerctPerturb/100) * N);

Array = randperm(N);

for i = 1 : 1 : Perturb
    index1 = Array(i);
    temp1 = X(index1);
    if(temp1 == 1)
        X(index1) = 0;
    elseif(temp1 == 0)
        X(index1) = 1;
    end
    
end


PerturbX = X;


end




