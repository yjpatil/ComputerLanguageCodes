% ----------------------------------------------------------------------- %
%                                                                         %
%           Main Code for 3D Model for 2 subjects                         %
% ----------------------------------------------------------------------- %
    % rem - useful for indexing an array with respect to another
    % index/sample index, here index of w1_s1 and sample index 'i'
    % 
addpath('C:\Users\Yuri\Dropbox\Walker_Coding\walker_test_mr\walker_test_mr')
addpath('C:\Users\3003\Dropbox\Walker_Coding\walker_test_mr\walker_test_mr')

addpath('C:\Users\Yuri\Dropbox\Walker_Coding\walker_test_mr\Main_Functions')
addpath('C:\Users\3003\Dropbox\Walker_Coding\walker_test_mr\Main_Functions')

addpath('C:\Users\Yuri\Dropbox\Walker_Coding\walker_test_mr\Main_Functions2')
addpath('C:\Users\3003\Dropbox\Walker_Coding\walker_test_mr\Main_Functions2')

clc;clear all;close all;

global Temp1 Temp2 Temp3 Temp4 Temp5 Temp6 Wait; % These variables are used to 
% equalize the number of data points in each subjects. e.g. when two
% subjects stop while other walk
Temp1=[]; Temp2=[]; Temp3=[]; Temp4=[];Temp5 = [];Temp6 = [];

