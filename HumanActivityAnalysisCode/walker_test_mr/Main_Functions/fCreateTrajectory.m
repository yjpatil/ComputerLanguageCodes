function[pathX,pathY,angle_direct] = fCreateTrajectory
% This function creates the required trajectory 

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

pathX = [path1x path2x path3x path4x];
pathY = [path1y path2y path3y path4y];
angle_direct = [angle_direct1,angle_direct2,angle_direct3,angle_direct4];

pathX = [pathX pathX];
pathY = [pathY pathY];
angle_direct = [angle_direct angle_direct];



end












