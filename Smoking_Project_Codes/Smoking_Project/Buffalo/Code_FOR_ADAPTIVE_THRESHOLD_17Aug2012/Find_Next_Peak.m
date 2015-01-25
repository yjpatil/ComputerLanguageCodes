function[Index_Peak,Index_Valley] = Find_Next_Peak(Peak_W,time1,Valley_W)
% TASK: This function gives the immediate next peak and next valley after a
% given time interval
% DATE: 19 Aug 2012


Index1 = find(time1 <= Peak_W(:,1) & Peak_W(:,1) <= time1+45,1);


t1 = Peak_W(Index1,1);
t2 = Peak_W(Index1+1,1); %% Now check if the current peak and its next peak has a valley between them

Ind_temp = find(t1 <= Valley_W(:,1) & Valley_W(:,1) <= t2); %% If there is valley present between the two peaks then it is a valid peak!!

err1 = isempty(Ind_temp);

if(err1 == 1)
    Index_Peak = Index1 + 1; %% That means there is no valley present between the current peak and next peak, so choose next peak INDEX
else
    Index_Peak = Index1;  %% Choose the current peak INDEX
end

Index_Valley = find(Peak_W(Index_Peak,1) <= Valley_W(:,1) & Valley_W(:,1) <= Peak_W(Index_Peak+1,1),1);



end