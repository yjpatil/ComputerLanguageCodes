% Aim :: This code allows to evaluate the performance of the btPCA
% algorithm %
% Date : 10 Jan, 2015

clc;clear all;close all;


% Variables %

AreaMat = zeros(8,8);


% 
% 
% Sc0102sample01 = AreaMat;
% Sc0102sample02 = AreaMat;
% Sc0102sample03 = AreaMat;
% Sc0102sample04 = AreaMat;
% Sc0102sample05 = AreaMat;
% Sc0102sample06 = AreaMat;
% Sc0102sample07 = AreaMat;
% Sc0102sample08 = AreaMat;
% Sc0102sample09 = AreaMat;
% Sc0102sample10 = AreaMat;
% Sc0102sample11 = AreaMat;
% Sc0102sample12 = AreaMat;
% Sc0102sample13 = AreaMat;
% Sc0102sample14 = AreaMat;
% Sc01sample15 = AreaMat;
% Sc01sample16 = AreaMat;
% Sc01sample17 = AreaMat;
% Sc01sample18 = AreaMat;

% Plot the Binary Matrices

% Plot restructured input matrix
figure(111)
Mat = Tr0202(:,:,7);
[r,c] = size(Mat);                           %# Get the matrix size
imagesc((1:c)+0.5,(1:r)+0.5,Mat);            %# Plot the image
colormap(gray);                              %# Use a gray colormap
axis equal                                   %# Make axes grid sizes equal
set(gca,'XTick',[],'YTick',[],...  %# Change some axes properties
        'XLim',[1 c+1],'YLim',[1 r+1],...
        'GridLineStyle','-','XGrid','on','YGrid','on');
% Now create the 3D data set Matrix
%  Tr0101(:,:,1) = Sc0102sample01;Tr0101(:,:,2) = Sc0102sample02;
% Tr0101(:,:,3) = Sc0102sample03;Tr0101(:,:,4) = Sc0102sample04;
% Tr0101(:,:,5) = Sc0102sample05;Tr0101(:,:,6) = Sc0102sample06;
% Tr0101(:,:,7) = Sc0102sample07;Tr0101(:,:,8) = Sc0102sample08;
% Tr0101(:,:,9) = Sc0102sample09;Tr0101(:,:,10) = Sc0102sample10;
% Tr0101(:,:,11) = Sc0102sample11;Tr0101(:,:,12) = Sc0102sample12;
% Tr0101(:,:,13) = Sc0102sample13;Tr0101(:,:,14) = Sc0102sample14;
% Tr0101(:,:,15) = Sc01sample15;Tr0101(:,:,16) = Sc01sample16;
% Tr0101(:,:,17) = Sc01sample17;Tr0101(:,:,18) = Sc01sample18;   
    
% Data set for watching TV %
% % 
% % Sc02sample01 = AreaMat;
% % Sc02sample02 = AreaMat;
% % Sc02sample03 = AreaMat;
% % Sc02sample04 = AreaMat;
% % Sc02sample05 = AreaMat;
% % Sc02sample06 = AreaMat;
% % Sc02sample07 = AreaMat;
% % Sc02sample08 = AreaMat;
% % Sc02sample09 = AreaMat;
% % Sc02sample10 = AreaMat;
% % Sc02sample11 = AreaMat;
% % Sc02sample12 = AreaMat;
% % Sc02sample13 = AreaMat;
% % Sc02sample14 = AreaMat;
% % Sc02sample15 = AreaMat;
% % Sc02sample16 = AreaMat;
% % Sc02sample17 = AreaMat;
% % Sc02sample18 = AreaMat;
% % % Now create the 3D data set Matrix
% %  Tr02(:,:,1) = Sc02sample01;Tr02(:,:,2) = Sc02sample02;
% % Tr02(:,:,3) = Sc02sample03;Tr02(:,:,4) = Sc02sample04;
% % Tr02(:,:,5) = Sc02sample05;Tr02(:,:,6) = Sc02sample06;
% % Tr02(:,:,7) = Sc02sample07;Tr02(:,:,8) = Sc02sample08;
% % Tr02(:,:,9) = Sc02sample09;Tr02(:,:,10) = Sc02sample10;
% % Tr02(:,:,11) = Sc02sample11;Tr02(:,:,12) = Sc02sample12;
% % Tr02(:,:,13) = Sc02sample13;Tr02(:,:,14) = Sc02sample14;
% % Tr02(:,:,15) = Sc02sample15;Tr02(:,:,16) = Sc02sample16;
% % Tr02(:,:,17) = Sc02sample17;Tr02(:,:,18) = Sc02sample18;   

