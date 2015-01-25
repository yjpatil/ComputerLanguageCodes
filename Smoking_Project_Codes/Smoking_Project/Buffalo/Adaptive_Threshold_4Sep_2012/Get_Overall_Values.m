function [L_TD,U_TD,L_R1,U_R1,U_Max_Mean_Dif,L_Max_Mean_Dif,U_Min_Mean_Dif,L_Min_Mean_Dif] = Get_Overall_Values(Variable_Stats,zvalue,n)
% Task : This function finds the overall mean of the stats collected previously
% Date : 4 Sep 2012

Mean_TD = mean(Variable_Stats(:,3));
std_TD = std(Variable_Stats(:,3));

L_TD = Mean_TD - ((zvalue * std_TD)/ sqrt(n));
%L_TD = Mean_TD + ((zvalue * std_TD)/ sqrt(n));

U_TD = Mean_TD + ((zvalue * std_TD)/ sqrt(n));
%U_TD = Mean_TD - ((zvalue * std_TD)/ sqrt(n));


Mean_R1 = mean(Variable_Stats(:,9));
std_R1 = std(Variable_Stats(:,9));

%L_R1 = Mean_R1 - ((zvalue * std_R1)/ sqrt(n));
L_R1 = Mean_R1 + ((zvalue * std_R1)/ sqrt(n));

% U_R1 = Mean_R1 + ((zvalue * std_R1)/ sqrt(n));
U_R1 = Mean_R1 - ((zvalue * std_R1)/ sqrt(n));


Mean_Max_Mean_Dif_R1 = mean(Variable_Stats(:,11));
std_Max_Mean_Dif_R1 = std(Variable_Stats(:,11));

L_Max_Mean_Dif = Mean_Max_Mean_Dif_R1 - ((zvalue * std_Max_Mean_Dif_R1)/ sqrt(n));

U_Max_Mean_Dif = Mean_Max_Mean_Dif_R1 + ((zvalue * std_Max_Mean_Dif_R1)/ sqrt(n));

Mean_Min_Mean_Dif_R1 = mean(Variable_Stats(:,12));
std_Min_Mean_Dif_R1 = std(Variable_Stats(:,12));

L_Min_Mean_Dif = Mean_Min_Mean_Dif_R1 - ((zvalue * std_Min_Mean_Dif_R1)/ sqrt(n));

U_Min_Mean_Dif = Mean_Min_Mean_Dif_R1 + ((zvalue * std_Min_Mean_Dif_R1)/ sqrt(n));


end