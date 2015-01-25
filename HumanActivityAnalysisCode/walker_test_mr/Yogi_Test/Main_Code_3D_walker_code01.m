% ----------------------------------------------------------------------- %
%                                                                         %
%                   Main Code for 3D Model                                %
% ----------------------------------------------------------------------- %
addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\walker_test_mr')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\walker_test_mr')

addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\Main_Functions')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\Main_Functions')

clc;clear all;close all;

w1_s = [-10:2:10 10:-2:-10];  % angle values for arm swing
w2_s = [-5:1:10 5:-1:-5];   

angle1 = 0; % swing for left/right arm,leg
angle2 = 0;

h2=figure(2); 
set(h2,'position', [25 55 1681 907]);

i = 1;
%angle_direct = 180;

[pathX,pathY,angle_direct] = fCreateTrajectory;

while(i <= length(pathX))
    
    [walker] = fGetWalker(angle1,angle2);
    
    x=pathX(i);y=pathY(i);
    
    [out111] = fDraw3Dmodel(walker,x,y,angle_direct(i));
    
    angle1 = w1_s(rem(i,length(w1_s))+1);
    angle2 = w2_s(rem(i,length(w1_s))+1);
    
    i = i + 1;

end