% Data set for Giving Presentation %
% 
% Sc0102sample01 = AreaMat;
% Sc0102sample02 = AreaMat;
% Sc0102sample03 = AreaMat;
% Sc0102sample04 = AreaMat;
% Sc0102sample05 = AreaMat;
% Sc0102sample06 = AreaMat;
% Sc0102sample07 = AreaMat;
% Sc0102sample08 = AreaMat;
% Sc0102sample09 = AreaMat;
% Sc0102sample10 = AreaMat;
% Sc0102sample11 = AreaMat;
% Sc0102sample12 = AreaMat;
% Sc0102sample13 = AreaMat;
% Sc0102sample14 = AreaMat;
% Sc0102sample15 = AreaMat;
% Sc0102sample16 = AreaMat;
% Sc0102sample17 = AreaMat;
% Sc0102sample18 = AreaMat;
% Now create the 3D data set Matrix
%  Tr0102(:,:,1) = Sc0102sample01;Tr0102(:,:,2) = Sc0102sample02;
% Tr0102(:,:,3) = Sc0102sample03;Tr0102(:,:,4) = Sc0102sample04;
% Tr0102(:,:,5) = Sc0102sample05;Tr0102(:,:,6) = Sc03sample06;
% Tr0102(:,:,7) = Sc0102sample07;Tr0102(:,:,8) = Sc0102sample08;
% Tr0102(:,:,9) = Sc0102sample09;Tr0102(:,:,10) = Sc0102sample10;
% Tr0102(:,:,11) = Sc0102sample11;Tr0102(:,:,12) = Sc0102sample12;
% Tr0102(:,:,13) = Sc0102sample13;Tr0102(:,:,14) = Sc0102sample14;
% Tr0102(:,:,15) = Sc0102sample15;Tr0102(:,:,16) = Sc0102sample16;
% Tr0102(:,:,17) = Sc0102sample17;Tr0102(:,:,18) = Sc0102sample18;   


% Sc0102sample01 = AreaMat;
% Sc0102sample02 = AreaMat;
% Sc0102sample03 = AreaMat;
% Sc0102sample04 = AreaMat;
% Sc0102sample05 = AreaMat;
% Sc0102sample06 = AreaMat;
% Sc0102sample07 = AreaMat;
% Sc0102sample08 = AreaMat;
% Sc0102sample09 = AreaMat;
% Sc0102sample10 = AreaMat;
% Sc0102sample11 = AreaMat;
% Sc0102sample12 = AreaMat;
% Sc0102sample13 = AreaMat;
% Sc0102sample14 = AreaMat;
% Sc0102sample15 = AreaMat;
% Sc0102sample16 = AreaMat;
% Sc0102sample17 = AreaMat;
% Sc0102sample18 = AreaMat;
% % Now create the 3D data set Matrix
%  Tr0102(:,:,1) = Sc0102sample01;Tr0102(:,:,2) = Sc0102sample02;
% Tr0102(:,:,3) = Sc0102sample03;Tr0102(:,:,4) = Sc0102sample04;
% Tr0102(:,:,5) = Sc0102sample05;Tr0102(:,:,6) = Sc0102sample06;
% Tr0102(:,:,7) = Sc0102sample07;Tr0102(:,:,8) = Sc0102sample08;
% Tr0102(:,:,9) = Sc0102sample09;Tr0102(:,:,10) = Sc0102sample10;
% Tr0102(:,:,11) = Sc0102sample11;Tr0102(:,:,12) = Sc0102sample12;
% Tr0102(:,:,13) = Sc0102sample13;Tr0102(:,:,14) = Sc0302sample14;
% Tr0102(:,:,15) = Sc0102sample15;Tr0102(:,:,16) = Sc0102sample16;
% Tr0102(:,:,17) = Sc0102sample17;Tr0102(:,:,18) = Sc0102sample18;   


