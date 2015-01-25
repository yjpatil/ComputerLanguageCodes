function[Curr_AS_vy_Index,Curr_AS_vy_time,Curr_AS_vy_amp] = Curr_AS_Valley(Curr_AS_pk_time,VtsAS)
% This code finds the Current Valley (associated with the current peak of A
% S). 
% "Curr_AS_pk_time" = current peak time; "VtsAS" = valleys 

Index1 = find(Curr_AS_pk_time <= VtsAS(:,1) & VtsAS(:,1) <= Curr_AS_pk_time + 55,1);

Curr_AS_vy_Index = Index1;
Curr_AS_vy_time = VtsAS(Index1,1);
Curr_AS_vy_amp = VtsAS(Index1,2);

end