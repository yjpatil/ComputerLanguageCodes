% This code is to know the statitics of the smoking breath. That is, to
% know the time-duration from apnea-inhale-deep exhale.
% Date: 5 May 2013

clc;clear all;close all;
% global sf ts;
% sf = 101.73;


path = char('C:\Users\student\Documents\MATLAB\Biology_bldg_20subjects\');

list = char('Sub_003','Sub_004','Sub_005','Sub_006','Sub_007','Sub_008','Sub_009','Sub_010','Sub_011','Sub_012','Sub_013','Sub_014','Sub_015','Sub_016','Sub_017','Sub_019','Sub_020','Sub_021','Sub_022','Sub_023');

Size_List = size(list,1);

Sub(Size_List) = struct('Name',[],'Mean_std',[],'Median',[],'Max_Min',[]);  % TPR = True Positive Rate = length(Score)  Recall = TP/TPR

I = 1;
j = 1;
while(I <= Size_List)
    if(I == 15)
        
    else
   
    load(strcat(path(1,:),list(I,:),'.mat'));
    
    Sub(j).Name = list(I,:);  
    
    A1 = Score(:,3);
    
    A2 = Score(:,6);
    
    A = A2 - A1;        
    
    Sub(j).Mean_std(1,1) = mean(A);
    Sub(j).Mean_std(1,2) = std(A);
    
    Sub(j).Median = median(A);
    
    Sub(j).Max_Min(1,1) = max(A);
    Sub(j).Max_Min(1,2) = min(A);
    
    Mean_Std(1,j) = mean(A);
    Mean_Std(2,j) = std(A);
    
    Median(1,j) = median(A);
    
    Min_Max(1,j) = min(A);
    Min_Max(2,j) = max(A);
    
    j = j + 1;
    end
    
    I = I + 1;

end


figure;hold on;title('Mean Time Duration for Smoking cycle vs Subjects');ylabel('Mean+Std');xlabel('Subject')
H1 = errorbar(Mean_Std(1,:),Mean_Std(2,:),'-k');
figure;hold on;title('Median Time Duration for Smoking cycle vs Subjects');ylabel('Median');xlabel('Subject')
H2 = plot(Median,'-b');
figure;hold on;title('Min (Green) and Max (Red) for Time Duration of the smoking cycle');ylabel('Min+Max');xlabel('Subject')
H3 = plot(Min_Max(1,:),'o-g');
H4 = plot(Min_Max(2,:),'o-r');


mean(Mean_Std(1,:))
min(Min_Max(1,:))
max(Min_Max(2,:))


