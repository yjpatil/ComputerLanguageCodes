% Plotting of the Binary Matrix Code %


% figure(111)
% Mat = H(:,1:30);

% figure(122)
% Mat = W;

% figure(133)
% Mat = V(:,1:30);
% 
% [r,c] = size(Mat);                           %# Get the matrix size
% imagesc((1:c)+0.5,(1:r)+0.5,Mat);            %# Plot the image
% colormap(gray);                              %# Use a gray colormap
% axis equal                                   %# Make axes grid sizes equal
% set(gca,'XTick',[],'YTick',[],...  %# Change some axes properties
%         'XLim',[1 c+1],'YLim',[1 r+1],...
%         'GridLineStyle','-','XGrid','on','YGrid','on');


% clc;
% close all;
% 
% % ------ Procedure to Change dimensions of data 3D matrix ------ %
% Data1 = TrSc04;
% [k1,n1,i1] = size(Data1);
% Basis1 = MSc04LV4.W';
% Add = 1;
% for i = 1 : 1 : i1
%     for k = 1 : 1 : k1
%         for n = 1 : 1 : n1
%             %[k,n,i]
%             %Add
%             Data11(i,Add) = Data1(k,n,i);
%             Add = Add + 1;
%         end
%     end
%     Add = 1;
% end
% 
% figure(111)
% Mat = Data11;
% [r,c] = size(Mat);                           %# Get the matrix size
% imagesc((1:c)+0.5,(1:r)+0.5,Mat);            %# Plot the image
% colormap(gray);                              %# Use a gray colormap
% axis equal                                   %# Make axes grid sizes equal
% set(gca,'XTick',[],'YTick',[],...  %# Change some axes properties
%         'XLim',[1 c+1],'YLim',[1 r+1],...
%         'GridLineStyle','-','XGrid','on','YGrid','on');
% 

figure(2)
[r,c] = size(InpMat);                           %# Get the matrix size
imagesc((1:c)+0.5,(1:r)+0.5,Basis1);            %# Plot the image
colormap(gray);                              %# Use a gray colormap
axis equal                                   %# Make axes grid sizes equal
set(gca,'XTick',[],'YTick',[],...  %# Change some axes properties
        'XLim',[1 c+1],'YLim',[1 r+1],...
        'GridLineStyle','-','XGrid','on','YGrid','on');

    
    %     
% % ------ Procedure to Change dimensions of basis vector ------ %
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









% % MSc04LV4.W'
% % Basis
% figure(3)
% for i = 1 : 1 : 4%size(Data,3)
%     Mat = Data(:,:,i);
%     [r,c] = size(Mat);
%     subplot(2,3,i)
%     imagesc((1:c)+0.5,(1:r)+0.5,Mat);
%     colormap(gray);
%     axis equal
%     set(gca,'XTick',[],'YTick',[],...  %# Change some axes properties
%         'XLim',[1 c+1],'YLim',[1 r+1],...
%         'GridLineStyle','-','XGrid','on','YGrid','on');
% end


% figure(4)
% for i = 1 : 1 : size(Basis,3)
%     Mat = Basis(:,:,i);
%     [r,c] = size(Mat);
%     subplot(2,3,i)
%     imagesc((1:c)+0.5,(1:r)+0.5,Mat);
%     colormap(gray);
%     axis equal
%     set(gca,'XTick',[],'YTick',[],...  %# Change some axes properties
%         'XLim',[1 c+1],'YLim',[1 r+1],...
%         'GridLineStyle','-','XGrid','on','YGrid','on');
% end




% figure(4)
% [r,c] = size(Basis);                           %# Get the matrix size
% imagesc((1:c)+0.5,(1:r)+0.5,Basis);            %# Plot the image
% colormap(gray);                              %# Use a gray colormap
% axis equal                                   %# Make axes grid sizes equal
% set(gca,'XTick',1:(c+1),'YTick',1:(r+1),...  %# Change some axes properties
%         'XLim',[1 c+1],'YLim',[1 r+1],...
%         'GridLineStyle','-','XGrid','on','YGrid','on');
    
