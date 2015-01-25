% Code to create TRAJECTORY %
% Warning: This code is only for Binary data with length = 4 bits, i.e.,
% 1101 or 1001 or 1011 and not for 110 or 11 or 111111, etc.
clc;clear all;close all;
figure
% grid on;hold on;
% xlim([0 20]);ylim([0 20])
gcf;
BinLength = 4; % Length of the code on each floor

Case = 'FourByFour'; % Case 

SamplePlot = 5; % <<<<<<<------ After how many iterations do you want to plot

Counter = 1; % To stop the debugging mode if their is an Infinite Loop

WalkCount1 = 1;
WalkCount2 = 1;

StopSign = 10; % <<< Important part, How many times you want the Target to bump at the end and take reverse turn

carL = 1.2;
carW = 1.3;

%s = [0,0,40]; % Enter the Starting Point
%figure;hold on;

% % --- Initial assignment of the position of the subject --- % %
s11 = [9,10,-50]; % <<<------------ Enter the Starting Point for 1st subject
computecarpoints(s11(1),s11(2),s11(3),'r',carL,carW);
hold on;
s22 = [9,15,-130]; % <<<------------ Enter the Starting Point for 2nd subject
computecarpoints(s22(1),s22(2),s22(3),'c',carL,carW);

% % Plot the layout dimensions 
set(gca,'XTick',[0:5:20])
set(gca,'YTick',[0:5:20])
xlim([0 20]);ylim([0 20]);grid on;hold on;

% ====================================================================== %
% --- Layout for Location 1 --- %
text(2.25,2.25,'1010000000');text(7.25,2.25,'0010100000');
text(2.25,7.25,'0101000000');text(7.25,7.25,'0001010000');
% --- Layout for Location 2 --- %
text(2.25,12.25,'0000000111');text(7.25,12.25,'0000001110');
text(2.25,17.25,'0000011100');text(7.25,17.25,'0000111000');
% --- Layout for Location 3 --- %
text(12.25,2.25,'1000000000');text(12.25,7.25,'0100000000');
text(17.25,2.25,'0010000000');text(17.25,7.25,'0001000000');
% --- Layout for Location 3 --- %
text(12.25,12.25,'1111000000');text(17.25,12.25,'0111100000');
text(12.25,17.25,'0011110000');text(17.25,17.25,'0001111000');
% ====================================================================== %


it1 = 1;
dt = 0.1; % <------ 
i = 0;
CodeRec11 = [''];
theta1  = 10;

while (s11(1) > 0.0000001 && s11(1) < 19.99995 && s11(2) > 0.000001 && s11(2) < 19.9999995)
    
    i = i + 1;
    
    % Calculate angle for Target 1 %
    % Initialize the starting angle (facing) of the subject
    theta1 = randperm(360);
    theta1 = theta1(1)    
    [theta1] = truncate(theta1) 
    
    theta1 = correct_angle_range(theta1);% theta1 decides the next coordinates for the truck's back end    
    
    ds1 = truckmod(s11,theta1); % this function calculates the values for the three state (x,y,phi) of the car for given theta!    
    
    s11(1) = s11(1) + ds1(1) * dt;  % s11(1) orig X-coordinate + increment in its value 
    s11(2) = s11(2) + ds1(2) * dt;
    s11(3) = s11(3) + ds1(3) * dt;
    %[theta]=truncate(theta);
    
    if (rem(i,SamplePlot)==1)
        
        [X1,Y1,XCoG1,YCoG1] = computecarpoints(s11(1), s11(2), s11(3),'r',carL,carW);
        
        try
        [Code1] = fEmitCode(XCoG1,YCoG1,Case)    % Find the code for the CoG
        catch err
        end
        
        CodeRec11 = strcat(CodeRec11,Code1)
        CodeRec1(it1,:) = Code1        
        it1 = it1 + 1;
        
        % **** Certain Parts of the layout where the subject needs to take a
        % reverse turn **** %
        if(XCoG1 >= 18 || YCoG1 <= 2 )
            s11(3) = s11(3) - 270;
            [X1,Y1,XCoG1,YCoG1] = computecarpoints(s11(1), s11(2), s11(3),'r',carL,carW);
            WalkCount1 = WalkCount1 + 1;
        elseif(XCoG1 >= 18 || YCoG1 >= 18 )
            s11(3) = s11(3) - 270;
            [X1,Y1,XCoG1,YCoG1]=computecarpoints(s11(1), s11(2), s11(3),'r',carL,carW);
            WalkCount1 = WalkCount1 + 1;
        elseif(XCoG1 <= 2 || YCoG1 <= 2 )
            s11(3) = s11(3) - 270;
            [X1,Y1,XCoG1,YCoG1]=computecarpoints(s11(1), s11(2), s11(3),'r',carL,carW);
            WalkCount1 = WalkCount1 + 1;
        elseif(WalkCount1 > StopSign)
            break
        end
        
        pause(0.1);
    end
end


