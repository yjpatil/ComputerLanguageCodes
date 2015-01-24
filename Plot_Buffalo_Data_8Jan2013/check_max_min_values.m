function[S1,S2] = check_max_min_values(S1,thS1,S2,thS2)
% This function simply transforms the two given signal into a new signals
% that rejects the outlier values
% Created : 21 July 2012

IndexS1 = find(S1 > thS1);

if(isempty(IndexS1))   
else
    S1(IndexS1) = S1(IndexS1 - 1); % if this doesnot work then it will put zero
    IndexS1 = find(S1 > thS1);    
    if(isempty(IndexS1))   
    else
        S1(IndexS1) = 0;
    end
end

IndexS1 = find(S1 < -thS1);

if(isempty(IndexS1))   
else
    S1(IndexS1) = S1(IndexS1 - 1); % if this doesnot work then it will put zero
    IndexS1 = find(S1 < -thS1);    
    if(isempty(IndexS1))   
    else
        S1(IndexS1) = 0;
    end
end


IndexS2 = find(S2 > thS2);

if(isempty(IndexS2))   
else
    S2(IndexS2) = S2(IndexS2 - 1); % if this doesnot work then it will put zero
    IndexS2 = find(S2 > thS2);
    if(isempty(IndexS2))
    else
        S2(IndexS2) = 0;
    end
end

IndexS2 = find(S2 < -thS2);

if(isempty(IndexS2))   
else
    S2(IndexS2) = S2(IndexS2 - 1); % if this doesnot work then it will put zero
    IndexS2 = find(S2 < -thS2);
    if(isempty(IndexS2))
    else
        S2(IndexS2) = 0;
    end
end



end

