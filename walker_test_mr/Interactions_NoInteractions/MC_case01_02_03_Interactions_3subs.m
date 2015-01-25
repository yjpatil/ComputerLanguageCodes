% ----------------------------------------------------------------------- %
%                                                                         %
%           Main Code for 3D Model for 2 subjects                         %
% ----------------------------------------------------------------------- %
    % rem - useful for indexing an array with respect to another
    % index/sample index, here index of w1_s1 and sample index 'i'
    % 
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

Case = 7; % <------------------------------- ******** What kind of Trajectory you want 
if(Case == 1)
    [pathX1,pathY1,angle_direct1] = fCreateInteractionsTraj001(sub1);
    [pathX2,pathY2,angle_direct2] = fCreateInteractionsTraj001(sub2);
    [pathX3,pathY3,angle_direct3] = fCreateInteractionsTraj001(sub3);
elseif(Case == 2)
    [pathX1,pathY1,angle_direct1] = fCreateInteractionsTraj002(sub1);
    [pathX2,pathY2,angle_direct2] = fCreateInteractionsTraj002(sub2);
    [pathX3,pathY3,angle_direct3] = fCreateInteractionsTraj002(sub3);
elseif(Case ==3)
    [pathX1,pathY1,angle_direct1] = fCreateInteractionsTraj003(sub1);
    [pathX2,pathY2,angle_direct2] = fCreateInteractionsTraj003(sub2);
    [pathX3,pathY3,angle_direct3] = fCreateInteractionsTraj003(sub3);
elseif(Case == 5)% Interaction and Dispersion for Case # 2
    [pathX1,pathY1,angle_direct1] = fInt_Disp_Traj002(sub1);
    [pathX2,pathY2,angle_direct2] = fInt_Disp_Traj002(sub2);
    [pathX3,pathY3,angle_direct3] = fInt_Disp_Traj002(sub3);
elseif(Case == 6)% Interaction and Dispersion for Case # 3
    [pathX1,pathY1,angle_direct1] = fInt_Disp_Traj003(sub1);
    [pathX2,pathY2,angle_direct2] = fInt_Disp_Traj003(sub2);
    [pathX3,pathY3,angle_direct3] = fInt_Disp_Traj003(sub3);
elseif(Case == 7)% *********** Following
    [pathX1,pathY1,angle_direct1] = fInt_Follow_Traj001(sub1);
    [pathX2,pathY2,angle_direct2] = fInt_Follow_Traj001(sub2);
    [pathX3,pathY3,angle_direct3] = fInt_Follow_Traj001(sub3);
else
    fprintf('Wrong Case Number !!')
end

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
stop1 = 0;stop2 = 20;stop3 = 20;
FaceColor1 = [0.1,0.1,0.9];FaceColor2 = [0.1,0.9,0.1];FaceColor3 = [0.9,0.1,0.1];
Counter = 1; % Simple counter that counts the grand total iterations
it1 = 1;  % index iterations to collect codes


