function[pathX,pathY,angle_direct] = fCreateInteractionsTraj001(subject_choice)
% This function creates the required trajectory 


if(subject_choice == 1)
    % --------- stage 1 -------- %
    path1y = 2:0.1:10;
    path1x = 18*ones(size(path1y));
    angle_direct1 = 90*ones(size(path1x));
    % --------- stage 2 -------- %
    path2x = 18:-0.1:11;
    path2y = 10*ones(size(path2x));
    angle_direct2 = 180*ones(size(path2y));
    % --------- stage 3 -------- %
    path3x = 11*ones(1,50);
    path3y = 10*ones(1,50);
    angle_direct3 = 180*ones(size(path3x));
    % --------- stage 4 -------- %
    path4x = 11:0.1:18;
    path4y = 10*ones(size(path4x));
    angle_direct4 = 0*ones(size(path4x));
    % --------- stage 5 -------- %
    path5y = 10:-0.1:2;
    path5x = 18*ones(size(path5y));
    angle_direct5 = -90*ones(size(path5x));
    
    pathX = [path1x,path2x,path3x,path3x];%%path4x,path5x,path5x(end)];
    pathY = [path1y,path2y,path3y,path3y];%%path4y,path5y,path5y(end)];
    angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct3];%%angle_direct4,angle_direct5,90];
    
% %     pathX = [path1x path2x path3x path4x];
% %     pathY = [path1y path2y path3y path4y];
% %     angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct4];
    
%     pathX = [pathX pathX];
%     pathY = [pathY pathY];
    angle_direct = [angle_direct angle_direct];
elseif(subject_choice == 2)
    % --------- stage 1 -------- %
    path1y = 3:0.1:9;
    path1x = 9*ones(size(path1y));
    angle_direct1 = 90*ones(size(path1x));
    % --------- stage 2 -------- %
    path2x = 9*ones(1,50);
    path2y = 9*ones(1,50);
    angle_direct2 = 90*ones(size(path2x));
    
    pathX = [path1x,path2x,path2x];
    pathY = [path1y,path2y,path2y];
    angle_direct = [angle_direct1,angle_direct2,angle_direct2];
elseif(subject_choice == 3)
    % --------- stage 1 -------- %
    path1x = 2:0.1:9;
    path1y = 18:-0.1:11;
    
    for i = 1 : 1 : length(path1x) - 1
        angle_direct1(i) = atan((path1y(i+1) - path1y(i))/(path1x(i+1) - path1x(i)+eps))/pi*180;
    end
    angle_direct1 = [angle_direct1,angle_direct1(end)];
    
    path2x = 9*ones(1,50);
    path2y = 11*ones(1,50);
    angle_direct2 = -45*ones(size(path2x));
    
    
    pathX = [path1x,path2x,path2x];
    pathY = [path1y,path2y,path2y];
    angle_direct = [angle_direct1,angle_direct2,angle_direct2];
else


end










end







