close all;clear all;clc

%------------------------------------------------------------
load men_2track
len1=length(human11); len2=length(human21);
len=max(len1,len2);
path1X=zeros(1,len1);path1Y=path1X;
path2X=zeros(1,len2);path2Y=path2X;
%------------------------------------------------------------
for i=1:len1
    if human12(1,i)>0
        path1X(i)=(human11(1,i)+human12(1,i))/2;
        path1Y(i)=(human11(2,i)+human12(2,i))/2;
    else
        path1X(i)=human11(1,i);
        path1Y(i)=human11(2,i);
    end
end
for i=1:len2
    if human22(1,i)>0
        path2X(i)=(human21(1,i)+human22(1,i))/2;
        path2Y(i)=(human21(2,i)+human22(2,i))/2;
    else
        path2X(i)=human21(1,i);
        path2Y(i)=human21(2,i);
    end
end
%------------------------For human 1-----------------------
%----------Insert more points between the discrete localizations------
ik=1;
for i=1:len1-1
    insert_pathX=[];insert_pathY=[];
    if abs((path1X(ik+1)-path1X(ik)))>=abs((path1Y(ik+1)-path1Y(ik)))
        
        if path1X(ik+1)>=path1X(ik)
            insert_pathX=path1X(ik):0.1:path1X(ik+1);
        else
            insert_pathX=path1X(ik):-0.1:path1X(ik+1);
        end
        if length(insert_pathX)>=3
        insert_pathY = ...
            interp1q([path1X(ik);path1X(ik+1)],[path1Y(ik);path1Y(ik+1)],insert_pathX')';
        end
    else 
        if path1Y(ik+1)>=path1Y(ik)
            insert_pathY=path1Y(ik):0.1:path1Y(ik+1);
        else
            insert_pathY=path1Y(ik):-0.1:path1Y(ik+1);
        end
        if length(insert_pathY)>=3
        insert_pathX = ...
            interp1q([path1Y(ik);path1Y(ik+1)],[path1X(ik);path1X(ik+1)],insert_pathY')';
        end
    end
    
    inlen=length(insert_pathX);
    if inlen>=3
        %[path1X(ik);path1X(ik+1)],[path1Y(ik);path1Y(ik+1)]
        path1X=[path1X(1:ik),insert_pathX(2:inlen-1),path1X(ik+1:end)];
        path1Y=[path1Y(1:ik),insert_pathY(2:inlen-1),path1Y(ik+1:end)];
        ik=ik+inlen-1;
    else
        ik=ik+1;
    end
    
end
% ----------------------For human 2-------------------------------------
ik=1;
for i=1:len2-1
    insert_pathX=[];insert_pathY=[];
    if abs((path2Y(ik+1)-path2Y(ik)))<=abs((path2X(ik+1)-path2X(ik)))
        if path2X(ik+1)>=path2X(ik)
            insert_pathX=path2X(ik):0.1:path2X(ik+1);
        else
            insert_pathX=path2X(ik):-0.1:path2X(ik+1);
        end
        if length(insert_pathX)>=3
        insert_pathY = ...
            interp1q([path2X(ik);path2X(ik+1)],[path2Y(ik);path2Y(ik+1)],insert_pathX')';
        end
    else 
        if path2Y(ik+1)>=path2Y(ik)
            insert_pathY=path2Y(ik):0.1:path2Y(ik+1);
        else
            insert_pathY=path2Y(ik):-0.1:path2Y(ik+1);
        end
        if length(insert_pathY)>=3
        insert_pathX = ...
            interp1q([path2Y(ik);path2Y(ik+1)],[path2X(ik);path2X(ik+1)],insert_pathY')';
        end
    end
    
    inlen=length(insert_pathX);
    if inlen>=3
        %[path1X(ik);path1X(ik+1)],[path1Y(ik);path1Y(ik+1)]
        path2X=[path2X(1:ik),insert_pathX(2:inlen-1),path2X(ik+1:end)];
        path2Y=[path2Y(1:ik),insert_pathY(2:inlen-1),path2Y(ik+1:end)];
        ik=ik+inlen-1;
    else
        ik=ik+1;
    end
    
end
%angle_direct1=atan(([path1Y,0]-[0,path1Y])./([path1X,0]-[0,path1X]+eps))/pi*180;
%angle_direct2=atan(([path2Y,0]-[0,path2Y])./([path2X,0]-[0,path2X]+eps))/pi*180;
%------------------------------------------------------------
cyl = UnitCylinder(2);
sph = UnitSphere(2);
sph_hf = UnitSphere_half(2,0.5);

% pathX=0:0.1:14;
% pathY=(15^2-pathX.^2).^0.5;
% pathX = [pathX,[14.1:0.1:22]];
% pathY = [pathY,(pathY(length(pathY))-0.1)*ones(1,length([14:0.1:22]))];
% pathX2=pathX; pathY2=pathX;

%plot(pathX,pathY)
% Head 
L1 = 2;
Head = translate(scale(sph,L1/2, L1/2, L1/1.4),0,0,L1+4.5);
Head.facecolor = [0.9 0.6 0.6];
Head1=Head;Head1.facecolor = [0.3 0.3 1];
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
Head1 = combine(Head1,Neck,meys1,meys2);
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

angle1 = 0;
angle2 = 0;
angle_direct2=0;
h2=figure(2); 
set(h2,'position', [100 155 1280 700]); %
%drawnow
M=moviein(len-1);
for i = 1:len-1
    if angle_direct2==0;
        angle2=0;
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
    Upper_Body1 = combine(Head1, Shoulder, Arm_left, Arm_right, Chest, Weist);
    Lower_Body = combine(Hip, Leg_left, Leg_right);
    
    walker  = combine(Upper_Body, Lower_Body);
    walker1  = combine(Upper_Body1, Lower_Body);
   % ---------------------------------------------------------------------
    
    
    walker = scale(walker,0.3,0.3,0.55);
    walker1 = scale(walker1,0.3,0.3,0.55);
    % ---------------------------------------------------------------------
    cla
    % ---------------------------------------------------------------------
    if i+1<=len1
        if (path1X(i+1)-path1X(i))>=0
            angle_direct1=atan((path1Y(i+1)-path1Y(i))/(path1X(i+1)-path1X(i)+eps))/pi*180;
        else
            angle_direct1=180+atan((path1Y(i+1)-path1Y(i))/(path1X(i+1)-path1X(i)+eps))/pi*180;
        end
        xfill=[path1X(i)-0.5,path1X(i)+0.5,path1X(i)+0.5,path1X(i)-0.5];
        yfill=[path1Y(i)-0.5,path1Y(i)-0.5,path1Y(i)+0.5,path1Y(i)+0.5];
        fill(xfill,yfill,'b')
        walker1  = rotateZ(walker1,angle_direct1);
        walker1  = translate(walker1,path1X(i),path1Y(i),3);
    else
        xfill=[path1X(end)-0.5,path1X(end)+0.5,path1X(end)+0.5,path1X(end)-0.5];
        yfill=[path1Y(end)-0.5,path1Y(end)-0.5,path1Y(end)+0.5,path1Y(end)+0.5];
        fill(xfill,yfill,'b')
        walker1  = rotateZ(walker1,angle_direct1(end));
        walker1  = translate(walker1,path1X(end),path1Y(end),3);
    end
    % ---------------------------------------------------------------------
    if i+1<=len2
        if (path2X(i+1)-path2X(i))>=0
            angle_direct2=atan((path2Y(i+1)-path2Y(i))/(path2X(i+1)-path2X(i)+eps))/pi*180;
        else
            angle_direct2=180+atan((path2Y(i+1)-path2Y(i))/(path2X(i+1)-path2X(i)+eps))/pi*180;
        end
        xfill=[path2X(i)-0.5,path2X(i)+0.5,path2X(i)+0.5,path2X(i)-0.5];
        yfill=[path2Y(i)-0.5,path2Y(i)-0.5,path2Y(i)+0.5,path2Y(i)+0.5];
        fill(xfill,yfill,'r')
        walker  = rotateZ(walker,angle_direct2);
        walker  = translate(walker,path2X(i),path2Y(i),3);
    else
        xfill=[path2X(end)-0.5,path2X(end)+0.5,path2X(end)+0.5,path2X(end)-0.5];
        yfill=[path2Y(end)-0.5,path2Y(end)-0.5,path2Y(end)+0.5,path2Y(end)+0.5];
        fill(xfill,yfill,'r')
        walker  = rotateZ(walker,angle_direct2(end));
        walker  = translate(walker,path2X(end),path2Y(end),3);
    end
    
    body_all = combine(walker1, walker);
    % --------------------------------------------------------------------- 
    
    plot([-2,10],[0,0],'k','LineWidth',1.5)
    hold on
    plot([-2,10],[-2,-2],'k'); plot([-2,10],[-1,-1],'k'); 
    plot([-2,10],[1,1],'k'); plot([-2,10],[2,2],'k'); 
    plot([-2,10],[3,3],'k');plot([-2,10],[4,4],'k','LineWidth',1.5); 
    plot([-2,10],[5,5],'k');plot([-2,10],[6,6],'k'); 
    plot([-2,10],[7,7],'k');plot([-2,10],[8,8],'k','LineWidth',2); 
    plot([-2,10],[9,9],'k');plot([-2,10],[10,10],'k');
    
    plot([-2,-2],[-2,10],'k'); plot([-1,-1],[-2,10],'k');
    plot([0,0],[-2,10],'k','LineWidth',1.5); plot([1,1],[-2,10],'k'); 
    plot([2,2],[-2,10],'k'); plot([3,3],[-2,10],'k'); 
    plot([4,4],[-2,10],'k','LineWidth',1.5);
    plot([5,5],[-2,10],'k'); plot([6,6],[-2,10],'k');
    plot([7,7],[-2,10],'k'); plot([8,8],[-2,10],'k','LineWidth',1.5);
    plot([9,9],[-2,10],'k'); plot([10,10],[-2,10],'k');
    %axis([0 8 0 8]); 
    %axis square; 
    % ---------------------------------------------------------------------
    
    % ---------------------------------------------------------------------
    %renderpatch(walker);
    renderpatch(body_all);
    %plot(pathX,pathY)
    camlight
    box off
    view(130,35)
    %axis off
    %axis equal
    grid on
    drawnow
    set(gca,'xlim',[-2 10],'ylim',[-2 10],'zlim',[0 13]);
    %M(:,i) = getframe;
    angle1 = w1_s(rem(i,length(w1_s))+1);
    angle2 = w2_s(rem(i,length(w1_s))+1);
    
    
%     if i<=len2
%     title(num2str([path1X(i),path1Y(i),path2X(i),path2Y(i)]),'Position',[9,-2,12],'FontSize',18);
%     else
%     title(num2str([path1X(i),path1Y(i),path2X(len2),path2Y(len2)]),'Position',[9,-2,12],'FontSize',18);
%     end
    
end
%movie2avi(M,'fiber32s_64g_movie.avi', 'compression', 'None','fps',30);
clear M;




