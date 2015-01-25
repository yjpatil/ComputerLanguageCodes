function[MixData,Leg3] = fCreateBernoulliMix2(Pi,X)
% X = [1st Row --> 1st Target Data;
%      2nd Row --> 2nd Target Data;
%      3rd Row --> 3rd Target Data;]

[R,C] = size(X);

MixComp = R;

TossProb = rand;  % Tossing coin to select which 

MixData = zeros(1,C);

if(MixComp == 2)
    temp1 = Pi(1);temp2 = Pi(2);
    for j = 1 : 1 : C
        TossProb = rand;
        if(TossProb <= temp1)
            MixData(j) = X(1,j);
        elseif(TossProb <= temp2)
            MixData(j) = X(2,j);
        end
    end
elseif(MixComp == 3)
    temp1 = Pi(1);temp2 = Pi(2);temp3 = Pi(3);
    for j = 1 : 1 : C
        TossProb = rand;
        if(TossProb <= temp1)
            MixData(j) = X(1,j);
        elseif(TossProb <= temp2)
            MixData(j) = X(2,j);
        elseif(TossProb <= temp3)
            MixData(j) = X(3,j);
        end
    end
elseif(MixComp == 4)
    temp1 = Pi(1);temp2 = Pi(2);temp3 = Pi(3);temp4 = Pi(4);
    for j = 1 : 1 : C
        TossProb = rand;
        if(TossProb <= temp1)
            MixData(j) = X(1,j);
        elseif(TossProb <= temp2)
            MixData(j) = X(2,j);
        elseif(TossProb <= temp3)
            MixData(j) = X(3,j);
        elseif(TossProb <= temp4)
            MixData(j) = X(4,j);
        end
    end
elseif(MixComp == 5)
    temp1 = Pi(1);temp2 = Pi(2);temp3 = Pi(3);temp4 = Pi(4);temp5 = Pi(5);
    for j = 1 : 1 : C
        TossProb = rand;
        if(TossProb <= temp1)
            MixData(j) = X(1,j);
        elseif(TossProb <= temp2)
            MixData(j) = X(2,j);
        elseif(TossProb <= temp3)
            MixData(j) = X(3,j);
        elseif(TossProb <= temp4)
            MixData(j) = X(4,j);
        elseif(TossProb <= temp5)
            MixData(j) = X(5,j);
        end
    end
elseif(MixComp == 6)
    temp1 = Pi(1);temp2 = Pi(2);temp3 = Pi(3);temp4 = Pi(4);temp5 = Pi(5);temp6 = Pi(6);
    for j = 1 : 1 : C
        TossProb = rand;
        if(TossProb <= temp1)
            MixData(j) = X(1,j);
        elseif(TossProb <= temp2)
            MixData(j) = X(2,j);
        elseif(TossProb <= temp3)
            MixData(j) = X(3,j);
        elseif(TossProb <= temp4)
            MixData(j) = X(4,j);
        elseif(TossProb <= temp5)
            MixData(j) = X(5,j);
        elseif(TossProb <= temp6)
            MixData(j) = X(6,j);
        end
    end
end

% stats1 = fCal_Stats(MixData);
% 
% Leg3 = plot3(stats1(1,1),stats1(1,2),stats1(1,3),'xk','Linewidth',1.5);

Leg3 = 0;


end

