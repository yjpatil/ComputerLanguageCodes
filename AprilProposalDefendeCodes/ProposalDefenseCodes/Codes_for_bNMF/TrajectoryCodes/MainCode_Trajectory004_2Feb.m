% Code to create TRAJECTORY For Straight Up and Down and Diagonal % For 3 Subjects %
% Warning: This code is only for Binary data with length = 4 bits, i.e.,
% 1101 or 1001 or 1011 and not for 110 or 11 or 111111, etc.
clc;clear all;close all;

addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\MainFunctions\');

figure
gcf;
BinLength = 4;  % <>----- Length of the code on each floor

Case = 'FourByFour'; % Case 

SampleData = 5; % <>----- "After how many iterations do you want to plot"
SamplePlot = 25;

Counter = 1; %????????? To stop the debugging mode if their is an Infinite Loop

WalkCount1 = 1; % Number of times Subject#1 bumps into the wall
WalkCount2 = 1; % Number of times Subject#2 bumps into the wall
WalkCount3 = 1; % Number of times Subject#3 bumps into the wall

StopSign = 2;  % <>----- "Important:: How many times you want the Target to bump at the end and take reverse turn"

carL = 1.2;
carW = 1.3;

% % ----- Initial assignment of the position of the subject ----- % %
s11 = [9,9,90];%[X,Y,Angle w.r.t X]   % <>-------- Enter the Starting Point for 1st subject
computecarpoints1(s11(1),s11(2),s11(3),carL,carW);
hold on;
s22 = [11,9,180];%[X,Y,Angle w.r.t X]  % <>-------- Enter the Starting Point for 2nd subject
computecarpoints2(s22(1),s22(2),s22(3),carL,carW);
% % 
s33 = [2,2,45];%[X,Y,Angle w.r.t X]  % <>-------- Enter the Starting Point for 2nd subject
computecarpoints3(s33(1),s33(2),s33(3),carL,carW);
% % ----- Plot the layout dimensions  ----- % % 
set(gca,'XTick',[0:5:20])
set(gca,'YTick',[0:5:20])
xlim([0 20]);ylim([0 20]);grid on;hold on;

% ======================================================================= %
text(2.,2.,'LPDC(:,13)');text(7.,2.,'LPDC(:,14)');text(12.,2.,'LPDC(:,15)');text(17.,2.,'LPDC(:,16)');
text(2.,7.,'LPDC(:,9)');text(7.,7.,'LPDC(:,10)');text(12.,7.,'LPDC(:,11)');text(17.,7.,'LPDC(:,12)');
text(2.,12.,'LPDC(:,5)');text(7.,12.,'LPDC(:,6)');text(12.,12.,'LPDC(:,7)');text(17.,12.,'LPDC(:,8)');
text(2.,17.,'LPDC(:,1)');text(7.,17.,'LPDC(:,2)');text(12.,17.,'LPDC(:,3)');text(17.,17.,'LPDC(:,4)');
% ======================================================================= %
D1 = 20; % Length of each code
Blocks = 16;
%LPDCmat = gen_ldpc(D1,Blocks);
load('LDPCmat02.mat');
LPDCmat = LDPCmat02;%gen_ldpc(D1,Blocks);
% <> ------------------------------ <> -------------------------------- <>
it1 = 1;
dt = 0.1;
i = 0;
%%CodeRec11 = [];
theta1  = 10;

