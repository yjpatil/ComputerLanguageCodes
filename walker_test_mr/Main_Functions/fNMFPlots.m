function[W,H] = fNMFPlots(V,LDPCmat,Actual_Blocks,tol,maxiter,timelimit,plt1,CHOICE)
% This code plots 


[S1,S2] = size(V);
[S3,S4] = size(LDPCmat);

Winit = LDPCmat;
Hinit = rand(S4,S2);


[W,H] = fnmf2_01(V,Winit,Hinit,tol,timelimit,maxiter);


if(plt1 == 0)
    figure
    Mat = H(:,1:size(H,2));
    [Plt] = fPltNMF(Mat,CHOICE);
    set(gca,'XTick',[],'YTick',[1:1:Actual_Blocks]);
    
elseif(plt1 == 1)
    figure
    Mat = H(:,1:25);
    [Plt] = fPltNMF(Mat,CHOICE)
    set(gca,'XTick',[],'YTick',[1:1:Actual_Blocks]);
    
    figure
    Mat = V(:,1:45);
    [Plt] = fPltNMF(Mat,CHOICE);
    
    figure
    Mat = W;
    [Plt] = fPltNMF(Mat,CHOICE)
else
end







end













