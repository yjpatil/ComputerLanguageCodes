function[pathX,pathY,angle_direct] = fInt_Follow_Traj001(subject_choice)
% This function creates the required trajectory 


if(subject_choice == 1)
    % --------- stage 1 -------- %
    path1x = 2:0.1:10;
    path1y = 2*ones(size(path1x));
    angle_direct1 = 0*ones(size(path1x));
    % --------- stage 2 -------- %
    path2y = 2:0.1:18;
    path2x = 10*ones(size(path2y));
    angle_direct2 = 90*ones(size(path2y)); 
    % --------- stage 3 -------- %
    path3x = 10:0.1:18;
    path3y = 18*ones(size(path3x));
    angle_direct3 = 0*ones(size(path3x));
    % --------- stage 4 -------- %
    path4y = [18:-0.1:2,2*ones(1,20)];
    path4x = 18*ones(size(path4y));
    angle_direct4 = -90*ones(size(path4y)); 
    
    pathX = [path1x,path2x,path3x,path4x];
    pathY = [path1y,path2y,path3y,path4y];
    angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct4];
    

    
elseif(subject_choice == 2)
    % --------- stage 1 -------- %
     
    path1x = 14*ones(size(2:0.1:10));
    path1y = 1*ones(size(path1x));
    angle_direct1 = 180*ones(size(path1x));    
    
    %%angle_direct1 = [angle_direct1,angle_direct1(end)];
    % --------- stage 2.1 -------- %
    path21x = 14:-0.1:10;
    path21y = 1*ones(size(path21x));
    angle_direct21 = 180*ones(size(path21x));
    % path 2.2
    path22y = 3:0.1:18;
    path22x = 9*ones(size(path22y));
    angle_direct22 = 90*ones(size(path22x));    
    
    %for i = 1 : 1 : length(path2x) - 1
        %angle_direct2(i) = atan((path2y(i+1) - path2y(i))/(path2x(i+1) - path2x(i)+eps))/pi*180;
    %end   
    
    % --------- stage 3 -------- %
    path3x = 11:0.1:18;
    path3y = 19*ones(size(path3x));
    angle_direct3 = 0*ones(size(path3x));    
    
    % --------- stage 4 -------- %
    path4y = 18:-0.1:2;
    path4x = 19*ones(size(path4y));
    angle_direct4 = -90*ones(size(path4y));            
    
    pathX = [path1x,path21x,path22x,path3x,path4x];
    pathY = [path1y,path21y,path22y,path3y,path4y];
    angle_direct = [angle_direct1,angle_direct21,angle_direct22,angle_direct3,angle_direct4];
    
elseif(subject_choice == 3)
    % --------- stage 1 -------- %
     
    path1x = 14*ones(size(2:0.1:10));
    path1y = 3*ones(size(path1x));
    angle_direct1 = -90*ones(size(path1x));
    % --------- stage 2.1 -------- %
    path21x = 14:-0.1:10;
    path21y = 3*ones(size(path21x));
    angle_direct21 = 180*ones(size(path21x));
    % path 2.2
    path22y = 3:0.1:18;
    path22x = 11*ones(size(path22y));
    angle_direct22 = 90*ones(size(path22x));
    
    % --------- stage 3 -------- %
    path3x = 11:0.1:18;
    path3y = 17*ones(size(path3x));
    angle_direct3 = 0*ones(size(path3x));  
    % --------- stage 4 -------- %
    path4y = 18:-0.1:2;
    path4x = 17*ones(size(path4y));
    angle_direct4 = -90*ones(size(path4y)); 
    
    pathX = [path1x,path21x,path22x,path3x,path4x];
    pathY = [path1y,path21y,path22y,path3y,path4y];
    angle_direct = [angle_direct1,angle_direct21,angle_direct22,angle_direct3,angle_direct4];
    
else


end










end







