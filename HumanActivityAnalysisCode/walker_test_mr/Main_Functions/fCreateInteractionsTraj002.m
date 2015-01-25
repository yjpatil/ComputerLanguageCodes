function[pathX,pathY,angle_direct] = fCreateInteractionsTraj002(subject_choice)
% This function creates the required trajectory 


if(subject_choice == 1)
    % --------- stage 1 -------- %
    path1x = 18:-0.1:3;
    path1y = 2*ones(size(path1x));
    angle_direct1 = 180*ones(size(path1x));
    % --------- stage 2 -------- %
    path2x = 3*ones(1,20);
    path2y = 3*ones(size(path2x));
    angle_direct2 = 180*ones(size(path2y));    
    
    pathX = [path1x,path2x,path2x];
    pathY = [path1y,path2y,path2y];
    angle_direct = [angle_direct1,angle_direct2,angle_direct2];
    

    
elseif(subject_choice == 2)
    % --------- stage 1 -------- %
    path1y = 2:0.1:10;
    path1x = 10*ones(size(path1y));
    angle_direct1 = 90*ones(size(path1x));
    
    
    %%angle_direct1 = [angle_direct1,angle_direct1(end)];
    % --------- stage 2 -------- %
    path2x = 10:-0.1:2;
    path2y = 10:-0.1:2;
    
    for i = 1 : 1 : length(path2x) - 1
        angle_direct2(i) = atan((path2y(i+1) - path2y(i))/(path2x(i+1) - path2x(i)+eps))/pi*180;
    end   
    
    pathX = [path1x,path2x,path2x(end)];
    pathY = [path1y,path2y,path2y(end)];
    angle_direct = [angle_direct1,angle_direct2,225];
    
elseif(subject_choice == 3)
    % --------- stage 1 -------- %
    path1y = 18:-0.1:2;
    path1x = 2*ones(size(path1y));
    angle_direct1 = -90*ones(size(path1x));
    % --------- stage 2 -------- %
    path2x = 2*ones(1,20);
    path2y = 2*ones(1,20);
    angle_direct2 = 135*ones(size(path2x));
    
    pathX = [path1x,path2x,path2x];
    pathY = [path1y,path2y,path2y];
    angle_direct = [angle_direct1,angle_direct2,angle_direct2];
    
else


end










end







