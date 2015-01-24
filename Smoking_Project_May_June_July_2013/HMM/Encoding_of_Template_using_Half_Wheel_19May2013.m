% This code loads the template of the AirFlow/Tidal-Volume Signal. Then
% dicretizes the template. Finally for each discrete point, the point is
% assigned a code.

clc;clear all;close all;
% load the AirFlow template %
load('C:\Users\student\Documents\MATLAB\Smoking_Project_May_2013\Wheel_Coding_20Subjects\Templates\AirFlowSignal\ASts_Sub007');
% load the Tidal Volume template %
load('C:\Users\student\Documents\MATLAB\Smoking_Project_May_2013\Wheel_Coding_20Subjects\Templates\TidalVolSignal\VTts_Sub007');
ASts = ASts_SubXX;
VTts = VTts_SubXX;

% plot of the Air Flow Signal %
figure;hold on;
plot(ASts(:,1),ASts(:,2))
SepAS = 15;
it3 = 1;

while(it3 < size(ASts,1)- SepAS)    
    plot(ASts(it3,1),ASts(it3,2),'ok');
    x1 = ASts(it3,1);y1 = ASts(it3,2);
    x2 = ASts(it3+SepAS,1);y2 = ASts(it3+SepAS,2); 
    Slope = (y2 - y1)/(x2 - x1);
    Theta = atand(Slope);
    if(Theta < 0)
        Theta = Theta + 360;
    end
    
    [Code] = AngleCode(Theta,9);
    
    figure(1);gcf;
    %text(ASts(it3,1) - 0.1, ASts(it3,2), num2str(Theta));
    text(ASts(it3,1) - 0.1, ASts(it3,2), num2str(Code));
    it3 = it3 + SepAS;
end



% plot of the Tidal Volume Signal %
figure;hold on;
plot(VTts(:,1),VTts(:,2))
SepVT = 15;
it3 = 1;

while(it3 < size(VTts,1))    
    plot(VTts(it3,1),VTts(it3,2),'ok');
    x1 = VTts(it3,1);y1 = VTts(it3,2);
    x2 = VTts(it3+SepVT,1);y2 = VTts(it3+SepVT,2); 
    Slope = (y2 - y1)/(x2 - x1);
    Theta = atand(Slope);
    if(Theta < 0)
        Theta = Theta + 360;
    end
    
    [Code] = AngleCode(Theta,9);
    
    figure(2);gcf;
    %text(VTts(it3,1) - 0.1, VTts(it3,2), num2str(Theta));
    text(VTts(it3,1) - 0.1, VTts(it3,2), num2str(Code));
    it3 = it3 + SepVT;
end











