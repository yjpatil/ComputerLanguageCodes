%function[Code] = AngleCode(Theta,Parts)
% This code is used to perform Half-Wheel enCoding %
% Theta = the angle that is to be encoded,
% Parts = The number of divisions the Quarter Circle is to be made
%  Code = Output code corresponding to the input angle 'Theta'

% Get the radian equivalent of Pi %
Ninty = pi/2;

% Input your angle choice to infer the corresponding code %
Theta = 284.9523;

% Decide how many parts do you want to divide the Quarter Circle %
Parts = 3;

% Therefore the smallest part (resolution) will be ... 
Res = Ninty/Parts;

% Now divide a circle that gets divided into equal "Parts" parts
for i = 1: 1 : Parts*4 
    Ang(i) = Res*(180/pi)*i;
end
Ang = Ang';

% Now get the part of the division where the angle is from 0 to 90
Index1 = find(0 <= Ang & Ang <= 90);
Temp1 = Ang(Index1);
Temp1 = sort(Temp1,'descend');

Len1 = length(Temp1);

Res_Diff = (Temp1(1)-Temp1(2))/2;

Angle1 = zeros(Len1,4);

cnt = 1;
for i = 1 : 1 : Len1+1
    if(i == Len1+1)
        Angle1(cnt,1) = 0;
        Angle1(cnt,2) = 0 + Res_Diff;
        Angle1(cnt,3) = 0 ;
        Angle1(cnt,4) = cnt;
        %cnt = cnt + 1;
    else
        Angle1(cnt,1) = Temp1(i);
        Angle1(cnt,2) = Temp1(i) + Res_Diff; % Upper Limit in Column 2
        Angle1(cnt,3) = Temp1(i) - Res_Diff; % Upper Limit in Column 3
        Angle1(cnt,4) = cnt;
        cnt = cnt + 1;
    end
end


% Now get the part of the division where the angle is from 360 to 270
Index2 = find(268 <= Ang & Ang <= 360);
Temp2 = Ang(Index2);
Temp2 = sort(Temp2,'descend');

Len2 = length(Temp2);
Angle2 = zeros(Len2,4);
for i = 1 : 1 : Len2
    if(i == 1)
        Angle2(i,1) = 360;
        Angle2(i,2) = 360 ;
        Angle2(i,3) = 360 - Res_Diff;
        Angle2(i,4) = cnt;
        cnt = cnt + 1;
    else
        Angle2(i,1) = Temp2(i);
        Angle2(i,2) = Temp2(i) + Res_Diff;   % Upper Limit in Column 2
        Angle2(i,3) = Temp2(i) - Res_Diff;   % Lower Limit in Column 2
        Angle2(i,4) = cnt;
        cnt = cnt + 1;
    end
end


Ang_Table = cat(1,Angle1,Angle2);

Index = find(Ang_Table(:,3) <= Theta & Theta <= Ang_Table(:,2));

fprintf('\n The code for Angle %3.2f is %d \n',Theta,Ang_Table(Index,4))

%Code = Ang_Table(Index,4);

%end



