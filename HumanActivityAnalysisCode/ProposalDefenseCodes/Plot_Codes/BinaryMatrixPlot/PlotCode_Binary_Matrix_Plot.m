% Plotting of the Binary Matrix Code %

% Mat = TrSc01(:,:,2);%Mat = MSc01LV4.W';
% %Mat = TrSc02(:,:,7);%Mat = MSc01LV4.W';
% [r,c] = size(Mat);                           %# Get the matrix size
% imagesc((1:c)+0.5,(1:r)+0.5,Mat);            %# Plot the image
% colormap(gray);                              %# Use a gray colormap
% axis equal                                   %# Make axes grid sizes equal
% set(gca,'XTick',1:(c+1),'YTick',1:(r+1),...  %# Change some axes properties
%         'XLim',[1 c+1],'YLim',[1 r+1],...
%         'GridLineStyle','-','XGrid','on','YGrid','on');


close all;
Data = TrSc04;
figure(1)
for i = 1 : 1 : 6%size(Data,3)
    Mat = Data(:,:,i);
    [r,c] = size(Mat);
    subplot(2,3,i)
    imagesc((1:c)+0.5,(1:r)+0.5,Mat);
    colormap(gray);
    axis equal
    set(gca,'XTick',1:(c+1),'YTick',1:(r+1),...  %# Change some axes properties
        'XLim',[1 c+1],'YLim',[1 r+1],...
        'GridLineStyle','-','XGrid','on','YGrid','on');
end

figure(2)
Basis = MSc04LV4.W';
[r,c] = size(Basis);                           %# Get the matrix size
imagesc((1:c)+0.5,(1:r)+0.5,Basis);            %# Plot the image
colormap(gray);                              %# Use a gray colormap
axis equal                                   %# Make axes grid sizes equal
set(gca,'XTick',1:(c+1),'YTick',1:(r+1),...  %# Change some axes properties
        'XLim',[1 c+1],'YLim',[1 r+1],...
        'GridLineStyle','-','XGrid','on','YGrid','on');