% ----------------------------------------------------------------------- %
%                                                                         %
%           Main Code for 3D Model for 2 subjects                         %
% ----------------------------------------------------------------------- %
addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\walker_test_mr')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\walker_test_mr')

addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\Main_Functions')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\RuiMa_codes\3D_model\walker_test_mr\Main_Functions')

clc;clear all;close all;

SampleData = 2;% <----- "After how many iterations do you want to samples"

h2=figure(232); 
set(h2,'position', [25 55 1681 907]);
% ====----=========================================----======== %
w1_s1 = [-10:2:10 10:-2:-10];  % angle values for arm swing
w2_s1 = [-5:1:10 5:-1:-5];   
%        +       %
w1_s2 = [-10:2:10 10:-2:-10];  % angle values for arm swing
w2_s2 = [-5:1:10 5:-1:-5]; 
%        +       %
w1_s3 = [-10:2:10 10:-2:-10];  % angle values for arm swing
w2_s3 = [-5:1:10 5:-1:-5]; 
% ========= swing angles for left/right arm,leg =-=========== %
angle11 = 0;angle12 = 0;
angle21 = 0;angle22 = 0;
angle31 = 0;angle32 = 0;

i = 1;sub1 = 1;
j = 1;sub2 = 2;
k = 1;sub3 = 3;

[pathX1,pathY1,angle_direct1] = fCreateInteractionsTraj002(sub1);
[pathX2,pathY2,angle_direct2] = fCreateInteractionsTraj002(sub2);
[pathX3,pathY3,angle_direct3] = fCreateInteractionsTraj002(sub3);

%len1 = length(pathX1); len2 = length(pathX2);
%len = max(len1,len2);
%M = moviein(len-1);

