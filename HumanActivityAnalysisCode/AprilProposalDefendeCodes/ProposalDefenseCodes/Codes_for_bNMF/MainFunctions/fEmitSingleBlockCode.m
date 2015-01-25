function[Code] = fEmitSingleBlockCode(x,y,LPDCmat)
% This code determines the code that is emitted when the user walks on a
% particular area.
% The code that is emitted depends on the position of the Center of Gravity
% x, y  - X and Y coordinates of CoG
% Code - Binary code emitted based on the position x,y
% Date : 9 Sep 2013

if(x >= 0 && x < 5 && y >= 0 && y < 5)
    Code = LPDCmat(:,13);
elseif(x >= 5 && x < 10 && y >= 0 && y < 5)
    Code = LPDCmat(:,14);
elseif(x >= 10 && x < 15 && y >= 0 && y < 5)
    Code = LPDCmat(:,15);
elseif(x >= 15 && x <= 20 && y >= 0 && y < 5)
    Code = LPDCmat(:,16);
elseif(x >= 0 && x < 5 && y >= 5 && y < 10)
    Code = LPDCmat(:,9);
elseif(x >= 5 && x < 10 && y >= 5 && y < 10)
    Code = LPDCmat(:,10);
elseif(x >= 10 && x < 15 && y >= 5 && y < 10)
    Code = LPDCmat(:,11);
elseif(x >= 15 && x <= 20 && y >= 5 && y < 10)
    Code = LPDCmat(:,12);
elseif(x >= 0 && x < 5 && y >= 10 && y < 15)
    Code = LPDCmat(:,5);
elseif(x >= 5 && x < 10 && y >= 10 && y < 15)
    Code = LPDCmat(:,6);
elseif(x >= 10 && x < 15 && y >= 10 && y < 15)
    Code = LPDCmat(:,7);
elseif(x >= 15 && x <= 20 && y >= 10 && y < 15)
    Code = LPDCmat(:,8);
elseif(x >= 0 && x < 5 && y >= 15 && y <= 20)
    Code = LPDCmat(:,1);
elseif(x >= 5 && x < 10 && y >= 15 && y <= 20)
    Code = LPDCmat(:,2);
elseif(x >= 10 && x < 15 && y >= 15 && y <= 20)
    Code = LPDCmat(:,3);
elseif(x >= 15 && x <= 20 && y >= 15 && y <= 20)
    Code = LPDCmat(:,4);
end






end









