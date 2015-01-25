function[pathX,pathY,angle_direct] = fInt_Disp_Traj003(subject_choice)
% This function creates the required trajectory 


if(subject_choice == 1)
    % --------- stage 1 -------- %
    path1x = 18:-0.1:15;
    path1y = 2*ones(size(path1x));
    angle_direct1 = 180*ones(size(path1x));
    % --------- stage 2 -------- %
    path2y = 2:0.1:19;
    path2x = 15*ones(size(path2y));
    angle_direct2 = 90*ones(size(path2y));
    % --------- stage 3 -------- %
    path3x = 15:-0.1:1;
    path3y = 19*ones(size(path3x));
    angle_direct3 = 180*ones(size(path3y));
    % --------- stage 4 -------- %
    path4x = 1*ones(1,20);
    path4y = 19*ones(size(path4x));
    angle_direct4 = 0*ones(size(path4y));
    % --------- stage 5 -------- %
    path5x = 1:0.1:19;
    path5y = 19*ones(size(path5x));
    angle_direct5 = 0*ones(size(path5y));
    
    pathX = [path1x,path2x,path3x,path4x,path5x];
    pathY = [path1y,path2y,path3y,path4y,path5y];
    angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct4,angle_direct5];    
    
elseif(subject_choice == 2)
    % --------- stage 1 -------- %
    path1x = 10:0.1:13;
    path1y = 2*ones(size(path1x));
    angle_direct1 = 0*ones(size(path1x));       
    % --------- stage 2 -------- %
    path2y = 2:0.1:18;
    path2x = 13*ones(size(path2y));
    angle_direct2 = 90*ones(size(path2y));
    % --------- stage 3 -------- %
    path3x = 13:-0.1:2;
    path3y = 18*ones(size(path3x));
    angle_direct3 = 180*ones(size(path3y));
    % --------- stage 4 -------- %
    path4x = 2*ones(1,60);
    path4y = 18*ones(size(path4x));
    angle_direct4 = 180*ones(size(path4y));
    % --------- stage 5 -------- %
    path5x = 2:0.1:9;
    path5y = 18:-0.1:11;
    
    for i = 1 : 1 : length(path5x) - 1
        angle_direct5(i) = atan((path5y(i+1) - path5y(i))/(path5x(i+1) - path5x(i)+eps))/pi*180;
    end
    angle_direct5 = [angle_direct5,angle_direct5(end)];
    
    pathX = [path1x,path2x,path3x,path4x,path5x];
    pathY = [path1y,path2y,path3y,path4y,path5y];
    angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct4,angle_direct5];
    
elseif(subject_choice == 3)
    % --------- stage 1 -------- %
    path1y = 18:-0.1:2;
    path1x = 2*ones(size(path1y));
    angle_direct1 = -90*ones(size(path1x));
    % --------- stage 2 -------- %
    path2y = 2:0.1:17;
    path2x = 2*ones(size(path2y));
    angle_direct2 = 90*ones(size(path2x));
    % --------- stage 3 -------- %
    path3x = 2*ones(1,60);
    path3y = 17*ones(size(path3x));
    angle_direct3 = 90*ones(size(path3y));
    
    % --------- stage 4 -------- %
    path4y = 17:-0.1:11;
    path4x = 2*ones(size(path4y));
    angle_direct4 = -90*ones(size(path4x));
    
    pathX = [path1x,path2x,path3x,path4x];
    pathY = [path1y,path2y,path3y,path4y];
    angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct4];
    
else


end










end