Wait = 60;% Wait --> determines the time(# of data points) of wait at a scenario!!

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
%        +       %
w1_s4 = [-10:2:10 10:-2:-10];  % angle values for arm swing
w2_s4 = [-5:1:10 5:-1:-5]; 
%        +       %
w1_s5 = [-10:2:10 10:-2:-10];  % angle values for arm swing
w2_s5 = [-5:1:10 5:-1:-5]; 
% ========= swing angles for left/right arm,leg =-=========== %
angle11 = 0;angle12 = 0;
angle21 = 0;angle22 = 0;
angle31 = 0;angle32 = 0;
angle41 = 0;angle42 = 0;
angle51 = 0;angle52 = 0;
% ======= Indices for each subject and iteration variables ====== %
i = 1;sub1 = 1;
j = 1;sub2 = 2;
k = 1;sub3 = 3;
l = 1;sub4 = 4;
m = 1;sub5 = 5;

Case = 2;Scenario_choice = 2; % <------------------------------- ******** What kind of Trajectory you want 

if(Case == 1)
    [pathX1,pathY1,angle_direct1] = fNewIntTraj001(sub1,Scenario_choice);
    [pathX2,pathY2,angle_direct2] = fNewIntTraj001(sub2,Scenario_choice);
    [pathX3,pathY3,angle_direct3] = fNewIntTraj001(sub3,Scenario_choice);
    [pathX4,pathY4,angle_direct4] = fNewIntTraj001(sub4,Scenario_choice);
elseif(Case == 2)
    [pathX1,pathY1,angle_direct1] = fNewScenarioTraj001(sub1,Scenario_choice);
    [pathX2,pathY2,angle_direct2] = fNewScenarioTraj001(sub2,Scenario_choice);
    [pathX3,pathY3,angle_direct3] = fNewScenarioTraj001(sub3,Scenario_choice);
    [pathX4,pathY4,angle_direct4] =fNewScenarioTraj001(sub4,Scenario_choice);
elseif(Case ==3)
    [pathX1,pathY1,angle_direct1] = fNewIntTraj003(sub1,Scenario_choice);
    [pathX2,pathY2,angle_direct2] = fNewIntTraj003(sub2,Scenario_choice);
    [pathX3,pathY3,angle_direct3] = fNewIntTraj003(sub3,Scenario_choice);
    [pathX4,pathY4,angle_direct4] = fNewIntTraj003(sub4,Scenario_choice);
elseif(Case == 5)% Interaction and Dispersion for Case # 2
    
elseif(Case == 6)% Interaction and Dispersion for Case # 3
    
elseif(Case == 7)% *********** Following
    
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
stop1 = 0;stop2 = 0;stop3 = 0;stop4 = 0;
FaceColor1 = [0.1,0.1,0.9];FaceColor2 = [0.1,0.9,0.1];
FaceColor3 = [0.9,0.1,0.1];FaceColor4 = [0.2,0.7,0.7];FaceColor5 = [0.2,0.1,0.1];

Counter = 1; % Simple counter that counts the grand total iterations
it1 = 1;  % index iterations to collect codes

% ========================================================= %\
[walker5] = fGetWalker(0,0,FaceColor5);
walker5 = scale(walker5,0.5,0.5,0.5);walker5 = rotateZ(walker5,90);walker5 = translate(walker5,10,9,0);


while(i <= length(pathX1) - stop1 )%%|| j <= length(pathX2) - stop2 || k <= length(pathX3) - stop3) 
    %--$$-- SUBJECT 1:  Get the first x & y co-ordinates  for subject 1 % 
    x1 = pathX1(1,i);
    y1 = pathY1(i);    
    
    %--$$-- SUBJECT 1:  Collect the corresponding code/ Sample data if remainder is 0 % %
    if (rem(Counter,SampleData)==0)
        %[Code1] = fEmitSingleBlockCode(x1,y1,LDPCmat);
        [Code1,Loc] = fEmitSingleBlockCode001(x1,y1,LDPCmat);% Code1 is a column matrix. Transpose it in the next step
        Codemat1(it1,:) = Code1'; % Codemat1 is  a 64 X n samples matrix
        %it1 = it1 + 1;
    end

    %--$$-- SUBJECT 1:  Get the Body of subject 1
    [walker1] = fGetWalker(angle11,angle12,FaceColor1); %% angle11 and angle12 --> ARM/LEG and FORE-ARM/LOWER-LEG resp swing angle          
                 
    %--$$-- SUBJECT 2:      
    if(j <= length(pathX2)-2)%% - stop2)  %%subject 2 should stop before subject 1
        [walker2] = fGetWalker(angle21,angle22,FaceColor2);
        %--$$-- SUBJECT 2:
        x2 = pathX2(1,j);
        y2 = pathY2(j); 
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
    end
    
    % Similarly ,
    %--$$-- SUBJECT 3:
    if(k <= length(pathX3)-2)%% - stop3)
        [walker3] = fGetWalker(angle31,angle32,FaceColor3);
        %--$$-- SUBJECT 3:
        x3 = pathX3(1,k);
        y3 = pathY3(k);
        
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
    end
    
    % Similarly ,
    %--$$-- SUBJECT 4:
    if(l <= length(pathX4)-2)%% - stop3)
        [walker4] = fGetWalker(angle41,angle42,FaceColor4);
        %--$$-- SUBJECT 4:
        x4 = pathX4(1,l);
        y4 = pathY4(l);
        
        %--$$-- SUBJECT 4:
        if (rem(Counter,SampleData)==0)
            %[Code3] = fEmitSingleBlockCode(x3,y3,LDPCmat);
            [Code4,Loc] = fEmitSingleBlockCode001(x4,y4,LDPCmat);
            Codemat4(it1,:) = Code4';
            it1 = it1 + 1;
        end
        
        l = l + 1;
        walker4 = scale(walker4,0.5,0.5,0.5);walker4 = rotateZ(walker4,angle_direct4(l));walker4 = translate(walker4,x4,y4,0);
    else  % This is when subject 4 is not moving at all !!!!         
    end
    
    %plot([16,16],[0,20],'k','LineWidth',1.5)
    %hold on;
    % =================================================================== %
    walker1 = scale(walker1,0.5,0.5,0.5);walker1 = rotateZ(walker1,angle_direct1(i));walker1 = translate(walker1,x1,y1,0);   %%<-------------- SCALED TRANSLATED ROTATED --------------------<<<<
    
    %---------------------------------------------------------------------------------
    body_all = combine(walker1, walker2, walker3, walker4);
    cla
    renderpatch(body_all); % Takes the structure
    camlight   % Create or move light object in camera coordinates    
    view(130,35)    
    grid on
    drawnow    
    set(gca,'xlim',[0 20],'ylim',[0 20],'zlim',[-2.718 9]);hold on
    
    if(pathX1(2,i) == 1)
        angle11 = w1_s1(rem(i,length(w1_s1))+1);% During the path creation create another row along with x/y coordinates, DEfining the static "'S'/ 0" or dynamic "'D'/1" arm/leg swing
        angle12 = w2_s1(rem(i,length(w1_s1))+1);% if (pathX(2nd row)==1),angle11 = w1_s1(rem...), elseif(pathX(2nd row)==0),angle11 = 0, end
    elseif(pathX1(2,i) == 0)
        angle11 = 0;
        angle12 = 0;
    end
    
    if(pathX2(2,j) == 1)
        angle21 = w1_s2(rem(i,length(w1_s2))+1);
        angle22 = w2_s2(rem(i,length(w1_s2))+1);
    elseif(pathX2(2,j) == 0)
        angle21 = 0;
        angle22 = 0;
    end
    
    if(pathX3(2,k) == 1)
        angle31 = w1_s3(rem(i,length(w1_s3))+1);
        angle32 = w2_s3(rem(i,length(w1_s3))+1);
    elseif(pathX3(2,k) == 0)
        angle31 = 0;
        angle32 = 0;
    end
    
    if(pathX4(2,l) == 1)
        angle41 = w1_s4(rem(i,length(w1_s4))+1);
        angle42 = w2_s4(rem(i,length(w1_s4))+1);
    elseif(pathX4(2,l) == 0)
        angle41 = 0;
        angle42 = 0;
    end
    % ---------------------------------------------------
   
    
    % ---------------------------------------------------
    i = i + 1;
    
    Counter = Counter + 1;
    
