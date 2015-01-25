function[Code] = fGenCodeMat(Size)
% This function intakes "Size" which determines the # of blocks
% Output:: Code Matrix that contains codes for each block


if(Size(1)==4 & Size(2)==4)
    Code(1,:) = [1,0,1,1,0,0,0,1,0,1];
    Code(2,:) = [1,0,0,1,0,0,0,0,0,1];
    Code(3,:) = [1,0,0,0,1,0,0,0,0,1];
    Code(4,:) = [1,0,1,0,1,0,0,0,0,1];
















