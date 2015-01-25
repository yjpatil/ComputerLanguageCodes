function[MixData,ProbCount,Leg3] = fCreateBernoulliMix3(Pi,X)

% X = [1st Row --> 1st Target Data;
%      2nd Row --> 2nd Target Data;
%      3rd Row --> 3rd Target Data;]

[R,C] = size(X);

MixComp = R;

TossProb = rand;  % Tossing coin to select which 

MixData = zeros(1,C);

ProbCount = 0;

Count1 = 0;Count2 = 0;
Count3 = 0;Count4 = 0;
Count5 = 0;Count6 = 0;

if(MixComp == 2)   % Mixture of Two
    temp1 = Pi(1);temp2 = Pi(2);
    for j = 1 : 1 : C
        TossProb = rand;
        if(TossProb <= temp1)
            MixData(j) = X(1,j);
            Count1 = Count1 + 1;
        elseif(TossProb <= temp2)
            MixData(j) = X(2,j);
            Count2 = Count2 + 1;
        end
    end
    ProbCount = [Count1/C,Count2/C];
elseif(MixComp == 3)
    temp1 = Pi(1);temp2 = Pi(2);temp3 = Pi(3);
    for j = 1 : 1 : C
        TossProb = rand;
        if(TossProb <= temp1)
            MixData(j) = X(1,j);
            Count1 = Count1 + 1;
        elseif(TossProb <= temp2)
            MixData(j) = X(2,j);
            Count2 = Count2 + 1;
        elseif(TossProb <= temp3)
            MixData(j) = X(3,j);
            Count3 = Count3 + 1;
        end
    end
    ProbCount = [Count1/C,Count2/C,Count3/C];
elseif(MixComp == 4)
    temp1 = Pi(1);temp2 = Pi(2);temp3 = Pi(3);temp4 = Pi(4);
    for j = 1 : 1 : C
        TossProb = rand;
        if(TossProb <= temp1)
            MixData(j) = X(1,j);
            Count1 = Count1 + 1;
        elseif(TossProb <= temp2)
            MixData(j) = X(2,j);
            Count2 = Count2 + 1;
        elseif(TossProb <= temp3)
            MixData(j) = X(3,j);
            Count3 = Count3 + 1;
        elseif(TossProb <= temp4)
            MixData(j) = X(4,j);
            Count4 = Count4 + 1;
        end
    end
    ProbCount = [Count1/C,Count2/C,Count3/C,Count4/C];
elseif(MixComp == 5)
    temp1 = Pi(1);temp2 = Pi(2);temp3 = Pi(3);temp4 = Pi(4);temp5 = Pi(5);
    for j = 1 : 1 : C
        TossProb = rand;
        if(TossProb <= temp1)
            MixData(j) = X(1,j);
            Count1 = Count1 + 1;
        elseif(TossProb <= temp2)
            MixData(j) = X(2,j);
            Count2 = Count2 + 1;
        elseif(TossProb <= temp3)
            MixData(j) = X(3,j);
            Count3 = Count3 + 1;
        elseif(TossProb <= temp4)
            MixData(j) = X(4,j);
            Count4 = Count4 + 1;
        elseif(TossProb <= temp5)
            MixData(j) = X(5,j);
            Count5 = Count5 + 1;
        end
    end
    ProbCount = [Count1/C,Count2/C,Count3/C,Count4/C,Count5/C];
elseif(MixComp == 6)
    temp1 = Pi(1);temp2 = Pi(2);temp3 = Pi(3);temp4 = Pi(4);temp5 = Pi(5);temp6 = Pi(6);
    for j = 1 : 1 : C
        TossProb = rand;
        if(TossProb <= temp1)
            MixData(j) = X(1,j);
            Count1 = Count1 + 1;
        elseif(TossProb <= temp2)
            MixData(j) = X(2,j);
            Count2 = Count2 + 1;
        elseif(TossProb <= temp3)
            MixData(j) = X(3,j);
            Count3 = Count3 + 1;
        elseif(TossProb <= temp4)
            MixData(j) = X(4,j);
            Count4 = Count4 + 1;
        elseif(TossProb <= temp5)
            MixData(j) = X(5,j);
            Count5 = Count5 + 1;
        elseif(TossProb <= temp6)
            MixData(j) = X(6,j);
            Count6 = Count6 + 1;
        end
    end
    ProbCount = [Count1/C,Count2/C,Count3/C,Count4/C,Count5/C,Count6/C];
end

% stats1 = fCal_Stats(MixData);
% 
% Leg3 = plot3(stats1(1,1),stats1(1,2),stats1(1,3),'xk','Linewidth',1.5);

Leg3 = 0;


end

