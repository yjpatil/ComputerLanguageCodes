function[Curr_VT_pk_Index,Curr_VT_pk_time,Curr_VT_pk_amp] = Curr_VT_Peak(Curr_AS_pk_time,PtsVT)
% This code finds the VT peak that is considered to be immediatley after
% the AS peak. Simply find the VT peak after "Curr_AS_pk_time"
% Date:9Nov2012

Index = find(Curr_AS_pk_time <= PtsVT(:,1) & PtsVT(:,1) <= Curr_AS_pk_time + 55,1);

Curr_VT_pk_Index = Index;
Curr_VT_pk_time = PtsVT(Index,1);
Curr_VT_pk_amp = PtsVT(Index,2);


end