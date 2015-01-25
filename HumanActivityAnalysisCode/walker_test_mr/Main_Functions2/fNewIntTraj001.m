function[pathX,pathY,angle_direct] = fNewIntTraj001(subject_choice,Scenario_choice)
% This function creates the required trajectory 
% **---->< Just go on adding Temps ------->< **
global Temp1 Temp2 Temp3 Temp4 Temp5 Temp6; % This global vars are useful to manage the 
% imbalance of points between Sub1 and Sub2,3,4,5,....
% *** Temp6 is specially for subject 4
if(subject_choice == 1)
    % --------- stage 1: Sub 1 walks to Sub 2 -------- %
    path1y = 10:-0.1:3.5;
    path1x = 18*ones(size(path1y));
    Temp1 = ones(size(path1y));% <--- So that other subjects wait until sub1 arrives to them
    % Hence the length of data set is equalize  for all subjects
    angle_direct1 = -90*ones(size(path1x));
    path1x = [path1x;ones(size(path1y))]; %%<-------- swing angle check !!!
    % --------- stage 2: Sub 1 & Sub 2 hang out  -------- %
    path2x = 18*ones(1,10);
    path2y = 3.5*ones(size(path2x));
    Temp2 = ones(size(path2y));% <--- So that other subjects wait untill sub1 arrives to them
    angle_direct2 = -90*ones(size(path2y));
    path2x = [path2x;zeros(size(path2y))]; %%<------- swing angle check !!!
    % --------- stage 3: Sub 1 & Sub 2 walk to Sub 3 -------- %
    path3x = 18:-0.1:10;
    path3y = 3.5*ones(size(path3x));
    Temp3 = ones(size(path3y));
    angle_direct3 = 180*ones(size(path3x));
    path3x = [path3x;ones(size(path3y))]; %%<-------- swing angle check !!!
    % --------- stage 4: Sub 1, Sub 2, Sub 3 walk together to meet ------ %
    path4x = 10:-0.1:3;
    path4y = 3.5*ones(size(path4x));
    angle_direct4 = 180*ones(size(path4x));
    path4x = [path4x;ones(size(path4y))]; %%<-------- swing angle check !!!
    % --------- stage 5: Sub 1, Sub 2, Sub 3 walk together to meet ------ %
    path5y = 3.5:0.1:18;
    path5x = 3*ones(size(path5y));
    angle_direct5 = 90*ones(size(path5x));
    path5x = [path5x;ones(size(path5y))]; %%<-------- swing angle check !!!
    % ---
    Temp5 = length(path1y)+length(path2y)+length(path3y)+length(path4y)+length(path5y);%<------ Total Data set before break away !!!
    % ----------------- Break Away + Start of a Scenario ---------------- %
    [pX,pY,ang_direct] = fNewScenarioTraj001(subject_choice,Scenario_choice);
    pathX11 = [path1x,path2x,path3x,path4x,path5x,pX];
    pathY11 = [path1y,path2y,path3y,path4y,path5y,pY];
    angle_direct001 = [angle_direct1,angle_direct2,angle_direct3,angle_direct4,angle_direct5,ang_direct];
    Temp4 = length(pY);%%<----- This is total # of points when they break away and the start of a scenario     
    
    % --------- Meeting Over So Disperse Now -------- %
    LastpX = pX(1,end);LastpY = pY(1,end);%%<--- Take the last data point of the Scenario, Then start from their
    [pX11,pY11,angle_direct111] = fScDispTraj001(LastpX,LastpY,subject_choice,Scenario_choice);   
    
    pathX = [pathX11,pX11];
    pathY = [pathY11,pY11];
    angle_direct = [angle_direct001,angle_direct111];
    
elseif(subject_choice == 2)
    % --------- stage 1 -------- %
    path1y = 2.5*Temp1; %<-------- Global Variable 1: Until sub1 arrives at 
    % sub2
    path1x = 18*ones(size(path1y));
    angle_direct1 = 0*ones(size(path1x));
    path1x = [path1x;zeros(size(path1y))]; %%<-------- swing angle check !!!
    % --------- stage 2 -------- %
    path2y = 2.5*Temp2; %<--------------   Global Variable 2
    path2x = 18*ones(size(path2y));
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
    % ------- Now check the size of size of all paths of Sub2 and Sub1(which
    % is greater). Append with extra last position points %%%%%%%%%%        
    Size2 = length(path1y)+length(path2y)+length(path3y)+length(path4y)+length(path5y);
    Extra = Temp5 - Size2;        
    
    path6x = path5x(1,end)*ones(1,Extra);
    path6y = path5y(1,end)*ones(1,Extra);
    angle_direct6 = 225*ones(size(path6x));
    path6x = [path6x;zeros(size(path6x))]; %%<-------- swing angle check !!!
    
    
    % ----------------- Break Away -------------------------- %
    [pX,pY,ang_direct] = fNewScenarioTraj001(subject_choice,Scenario_choice);
    pathX11 = [path1x,path2x,path3x,path4x,path5x,path6x,pX];
    pathY11 = [path1y,path2y,path3y,path4y,path5y,path6y,pY];
    angle_direct001 = [angle_direct1,angle_direct2,angle_direct3,angle_direct4,angle_direct5,angle_direct6,ang_direct];
    % --------- Meeting Over So Disperse Now -------- %
    LastpX = pX(1,end);LastpY = pY(1,end);
    [pX11,pY11,angle_direct111] = fScDispTraj001(LastpX,LastpY,subject_choice,Scenario_choice);   
    
    pathX = [pathX11,pX11];
    pathY = [pathY11,pY11];
    angle_direct = [angle_direct001,angle_direct111];
    
    
