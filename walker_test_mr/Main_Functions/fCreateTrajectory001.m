function[pathX,pathY,angle_direct] = fCreateTrajectory001(subject_choice)
% This function creates the required trajectory 


if(subject_choice == 1)
    % --------- stage 1 -------- %
    path1x = 14:-0.1:3;
    path1y = 3*ones(size(path1x));
    angle_direct1 = 180*ones(size(path1x));
    % --------- stage 2 -------- %
    path2y = 3:0.1:19;
    path2x = 3*ones(size(path2y));
    angle_direct2 = 90*ones(size(path2y));
    % --------- stage 3 -------- %
    path3x = 3:0.1:17;
    path3y = 19*ones(size(path3x));
    angle_direct3 = zeros(size(path3x));
    % --------- stage 4 -------- %
    path4y = 19:-0.1:3;
    path4x = 17*ones(size(path4y));
    angle_direct4 = -90*ones(size(path4y));
    
    pathX = [path1x path2x path3x];
    pathY = [path1y path2y path3y];
    angle_direct = [angle_direct1,angle_direct2,angle_direct3];
    
% %     pathX = [path1x path2x path3x path4x];
% %     pathY = [path1y path2y path3y path4y];
% %     angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct4];
    
%     pathX = [pathX pathX];
%     pathY = [pathY pathY];
    angle_direct = [angle_direct angle_direct];
elseif(subject_choice == 2)
    % --------- stage 1 -------- %
    path1y = 3:0.1:19;
    path1x = 9*ones(size(path1y));
    angle_direct1 = 90*ones(size(path1x));
    % --------- stage 2 -------- %
    path2y = 19:-0.1:3;
    path2x = 9*ones(size(path2y));
    angle_direct2 = -90*ones(size(path2y));
    
    pathX = [path1x path2x];
    pathY = [path1y path2y];
    angle_direct = [angle_direct1,angle_direct2];
elseif(subject_choice == 3)
    % --------- stage 1 -------- %
    path1x = 2:0.1:18;
    path1y = 18:-0.1:2;
    
    for i = 1 : 1 : length(path1x) - 1
        angle_direct1(i) = atan((path1y(i+1) - path1y(i))/(path1x(i+1) - path1x(i)+eps))/pi*180;
    end   
    
    angle_direct1 = [angle_direct1,angle_direct1(end)];
    pathX = path1x;
    pathY = path1y;
    angle_direct = angle_direct1;
else


end










end