% % for i = 1 : 1 : length(CodeRec11)
% %     CodeR11(i) = str2num(CodeRec11(i));
% % end
% % 
% % %CodeR1 = str2num(CodeRec1)
% % %CodeR1 = dec2bin(CodeR1)
% % 
% % i = 0;
% % CodeRec22 = [''];
% % theta2  = 10;
% % it2 = 1;
% % while (s22(1) > 0.0000001 && s22(1) < 19.99999995 && s22(2) > 0.0000001 && s22(2) < 19.9999995)
% %     i = i + 1;        
% %     % Calculate angle for Target 2 %
% %     theta2 = randperm(360);
% %     theta2 = theta2(1);    
% %     [theta2]=truncate(theta2);        
% %     theta2 = correct_angle_range(theta2);
% %     
% %     ds2=truckmod(s22,theta2);
% %     %[theta]=truncate(theta);
% %     s22(1)=s22(1)+ds2(1)*dt;  % at discrete time 0.2 units
% %     s22(2)=s22(2)+ds2(2)*dt;
% %     s22(3)=s22(3)+ds2(3)*dt;
% %     
% %     if (rem(i,SamplePlot)==1)               
% %         [X2,Y2,XCoG2,YCoG2]=computecarpoints(s22(1), s22(2), s22(3),'c',carL,carW);  
% %         try
% %             [Code2] = fEmitCode(XCoG2,YCoG2,Case);    % Find the code for the CoG
% %         catch err
% %         end
% %         CodeRec22 = strcat(CodeRec22,Code2);
% %         CodeRec2(it2,:) = Code2;
% %         it2 = it2 + 1;
% %         if(XCoG2 >= 18 || YCoG2 <= 2 )
% %             s22(3) = s22(3) - 270;
% %             [X2,Y2,XCoG2,YCoG2]=computecarpoints(s22(1), s22(2), s22(3),'c',carL,carW);
% %             WalkCount2 = WalkCount2 + 1;
% %         elseif(XCoG2 >= 18 || YCoG2 >= 18 )
% %             s22(3) = s22(3) - 270;
% %             [X2,Y2,XCoG2,YCoG2]=computecarpoints(s22(1), s22(2), s22(3),'c',carL,carW);
% %             WalkCount2 = WalkCount2 + 1;
% %         elseif(XCoG2 <= 2 || YCoG2 <= 2 )
% %             s22(3) = s22(3) - 270;
% %             [X2,Y2,XCoG2,YCoG2]=computecarpoints(s22(1), s22(2), s22(3),'c',carL,carW);
% %             WalkCount2 = WalkCount2 + 1;
% %         elseif(WalkCount2 > StopSign)
% %             break
% %         end
% %             [X2,Y2,XCoG2,YCoG2]=computecarpoints(s22(1), s22(2), s22(3),'c',carL,carW);
% %         pause(0.1);
% %     end
% % end
% % 
% % 
% % 
% % for i = 1 : 1 : length(CodeRec22)
% %     CodeR22(i) = str2num(CodeRec22(i));
% % end
% % 
% % 
% % %CodeR2 = str2num(CodeRec2)
% % %CodeR2 = dec2bin(CodeR2)
% % 
% % clc
% % 
% % CodeRec1
% % CodeRec11
% % CodeR11
% % 
% % CodeRec2
% % CodeRec22
% % CodeR22
% % 
% % % This is the part where the Binary String emitted by Multi-Targets are
% % % equalized when there they have different lengths
% % 
% % if(length(CodeR11) < length(CodeR22))
% %     Diff1 = length(CodeR22) - length(CodeR11);
% %     vector1 = [CodeR11(length(CodeR11)-3), CodeR11(length(CodeR11)-2), CodeR11(length(CodeR11)-1), CodeR11(length(CodeR11))]; % <<<< Only for 4 binary length string e.g for 1101 not for 01101 or 010
% %     for i = 1 : 1 : Diff1/BinLength
% %         CodeR11 = cat(2,CodeR11,vector1);
% %     end
% % elseif(length(CodeR11) > length(CodeR22))
% %     Diff2 = length(CodeR11) - length(CodeR22);
% %     vector2 = [CodeR22(length(CodeR22)-3), CodeR22(length(CodeR22)-2), CodeR22(length(CodeR22)-1), CodeR22(length(CodeR22))]; % <<<< Only for 4 binary length string e.g for 1101 not for 01101 or 010
% %     for i = 1 : 1 : Diff2/BinLength
% %         CodeR22 = cat(2,CodeR22,vector2);
% %     end
% % end
% % 
% % ORed = CodeR11 | CodeR22
% % 
% % [Stats1TG] = fCal_Stats(CodeR11)
% % [Stats2TG] = fCal_Stats(CodeR22)
% % [StatsORed] = fCal_Stats(ORed)
% % 
% % figure;
% % H1 = plot3(Stats1TG(1,1),Stats1TG(1,2),Stats1TG(1,3),'rx','Linewidth',2.0);hold on;grid on;
% % H2 = plot3(Stats2TG(1,1),Stats2TG(1,2),Stats2TG(1,3),'cx','Linewidth',2.0);
% % H3 = plot3(StatsORed(1,1),StatsORed(1,2),StatsORed(1,3),'kx','Linewidth',2.0);
% % 
% % xlabel('P00');ylabel('P01');zlabel('P10');title('Stats for two targets and ORed')
% % xlim([0 1]);ylim([0 1]);zlim([0 1])
% % 
% % legend([H1 H2 H3],{'1st Target' '2nd Target' 'Final ORed Output'});
% % 
% % 
% % 
% % 
% % 






