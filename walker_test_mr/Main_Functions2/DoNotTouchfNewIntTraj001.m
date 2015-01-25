function[pathX,pathY,angle_direct] = DoNotTouchfNewIntTraj001(subject_choice,Scenario_choice)
% This function creates the required trajectory 
global Temp1 Temp2 Temp3 Temp4 Temp5;

if(subject_choice == 1)
    % --------- stage 1: Sub 1 walks to Sub 2 -------- %
    path1y = 10:-0.1:3.5;
    path1x = 18*ones(size(path1y));
    Temp1 = ones(size(path1y));
    angle_direct1 = -90*ones(size(path1x));
    path1x = [path1x;ones(size(path1y))]; %%<-------- swing angle check !!!
    % --------- stage 2: Sub 1 & Sub 2 hang out  -------- %
    path2x = 18*ones(1,10);
    path2y = 3.5*ones(size(path2x));
    Temp2 = ones(size(path2y));
    angle_direct2 = -90*ones(size(path2y));
    path2x = [path2x;zeros(size(path2y))]; %%<------- swing angle check !!!
    % --------- stage 3: Sub 1 & Sub 2 walk to Sub 3 -------- %
    path3x = 18:-0.1:10;
    path3y = 3.5*ones(size(path3x));
    Temp3 = ones(size(path3y));
    angle_direct3 = 180*ones(size(path3x));
    path3x = [path3x;ones(size(path3y))]; %%<-------- swing angle check !!!
    % --------- stage 4: Sub 1, Sub 2, Sub 3 walk together to meet -------- %
    path4x = 10:-0.1:3;
    path4y = 3.5*ones(size(path4x));
    angle_direct4 = 180*ones(size(path4x));
    path4x = [path4x;ones(size(path4y))]; %%<-------- swing angle check !!!
    % --------- stage 5: Sub 1, Sub 2, Sub 3 walk together to meet  -------- %
    path5y = 3.5:0.1:18;
    path5x = 3*ones(size(path5y));
    angle_direct5 = 90*ones(size(path5x));
    path5x = [path5x;ones(size(path5y))]; %%<-------- swing angle check !!!
    % ----------------- Break Away -------------------------- %
    [pX,pY,ang_direct] = fNewScenarioTraj001(subject_choice,Scenario_choice);
    pathX = [path1x,path2x,path3x,path4x,path5x,pX];
    pathY = [path1y,path2y,path3y,path4y,path5y,pY];
    angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct4,angle_direct5,ang_direct];
    % --------- stage 6: Sub1 walks away from 2&3 -------- %
% %     path6x = 3:0.1:11;
% %     path6y = 18*ones(size(path6x));
% %     angle_direct6 = 0*ones(size(path6x));
% %     path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
% %     % --------- stage 7: Sub1 diagonally moves to table -------- %
% %     path7x = 11:-0.1:10;
% %     path7y = 18:-0.1:11;
% %     
% %     for i = 1 : 1 : length(path7x) - 1
% %         angle_direct7(i) = atan((path7y(i+1) - path7y(i))/(path7x(i+1) - path7x(i)+eps))/pi*180;
% %     end          
% %     
% %     path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
% %     
% %     pathX = [path1x,path2x,path3x,path4x,path5x,path6x,path7x];
% %     pathY = [path1y,path2y,path3y,path4y,path5y,path6y,path7y];
% %     angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct4,angle_direct5,angle_direct6,angle_direct7];    
    
elseif(subject_choice == 2)
    % --------- stage 1 -------- %
    path1y = 2.5*Temp1; %<--------------   Global Variable 1
    path1x = 18*ones(size(path1y));
    angle_direct1 = 0*ones(size(path1x));
    path1x = [path1x;zeros(size(path1y))]; %%<-------- swing angle check !!!
    % --------- stage 2 -------- %
    path2x = 2.5*Temp2; %<--------------   Global Variable 2
    path2y = 18*ones(size(path2x));
    angle_direct2 = 90*ones(size(path2x));
    path2x = [path2x;zeros(size(path2y))]; %%<------- swing angle check !!!
    
    % --------- stage 3 -------- %
    path3x = 18:-0.1:10;
    path3y = 2.5*ones(size(path3x));
    angle_direct3 = 180*ones(size(path3x));
    path3x = [path3x;ones(size(path3y))]; %%<-------- swing angle check !!!
    % --------- stage 4 -------- %
    path4x = 10:-0.1:3;
    path4y = 2.5*ones(size(path4x));
    angle_direct4 = 180*ones(size(path4x));
    path4x = [path4x;ones(size(path4y))]; %%<-------- swing angle check !!!    
    % --------- stage 5 -------- %
    path5y = 3.5:0.1:17;
    path5x = 2.5*ones(size(path5y));
    angle_direct5 = 90*ones(size(path5x));
    path5x = [path5x;ones(size(path5y))]; %%<-------- swing angle check !!!
    % ----------------- Break Away -------------------------- %
    [pX,pY,ang_direct] = fNewScenarioTraj001(subject_choice,Scenario_choice);
    pathX = [path1x,path2x,path3x,path4x,path5x,pX];
    pathY = [path1y,path2y,path3y,path4y,path5y,pY];
    angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct4,angle_direct5,ang_direct];
    % --------- stage 6 -------- %
