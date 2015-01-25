function[Plt] = fPltNMF(Mat);

% ---- Plotting of the Binary Matrix Code for binary NMF ----- %


% % figure(111)
% % Mat = H(:,1:30);

% % figure(122)
% % Mat = W;

% % figure(133)
% % Mat = V(:,1:30);

[r,c] = size(Mat);                           %# Get the matrix size
imagesc((1:c)+0.5,(1:r)+0.5,Mat);            %# Plot the image
colormap(gray);                              %# Use a gray colormap
axis equal                                   %# Make axes grid sizes equal
set(gca,'XTick',[],'YTick',[],...  %# Change some axes properties
        'XLim',[1 c+1],'YLim',[1 r+1],...
        'GridLineStyle','-','XGrid','on','YGrid','on');
    

 Plt = 1;
    
end