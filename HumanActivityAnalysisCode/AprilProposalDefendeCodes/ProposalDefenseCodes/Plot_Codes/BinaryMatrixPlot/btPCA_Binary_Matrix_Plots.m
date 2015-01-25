% % clc;
% % close all;

%%% ------ Procedure to Change dimensions of data 3D matrix ------ %
% Plot the input data which is a 3D matrix %
Data1 = TrSc02;
[k1,n1,i1] = size(Data1);
%Basis1 = MSc04LV1.W';
Add = 1;
for i = 1 : 1 : i1
    for k = 1 : 1 : k1
        for n = 1 : 1 : n1
            %[k,n,i]
            %Add
            Data11(i,Add) = Data1(k,n,i);
            Add = Add + 1;
        end
    end
    Add = 1;
end

% Plot restructured input matrix
figure(111)
Mat = Data11;
[r,c] = size(Mat);                           %# Get the matrix size
imagesc((1:c)+0.5,(1:r)+0.5,Mat);            %# Plot the image
colormap(gray);                              %# Use a gray colormap
axis equal                                   %# Make axes grid sizes equal
set(gca,'XTick',[],'YTick',[],...  %# Change some axes properties
        'XLim',[1 c+1],'YLim',[1 r+1],...
        'GridLineStyle','-','XGrid','on','YGrid','on');

figure(2222)
Basis1 = MSc01LV8.W';
[r,c] = size(Basis1);                           %# Get the matrix size
imagesc((1:c)+0.5,(1:r)+0.5,Basis1);            %# Plot the image
colormap(gray);                              %# Use a gray colormap
axis equal                                   %# Make axes grid sizes equal
set(gca,'XTick',[],'YTick',[],...  %# Change some axes properties
        'XLim',[1 c+1],'YLim',[1 r+1],...
        'GridLineStyle','-','XGrid','on','YGrid','on');
    
%%% ------ Procedure to Change dimensions of basis vector ------ %
% Data = TrSc04;
% [k1,n1,i1] = size(Data);
% Basis1 = MSc04LV4.W';
% Add = 1;
% for i = 1 : 1 : size(Basis1,1)
%     for k = 1 : 1 : k1  % 4
%         for j = 1 : 1 : n1 % 10
%         Basis(k,j,i) = Basis1(i,Add);
%         Add = Add + 1;
%         end
%     end
%     Add = 1;
% end