while(i <= length(pathX1) - stop1 || j <= length(pathX2) - stop2 || k <= length(pathX3) - stop3) 
    %--$$-- SUBJECT 1:  Get the first x & y co-ordinates  for subject 1 % 
    x1 = pathX1(i);y1 = pathY1(i);    
    
    %--$$-- SUBJECT 1:  Collect the corresponding code/ Sample data if remainder is 0 % %
    if (rem(Counter,SampleData)==0)
        %[Code1] = fEmitSingleBlockCode(x1,y1,LDPCmat);
        [Code1,Loc] = fEmitSingleBlockCode001(x1,y1,LDPCmat);
        Codemat1(it1,:) = Code1';
        %it1 = it1 + 1;
    end

    %--$$-- SUBJECT 1:  Get the Body of subject 1
    [walker1] = fGetWalker(angle11,angle12,FaceColor1); %% angle11 and angle12 --> ARM/LEG and FORE-ARM/LOWER-LEG resp swing angle          
                 
    %--$$-- SUBJECT 2:      
    if(j <= length(pathX2) - stop2)  %%subject 2 should stop before subject 1
        [walker2] = fGetWalker(angle21,angle22,FaceColor2);
        %--$$-- SUBJECT 2:
        x2 = pathX2(j);y2 = pathY2(j);  
        %--$$-- SUBJECT 2:
        if (rem(Counter,SampleData)==0)
            %[Code2] = fEmitSingleBlockCode(x2,y2,LDPCmat);
            [Code2,Loc] = fEmitSingleBlockCode001(x2,y2,LDPCmat);
            Codemat2(it1,:) = Code2';
            %it1 = it1 + 1;
        end
        
        j = j + 1;
        walker2 = scale(walker2,0.5,0.5,0.5);walker2 = rotateZ(walker2,angle_direct2(j));walker2 = translate(walker2,x2,y2,0);  %%<-------------- SCALED TRANSLATED ROTATED --------------------<<<<
    else  % This is when subject 2 is not moving at all !!!! 
        angle_direct2 = 225;
        [walker2] = fGetWalker(0,0,FaceColor2); 
        walker2 = scale(walker2,0.5,0.5,0.5);walker2 = rotateZ(walker2,angle_direct2);walker2 = translate(walker2,x2,y2,0);  %%<-------------- SCALED TRANSLATED ROTATED --------------------<<<<
        
        %--$$-- SUBJECT 2:
        x2 = pathX2(j);y2 = pathY2(j); 
        
        %--$$-- SUBJECT 2:
        if (rem(Counter,SampleData)==0)
            %[Code2] = fEmitSingleBlockCode(x2,y2,LDPCmat);
            [Code2,Loc] = fEmitSingleBlockCode001(x2,y2,LDPCmat);
            Codemat2(it1,:) = Code2';
            %it1 = it1 + 1;
        end
        
    end
    
    % Similarly ,
    %--$$-- SUBJECT 3:
    if(k <= length(pathX3) - stop3)
        [walker3] = fGetWalker(angle31,angle32,FaceColor3);
        %--$$-- SUBJECT 3:
        x3 = pathX3(k);y3 = pathY3(k); 
        
        %--$$-- SUBJECT 3:
        if (rem(Counter,SampleData)==0)
            %[Code3] = fEmitSingleBlockCode(x3,y3,LDPCmat);
            [Code3,Loc] = fEmitSingleBlockCode001(x3,y3,LDPCmat);
            Codemat3(it1,:) = Code3';
            it1 = it1 + 1;
        end
        
        k = k + 1;
        walker3 = scale(walker3,0.5,0.5,0.5);walker3 = rotateZ(walker3,angle_direct3(k));walker3 = translate(walker3,x3,y3,0);
    else  % This is when subject 3 is not moving at all !!!! 
        angle_direct3 = 90;
        [walker3] = fGetWalker(0,0,FaceColor3); 
        walker3 = scale(walker3,0.5,0.5,0.5);walker3 = rotateZ(walker3,angle_direct3);walker3 = translate(walker3,x3,y3,0);  %%<-------------- SCALED TRANSLATED ROTATED --------------------<<<<
        %--$$-- SUBJECT 3:
        x3 = pathX3(k);y3 = pathY3(k); 
        
        %--$$-- SUBJECT 3:
        if (rem(Counter,SampleData)==0)
            %[Code3] = fEmitSingleBlockCode(x3,y3,LDPCmat);
            [Code3,Loc] = fEmitSingleBlockCode001(x3,y3,LDPCmat);
            Codemat3(it1,:) = Code3';
            it1 = it1 + 1;
        end
        
    end
    
    
    %plot([16,16],[0,20],'k','LineWidth',1.5)
    %hold on;
    % =================================================================== %
    walker1 = scale(walker1,0.5,0.5,0.5);walker1 = rotateZ(walker1,angle_direct1(i));walker1 = translate(walker1,x1,y1,0);   %%<-------------- SCALED TRANSLATED ROTATED --------------------<<<<
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
    % rem(X,Y) - This command returns the remainder when X is divided by Y
    % i.e. if( X not > Y ) return X;
    %   elseif(X == Y) return XorY;
    %   elseif( X > Y) return remainder of X/Y; end
    % rem - useful for indexing an array with respect to another
    % index/sample index, here index of w1_s1 and sample index 'i'
    % 
    % e.g. rem(4,3) will return 1, while rem(4,5) will return 4
    % Copy Paste the following lines to understand "w1_s1(rem())"
     % for i = 1 : 1 : 20
     % [i rem(i,length(w1_s1))+1 w1_s1(rem(i,length(w1_s1))+1)]
     % end
    angle11 = w1_s1(rem(i,length(w1_s1))+1);% During the path creation create another row along with x/y coordinates, DEfining the static "'S'/ 0" or dynamic "'D'/1" arm/leg swing
    angle12 = w2_s1(rem(i,length(w1_s1))+1);% if (pathX(2nd row)==1),angle11 = w1_s1(rem...), elseif(pathX(2nd row)==0),angle11 = 0, en
    
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

