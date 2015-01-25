%function [S1norm,S2norm] = Normalization_Second_stage(S1,S2,case_value,V_AS,P_AS,V_VT,P_VT,range)
function [S1norm,S2norm] = Normalization_Second_stage(S1,S2,range,I)
% TASK : This function intakes the waveforms that need to be normalized 
% and 
% case_value = 1, min-max normalization using MEDIAN of Peaks and Valleys
% case_value = 2, min-max normalization using MEAN of Peaks and Valleys
% range = [r1 r2] = [min maX],e.g. range = [-1 +1],then r1 = +1 and r2 = -1
% Created : 1 Nov 2012

Table=[282.31 -114.79 141.50 -58.78
111.36	-41.39	62.04	1.48
41.92	-25.60	20.96	-7.20
67.16	-39.95	27.78	-31.90
105.24	-93.51	34.23	-33.81];


r1 = range(1);
r2 = range(2);    

max_S1 = Table(I,1);   
min_S1 = Table(I,2);
 
S1norm = (((S1 - min_S1)./(max_S1 - min_S1)) .* (r2 - r1)) + (r1);    

max_S2 = Table(I,3);
min_S2 = Table(I,4);    
S2norm = (((S2 - min_S2)./(max_S2 - min_S2)) .* (r2 - r1)) + (r1);


% % r1 = range(1);
% % r2 = range(2);
% % 
% % if(case_value == 1) % Case_Value == 1 for MEDIAN
% %     Med_Pk_AS = median(P_AS);
% %     Med_Vy_AS = median(V_AS);
% %     Med_Pk_VT = median(P_VT);
% %     Med_Vy_VT = median(V_VT);
% %     
% %     min_S1 = Med_Vy_AS;
% %     max_S1 = Med_Pk_AS;    
% %     S1norm = (((S1 - min_S1)./(max_S1 - min_S1)) .* (r2 - r1)) + (r1);
% %     
% %     min_S2 = Med_Vy_VT;
% %     max_S2 = Med_Pk_VT;    
% %     S2norm = (((S2 - min_S2)./(max_S2 - min_S2)) .* (r2 - r1)) + (r1);
% % elseif(case_value == 2) % Case_Value == 2 for MEAN
% %     Mn_Pk_AS = mean(P_AS);
% %     Mn_Vy_AS = mean(V_AS);
% %     Mn_Pk_VT = mean(P_VT);
% %     Mn_Vy_VT = mean(V_VT);
% %     
% %     min_S1 = Mn_Vy_AS;
% %     max_S1 = Mn_Pk_AS;    
% %     S1norm = (((S1 - min_S1)./(max_S1 - min_S1)) .* (r2 - r1)) + (r1);
% %     
% %     min_S2 = Mn_Vy_VT;
% %     max_S2 = Mn_Pk_VT;    
% %     S2norm = (((S2 - min_S2)./(max_S2 - min_S2)) .* (r2 - r1)) + (r1);
% %     
% % % elseif(case_value==3)
% % %     S1norm = (S1 - mean(S1))./std(S1);
% % %     S2norm = (S2 - mean(S2))./std(S2);
% % %     %S1norm = S1norm./max(S1norm);
% % %     S1norm = S1norm./mean(S1norm);
% % %     %S2norm = S2norm./max(S2norm);
% % %     S2norm = S2norm./mean(S2norm);
% % else
% %     printf('Invalid case value');
% % end






end



