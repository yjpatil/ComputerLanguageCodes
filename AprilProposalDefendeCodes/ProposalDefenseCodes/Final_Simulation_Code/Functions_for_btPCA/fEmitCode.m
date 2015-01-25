function[Code] = fEmitCode(x,y,Case)
% This code determines the code that is emitted when the user walks on a
% particular area.
% The code that is emitted depends on the position of the Center of Gravity
% x, y  - X and Y coordinates of CoG
% Code - Binary code emitted based on the position x,y
% Date : 9 Sep 2013

if(strcmp('FourByFour',Case))
    if(x >= 0 && x < 5 && y >= 0 && y < 5)
        Code = '1,0,1,0,0,0,0,0,0,0';
    elseif(x >= 5 && x < 10 && y >= 0 && y < 5)
        Code = '0,0,1,0,1,0,0,0,0,0';
    elseif(x >= 10 && x < 15 && y >= 0 && y < 5)
        Code = '1,0,0,0,0,0,0,0,0,0';
    elseif(x >= 15 && x <= 20 && y >= 0 && y < 5)
        Code = '0,0,1,0,0,0,0,0,0,0';
    elseif(x >= 0 && x < 5 && y >= 5 && y < 10)
        Code = '0,1,0,1,0,0,0,0,0,0';
    elseif(x >= 5 && x < 10 && y >= 5 && y < 10)
        Code = '0,0,0,1,0,1,0,0,0,0';
    elseif(x >= 10 && x < 15 && y >= 5 && y < 10)
        Code = '0,1,0,0,0,0,0,0,0,0';
    elseif(x >= 15 && x <= 20 && y >= 5 && y < 10)
        Code = '0,0,0,1,0,0,0,0,0,0';
    elseif(x >= 0 && x < 5 && y >= 10 && y < 15)
        Code = '0,0,0,0,0,0,0,1,1,1';
    elseif(x >= 5 && x < 10 && y >= 10 && y < 15)
        Code = '0,0,0,0,0,0,1,1,1,0';
    elseif(x >= 10 && x < 15 && y >= 10 && y < 15)
        Code = '1,1,1,1,0,0,0,0,0,0';
    elseif(x >= 15 && x <= 20 && y >= 10 && y < 15)
        Code = '0,1,1,1,1,0,0,0,0,0';
    elseif(x >= 0 && x < 5 && y >= 15 && y <= 20)
        Code = '0,0,0,0,0,1,1,1,0,0';
    elseif(x >= 5 && x < 10 && y >= 15 && y <= 20)
        Code = '0,0,0,0,1,1,1,0,0,0';
    elseif(x >= 10 && x < 15 && y >= 15 && y <= 20)
        Code = '0,0,1,1,1,1,0,0,0,0';
    elseif(x >= 15 && x <= 20 && y >= 15 && y <= 20)
        Code = '0,0,0,1,1,1,1,0,0,0';
    end
elseif(strcmp('TwoByTwo',Case))
    if(x >= 0 && x < 5 && y >= 0 && y < 5)
        Code = '1001';
    elseif(x >= 5 && x <= 10 && y >= 0 && y < 5)
        Code = '1010';
    elseif(x >= 0 && x < 5 && y >= 5 && y <= 10)
        Code = '1000';
    elseif(x >= 5 && x <= 10 && y >= 5 && y <= 10)
        Code = '1101';
    end
end







end









