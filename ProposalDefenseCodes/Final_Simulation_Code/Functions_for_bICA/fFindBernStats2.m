function[Stats,p,q] = fFindBernStats2(X,choice)
% WARNING :: Works for Single Binary Data or Single value (scalars)
% This function calculates the statistics of the Bernoulli data using the
% knowledege of # of 1's "p" and 0's "(1 - p)"
% If "choice == 1" you have only Binary Data
% If "choice == 2" you have only # of 1's Data
% Date: 24Oct2013


if(choice == 1)
    N = length(X);
    Index1 = find(X == 1);
    Index2 = find(X == 0);
    p = length(Index1);
    q = length(Index2);
    if~(N == (p+q))
        fprintf('Error in the calculation of the Bern Stats')
    end
    p = p/N;
    q = q/N;
    p00 = q * q;
    p11 = p * p;
    p10 = p * q;
    p01 = q * p;
    Stats = [p00,p01,p10,p11];
elseif(choice == 2)
    p = X;
    q = 1 - X;
    p00 = q * q;
    p11 = p * p;
    p10 = p * q;
    p01 = q * p;
    Stats = [p00,p01,p10,p11];


end

end