end
   

% Equalize all code matrices % 
%----- WARNING: Manually enter -----%
Leng1 = [length(Codemat1),length(Codemat2),length(Codemat3),length(Codemat4)];
End1 = [Codemat1(end,:);Codemat2(end,:);Codemat3(end,:);Codemat4(end,:)];

CodeMat{1,1} = Codemat1;CodeMat{1,2} = Codemat2;
CodeMat{1,3} = Codemat3;CodeMat{1,4} = Codemat4;

Index= find(max(max(Leng1)== Leng1));% Find the code matrix that had the maximum number 
%of samples, pad the matrices who has less

for i = 1 : 1 : length(Leng1)
    if(i == Index)
    elseif(i ~= Index && Leng1(i) ~= Leng1(Index))
        while(Leng1(i) < Leng1(Index))
            CodeMat{1,i} = [CodeMat{1,i};End1(i,:)];
            Leng1(i) = length(CodeMat{1,i});
        end
    end
end

Codemat1 = CodeMat{1,1};Codemat2 = CodeMat{1,2};
Codemat3 = CodeMat{1,3};Codemat4 = CodeMat{1,4};

V = Codemat1 | Codemat2 | Codemat3 | Codemat4;

V = V'; % You are using old V, make sure you dont inverse the matrix dims
tol = 0.00001;
maxiter = 500;
timelimit = 1000;
plt1 = 0;% plt1 decides to plot all matrices or just H - the coefficients
CHOICE = 1; % Plot, B&W ==> 1 and COLOR ==> 2
%-------------- Calculate the Matrices W&H --------------------%
[S1,S2] = size(V);
[S3,S4] = size(LDPCmat);

Winit = LDPCmat;
Hinit = rand(S4,S2);

[W,H] = fnmf2_01(V,Winit,Hinit,tol,timelimit,maxiter);
%-------------------------------------------------------------%

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
        
% % ------------ Plot the Grey-Scale of the Coefficients ------------ % %
figure
Mat = New_H;
[Plt] = fPltNMF(Mat(:,571:655),2);
set(gca,'XTick',[],'YTick',[1:1:Actual_Blocks]);












