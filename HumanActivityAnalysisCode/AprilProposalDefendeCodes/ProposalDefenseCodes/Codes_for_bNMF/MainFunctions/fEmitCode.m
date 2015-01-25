function[Code] = fEmitCode(x,y,Case)
% This code determines the code that is emitted when the user walks on a
% particular area.
% The code that is emitted depends on the position of the Center of Gravity
% x, y  - X and Y coordinates of CoG
% Code - Binary code emitted based on the position x,y
% Date : 9 Sep 2013

if(strcmp('FourByFour',Case))
    if(x >= 0 && x < 5 && y >= 0 && y < 5)
        Code = '0101';
    elseif(x >= 5 && x < 10 && y >= 0 && y < 5)
        Code = '1011';
    elseif(x >= 10 && x < 15 && y >= 0 && y < 5)
        Code = '0100';
    elseif(x >= 15 && x <= 20 && y >= 0 && y < 5)
        Code = '1110';
    elseif(x >= 0 && x < 5 && y >= 5 && y < 10)
        Code = '1001';
    elseif(x >= 5 && x < 10 && y >= 5 && y < 10)
        Code = '1000';
    elseif(x >= 10 && x < 15 && y >= 5 && y < 10)
        Code = '0010';
    elseif(x >= 15 && x <= 20 && y >= 5 && y < 10)
        Code = '1010';
    elseif(x >= 0 && x < 5 && y >= 10 && y < 15)
        Code = '1101';
    elseif(x >= 5 && x < 10 && y >= 10 && y < 15)
        Code = '0011';
    elseif(x >= 10 && x < 15 && y >= 10 && y < 15)
        Code = '0000';
    elseif(x >= 15 && x <= 20 && y >= 10 && y < 15)
        Code = '1100';
    elseif(x >= 0 && x < 5 && y >= 15 && y <= 20)
        Code = '0111';
    elseif(x >= 5 && x < 10 && y >= 15 && y <= 20)
        Code = '1111';
    elseif(x >= 10 && x < 15 && y >= 15 && y <= 20)
        Code = '0001';
    elseif(x >= 15 && x <= 20 && y >= 15 && y <= 20)
        Code = '0110';
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









