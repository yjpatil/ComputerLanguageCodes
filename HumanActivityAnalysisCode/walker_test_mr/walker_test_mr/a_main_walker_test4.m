close all;clear all;clc

cyl = UnitCylinder(2);
sph = UnitSphere(2);
sph_hf = UnitSphere_half(2,0.5);

pathX=0:0.1:14;
pathY=3*sin(pathX);
pathX=pathX(end:-1:1);
 %pathY=pathY(end:-1:1);
% Head 
L1 = 2;
Head = translate(scale(sph,L1/2, L1/2, L1/1.4),0,0,L1+4.5);
Head.facecolor = [0.9 0.6 0.6];
%---------------------------------------------------------
Neck = translate(scale(sph_hf,L1/2, L1/2, L1/0.4),0,0,1.0);
Neck.facecolor = [0.9 0.6 0.6];
%---------------------------------------------------------
meys1 = rotateY(scale(cyl,L1/10, L1/12, L1/8),90);
meys1 = translate(meys1,0.7,0.4,L1+4.6);
meys1.facecolor = 'yellow';
meys2 = rotateY(scale(cyl,L1/10, L1/12, L1/8),90);
meys2 = translate(meys2,0.7,-0.4,L1+4.6);
meys2.facecolor = 'yellow';
%---------------------------------------------------------
Head = combine(Head,Neck,meys1,meys2);
%Shoulder 
r2 = 1.2;
L2 = 3;
Shoulder = translate(rotateX(scale(cyl,r2/2,r2/2,L2/2.2),90),0,0,4.65);
Shoulder1 = translate(scale(sph,L1/4, L1/4, L1/4),0,-1.3,4.8);
Shoulder2 = translate(scale(sph,L1/4, L1/4, L1/4),0,1.3,4.8);
Shoulder.facecolor = [0.9 0.6 0.6];
Shoulder1.facecolor = [0.9 0.6 0.6];
Shoulder2.facecolor = [0.9 0.6 0.6];
Shoulder = combine(Shoulder1,Shoulder,Shoulder2);
%Left Upper Arm
w1_s = [-10:2:10 10:-2:-10];
r3 = 0.5;
L3 = 2;
%Upper_Arm_left = translate(scale(cyl,r3/2,r3/2,L3/2),0,0,-L3/2);
Upper_Arm_left = translate(scale(sph,r3/2,r3/2,L3/1.6),0,0,-L3/2);
Upper_Arm_left.facecolor = [0.9 0.6 0.6];

%Right Upper Arm
%Upper_Arm_right = translate(scale(cyl,r3/2,r3/2,L3/2),0,0,-L3/2);
Upper_Arm_right = translate(scale(sph,r3/2,r3/2,L3/1.6),0,0,-L3/2);
Upper_Arm_right.facecolor = [0.9 0.6 0.6];

%Left Forearm
r4=0.4;
w2_s = [-5:1:10 5:-1:-5];
L3_f = 2.5;
%Fore_Arm_left = translate(scale(cyl,r4/2,r4/2,L3_f/2),0,0,-L3_f/2);
Fore_Arm_left = translate(scale(sph,r4/2,r4/2,L3_f/2),0,0,-1);
Fore_Arm_left.facecolor = [0.9 0.6 0.6];
hand1_left = translate(scale(sph,L1/8, L1/8, L1/8),0,0,-2.0);
hand1_left.facecolor = [0.6 0.6 0.6];
hand2_left = translate(scale(sph,L1/6, L1/16, L1/4),0,0,-2.4);
hand2_left.facecolor = [0.6 0.6 0.6];
Fore_Arm_left=combine(Fore_Arm_left,hand1_left,hand2_left);

%Right Forearm
%Fore_Arm_right = translate(scale(cyl,r4/2,r4/2,L3_f/2),0,0,-L3_f/2);
Fore_Arm_right = translate(scale(sph,r4/2,r4/2,L3_f/2),0,0,-1);
Fore_Arm_right.facecolor = [0.9 0.6 0.6];
hand1_right = translate(scale(sph,L1/8, L1/8, L1/8),0,0,-2.0);
hand1_right.facecolor = [0.6 0.6 0.6];
hand2_right = translate(scale(sph,L1/6, L1/16, L1/4),0,0,-2.4);
hand2_right.facecolor = [0.6 0.6 0.6];
Fore_Arm_right=combine(Fore_Arm_right,hand1_right,hand2_right);

%Chest
r4 = 2;
L4 = 2;
Chest = translate(scale(cyl,r4/2,r4/2,L4/2),0, 0, 5-L4/2);
Chest.facecolor = [0.9 0.6 0.6];
%Weist -------------------------------------------------------------------
r5 = 1;
L5 = 2;
Weist = translate(scale(cyl,r5/2,r5/2,L5/2),0, 0, 5-L4-L5/2);
Weist.facecolor = [0.9 0.6 0.6];

