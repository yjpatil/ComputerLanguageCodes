function[walker] = fGetWalker(angle1,angle2,FaceColor)
% This function allows to combine different bosy parts to get the proper
% scaled Body

%[Head,Shoulder,Upper_Arm_left,Upper_Arm_right,Fore_Arm_left,Fore_Arm_right,Chest,Waist,Hip,Upper_Leg_left,Upper_Leg_right,Lower_Leg_left,Lower_Leg_right,L2,L3,L7,L71,L72] = fGetBodyParts;

[Head,Shoulder,Upper_Arm_left,Upper_Arm_right,Fore_Arm_left,Fore_Arm_right,Chest,Waist,Hip,Upper_Leg_left,Upper_Leg_right,Lower_Leg_left,Lower_Leg_right,L2,L3,L7,L71,L72] = fGetBodyParts001(FaceColor);

Arm_left = combine(translate(rotateY(Fore_Arm_left,angle2),0,0,-L3), Upper_Arm_left);
Arm_right = combine(translate(rotateY(Fore_Arm_right,-angle2),0,0,-L3), Upper_Arm_right);    

Arm_left = translate(rotateY(Arm_left,angle1),0,-L2/2,(5-L3/2)+L3/2);
Arm_right = translate(rotateY(Arm_right,-angle1),0,L2/2,(5-L3/2)+L3/2);   

Leg_left = combine(translate(rotateY(Lower_Leg_left,-angle2),0,0,-L7), Upper_Leg_left);
Leg_right = combine(translate(rotateY(Lower_Leg_right,angle2),0,0,-L7), Upper_Leg_right);    

Leg_left = translate(rotateY(Leg_left,-angle1),0,-L71,L72+L7/2);
Leg_right = translate(rotateY(Leg_right,angle1),0,L71,L72+L7/2);    

Upper_Body = combine(Head, Shoulder, Arm_left, Arm_right, Chest, Waist);
Lower_Body = combine(Hip, Leg_left, Leg_right);
walker  = combine(Upper_Body, Lower_Body);







end
