function[Plt] = fPltNMF(Mat,choice);

% ---- Plotting of the Binary Matrix Code for binary NMF ----- %
% Plot, B&W ==> 1 and COLOR ==> 2

% % figure(111)
% % Mat = H(:,1:30);

% % figure(122)
% % Mat = W;

% % figure(133)
% % Mat = V(:,1:30);

%if(choice == 1)
    [r,c] = size(Mat);                           %# Get the matrix size
    imagesc((1:c)+0.5,(1:r)+0.5,Mat);            %# Plot the image
    colormap(gray);                              %# Use a gray colormap
    %%caxis([-7.2 7])
    axis equal                                   %# Make axes grid sizes equal
    set(gca,'XTick',[],'YTick',[],...  %# Change some axes properties
        'XLim',[1 c+1],'YLim',[1 r+1],...
        'GridLineStyle','-','XGrid','on','YGrid','on');
%elseif(choice == 2)
%     [r,c] = size(Mat);                           %# Get the matrix size
%     imagesc((1:c)+0.5,(1:r)+0.5,Mat);            %# Plot the image
%     colormap(color);                              %# Use a colormap
%     axis equal                                   %# Make axes grid sizes equal
%     set(gca,'XTick',[],'YTick',[],...  %# Change some axes properties
%         'XLim',[1 c+1],'YLim',[1 r+1],...
%         'GridLineStyle','-','XGrid','on','YGrid','on');
%end
 Plt = 1;
    
end