% ================= HADAMARD CODE ======================= %
sqrblk = 8;Blocks = (sqrblk*sqrblk);Actual_Blocks = 25;
% 
LDPCmat = hadamard(Blocks);
LDPCmat(LDPCmat == -1) = 0;
LDPCmat = LDPCmat(:,2:Actual_Blocks+1);%LDPCmat = LDPCmat(:,1:Actual_Blocks);
% ====================================================== %
stop1 = 50;stop2 = 20;stop3 = 20;
FaceColor1 = [0.1,0.1,0.9];FaceColor2 = [0.1,0.9,0.1];FaceColor3 = [0.9,0.1,0.1];
Counter = 1; % Simple counter that counts the grand total iterations
it1 = 1;  % index iterations to collect codes
while(i <= length(pathX1) - stop1 || j <= length(pathX2) - stop2 || k <= length(pathX3) - stop3) 
    
    x1 = pathX1(i);y1 = pathY1(i);    
    
    if (rem(Counter,SampleData)==0)
        [Code1] = fEmitSingleBlockCode(x1,y1,LDPCmat);
        Codemat1(it1,:) = Code1';
        %it1 = it1 + 1;
    end

    
    [walker1] = fGetWalker(angle11,angle12,FaceColor1);          
                 
        
    if(j <= length(pathX2) - stop2)
        [walker2] = fGetWalker(angle21,angle22,FaceColor2);
        
        x2 = pathX2(j);y2 = pathY2(j);  
        
        if (rem(Counter,SampleData)==0)
            [Code2] = fEmitSingleBlockCode(x2,y2,LDPCmat);
            Codemat2(it1,:) = Code2';
            %it1 = it1 + 1;
        end
        
        j = j + 1;
        walker2 = scale(walker2,0.5,0.5,0.5);walker2 = rotateZ(walker2,angle_direct2(j));walker2 = translate(walker2,x2,y2,0);
    else
        angle_direct2 = 225;
        [walker2] = fGetWalker(0,0,FaceColor2); 
        walker2 = scale(walker2,0.5,0.5,0.5);walker2 = rotateZ(walker2,angle_direct2);walker2 = translate(walker2,x2,y2,0); 
        
        x2 = pathX2(j);y2 = pathY2(j); 
        
        if (rem(Counter,SampleData)==0)
            [Code2] = fEmitSingleBlockCode(x2,y2,LDPCmat);
            Codemat2(it1,:) = Code2';
            %it1 = it1 + 1;
        end
        
    end
    
    
    if(k <= length(pathX3) - stop3)
        [walker3] = fGetWalker(angle31,angle32,FaceColor3);
        
        x3 = pathX3(k);y3 = pathY3(k); 
        
        if (rem(Counter,SampleData)==0)
            [Code3] = fEmitSingleBlockCode(x3,y3,LDPCmat);
            Codemat3(it1,:) = Code3';
            it1 = it1 + 1;
        end
        
        k = k + 1;
        walker3 = scale(walker3,0.5,0.5,0.5);walker3 = rotateZ(walker3,angle_direct3(k));walker3 = translate(walker3,x3,y3,0);
    else
        angle_direct3 = -45;
        [walker3] = fGetWalker(0,0,FaceColor3); 
        walker3 = scale(walker3,0.5,0.5,0.5);walker3 = rotateZ(walker3,angle_direct3);walker3 = translate(walker3,x3,y3,0); 
        
        x3 = pathX3(k);y3 = pathY3(k); 
        
        if (rem(Counter,SampleData)==0)
            [Code3] = fEmitSingleBlockCode(x3,y3,LDPCmat);
            Codemat3(it1,:) = Code3';
            it1 = it1 + 1;
        end
        
    end
    
    
    %plot([16,16],[0,20],'k','LineWidth',1.5)
    %hold on;
    % =================================================================== %
    walker1 = scale(walker1,0.5,0.5,0.5);walker1 = rotateZ(walker1,angle_direct1(i));walker1 = translate(walker1,x1,y1,0);
    %walker2 = scale(walker2,0.5,0.5,0.5);walker2 = rotateZ(walker2,angle_direct2(j));walker2 = translate(walker2,x2,y2,0);
    %---------------------------------------------------------------------------------
    body_all = combine(walker1, walker2, walker3);
    cla
    renderpatch(body_all); % Takes the structure
    camlight   % Create or move light object in camera coordinates    
    view(130,35)    
    grid on
    drawnow    
    set(gca,'xlim',[0 20],'ylim',[0 20],'zlim',[-2.718 9]);hold on
    
    %M(:,Counter) = getframe;
    %M(:,i) = getframe(gcf);
    % =================================================================== %
    angle11 = w1_s1(rem(i,length(w1_s1))+1);
    angle12 = w2_s1(rem(i,length(w1_s1))+1);
    
    angle21 = w1_s2(rem(i,length(w1_s2))+1);
    angle22 = w2_s2(rem(i,length(w1_s2))+1);
    
    angle31 = w1_s3(rem(i,length(w1_s3))+1);
    angle32 = w2_s3(rem(i,length(w1_s3))+1);
    % ---------------------------------------------------
   
    
    % ---------------------------------------------------
    i = i + 1;
    
    Counter = Counter + 1;
    
end

%movie2avi(M,'fiber32s_64g_movie.avi', 'compression', 'None','fps',30);


V = Codemat1 | Codemat2 | Codemat3;

V = V';

tol = 0.00001;
maxiter = 500;
timelimit = 100;
plt1 = 0;% plt1 decides to plot all matrices or just H - the coefficients

[W,H] = fNMFPlots(V,LDPCmat,Actual_Blocks,tol,maxiter,timelimit,plt1);


temp_col = [];
New_H = [];
it1 = 1;
for i = 1 : 1 : size(H,2)
    if(i == 1)
        temp_col = H(:,1);   
        New_H(:,it1) = temp_col;
        it1 = it1 + 1;        
    else
    end
    
    if(temp_col == H(:,i))
    elseif(temp_col ~= H(:,i))
        temp_col = [];
        temp_col = H(:,i);
        New_H(:,it1) = temp_col;
        it1 = it1 + 1;
    end
    
end
        
        
        
figure
Mat = New_H;
[Plt] = fPltNMF(Mat)
set(gca,'XTick',[],'YTick',[1:1:Actual_Blocks]);
















