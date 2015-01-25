close all;clear all

cyl = UnitCylinder(2); % To create the 'TORSO'
sph = UnitSphere(2); % To create the 'HEAD' 
% The number 2 is the resolution for the data points for head and torso

% -------------- Create the Head, Shoulder, Arms, Legs, Waist ----------- %
% CREATE THE HEAD % 
L1 = 2;
Head = translate(scale(sph,L1/2, L1/2, L1/2),0,0,L1+4.5); % Scale-->multiplication,Translate--> add values
Head.facecolor = 'yellow';

% CREATE THE SHOULDER % 
r2 = 0.3;% diameter of the cyclinder bar
L2 = 3; % scaling factor
% rotateX --> angle of rotation-- theta = 90
Shoulder = translate(rotateX(scale(cyl,r2/2,r2/2,L2/2),90),0,0,5);% This is the bar that is rotated 90 degrees and is fixed (doesnot moves)
Shoulder.facecolor = 'red';
% % % --------------------------------------------------------------- % % %
% Left Upper Arm %
w1_s = [-10:2:10 10:-2:-10]; % <--- rotation angle degree for Upper Arms (right/left)
r3 = 0.3;
L3 = 2;
Upper_Arm_left = translate(scale(cyl,r3/2,r3/2,L3/2),0,0,-L3/2);
Upper_Arm_left.facecolor = 'red';

% Right Upper Arm %
Upper_Arm_right = translate(scale(cyl,r3/2,r3/2,L3/2),0,0,-L3/2);
Upper_Arm_right.facecolor = 'red';
% % % --------------------------------------------------------------- % % %
% Left Forearm %
w2_s = [-5:1:10 5:-1:-5]; % <--- rotation angle degree for Fore Arms (right/left)
L3_f = 2.5;
Fore_Arm_left = translate(scale(cyl,r3/2,r3/2,L3_f/2),0,0,-L3_f/2);
Fore_Arm_left.facecolor = 'red';

% Right Forearm %
Fore_Arm_right = translate(scale(cyl,r3/2,r3/2,L3_f/2),0,0,-L3_f/2);
Fore_Arm_right.facecolor = 'red';
% % % --------------------------------------------------------------- % % %
% Chest %
r4 = 2;
L4 = 2;
Chest = translate(scale(cyl,r4/2,r4/2,L4/2),0, 0, 5-L4/2);
Chest.facecolor = 'yellow';

% Waist
r5 = 1;
L5 = 2;
Weist = translate(scale(cyl,r5/2,r5/2,L5/2),0, 0, 5-L4-L5/2);
Weist.facecolor = 'yellow';

%Hip % The horizontal bar (rotated 90 degrees)
L6 = 1.5;
Hip = translate(rotateX(scale(cyl,r2/2,r2/2,L6/2),90),0,0,5-L4-L5-r2/2);
Hip.facecolor = 'green';
% % % --------------------------------------------------------------- % % %
%Left Upper Leg
r7 = 0.4;
L7 = 2.5;
L71 = (L6/2+r7/2);
L72 = 5-L7/2-L4-L5;
Upper_Leg_left = translate(scale(cyl,r7/2,r7/2,L7/2),0,0,-L7/2);
Upper_Leg_left.facecolor = 'green';

%Right Upper Leg
Upper_Leg_right = translate(scale(cyl,r7/2,r7/2,L7/2),0,0,-L7/2);
Upper_Leg_right.facecolor = 'green';

%Left Lower Leg
L7_f = 3;
Lower_Leg_left = translate(scale(cyl,r7/2,r7/2,L7_f/2),0,0,-L7_f/2);
Lower_Leg_left.facecolor = 'green';

%Right Lower Leg
Lower_Leg_right = translate(scale(cyl,r7/2,r7/2,L7_f/2),0,0,-L7_f/2);
Lower_Leg_right.facecolor = 'green';

% ----------------------------------------------------------------------- %

angle1 = 0 % <-------- leg angle
angle2 = 0 % <-------- arm angle

for i = 1 : 1 : 160   
    % ------ (1) COMBINE ALL THE PARTS ----- %
    Arm_left = combine(translate(rotateY(Fore_Arm_left,angle2),0,0,-L3), Upper_Arm_left);% Fore_arm_left goes front (angle2+) and vice-versa
    Arm_right = combine(translate(rotateY(Fore_Arm_right,-angle2),0,0,-L3), Upper_Arm_right);% Fore_arm_right goes back (angle2-) and vice-versa
    % ------ (2) New Position ----- %
    Arm_left = translate(rotateY(Arm_left,angle1),0,-L2/2,(5-L3/2)+L3/2);
    Arm_right = translate(rotateY(Arm_right,-angle1),0,L2/2,(5-L3/2)+L3/2);
    % ------ (1) COMBINE ALL THE PARTS ----- %
    Leg_left = combine(translate(rotateY(Lower_Leg_left,-angle2),0,0,-L7), Upper_Leg_left);
    Leg_right = combine(translate(rotateY(Lower_Leg_right,angle2),0,0,-L7), Upper_Leg_right);
    % ------ (2) New Position ----- %
    Leg_left = translate(rotateY(Leg_left,-angle1),0,-L71,L72+L7/2);
    Leg_right = translate(rotateY(Leg_right,angle1),0,L71,L72+L7/2);
    
    
    % ------------- Combine All the Components -------------------------- %
    Upper_Body = combine(Head, Shoulder, Arm_left, Arm_right, Chest, Weist);
    Lower_Body = combine(Hip, Leg_left, Leg_right);
    walker  = combine(Upper_Body, Lower_Body);
        
    cla
    renderpatch(walker); % Takes the structure
    camlight   % Create or move light object in camera coordinates
    box on
    view(120,20)
    axis off
    drawnow
    set(gca,'xlim',[-5 5],'ylim',[-5 5],'zlim',[-5 5]);
    
    % rem(n1,n2) = n1 if(n2>n1) else(n2-n1)if(n1>n2); ans sign is same as
    % n1;  Plus '1' at the end ensures that 0 is not included
    rem(i,length(w1_s))+1 % ----> % Just to create the index for w1_s upto its length
    rem(i,length(w2_s))+1 % ----> % Just to create the index for w2_s upto its length

    angle1 = w1_s(rem(i,length(w1_s))+1) % <-------- angle w1_s at particular iteration i
    angle2 = w2_s(rem(i,length(w2_s))+1) % <-------- 

end