% Data set for Eating Food in Cafetria %

% Sc03sample01 = AreaMat;
% Sc03sample02 = AreaMat;
% Sc03sample03 = AreaMat;
% Sc03sample04 = AreaMat;
% Sc03sample05 = AreaMat;
% Sc03sample06 = AreaMat;
% Sc03sample07 = AreaMat;
% Sc03sample08 = AreaMat;
% Sc03sample09 = AreaMat;
% Sc03sample10 = AreaMat;
% Sc03sample11 = AreaMat;
% Sc03sample12 = AreaMat;
% Sc03sample13 = AreaMat;
% Sc03sample14 = AreaMat;
% Sc03sample15 = AreaMat;
% Sc03sample16 = AreaMat;
% Sc03sample17 = AreaMat;
% Sc03sample18 = AreaMat;
% % % Now create the 3D data set Matrix
%  Tr0301(:,:,1) = Sc03sample01;Tr0301(:,:,2) = Sc03sample02;
% Tr0301(:,:,3) = Sc03sample03;Tr0301(:,:,4) = Sc03sample04;
% Tr0301(:,:,5) = Sc03sample05;Tr0301(:,:,6) = Sc03sample06;
% Tr0301(:,:,7) = Sc03sample07;Tr0301(:,:,8) = Sc03sample08;
% Tr0301(:,:,9) = Sc03sample09;Tr0301(:,:,10) = Sc03sample10;
% Tr0301(:,:,11) = Sc03sample11;Tr0301(:,:,12) = Sc03sample12;
% Tr0301(:,:,13) = Sc03sample13;Tr0301(:,:,14) = Sc03sample14;
% Tr0301(:,:,15) = Sc03sample15;Tr0301(:,:,16) = Sc03sample16;
% Tr0301(:,:,17) = Sc03sample17;Tr0301(:,:,18) = Sc03sample18;  




% Data for watching in a semi-circle pattern %

Sc0202sample01 = AreaMat;
Sc0202sample02 = AreaMat;
Sc0202sample03 = AreaMat;
Sc0202sample04 = AreaMat;
Sc0202sample05 = AreaMat;
Sc0202sample06 = AreaMat;
Sc0202sample07 = AreaMat;
Sc0202sample08 = AreaMat;
Sc0202sample09 = AreaMat;
Sc0202sample10 = AreaMat;
Sc0202sample11 = AreaMat;
Sc0202sample12 = AreaMat;
Sc0202sample13 = AreaMat;
Sc0202sample14 = AreaMat;
Sc0202sample15 = AreaMat;
Sc0202sample16 = AreaMat;
Sc0202sample17 = AreaMat;
Sc0202sample18 = AreaMat;
% Now create the 3D data set Matrix
 Tr0202(:,:,1) = Sc0202sample01;Tr0202(:,:,2) = Sc0202sample02;
Tr0202(:,:,3) = Sc0202sample03;Tr0202(:,:,4) = Sc0202sample04;
Tr0202(:,:,5) = Sc0202sample05;Tr0202(:,:,6) = Sc0202sample06;
Tr0202(:,:,7) = Sc0202sample07;Tr0202(:,:,8) = Sc0202sample08;
Tr0202(:,:,9) = Sc0202sample09;Tr0202(:,:,10) = Sc0202sample10;
Tr0202(:,:,11) = Sc0202sample11;Tr0202(:,:,12) = Sc0202sample12;
Tr0202(:,:,13) = Sc0202sample13;Tr0202(:,:,14) = Sc0202sample14;
Tr0202(:,:,15) = Sc0202sample15;Tr0202(:,:,16) = Sc0202sample16;
Tr0202(:,:,17) = Sc0202sample17;Tr0202(:,:,18) = Sc0202sample18;   