while (s11(1) > 0.0000001 && s11(1) < 19.99995 && s11(2) > 0.000001 && s11(2) < 19.9999995)
    
    i = i + 1;
    
    % Calculate angle for Target 1 %
    % (1. Randomly select any theta value, 2. truncate (?dont know why this un-necessary 
    %  3. correct angle range - just in case if theta value > 360)
    theta1 = randperm(360);
    theta1 = theta1(1);    
    [theta1] = truncate(theta1);        
    theta1 = correct_angle_range(theta1);
    % theta decides the next coordinates for the truck's back end    
    
    % Below function calculates the equations for the three state (x,y,phi) of the car for given theta!
    ds1 = truckmod(s11,theta1);%      
    
    s11(1) = s11(1)+ds1(1)*dt;%s11(1) = s11(1)+ds1(1)*dt;  % at discrete time 0.2 units
    s11(2) = s11(2)+ds1(2)*dt;%s11(2) = s11(2)+ds1(2)*dt;
    s11(3) = s11(3);%+ds1(3)*dt;%s11(3) = s11(3)+ds1(3)*dt;
    %[theta]=truncate(theta);
    
    % % This is where the plotting part of the code comes % %
    if (rem(i,SampleData)==0) % Plot if 'ith' iteration and SamplePlt value have 1 e.g (rem(11,10) = 1)
        
        [X1,Y1,XCoG1,YCoG1] = computecarpoints001(s11(1), s11(2), s11(3),carL,carW,0); % Compute the whole body component
        
        if(rem(i,SamplePlot)==0)
            [X1,Y1,XCoG1,YCoG1] = computecarpoints001(s11(1), s11(2), s11(3),carL,carW,1); % Compute the whole body component
        end
        
        try
            [Code1] = fEmitSingleBlockCode(XCoG1,YCoG1,LPDCmat);   % <>--------- "Sampling Rate == 10(SamplePlot) iterations"Get the corresponding Code Find the code for the CoG
        catch err
        end
        
        %%CodeRec11 = strcat(CodeRec11,Code1); % Concatenate the previous iteration code
        
        CodeRec1(it1,:) = Code1';    
        
        it1 = it1 + 1;
        
        % " Shouldn't the following Part be outside of this loop??"
        % <>-----<> Now check if the person is at the boundaries <>-----<>
        if(XCoG1 >= 19 || YCoG1 <= 10 ) % ......... (1) ......... %
            s11(3) = 90;%s11(3) = s11(3) - 270; % 270 = Turn Angle
            [X1,Y1,XCoG1,YCoG1] = computecarpoints001(s11(1), s11(2), s11(3),carL,carW,0);
            WalkCount1 = WalkCount1 + 1;
        elseif(XCoG1 >= 19 || YCoG1 >= 19 ) % ......... (2) ......... %
            s11(3) = 270;%s11(3) = s11(3) - 270;
            [X1,Y1,XCoG1,YCoG1] = computecarpoints001(s11(1), s11(2), s11(3),carL,carW,0);
            WalkCount1 = WalkCount1 + 1;
        elseif(XCoG1 <= 2 || YCoG1 <= 2 ) % ......... (3) ......... %
            s11(3) = s11(3) - 270;
            [X1,Y1,XCoG1,YCoG1] = computecarpoints001(s11(1), s11(2), s11(3),carL,carW,0);
            WalkCount1 = WalkCount1 + 1;
        elseif(WalkCount1 > StopSign)
            break
        end
        
        %pause(0.1);
    end
end


 
i = 0;
theta2  = 10;
it2 = 1;
while (s22(1) > 0.0000001 && s22(1) < 19.99999995 && s22(2) > 0.0000001 && s22(2) < 19.9999995)
    i = i + 1;        
    % Calculate angle for Target 2 %
    theta2 = randperm(360);
    theta2 = theta2(1);    
    [theta2]=truncate(theta2);        
    theta2 = correct_angle_range(theta2);
    
    ds2=truckmod(s22,theta2);
    %[theta]=truncate(theta);
    s22(1)=s22(1)+ds2(1)*dt;  % at discrete time 0.2 units
    s22(2)=s22(2)+ds2(2)*dt;
    s22(3)=s22(3);%+ds2(3)*dt;
    
    if (rem(i,SampleData)==0)   
        
        [X2,Y2,XCoG2,YCoG2]=computecarpoints002(s22(1), s22(2), s22(3),carL,carW,0); 
        
        if(rem(i,SamplePlot)==0)
            [X2,Y2,XCoG2,YCoG2]=computecarpoints002(s22(1), s22(2), s22(3),carL,carW,1);  
        end
        
        try
            [Code2] = fEmitSingleBlockCode(XCoG2,YCoG2,LPDCmat);    % Find the code for the CoG
        catch err
        end
        
        CodeRec2(it2,:) = Code2';   
        
        it2 = it2 + 1;
        
        if(XCoG2 >= 19 || YCoG2 <= 1 )
            s22(3) = 180;
            [X2,Y2,XCoG2,YCoG2]=computecarpoints002(s22(1), s22(2), s22(3),carL,carW,0);
            WalkCount2 = WalkCount2 + 1;
        elseif(XCoG2 >= 19 || YCoG2 >= 19 )
            s22(3) = 180;
            [X2,Y2,XCoG2,YCoG2]=computecarpoints002(s22(1), s22(2), s22(3),carL,carW,0);
            WalkCount2 = WalkCount2 + 1;
        elseif(XCoG2 <= 10 || YCoG2 <= 1 )
            s22(3) = 0;
            [X2,Y2,XCoG2,YCoG2]=computecarpoints002(s22(1), s22(2), s22(3),carL,carW,0);
            WalkCount2 = WalkCount2 + 1;
        elseif(WalkCount2 > StopSign)
            break
        end
            [X2,Y2,XCoG2,YCoG2]=computecarpoints002(s22(1), s22(2), s22(3),carL,carW,0);
        %pause(0.1);
    end
end



i = 0;
%%CodeRec33 = [''];
theta3  = 10;
it3 = 1;
while (s33(1) > 0.0000001 && s33(1) < 19.99999995 && s33(2) > 0.0000001 && s33(2) < 19.9999995)
    i = i + 1;        
    % Calculate angle for Target 2 %
    theta3 = randperm(360);
    theta3 = theta3(1);    
    [theta3]=truncate(theta3);        
    theta3 = correct_angle_range(theta3);
    
    ds3=truckmod(s33,theta3);
    %[theta]=truncate(theta);
    s33(1)=s33(1)+ds3(1)*dt;  % at discrete time 0.2 units
    s33(2)=s33(2)+ds3(2)*dt;
    s33(3)=s33(3);%+ds2(3)*dt;
    
    if (rem(i,SampleData)==0)    
        
        [X3,Y3,XCoG3,YCoG3]=computecarpoints003(s33(1), s33(2), s33(3),carL,carW,0);  
        
        if(rem(i,SamplePlot)==0)
            [X3,Y3,XCoG3,YCoG3]=computecarpoints003(s33(1), s33(2), s33(3),carL,carW,1);  
        end
                
        try
            [Code3] = fEmitSingleBlockCode(XCoG3,YCoG3,LPDCmat);    % Find the code for the CoG
        catch err
        end
        %%CodeRec33 = strcat(CodeRec33,Code2);
        
        CodeRec3(it3,:) = Code3';
        
        it3 = it3 + 1;
        
        if(XCoG3 >= 9 || YCoG3 >= 9 )
            s33(3) = 225;
            [X3,Y3,XCoG3,YCoG3]=computecarpoints003(s33(1), s33(2), s33(3),carL,carW,0);
            WalkCount3 = WalkCount3 + 1;
        elseif(XCoG3 >= 19 || YCoG3 <= 0.001 )
            s33(3) = 135;
            [X3,Y3,XCoG3,YCoG3]=computecarpoints003(s33(1), s33(2), s33(3),carL,carW,0);
            WalkCount3 = WalkCount3 + 1;
        elseif(XCoG3 <= 2 || YCoG3 <= 2 )
            s33(3) = 45;
            [X3,Y3,XCoG3,YCoG3]=computecarpoints003(s33(1), s33(2), s33(3),carL,carW,0);
            WalkCount3 = WalkCount3 + 1;
        elseif(WalkCount3 > StopSign)
            break
        end
            [X3,Y3,XCoG3,YCoG3]=computecarpoints003(s33(1), s33(2), s33(3),carL,carW,0);
        %pause(0.1);
    end
end



Size1 = size(CodeRec1,1);
Size2 = size(CodeRec2,1);
Size3 = size(CodeRec3,1);

temp1 = [Size1,Size2,Size3];
Index1 = find(temp1 == min(temp1));


if(Index1 == 1)
    CodeRec2 = CodeRec2(1:Size1,:);
    CodeRec3 = CodeRec3(1:Size1,:);
elseif(Index1 == 2)
    CodeRec1 = CodeRec1(1:Size2,:);
    CodeRec3 = CodeRec3(1:Size2,:);
elseif(Index1 == 3)
    CodeRec1 = CodeRec1(1:Size3,:);
    CodeRec2 = CodeRec2(1:Size3,:);
end


V = CodeRec1'| CodeRec2' | CodeRec3';

[S1,S2] = size(V);
[S3,S4] = size(LPDCmat);

Winit = LPDCmat;
Hinit = rand(S4,S2);
tol = 0.00001;
maxiter = 500;
timelimit = 10000;

[W,H] = fnmf2_01(V,Winit,Hinit,tol,timelimit,maxiter);

Location1 = []; Location2 = [];Location3 = [];
for i = 1 : 1 : size(H,2)
    temp1 = H(:,i);
    temp2 = sort(temp1,'descend');
    Sub1 = temp2(1);
    Loc1 = find(Sub1 == temp1);
    Location1(1,i) = Loc1(1);
    Sub2 = temp2(2);
    Loc2 = find(Sub2 == temp1);
    Location2(1,i) = Loc2(1);
    Sub3 = temp2(3);
    Loc3 = find(Sub3 == temp1);
    Location3(1,i) = Loc3(1);
end

FontSize = 15.0;

figure(2);hold on;
nbins = Blocks;
xvalues = 1:nbins;
subplot(3,1,1);hist(Location1,xvalues);
H11 = findobj(gca,'Type','patch');set(H11,'FaceColor','w','EdgeColor','k')
title('Histogram of Location for Activity04','FontSize',FontSize);xlabel('Locations','FontSize',FontSize);

figure(2);hold on;
subplot(3,1,2);hist(Location2,xvalues);
H22 = findobj(gca,'Type','patch');set(H22,'FaceColor','w','EdgeColor','k')
xlabel('Locations','FontSize',FontSize);%title('Histogram for Location');

figure(2);hold on;
subplot(3,1,3);hist(Location3,xvalues);
H33 = findobj(gca,'Type','patch');set(H33,'FaceColor','w','EdgeColor','k')
xlabel('Locations','FontSize',FontSize);%title('Histogram for Location');



[Direction1] = fGetDirectnInfo(Location1);
[Direction2] = fGetDirectnInfo(Location2);
[Direction3] = fGetDirectnInfo(Location3);

figure(3);hold on;
subplot(4,1,1);
H001 = bar(Direction1,.2,'w');
set(gca,'XTickLabel',{'North','N-East','East','S-East','South','S-West','West','N-West','North'});
title('Different Direction Information','FontSize',FontSize)
set(gca,'FontSize',FontSize)
%%ylim([0 110])
hold on;
figure(3);hold on;
subplot(4,1,2);
H002 = bar(Direction2,.2,'w');
set(gca,'XTickLabel',{'North','N-East','East','S-East','South','S-West','West','N-West','North'});
%title('Different Direction Information','FontSize',FontSize)
set(gca,'FontSize',FontSize)
%%ylim([0 110])
hold on;
figure(3);hold on;
subplot(4,1,3);
H002 = bar(Direction3,.2,'w');
set(gca,'XTickLabel',{'North','N-East','East','S-East','South','S-West','West','N-West','North'});
%title('Different Direction Information','FontSize',FontSize)
set(gca,'FontSize',FontSize)
%%ylim([0 110])
hold on;


Direction = Direction1 + Direction2 + Direction3
figure(3);hold on;
subplot(4,1,4);
H004 = bar(Direction,.2,'w');
set(gca,'XTickLabel',{'North','N-East','East','S-East','South','S-West','West','N-West','North'});
%title('Sum','FontSize',FontSize)
set(gca,'FontSize',FontSize)
hold on;
