elseif(subject_choice == 3)
    % --------- stage 1 -------- %
    path1y = 1.5*Temp1; %<--------------   Global Variable 1
    path1x = 10*ones(size(path1y));
    angle_direct1 = -90*ones(size(path1x));
    path1x = [path1x;zeros(size(path1y))]; %%<-------- swing angle check !!!
    % --------- stage 2 -------- %
    path2y = 1.5*Temp2; %<--------------   Global Variable 2
    path2x = 10*ones(size(path2y));
    angle_direct2 = -90*ones(size(path2x));
    path2x = [path2x;zeros(size(path2y))]; %%<------- swing angle check !!!
    % --------- stage 3 -------- %
    path3y = 1.5*Temp3; %<--------------   Global Variable 2
    path3x = 10*ones(size(path3y));
    angle_direct3 = -90*ones(size(path3x));
    path3x = [path3x;zeros(size(path3y))]; %%<------- swing angle check !!!
    % --------- stage 4 -------- %
    path4x = 10:-0.1:3;
    path4y = 1.5*ones(size(path4x));
    angle_direct4 = 180*ones(size(path4x));
    path4x = [path4x;ones(size(path4y))]; %%<-------- swing angle check !!!
    % --------- stage 5 -------- %
    path5y = 3.5:0.1:18.5;
    path5x = 1.5*ones(size(path5y));
    angle_direct5 = 90*ones(size(path5x));
    path5x = [path5x;ones(size(path5y))]; %%<-------- swing angle check !!!
    % ----------------- Break Away -------------------------- %
    [pX,pY,ang_direct] = fNewScenarioTraj001(subject_choice,Scenario_choice);
    pathX11 = [path1x,path2x,path3x,path4x,path5x,pX];
    pathY11 = [path1y,path2y,path3y,path4y,path5y,pY];
    angle_direct001 = [angle_direct1,angle_direct2,angle_direct3,angle_direct4,angle_direct5,ang_direct];
    % --------- Meeting Over So Disperse Now -------- %
    LastpX = pX(1,end);LastpY = pY(1,end);
    [pX11,pY11,angle_direct111] = fScDispTraj001(LastpX,LastpY,subject_choice,Scenario_choice);   
    
    pathX = [pathX11,pX11];
    pathY = [pathY11,pY11];
    angle_direct = [angle_direct001,angle_direct111];

elseif(subject_choice == 4)
    % --------- stage 0: Sub 4 walks alone to meet room directly  -------- %
    path0x = 3*Temp1;
    path0y = 1*ones(size(path0x));
    angle_direct0 = -90*ones(size(path0x));
    path0x = [path0x;zeros(size(path0y))]; %%<-------- swing angle check !!!
    % --------- stage 1: Sub 4 walks alone to meet room directly  -------- %    
    path1x = 3:-0.1:3.5;
    path1y = 1*ones(size(path1x));
    angle_direct1 = 180*ones(size(path1x));        
    
    path1x = [path1x;ones(size(path1y))]; %%<-------- swing angle check !!!
    % --------- stage 2: Sub 4 still walks   -------- %
    path2y = 2:0.1:17;
    path2x = 3.5*ones(size(path2y));
    angle_direct2 = 90*ones(size(path2x));
    path2x = [path2x;ones(size(path2y))]; %%<-------- swing angle check !!!
    % 
    Size2 = length(path0y)+length(path1y)+length(path2y);
    Temp6 = Temp5 - Size2;%<----Temp 5 is the total data points of Sub 1 before entering the scenario 
    %
    % ----------------- Break Away -------------------------- %
    [pX,pY,ang_direct] = fNewScenarioTraj001(subject_choice,Scenario_choice);
    pathX11 = [path0x,path1x,path2x,pX];
    pathY11 = [path0y,path1y,path2y,pY];
    angle_direct001 = [angle_direct0,angle_direct1,angle_direct2,ang_direct];        
    % --------- Meeting Over So Disperse Now -------- %
    LastpX = pX(1,end);LastpY = pY(1,end);
    [pX11,pY11,angle_direct111] = fScDispTraj001(LastpX,LastpY,subject_choice,Scenario_choice);   
    
    pathX = [pathX11,pX11];
    pathY = [pathY11,pY11];
    angle_direct = [angle_direct001,angle_direct111];
    

    
else


end








end