sph_hf2 = UnitSphere_half(2,0.4);
Weistd = rotateY(scale(sph_hf2,L1/2, L1/2, L1/0.5),180);
Weistd = translate(Weistd,0,0,4.7);
Weistd.facecolor = [0.9 0.6 0.6];
Weist = combine(Weist,Weistd);
%Hip -------------------------------------------------------------------
L6 = 1.5;
%Hip = translate(rotateX(scale(cyl,r2/3,r2/3,L6/2),90),0,0,5-L4-L5-r2/2);
Hip = translate(rotateX(scale(cyl,r2/3,r2/3,L6/3),90),0,0,0.3);
Hip.facecolor = [0.6 0.6 0.6];
%Hipd = rotateY(scale(sph_hf2,L1/2, L1/2, L1/0.5),180);
sph_hf3 = UnitSphere_half(2,0.6);
Hipd = translate(scale(sph_hf3,L1/2, L1/2, L1/0.5),0,0,-1.6);
Hipd.facecolor = [0.9 0.6 0.6];

Hipd2 = rotateY(scale(sph_hf3,L1/2, L1/2, L1/0.5),180);
Hipd2 = translate(Hipd2,0,0,3.2);
Hipd2.facecolor = [0.9 0.6 0.6];

Shoulder_d1 = translate(scale(sph,L1/5, L1/5, L1/5),0,-0.7,0.2);
Shoulder_d2 = translate(scale(sph,L1/5, L1/5, L1/5),0,0.7,0.2);
Shoulder_d1.facecolor = [0.9 0.6 0.6];
Shoulder_d2.facecolor = [0.9 0.6 0.6];
leg_r1 = translate(scale(sph,L1/4, L1/5, L1/3),0,-0.9,0.15);
leg_r2 = translate(scale(sph,L1/4, L1/5, L1/3),0,0.9,0.15);
leg_r1.facecolor = [0.9 0.6 0.6];
leg_r2.facecolor = [0.9 0.6 0.6];
Hip = combine(Hip,Hipd,Hipd2,Shoulder_d1,Shoulder_d2,leg_r1,leg_r2);
%Left Upper Leg -----------------------------------------------------------
r7 = 0.8;
L7 = 2.5;
L71 = (L6/2+r7/2);
L72 = 5-L7/2-L4-L5;
%Upper_Leg_left = translate(scale(cyl,r7/2,r7/2,L7/2),0,0,-L7/2);
%Upper_Leg_left = translate(scale(cyl,r7/2,r7/2,L7/2),0,0,-1.8);
Upper_Leg_left = translate(scale(sph,r7/2,r7/2,L7/1.9),0,0.4,-1.8);
Upper_Leg_left.facecolor = [0.6 0.6 0.6];
knee_left = translate(scale(sph,L1/5, L1/5, L1/5),0,0.3,-3);
knee_left.facecolor = [0.6 0.6 0.6];
Upper_Leg_left = combine(Upper_Leg_left,knee_left);
%Right Upper Leg ----------------------------------------------------------
%Upper_Leg_right = translate(scale(cyl,r7/2,r7/2,L7/2),0,0,-L7/2);
%Upper_Leg_right = translate(scale(cyl,r7/2,r7/2,L7/2),0,0,-1.8);
Upper_Leg_right = translate(scale(sph,r7/2,r7/2,L7/1.9),0,-0.4,-1.8);
Upper_Leg_right.facecolor = [0.6 0.6 0.6];
knee_right = translate(scale(sph,L1/5, L1/5, L1/5),0,-0.3,-3);
knee_right.facecolor = [0.6 0.6 0.6];
Upper_Leg_right = combine(Upper_Leg_right,knee_right);
% -------------------------------------------------------------------------
%Left Lower Leg
L7_f = 3;
%Lower_Leg_left = translate(scale(cyl,r7/2,r7/2,L7_f/2),0,0,-L7_f/2);
%Lower_Leg_left = translate(scale(cyl,r7/2,r7/2,L7_f/2),0,0,-2.05);
Lower_Leg_left = translate(scale(sph,r7/2.5,r7/2.5,L7_f/1.8),0,0.2,-2.05);
Lower_Leg_left.facecolor = [0.6 0.6 0.6];
ankle_left = translate(scale(sph,L1/5, L1/5, L1/5),0,0.1,-3.6);
ankle_left.facecolor = [0.6 0.6 0.6];
foot_left = translate(scale(sph,L1/5, L1/7, L1/9),0.6,0.1,-3.8);
foot_left.facecolor = [0.6 0.6 0.6];
Lower_Leg_left=combine(Lower_Leg_left,ankle_left,foot_left);
%Right Lower Leg
%Lower_Leg_right = translate(scale(cyl,r7/2,r7/2,L7_f/2),0,0,-L7_f/2);
%Lower_Leg_right = translate(scale(cyl,r7/2,r7/2,L7_f/2),0,0,-2.05);
Lower_Leg_right = translate(scale(sph,r7/2.5,r7/2.5,L7_f/1.8),0,-0.2,-2.05);
Lower_Leg_right.facecolor = [0.6 0.6 0.6];
ankle_right = translate(scale(sph,L1/5, L1/5, L1/5),0,-0.1,-3.6);
ankle_right.facecolor = [0.6 0.6 0.6];
foot_right = translate(scale(sph,L1/5, L1/7, L1/9),0.6,-0.1,-3.8);
foot_right.facecolor = [0.6 0.6 0.6];
Lower_Leg_right=combine(Lower_Leg_right,ankle_right,foot_right);
% -------------------------------------------------------------------------
floor_r=UnitCube;
floor_r=translate(scale(floor_r,12.5,14,0.2),2.5,6,-6);
floor_r.facecolor = [0.2 0.2 0.2];
floor_r.facelighting='FLAT'; %GOURAUD,PHONG,NONE,FLAT
wall_1r=UnitCube;
wall_1r=translate(scale(wall_1r,9.4,0.2,6.4),-1.1,-7.9,-0.5);
wall_1r.facecolor = [0.4 0.4 0.4];
wall_1r.facelighting='FLAT';
wall_2r=UnitCube;
wall_2r=translate(scale(wall_2r,0.2,11.85,6.1),-10.4,3.75,-0.2);
wall_2r.facecolor = [0.4 0.4 0.4];
wall_2r.facelighting='FLAT';
room_r=combine(floor_r,wall_1r,wall_2r);
%room_r=scale(room_r,0.12,0.12,0.12);
%roomh=renderpatch2(room_r);

% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

angle1 = 0;
angle2 = 0;

h2=figure(2); 
set(h2,'position', [1 55 1681 907]);
%set(h2,'position', [1 55 1280 650]); %
%drawnow
for i = 1:length(pathX)-1
%for i = 1:10
    if (pathX(i+1)==pathX(i))&&(pathY(i+1)==pathY(i))
        angle1=0;angle2=0;
    end

    Arm_left = combine(translate(rotateY(Fore_Arm_left,angle2),0,0,-L3), Upper_Arm_left);
    Arm_right = combine(translate(rotateY(Fore_Arm_right,-angle2),0,0,-L3), Upper_Arm_right);
    
    Arm_left = translate(rotateY(Arm_left,angle1),0,-L2/2,(5-L3/2)+L3/2);
    Arm_right = translate(rotateY(Arm_right,-angle1),0,L2/2,(5-L3/2)+L3/2);
    
    Leg_left = combine(translate(rotateY(Lower_Leg_left,-angle2),0,0,-L7), Upper_Leg_left);
    Leg_right = combine(translate(rotateY(Lower_Leg_right,angle2),0,0,-L7), Upper_Leg_right);
    
    Leg_left = translate(rotateY(Leg_left,-angle1),0,-L71,L72+L7/2);
    Leg_right = translate(rotateY(Leg_right,angle1),0,L71,L72+L7/2);
    
    Upper_Body = combine(Head, Shoulder, Arm_left, Arm_right, Chest, Weist);
    Lower_Body = combine(Hip, Leg_left, Leg_right);
    walker  = combine(Upper_Body, Lower_Body);
   % ---------------------------------------------------------------------
   angle_direct=atan((pathY(i+1)-pathY(i))/(pathX(i+1)-pathX(i))+eps)/pi*180;
    if (pathX(i+1)-pathX(i))>=0
        angle_direct=angle_direct;
    else
        angle_direct=180+angle_direct;
    end
    
    walker = scale(walker,0.5,0.5,0.35);
    walker  = rotateZ(walker,angle_direct);
    walker  = translate(walker,pathX(i),pathY(i),0);
    %walker  = translate(walker,i/9,0,0);
    %all_3D=combine(walker,room_r);
   % --------------------------------------------------------------------- 
    cla  
    %renderpatch(all_3D);
    %roomh=renderpatch2(room_r);
    renderpatch(walker);
    %hold on
    %plot(pathX,pathY)
    %plot3(pathX,pathY,pathZ,'k +')
    camlight
    box on
    view(120,120)
    %axis off
    grid on
    drawnow
    set(gca,'xlim',[-1 19],'ylim',[-1 22],'zlim',[-2.718 9]);
    %axis equal
    
    angle1 = w1_s(rem(i,length(w1_s))+1);
    angle2 = w2_s(rem(i,length(w1_s))+1);

end
title('Hi Raymond!','Position',[9,-8,9],'FontSize',18);