% %     path6x = 2.5:0.1:5;
% %     path6y = 17*ones(size(path6x));
% %     angle_direct6 = 0*ones(size(path6x));
% %     path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!    
% %     % --------- stage 7 -------- %
% %     path7x = 5:0.1:6.5;
% %     path7y = 17:-0.1:11;
% %     
% %     for i = 1 : 1 : length(path7x) - 1
% %         angle_direct7(i) = atan((path7y(i+1) - path7y(i))/(path7x(i+1) - path7x(i)+eps))/pi*180;
% %     end          
% %     
% %     path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
% %     pathY = [path1y,path2y,path3y,path4y,path5y,path6y,path7y];
% %     
% %     pathX = [path1x,path2x,path3x,path4x,path5x,path6x,path7x];
% %     angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct4,angle_direct5,angle_direct6,angle_direct7];
elseif(subject_choice == 3)
    % --------- stage 1 -------- %
    path1y = 1.5*Temp1; %<--------------   Global Variable 1
    path1x = 10*ones(size(path1y));
    angle_direct1 = -90*ones(size(path1x));
    path1x = [path1x;zeros(size(path1y))]; %%<-------- swing angle check !!!
    % --------- stage 2 -------- %
    path2x = 1.5*Temp2; %<--------------   Global Variable 2
    path2y = 10*ones(size(path2x));
    angle_direct2 = -90*ones(size(path2x));
    path2x = [path2x;zeros(size(path2y))]; %%<------- swing angle check !!!
    % --------- stage 3 -------- %
    path3x = 1.5*Temp3; %<--------------   Global Variable 2
    path3y = 10*ones(size(path3x));
    angle_direct3 = -90*ones(size(path3x));
    path3x = [path3x;zeros(size(path3y))]; %%<------- swing angle check !!!
    % --------- stage 4 -------- %
    path4x = 10:-0.1:3;
    path4y = 1.5*ones(size(path4x));
    angle_direct4 = 180*ones(size(path4x));
    path4x = [path4x;ones(size(path4y))]; %%<-------- swing angle check !!!
    % --------- stage 5 -------- %
    path5y = 3.5:0.1:18;
    path5x = 1.5*ones(size(path5y));
    angle_direct5 = 90*ones(size(path5x));
    path5x = [path5x;ones(size(path5y))]; %%<-------- swing angle check !!!
    % ----------------- Break Away -------------------------- %
    [pX,pY,ang_direct] = fNewScenarioTraj001(subject_choice,Scenario_choice);
    pathX = [path1x,path2x,path3x,path4x,path5x,pX];
    pathY = [path1y,path2y,path3y,path4y,path5y,pY];
    angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct4,angle_direct5,ang_direct];
% % %     % --------- stage 6 -------- %
% % %     path6x = 3:0.1:11;
% % %     path6y = 18*ones(size(path6x));
% % %     angle_direct6 = 0*ones(size(path6x));
% % %     path6x = [path6x;ones(size(path6y))]; %%<-------- swing angle check !!!
% % %     % --------- stage 7 -------- %
% % %     path7x = 11:-0.1:10;
% % %     path7y = 18:-0.1:15;
% % %     
% % %     for i = 1 : 1 : length(path7x) - 1
% % %         angle_direct7(i) = atan((path7y(i+1) - path7y(i))/(path7x(i+1) - path7x(i)+eps))/pi*180;
% % %     end          
% % %     
% % %     path7x = [path7x;ones(size(path7x))]; %%<-------- swing angle check !!!
% % %     
% % %     pathX = [path1x,path2x,path3x,path4x,path5x,path6x,path7x];
% % %     pathY = [path1y,path2y,path3y,path4y,path5y,path6y,path7y];
% % %     angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct4,angle_direct5,angle_direct6,angle_direct7];

elseif(subject_choice == 4)
    % --------- stage 1: Sub 4 walks alone to meet room directly  -------- %
    path1x = 6:-0.1:3;
    path1y = 1:0.1:5;
    
    for i = 1 : 1 : length(path1x) - 1
        angle_direct1(i) = atan((path1y(i+1) - path1y(i))/(path1x(i+1) - path1x(i)+eps))/pi*180;
    end    
    
    path1x = [path1x;ones(size(path1y))]; %%<-------- swing angle check !!!
    % --------- stage 2: Sub 4 still walks   -------- %
    path2y = 5:0.1:17;
    path2x = 3*ones(size(path2y));
    angle_direct2 = 90*ones(size(path2x));
    path2x = [path2x;ones(size(path2y))]; %%<-------- swing angle check !!!
    % ----------------- Break Away -------------------------- %
    [pX,pY,ang_direct] = fNewScenarioTraj001(subject_choice,Scenario_choice);
    pathX = [path1x,path2x,pX];
    pathY = [path1y,path2y,pY];
    angle_direct = [angle_direct1,angle_direct2,ang_direct];
    
% %     % --------- stage 3 -------- %
% %     path3x = 3:0.1:5;
% %     path3y = 17*ones(size(path3x));
% %     angle_direct3 = 0*ones(size(path3x));
% %     path3x = [path3x;ones(size(path3y))]; %%<-------- swing angle check !!!    
% %     % --------- stage 4 -------- %
% %     path4x = 5:0.1:6.5;
% %     path4y = 17:-0.1:15;
% %     
% %     for i = 1 : 1 : length(path4x) - 1
% %         angle_direct4(i) = atan((path4y(i+1) - path4y(i))/(path4x(i+1) - path4x(i)+eps))/pi*180;
% %     end          
% %     
% %     path4x = [path4x;ones(size(path4x))]; %%<-------- swing angle check !!!
% %     
% %     pathX = [path1x,path2x,path3x,path4x];
% %     pathY = [path1y,path2y,path3y,path4y];
% %     angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct4];
    
else


end








end