% % % [W,H] = fNMFPlots(V,LDPCmat,Actual_Blocks,tol,maxiter,timelimit,plt1);
% % % 
% % % temp_col = [];
% % % New_H = [];
% % % it1 = 1;
% % % for i = 1 : 1 : size(H,2)
% % %     if(i == 1)        
% % %         temp_col = H(:,1);   
% % %         New_H(:,it1) = temp_col;
% % %         it1 = it1 + 1;        
% % %     else
% % %     end
% % %     
% % %     if(temp_col == H(:,i))        
% % %     elseif(~isequal(temp_col,H(:,i)))
% % %         temp_col = [];
% % %         temp_col = H(:,i);
% % %         New_H(:,it1) = temp_col;
% % %         it1 = it1 + 1;
% % %     end
% % %     
% % % end              
% % % 
 
% % figure
% % Mat = H;
% % [Plt] = fPltNMF(Mat);
% % set(gca,'XTick',[],'YTick',[1:1:Actual_Blocks]);

% % % 
% % % % --------- Info about Location + Direction --------- %
% % % Ind = find(H(:,1)> 0.100,3);
% % % ind = [];
% % % Loc = [];
% % % for i = 1 : 1 : size(H,2)
% % %     ind = find(H(:,i) > 0.100,3);
% % %     Loc(:,i) = ind;
% % % end
% % % 
% % % Dir = [];
% % % Histo = [];
% % % for i = 1 : 1 : size(Loc,1)
% % %     Location = Loc(i,:);
% % %     [Hist,DirInfo] = fDirInfo001(Location);
% % %     Histo(i,:) = Hist;
% % %     Dir(i,:) = DirInfo;
% % %     Hist = [];
% % %     DirInfo = [];
% % % end
    

%-------------- Calculate the Matrices W&H --------------------%
[S1,S2] = size(V);
[S3,S4] = size(LDPCmat);

Winit = LDPCmat;
Hinit = rand(S4,S2);

[W,H] = fnmf2_01(V,Winit,Hinit,tol,timelimit,maxiter);
Store_H = H;
% H = Store_H;

%-------------------------------------------------------------%
% Now try to reduce the 'coeff Matrix H', by fusing the same columns
% together
temp_col = [];
New_H = [];% Reduced Coefficient Matrix 
it1 = 1;
for i = 1 : 1 : size(H,2)
    if(i == 1) % For first iteration only take the first column as template
        temp_col = H(:,1);   % First column of H as template 
        New_H(:,it1) = temp_col; % Add to the new H matrix
        it1 = it1 + 1;        
    else
    end    
    if(temp_col == H(:,i))                
    elseif(~isequal(temp_col,H(:,i)))% Compare the present common template to current iteration/column of H
        temp_col = [];% if they are not-same then clear the template in temp_col ...
        temp_col = H(:,i);% and add the new/current iteration/column of H to temp_col ...
        New_H(:,it1) = temp_col;% Also add it to the new_h
        it1 = it1 + 1;
    end
    
end        

%---------------Different cases for Case #6---------------%
H1 = H(:,1:10);
H2 = H(:,11:30);
H3 = H(:,31:50);
H4 = H(:,51:70);
H5 = H(:,72:95);
H6 = H(:,91:101);
H7 = H(:,136:166);

