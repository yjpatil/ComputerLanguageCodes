% ----------------------------------------------------------------------- %
%                                                                         %
%           Main Code for 3D Model for 2 subjects                         %
% ----------------------------------------------------------------------- %
addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\walker_test_mr')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\walker_test_mr')

addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\Main_Functions')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\Main_Functions')

clc;clear all;close all;
h2=figure(2); 
set(h2,'position', [25 55 1681 907]);
% ==----=========================================----+======== %
w1_s1 = [-10:2:10 10:-2:-10];  % angle values for arm swing
w2_s1 = [-5:1:10 5:-1:-5];   
%        +       %
w1_s2 = [-10:2:10 10:-2:-10];  % angle values for arm swing
w2_s2 = [-5:1:10 5:-1:-5]; 
% ========= swing angles for left/right arm,leg =-=========== %
angle11 = 0;angle12 = 0;
angle21 = 0;angle22 = 0;

i = 1;sub1 = 1;
j = 1;sub2 = 2;

[pathX1,pathY1,angle_direct1] = fCreateTrajectory001(sub1);
[pathX2,pathY2,angle_direct2] = fCreateTrajectory001(sub2);

len1=length(pathX1); len2=length(pathX2);
len=max(len1,len2);
M=moviein(len-1);

stop1 = 50;stop2 = 15;
while(i <= length(pathX1) - stop1 || j <= length(pathX2) - stop2)
    
    [walker1] = fGetWalker(angle11,angle12);      
    
    x1 = pathX1(i);y1 = pathY1(i);        
        
    if(j <= length(pathX2) - stop2)
        [walker2] = fGetWalker(angle21,angle22);
        x2 = pathX2(j);y2 = pathY2(j);        
        j = j + 1;
        walker2 = scale(walker2,0.5,0.5,0.5);walker2 = rotateZ(walker2,angle_direct2(j));walker2 = translate(walker2,x2,y2,0);
    else
        angle_direct2 = 90;
        [walker2] = fGetWalker(0,0); 
        walker2 = scale(walker2,0.5,0.5,0.5);walker2 = rotateZ(walker2,angle_direct2);walker2 = translate(walker2,x2,y2,0);       
    end
    
    % =================================================================== %
    walker1 = scale(walker1,0.5,0.5,0.5);walker1 = rotateZ(walker1,angle_direct1(i));walker1 = translate(walker1,x1,y1,0);
    %walker2 = scale(walker2,0.5,0.5,0.5);walker2 = rotateZ(walker2,angle_direct2(j));walker2 = translate(walker2,x2,y2,0);
    %---------------------------------------------------------------------------------
    body_all = combine(walker1, walker2);
    cla
    renderpatch(body_all); % Takes the structure
    camlight   % Create or move light object in camera coordinates    
    view(120,20)    
    grid on
    drawnow    
    set(gca,'xlim',[-1 19],'ylim',[-1 22],'zlim',[-2.718 9]);
    % =================================================================== %
    angle11 = w1_s1(rem(i,length(w1_s1))+1);
    angle12 = w2_s1(rem(i,length(w1_s1))+1);
    
    angle21 = w1_s2(rem(i,length(w1_s2))+1);
    angle22 = w2_s2(rem(i,length(w1_s2))+1);
    
    i = i + 1;
    
    
end












