function[Curr_VT_vy_Index,Curr_VT_vy_time,Curr_VT_vy_amp] = Curr_VT_Valley(Curr_VT_pk_time,VtsVT)
% This code finds the VT peak that is considered to be immediatley after
% the AS peak. Simply find the VT peak after "Curr_AS_pk_time"
% Date:9Nov2012

Index = find(Curr_VT_pk_time <= VtsVT(:,1) & VtsVT(:,1) <= Curr_VT_pk_time + 55,1);

Curr_VT_vy_Index = Index;
Curr_VT_vy_time = VtsVT(Index,1);
Curr_VT_vy_amp = VtsVT(Index,2);


end