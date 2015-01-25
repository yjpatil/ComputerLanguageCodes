function[pathX,pathY,angle_direct] = fCreateTrajectory002(subject_choice)
% This function creates the required trajectory 


if(subject_choice == 1)
    % --------- stage 1 -------- %
    path1y = 2:0.1:18;
    path1x = 18*ones(size(path1y));
    angle_direct1 = 90*ones(size(path1x));
    % --------- stage 2 -------- %
    path2y = 18:-0.1:2;
    path2x = 18*ones(size(path2y));
    angle_direct2 = -90*ones(size(path2y));
    % --------- stage 3 -------- %
    path3y = 2:0.1:10;
    path3x = 18*ones(size(path3y));
    angle_direct3 = 90*ones(size(path3x));
        
    
    pathX = [path1x path2x path3x];
    pathY = [path1y path2y path3y];
    angle_direct = [angle_direct1,angle_direct2,angle_direct3];
    
elseif(subject_choice == 2)
    % --------- stage 1 -------- %
    path1y = 2:0.1:18;
    path1x = 10*ones(size(path1y));
    angle_direct1 = 90*ones(size(path1x));
    % --------- stage 2 -------- %
    path2y = 18:-0.1:2;
    path2x = 10*ones(size(path2y));
    angle_direct2 = -90*ones(size(path2y));
    
    pathX = [path1x path2x];
    pathY = [path1y path2y];
    angle_direct = [angle_direct1,angle_direct2];
elseif(subject_choice == 3)
    % --------- stage 1 -------- %
    path1y = 18:-0.1:2;
    path1x = 2*ones(size(path1y));
    angle_direct1 = -90*ones(size(path1x));
    % --------- stage 2 -------- %
    path2y = 2:0.1:19;
    path2x = 2*ones(size(path2y));
    angle_direct2 = 90*ones(size(path2y));
    
    pathX = [path1x path2x];
    pathY = [path1y path2y];
    angle_direct = [angle_direct1,angle_direct2];
else


end










end







