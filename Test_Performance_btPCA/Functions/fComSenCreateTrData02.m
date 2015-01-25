function[CSTr0101,CSTr0102,CSTr0103,CSTr0201,CSTr0301] = fComSenCreateTrData02(LDPC,Tr0101,Tr0102,Tr0103,Tr0201,Tr0301)
% This function creates different scenario train-data %


[h,w,l]=size(Tr0101);
for i = 1 : 1 : l
    TempMat = Tr0101(:,:,i);   
    CSTr0101(:,1,i) = mod(LDPC*TempMat,2);
end

[h,w,l]=size(Tr0102);
for i = 1 : 1 : l
    TempMat = Tr0102(:,:,i);   
    CSTr0102(:,1,i) = mod(LDPC*TempMat,2);
end

[h,w,l]=size(Tr0103);
for i = 1 : 1 : l
    TempMat = Tr0103(:,:,i);   
    CSTr0103(:,1,i) = mod(LDPC*TempMat,2);
end

[h,w,l]=size(Tr0201);
for i = 1 : 1 : l
    TempMat = Tr0201(:,:,i);   
    CSTr0201(:,1,i) = mod(LDPC*TempMat,2);
end

[h,w,l]=size(Tr0301);
for i = 1 : 1 : l
    TempMat = Tr0301(:,:,i);   
    CSTr0301(:,1,i) = mod(LDPC*TempMat,2);
end

end