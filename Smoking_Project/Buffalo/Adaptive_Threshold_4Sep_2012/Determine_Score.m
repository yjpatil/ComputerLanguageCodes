function[u1] = Determine_Score(A_S,P_S)
% This code determines whether a given predicted score is accurately
% predicted are not
% Created : 24 July 2012

global Counter_TP Counter_FN Counter_FP ;

if(A_S == +1 && P_S == +1)
    Counter_TP = Counter_TP + 1;
elseif(A_S == +1 && P_S == -1)
    Counter_FN = Counter_FN + 1;
elseif(A_S == -1 && P_S == +1)
    Counter_FP = Counter_FP + 1;
end

u1 = 1;
end