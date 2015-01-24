% This code checks the cumulative distance of two signals after their
% alignment is obtained.
% Date: 08 July 2012
clc;clear all;close all;

list = char('001','002','003','004','005','006','007','008','009','010','011','012','013','014','015','016','017','018','019','020','021',...
            '022','023','026','027','028','029','030','031','032','033','034','035','036','037','038','039','040');
list1 = char('001','002','003','004','005','006','007','008','009','010','011','012','013','014','015','016','017','018','019','020','021',...
            '022','023','026','027','028','030','032','033','034','035','036','037','038','039','040');
        
pathAS = char('C:\Users\Yuri\Documents\MATLAB\Smoking_Project\DTW\PACT_114_Templates_26Jun2012\Templates_FOR_smoking_AS\');

pathVT = char('C:\Users\Yuri\Documents\MATLAB\Smoking_Project\DTW\PACT_114_Templates_26Jun2012\Templates_for_Smoking_VT\');

pathPS = char('C:\Users\Yuri\Documents\MATLAB\Smoking_Project\DTW\PACT_114_Templates_26Jun2012\Templates_FOR_smoking_PS\');

FileNameAS = char('PACT114_Air_Flow_');

FileNameVT = char('PACT114_Volume_Tidal_');

FileNamePS = char('PACT114_Proximity_Sensor_');

i1 = 19;  i2 = 38;

t1 = load(strcat(pathVT(1,:),FileNameVT(1,:),list(i1,:),'.mat'));
t2 = t1;
temp1 = strcat(FileNameVT(1,:),list(i1,:));
t2 = getfield(t1,temp1);    
t2 = t2(:,2);
V1 = t2;V1 = V1';%V1 = V1 + 5;
clear('t1','t2','temp1');

% t1 = load(strcat(pathPS(1,:),FileNamePS(1,:),list(i2,:),'.mat'));
% t2 = t1;
% temp1 = strcat(FileNamePS(1,:),list(i2,:));
% t2 = getfield(t1,temp1);    
% %t2 = t2(:,2);
% V2 = t2;V2 = V2';V2 = V2/max(V2);
t1 = load(strcat(pathVT(1,:),FileNameVT(1,:),list(i2,:),'.mat'));
t2 = t1;
temp1 = strcat(FileNameVT(1,:),list(i2,:));
t2 = getfield(t1,temp1);    
t2 = t2(:,2);
V2 = t2;V2 = V2';%V2 = V2 + 5;
%%V2 = -1.*V1;

[Dist,D,k,w] = dtw(V1,V2);

i3 = length(w);

Cum_dist = 0;

while(i3 >= 1)
    c1 = w(i3,1);
    c2 = w(i3,2);
    Cum_dist = Cum_dist + (V1(c1) - V2(c2))^2;
    i3 = i3 - 1;
end
Dist
Cum_dist
D(length(V1),length(V2))





