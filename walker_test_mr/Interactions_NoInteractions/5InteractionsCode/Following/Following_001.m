% ======================================================================= %
%                                                                         %
%                5 Interactions                                           %
%                                                                         %
% ======================================================================= %
addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\walker_test_mr')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\walker_test_mr')

addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\Main_Functions')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\Main_Functions')

clc;clear all;close all;

SampleData = 2;%% <-------- "After how many iterations do you want to samples" *

h2=figure(232); 
set(h2,'position', [25 55 1681 907]);
% ====----=========================================----======== %
w1_s1 = [-10:2:10 10:-2:-10];  % 1st Subject: angle values for hand swing
w2_s1 = [-5:1:10 5:-1:-5]; % angle values for leg
%        +       %
w1_s2 = [-10:2:10 10:-2:-10];  % 2nd Subject: angle values for hand swing
w2_s2 = [-5:1:10 5:-1:-5];  % angle values for leg
%        +       %
w1_s3 = [-10:2:10 10:-2:-10];  % 3rd Subject: angle values for hand swing
w2_s3 = [-5:1:10 5:-1:-5];   % angle values for leg
% ========= swing angles for left/right arm,leg =-=========== %
angle11 = 0;angle12 = 0;% Sub#1 Hand angle, Leg Angle respectively
angle21 = 0;angle22 = 0;% Sub#2 Hand angle, Leg Angle respectively
angle31 = 0;angle32 = 0;% Sub#3 Hand angle, Leg Angle respectively
% % ====== Each Subject Constant Indices ======= % %
i = 1;sub1 = 1;
j = 1;sub2 = 2;
k = 1;sub3 = 3;

























