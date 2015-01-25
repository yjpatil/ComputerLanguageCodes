function[New3DMat] = fReshapingMats(Orig3DMat)
% The goal of this function is to convert a 3D matrix into 
% a new 3D matrix with each element having A single column 
[h,w,l]=size(Orig3DMat);
for i = 1 : 1 : l
    TempMat = Orig3DMat(:,:,i);
    TempMat = reshape(TempMat,h*w,1);    
    New3DMat(:,1,i) = TempMat; % a single column in each element
end