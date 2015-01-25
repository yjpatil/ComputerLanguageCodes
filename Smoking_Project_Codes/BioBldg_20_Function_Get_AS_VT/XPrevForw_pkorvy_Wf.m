function[X_Prev_Forw_pkorvy_Wf_time,X_Prev_Forw_pkorvy_Wf_amp] = XPrevForw_pkorvy_Wf(X,pkorvy_ts_amp_Wf,Curr_pkorvy_Index)
% This function finds the Previous or Forward "Prev_Forw" peak or valley 
% "pkorvy" peak or valley for AS or VT "Wf" signal, when index of current
% "pkorvy" for AS or VT "Wf" is given i.e. "Curr_pkorvy_Index"
% If "X == -1", means "previous" one peak or valley
% If "X == +1", means "next" one peak or valley

X_Prev_Forw_pkorvy_Wf_time = pkorvy_ts_amp_Wf(Curr_pkorvy_Index + X,1);

X_Prev_Forw_pkorvy_Wf_amp = pkorvy_ts_amp_Wf(Curr_pkorvy_Index + X,2);

end