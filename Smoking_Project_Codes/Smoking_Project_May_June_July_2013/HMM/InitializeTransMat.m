function[TransMat] = InitializeTransMat(TransMat1)
% This function creates the first order State Transition Probabilities
% Matrix for the Hidden States
% 23 May 2013

MaxState = length(TransMat1);

for i = 1 : 1 : MaxState
    if(i < MaxState)
        j = 1;
        while(j <= MaxState)
            if(j == i || j == i+1)
                j = j + 1;
            else
                TransMat1(i,j) = 0;
                j = j + 1;
            end
        end
    elseif(i == MaxState)
        j = 1;
        while(j <= MaxState)
            if(j == i)
                j = j + 1;
            else
                TransMat1(i,j) = 0;
                j = j + 1;
            end
        end
    end
end



TransMat = TransMat1;





end