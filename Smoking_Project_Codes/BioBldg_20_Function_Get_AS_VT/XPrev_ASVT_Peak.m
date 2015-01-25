function[XPrev_pk_Wf_amp,XPrev_pk_Wf_time] = XPrev_ASVT_Peak(X,PtsWf,Curr_Wf_pk_Index)
% This function finds the Previous Peak for AS/VT signal 
% X is the index for previous peak,e.g. If "X == 1" that means one peak
% previous to current peak
% Date: 8 Nov 2012
XPrev_pk_Wf_time = PtsWf(Curr_Wf_pk_Index - X,1);

XPrev_pk_Wf_amp = PtsWf(Curr_Wf_pk_Index - X,2);

end