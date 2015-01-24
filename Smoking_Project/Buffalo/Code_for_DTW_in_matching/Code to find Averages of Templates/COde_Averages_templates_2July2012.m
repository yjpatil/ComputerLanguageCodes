% Code to find average of templates %
% Created : 2 July 2012 %
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

% -------------- Plot for Volume-Tidal Signal ------------------ %
figure
for i = 1 : 1 : size(list,1)
    t1 = load(strcat(pathVT(1,:),FileNameVT(1,:),list(i,:),'.mat'));
    t2 = t1;
    temp1 = strcat(FileNameVT(1,:),list(i,:));
    t2 = getfield(t1,temp1);    
    t2 = t2(:,2);
    if(i == 1)
        Temp = t2;
    else
        Diff = length(Temp) - length(t2);
        Z = zeros(abs(Diff),1);
        if(Diff < 0)            
            Temp = cat(1,Temp,Z);
        else
            t2 = cat(1,t2,Z);
        end
        Temp = (Temp + t2)/2;
    end 
    plot(t2,'c');grid on;hold on;
end
plot(Temp,'-k');
% ---------------------------------------------------------- %
clear('Temp','t2','Z','Diff');
% -------------- Plot for Air-Flow Signal ------------------ %
figure
for i = 1 : 1 : size(list,1)
    t1 = load(strcat(pathAS(1,:),FileNameAS(1,:),list(i,:),'.mat'));
    t2 = t1;
    temp1 = strcat(FileNameAS(1,:),list(i,:));
    t2 = getfield(t1,temp1);    
    t2 = t2(:,2);
    if(i == 1)
        Temp = t2;
    else
        Diff = length(Temp) - length(t2);
        Z = zeros(abs(Diff),1);
        if(Diff < 0)            
            Temp = cat(1,Temp,Z);
        else
            t2 = cat(1,t2,Z);
        end
        Temp = (Temp + t2)/2;
    end 
    plot(t2,'c');grid on;hold on;
end
plot(Temp,'-k');
% ------------------------------------------------------------------ %
clear('Temp','t2','Z','Diff','t1');
% -------------- Plot for Proximity-Sensor Signal ------------------ %
figure
for i = 1 : 1 : size(list1,1)
    t1 = load(strcat(pathPS(1,:),FileNamePS(1,:),list1(i,:),'.mat'));
    t2 = t1;
    temp1 = strcat(FileNamePS(1,:),list1(i,:));
    t2 = getfield(t1,temp1);    
    %t2 = t2(:,2);
    if(i == 1)
        Temp = t2;
    else
        Diff = length(Temp) - length(t2);
        Z = zeros(abs(Diff),1);
        if(Diff < 0)            
            Temp = cat(1,Temp,Z);
        else
            t2 = cat(1,t2,Z);
        end
        Temp = (Temp + t2)/2;
    end 
    plot(t2,'c');grid on;hold on;
end
plot(Temp,'-k');
% ---------------------------------------------------------------- %