H_one = H5;%H(:,157:191);
% --- Change H to H1,H2,...
H = H_one;


% % ------------ Plot the Grey-Scale of the Coefficients ------------ % %
figure
Mat = H;
[Plt] = fPltNMF(Mat,2);
set(gca,'XTick',[],'YTick',[1:1:Actual_Blocks]);

% % -------------- Info about Location + Direction --------------- % %

%%Ind = find(H(:,1)> 0.100,3); 
ind = [];
Loc = [];  % Loc gives the information of the subjects walking on a particular location!!
Intensity = []; %Collects the intensity of pixels

for i = 1 : 1 : size(H,2)
    IndOne = find(H(:,i)>= 0.95 & H(:,i)<= 1.1);%%IndOne = find(H(:,i) == 1);
    IndHalf = find(H(:,i)> 0.35 & H(:,i)< 0.75);
    if(isempty(IndOne) && isempty(IndHalf))
        ind = find(H(:,i)> 0.100,3);
    elseif(~isempty(IndHalf))
        ind = find(H(:,i)> 0.200);
        ind = [ind;ind(1)];% The column matrix should have 3 rows
    else
        ind = find(H(:,i)>= 0.95 & H(:,i)<= 1.1);%ind = find(H(:,i)== 1);
        ind = [ind;ind;ind];% The column matrix should have 3 rows
    end    
    Loc(:,i) = ind;
    Intensity(:,i) = H(ind,i);
end

% % ----------- Get Statistics for feature recognition ------------ % % 

% % Stats # 1 (Range of Intensity of Pixels)
R00_01 = 0;R02_07 = 0;R07_1 = 0;

Index11 = find(Intensity >= 0 & Intensity <= 0.1);L11 = length(Index11);
Index12 = find(Intensity > 0.1 & Intensity <= 0.7);L12 = length(Index12);
Index13 = find(Intensity > 0.7 & Intensity <= 1.0);L13 = length(Index13);

Total = L11 + L12 + L13;

R00_01 = L11/Total;R02_07 = L12/Total;R07_1 = L13/Total;

Feat1 = [R00_01;R02_07;R07_1];
% % Stats # 2&3 (Location of Different groups-> Same,Near,Far)& (Interaction Duration)
Same = 0;Near= 0;Far = 0;InteractionTime = 0;tempSame = [];
for i = 1 : 1 : size(Loc,2)
    [Same,Near,Far,InteractionTime,tempSame] = fNearFarLocInfo(Loc(1,i),Loc(2,i),Loc(3,i),Same,Near,Far,InteractionTime,tempSame);
    %[Same,Near,Far] = fNearFarLocInfo(Loc(1,i),Loc(2,i),Loc(3,i),Same,Near,Far);
end
Total = (Same+Near+Far);
Same = Same/Total;Near = Near/Total;Far = Far/Total;

if(InteractionTime < 3)
    NoInt = 1;MedInt = 0;HighInt = 0;
elseif(InteractionTime >= 3 && InteractionTime <= 6)
    NoInt = 0;MedInt = 1;HighInt = 0;
elseif(InteractionTime > 6)
    NoInt = 0;MedInt = 0;HighInt = 1;
end   
Feat2 = [Same;Near;Far];
Feat3 = [NoInt;MedInt;HighInt];

Dir = [];
NEWS_Histo = [];
% Hist = [North,North-East,East,South-East,South,South-West,West,North-West] ....... Clockwise
% DirInfo = [North(1),North-East(2),East(3),South-East(4),South(5),South-West(6),West(7),North-West(8)]
for i = 1 : 1 : size(Loc,1)
    Location = Loc(i,:);
    [Hist,DirInfo] = fDirInfo001(Location);
    NEWS_Histo(i,:) = Hist;
    Dir(i,:) = DirInfo;
    Hist = [];
    DirInfo = [];
end


% ---- Calculate features ---- %

Features = [Feat1,Feat2,Feat3];

figure
Mat = Features;
[Plt] = fPltNMF(Mat,2);
set(gca,'XTick',[],'XTick',[1:1:3],'YTick',[1:1:3]);

















