function[CSTr01,CSTr02,CSTr03,CSTr0302] = fComSenCreateTrData01(LDPC,Tr01,Tr02,Tr03,Tr0302)
% This function creates different scenario train-data %


[h,w,l]=size(Tr01);
for i = 1 : 1 : l
    TempMat = Tr01(:,:,i);   
    CSTr01(:,1,i) = mod(LDPC*TempMat,2);
end

[h,w,l]=size(Tr02);
for i = 1 : 1 : l
    TempMat = Tr02(:,:,i);   
    CSTr02(:,1,i) = mod(LDPC*TempMat,2);
end

[h,w,l]=size(Tr03);
for i = 1 : 1 : l
    TempMat = Tr03(:,:,i);   
    CSTr03(:,1,i) = mod(LDPC*TempMat,2);
end

[h,w,l]=size(Tr0302);
for i = 1 : 1 : l
    TempMat = Tr0302(:,:,i);   
    CSTr0302(:,1,i) = mod(LDPC*TempMat,2);
end

end