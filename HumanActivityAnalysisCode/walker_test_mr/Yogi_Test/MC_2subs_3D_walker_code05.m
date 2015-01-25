% ----------------------------------------------------------------------- %
%                                                                         %
%           Main Code for 3D Model for 2 subjects                         %
% ----------------------------------------------------------------------- %
addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\walker_test_mr')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\walker_test_mr')

addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\Main_Functions')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\Main_Functions')

clc;clear all;close all;

SampleData = 5;% <----- "After how many iterations do you want to samples"

h2=figure(232); 
set(h2,'position', [25 55 1681 907]);
% ====----=========================================----======== %
w1_s1 = [-10:2:10 10:-2:-10];  % angle values for arm swing
w2_s1 = [-5:1:10 5:-1:-5];   
%        +       %
w1_s2 = [-10:2:10 10:-2:-10];  % angle values for arm swing
w2_s2 = [-5:1:10 5:-1:-5]; 
% ========= swing angles for left/right arm,leg =-=========== %
angle11 = 0;angle12 = 0;
angle21 = 0;angle22 = 0;

i = 1;sub1 = 1;
j = 1;sub2 = 2;

[pathX1,pathY1,angle_direct1] = fCreateTrajectory001(sub1);
[pathX2,pathY2,angle_direct2] = fCreateTrajectory001(sub2);

len1 = length(pathX1); len2 = length(pathX2);
len = max(len1,len2);
M = moviein(len-1);

% ================= HADAMARD CODE ======================= %
sqrblk = 8;Blocks = (sqrblk*sqrblk);Actual_Blocks = 25;
% 
LDPCmat = hadamard(Blocks);
LDPCmat(LDPCmat == -1) = 0;
LDPCmat = LDPCmat(:,1:Actual_Blocks);
% ====================================================== %
stop1 = 50;stop2 = 15;FaceColor1 = [0.1,0.1,0.9];FaceColor2 = [0.1,0.9,0.1];
Counter = 1; % Simple counter that counts the grand total iterations
it1 = 1;  % index iterations to collect codes
while(i <= length(pathX1) - stop1 || j <= length(pathX2) - stop2) 
    
    x1 = pathX1(i);y1 = pathY1(i);    
    
    if (rem(Counter,SampleData)==0)
        [Code1] = fEmitSingleBlockCode(x1,y1,LDPCmat);
        Codemat1(it1,:) = Code1';
        %it1 = it1 + 1;
    end
%     xfill = [x1-0.5, x1+0.5, x1+0.5, x1-0.5];
%     yfill = [y1-0.5, y1-0.5, y1+0.5, y1+0.5];
%     fill(xfill,yfill,'b')
    
    [walker1] = fGetWalker(angle11,angle12,FaceColor1);          
                 
        
    if(j <= length(pathX2) - stop2)
        [walker2] = fGetWalker(angle21,angle22,FaceColor2);
        
        x2 = pathX2(j);y2 = pathY2(j);  
        
        if (rem(Counter,SampleData)==0)
            [Code2] = fEmitSingleBlockCode(x2,y2,LDPCmat);
            Codemat2(it1,:) = Code2';
            it1 = it1 + 1;
        end
        
        j = j + 1;
        walker2 = scale(walker2,0.5,0.5,0.5);walker2 = rotateZ(walker2,angle_direct2(j));walker2 = translate(walker2,x2,y2,0);
    else
        angle_direct2 = 90;
        [walker2] = fGetWalker(0,0,FaceColor2); 
        walker2 = scale(walker2,0.5,0.5,0.5);walker2 = rotateZ(walker2,angle_direct2);walker2 = translate(walker2,x2,y2,0); 
        
        x2 = pathX2(j);y2 = pathY2(j); 
        
        if (rem(Counter,SampleData)==0)
            [Code2] = fEmitSingleBlockCode(x2,y2,LDPCmat);
            Codemat2(it1,:) = Code2';
            it1 = it1 + 1;
        end
        
    end
% %     xfill = [x2-0.5, x2+0.5, x2+0.5, x2-0.5];
% %     yfill = [y2-0.5, y2-0.5, y2+0.5, y2+0.5];
% %     fill(xfill,yfill,'b')
    % =================================================================== %
    walker1 = scale(walker1,0.5,0.5,0.5);walker1 = rotateZ(walker1,angle_direct1(i));walker1 = translate(walker1,x1,y1,0);
    %walker2 = scale(walker2,0.5,0.5,0.5);walker2 = rotateZ(walker2,angle_direct2(j));walker2 = translate(walker2,x2,y2,0);
    %---------------------------------------------------------------------------------
    body_all = combine(walker1, walker2);
    cla
    renderpatch(body_all); % Takes the structure
    camlight   % Create or move light object in camera coordinates    
    view(120,20)    
    grid on
    drawnow    
    set(gca,'xlim',[0 20],'ylim',[0 20],'zlim',[-2.718 9]);
    %M(:,i) = getframe;
    %M(:,i) = getframe(gcf);
    % =================================================================== %
    angle11 = w1_s1(rem(i,length(w1_s1))+1);
    angle12 = w2_s1(rem(i,length(w1_s1))+1);
    
    angle21 = w1_s2(rem(i,length(w1_s2))+1);
    angle22 = w2_s2(rem(i,length(w1_s2))+1);
    % ---------------------------------------------------
   
    
    % ---------------------------------------------------
    i = i + 1;
    
    Counter = Counter + 1;
    
end

%movie2avi(M,'fiber32s_64g_movie.avi', 'compression', 'None','fps',30);
V = Codemat1 | Codemat2;
V = V';

tol = 0.00001;
maxiter = 50;
timelimit = 100;
plt1 = 0;% plt1 decides to plot all matrices or just H - the coefficients

[p001] = fNMFPlots(V,LDPCmat,Actual_Blocks,tol,maxiter,timelimit,plt1);




















