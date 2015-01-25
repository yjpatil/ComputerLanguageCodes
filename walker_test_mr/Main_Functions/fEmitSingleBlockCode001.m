function[Code,Loc] = fEmitSingleBlockCode001(x,y,LPDCmat)
% This code determines the code that is emitted when the user walks on a
% particular area.
% The code that is emitted depends on the position of the Center of Gravity
% x, y  - X and Y coordinates of CoG
% Code - Binary code emitted based on the position x,y
% Date : 08 May 2014

if(y >= 0 && y < 4 && x >= 0 && x < 4)
    Code = LPDCmat(:,1);
    Loc = 1;
elseif(y >= 4 && y < 8 && x >= 0 && x < 4)
    Code = LPDCmat(:,2);
    Loc = 2;
elseif(y >= 8 && y < 12 && x >= 0 && x < 4)
    Code = LPDCmat(:,3);
    Loc = 3;
elseif(y >= 12 && y < 16 && x >= 0 && x < 4)
    Code = LPDCmat(:,4);
    Loc = 4;
elseif(y >= 16 && y <= 20 && x >= 0 && x < 4)
    Code = LPDCmat(:,5);
    Loc = 5;
    % -------------------------------------------- %
elseif(y >= 0 && y < 4 && x >= 4 && x < 8)
    Code = LPDCmat(:,6);
    Loc = 6;
elseif(y >= 4 && y < 8 && x >= 4 && x < 8)
    Code = LPDCmat(:,7);
    Loc = 7;
elseif(y >= 8 && y < 12 && x >= 4 && x < 8)
    Code = LPDCmat(:,8);
    Loc = 8;
elseif(y >= 12 && y < 16 && x >= 4 && x < 8)
    Code = LPDCmat(:,9);
    Loc = 9;
elseif(y >= 16 && y <= 20 && x >= 4 && x < 8)
    Code = LPDCmat(:,10);
    Loc = 10;
    % -------------------------------------------- %
elseif(y >= 0 && y < 4 && x >= 8 && x < 12)
    Code = LPDCmat(:,11);
    Loc = 11;
elseif(y >= 4 && y < 8 && x >= 8 && x < 12)
    Code = LPDCmat(:,12);
    Loc = 12;
elseif(y >= 8 && y < 12 && x >= 8 && x < 12)
    Code = LPDCmat(:,13);
    Loc = 13;
elseif(y >= 12 && y < 16 && x >= 8 && x < 12)
    Code = LPDCmat(:,14);
    Loc = 14;
elseif(y >= 16 && y <= 20 && x >= 8 && x < 12)
    Code = LPDCmat(:,15);
    Loc = 15;
    % -------------------------------------------- %
elseif(y >= 0 && y < 4 && x >= 12 && x < 16)
    Code = LPDCmat(:,16);
    Loc = 16;
elseif(y >= 4 && y < 8 && x >= 12 && x < 16)
    Code = LPDCmat(:,17);
    Loc = 17;
elseif(y >= 8 && y < 12 && x >= 12 && x < 16)
    Code = LPDCmat(:,18);
    Loc = 18;
elseif(y >= 12 && y < 16 && x >= 12 && x < 16)
    Code = LPDCmat(:,19);
    Loc = 19;
elseif(y >= 16 && y <= 20 && x >= 12 && x < 16)
    Code = LPDCmat(:,20);
    Loc = 20;
    % -------------------------------------------- %
    elseif(y >= 0 && y < 4 && x >= 16 && x < 20)
    Code = LPDCmat(:,21);
    Loc = 21;
elseif(y >= 4 && y < 8 && x >= 16 && x <= 20)
    Code = LPDCmat(:,22);
    Loc = 22;
elseif(y >= 8 && y < 12 && x >= 16 && x <= 20)
    Code = LPDCmat(:,23);
    Loc = 23;
elseif(y >= 12 && y < 16 && x >= 16 && x <= 20)
    Code = LPDCmat(:,24);
    Loc = 24;
elseif(y >= 16 && y <= 20 && x >= 16 && x <= 20)
    Code = LPDCmat(:,25);
    Loc = 25;
    % -------------------------------------------- %
end






end









