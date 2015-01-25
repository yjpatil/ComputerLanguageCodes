% This code creates random data based on the 'Angle of User Arms movement'
% 
% Use structure to carry sensor data
clc;clear all;close all;
clear
%
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\September2013\21Sep2013')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\September2013\21Sep2013\bICA_TEST')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\September2013\Test_Codes\Test_bICA_diGamma')

% addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\September2013\21Sep2013');
% addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\September2013\21Sep2013\bICA_TEST');
% addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\September2013\Test_Codes\Test_bICA_diGamma');
%
N = 1000;  % Number of Observations
MaxSensors = 4;  % Total number of Maximum Sensors

% ========================== For Target 1 =========================== %
Stheta1 = 15; % -22.5 <= Stheta <= 22.5
Ltheta1 = 35; % -45 <= Stheta <= 45
Delta1 = 5;
Trans1 = [0.5 0.5; 0.5 0.5];
[Data01] = fCreateSinAlphaData(MaxSensors,Stheta1,Ltheta1,N,Trans1,Delta1);
for i = 1 : 1 : MaxSensors
    StatsData1(i,:) = fCal_Stats(Data01(i,:));
end
figure;%title('Distribution');
for I = 1 : 1 : MaxSensors
    gcf;
    H11 = plot3(StatsData1(I,1),StatsData1(I,2),StatsData1(I,3),'bx','Linewidth',2.0);
    hold on;grid on;
end
xlabel('P00');ylabel('P01');zlabel('P10');%title(strcat('Statistics for ',num2str(D),'sensors'))
xlim([0 1]);ylim([0 1]);zlim([0 1])
%legend([H11],{'8 Sensor Stats for Target 1'});
% ========================== For Target 2 ========================== %
Stheta2 = 12; % -22.5 <= Stheta <= 22.5
Ltheta2 = 25; % -45 <= Stheta <= 45
Delta2 = 25;
Trans2 = [0.50 0.50; 0.50 0.50];
[Data02] = fCreateSinAlphaData(MaxSensors,Stheta2,Ltheta2,N,Trans2,Delta2);
for i = 1 : 1 : MaxSensors
    StatsData2(i,:) = fCal_Stats(Data02(i,:));
end
%figure;%title('Distribution');
for I = 1 : 1 : MaxSensors
    gcf;
    H22 = plot3(StatsData2(I,1),StatsData2(I,2),StatsData2(I,3),'rx','Linewidth',2.0);
    hold on;grid on;
end
xlabel('P00');ylabel('P01');zlabel('P10');%title(strcat('Statistics for ',num2str(D),'sensors'))
xlim([0 1]);ylim([0 1]);zlim([0 1])
legend([H11 H22],{'8 Sensor Stats for Target 1' '8 Sensor Stats for Target 2'});
% =========================== For Target 3 ========================= %
Stheta3 = 5; % -22.5 <= Stheta <= 22.5
Ltheta3 = 40; % -45 <= Stheta <= 45
Delta3 = 20;
Trans3 = [0.50 0.50; 0.50 0.50];
[Data03] = fCreateSinAlphaData(MaxSensors,Stheta3,Ltheta3,N,Trans3,Delta3);
for i = 1 : 1 : MaxSensors
    StatsData3(i,:) = fCal_Stats(Data03(i,:));
end
%figure;%title('Distribution');
for I = 1 : 1 : MaxSensors
    gcf;
    H33 = plot3(StatsData3(I,1),StatsData3(I,2),StatsData3(I,3),'mx','Linewidth',2.0);
    hold on;grid on;
end
xlabel('P00');ylabel('P01');zlabel('P10');%title(strcat('Statistics for ',num2str(D),'sensors'))
xlim([0 1]);ylim([0 1]);zlim([0 1])
legend([H11 H22 H33],{'8 Sensor Stats for Target 1' '8 Sensor Stats for Target 2' '8 Sensor Stats for Target 3'});
% ========================== For Target 4 ========================== %
Stheta4 = 12; % -22.5 <= Stheta <= 22.5
Ltheta4 = 45; % -45 <= Stheta <= 45
Delta4 = 15;
Trans4 = [0.50 0.50; 0.50 0.50];
[Data04] = fCreateSinAlphaData(MaxSensors,Stheta4,Ltheta4,N,Trans4,Delta4);
for i = 1 : 1 : MaxSensors
    StatsData4(i,:) = fCal_Stats(Data04(i,:));
end
%figure;%title('Distribution');
for I = 1 : 1 : MaxSensors
    gcf;
    H44 = plot3(StatsData4(I,1),StatsData4(I,2),StatsData4(I,3),'gx','Linewidth',2.0);
    hold on;grid on;
end
xlabel('P00');ylabel('P01');zlabel('P10');%title(strcat('Statistics for ',num2str(D),'sensors'))
xlim([0 1]);ylim([0 1]);zlim([0 1])
legend([H11 H22 H33 H44],{'8 Sensor Stats for Target 1' '8 Sensor Stats for Target 2' '8 Sensor Stats for Target 3' '8 Sensor Stats for Target 4'});

% =================== Create the Mixed Component # 1 ================= %
close;clearvars -except Data01 Data02 Data03 Data04
Data1 = Data01(2,:);%Data01(2,:);
Data2 = Data03(1,:);%Data03(1,:);
Data3 = Data04(3,:);%Data04(3,:);
Data4 = Data01(4,:);%Data02(2,:);

Stats1 = fCal_Stats(Data1);
p00 = Stats1(1);p01 = Stats1(2);p10 = Stats1(3);p11 = Stats1(4);
Stats2 = fCal_Stats(Data2);
q00 = Stats2(1);q01 = Stats2(2);q10 = Stats2(3);q11 = Stats2(4);

Stats3 = fCal_Stats(Data3);
r00 = Stats3(1);r01 = Stats3(2);r10 = Stats3(3);r11 = Stats3(4);
Stats4 = fCal_Stats(Data4);
s00 = Stats4(1);s01 = Stats4(2);s10 = Stats4(3);s11 = Stats4(4);

figure
plot3(Stats1(1,1),Stats1(1,2),Stats1(1,3),'bx','Linewidth',2.0);hold on;grid on;
plot3(Stats2(1,1),Stats2(1,2),Stats2(1,3),'rx','Linewidth',2.0);
% plot3(Stats3(1,1),Stats3(1,2),Stats3(1,3),'gx','Linewidth',2.0);
% plot3(Stats4(1,1),Stats4(1,2),Stats4(1,3),'cx','Linewidth',2.0);

% ============================== ORed Data =========================== %
ORed = Data1 | Data2;% | Data3 | Data4;
StatsORed = fCal_Stats(ORed);
LegOR = plot3(StatsORed(1,1),StatsORed(1,2),StatsORed(1,3),'hm','Linewidth',1.5);

ORed = Data1;          %<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< CHANGED

xlabel('P00');ylabel('P01');zlabel('P10');%title(strcat('Statistics for ',num2str(D),'sensors'))
xlim([0 1]);ylim([0 1]);zlim([0 1])

%[Leg_11] = fStraightLineApprox(Stats1,Stats2);

% % legend([H11 H22],{'8 Sensor Stats for Target 1' '8 Sensor Stats for Target 2'});

% ======================= Bernoulli Mixture Data ==================== %
X = [Data1;Data2];
Pi = .5;
[MixData,Leg3] = fCreateBernoulliMix(Pi,X);

% ================= Very Important Step ======================= %
%MixData = ORed;  % <<<<<<<<<<<<<<<<<<<<<< Change here

%MixData = Data2;      %<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< CHANGED

L = length(MixData);
A11 = MixData(2:length(MixData));
x = [MixData;A11,MixData(1)];

StatsMixD = fCal_Stats(MixData);

Ind00 = find(x(1,:)==0 & x(2,:)==0);L00 = length(Ind00)/L;
Ind01 = find(x(1,:)==0 & x(2,:)==1);L01 = length(Ind01)/L;
Ind10 = find(x(1,:)==1 & x(2,:)==0);L10 = length(Ind10)/L;
Ind11 = find(x(1,:)==1 & x(2,:)==1);L11 = length(Ind11)/L;

Delta = zeros(4,L);
Delta(1,Ind00) = 1;%Delta(1,Ind00+1) = 1; %Delta(1,Ind00+1) = 1; 
Delta(2,Ind01) = 1;%Delta(2,Ind01+1) = 1;%Delta(2,Ind01+1) = 1;
Delta(3,Ind10) = 1;%Delta(3,Ind10+1) = 1;%Delta(3,Ind10+1) = 1;
Delta(4,Ind11) = 1;%Delta(4,Ind11+1) = 1;Delta = Delta(:,1:L);%Delta(4,Ind11+1) = 1;Delta = Delta(:,1:L);

% % ========== Changes were Made Here :: 1 Nov 2013 ===================% %

MixData1 = ORed;

Pi2 = [0.5,1]; 
[MixData2,Leg222] = fCreateBernoulliMix2(Pi2,X);
[BernStats2] = fFindBernStats(MixData2,1);
%MixData2 = ORed;

Pi3 = [0.3,1]; 
[MixData3,Leg333] = fCreateBernoulliMix2(Pi3,X);
[BernStats3] = fFindBernStats(MixData3,1);
% MixData = [MixData1;MixData2;MixData3];

Pi4 = [0.4,1]; 
[MixData4,Leg444] = fCreateBernoulliMix2(Pi4,X);
[BernStats4] = fFindBernStats(MixData4,1);
%MixData = [MixData1;MixData2;MixData3;MixData4];

Pi5 = [0.2,1]; 
[MixData5,Leg555] = fCreateBernoulliMix2(Pi5,X);
[BernStats5] = fFindBernStats(MixData5,1);
%MixData = [MixData1;MixData2;MixData3;MixData4;MixData5];

Pi6 = [0.7,1]; 
[MixData6,Leg666] = fCreateBernoulliMix2(Pi6,X);
[BernStats6] = fFindBernStats(MixData6,1);
%MixData = [MixData1;MixData2;MixData3;MixData4;MixData5;MixData6];

Pi7 = [0.8,1]; 
[MixData7,Leg777] = fCreateBernoulliMix2(Pi7,X);
[BernStats7] = fFindBernStats(MixData7,1);
%MixData = [MixData1;MixData2;MixData3;MixData4;MixData5;MixData6;MixData7];

Pi8 = [0.1,1]; 
[MixData8,Leg888] = fCreateBernoulliMix2(Pi8,X);
[BernStats8] = fFindBernStats(MixData8,1);
MixData = [MixData1;MixData2;MixData3;MixData4;MixData5;MixData6;MixData7;MixData8];

% % ====================================================================% %


% ========================== Apply bICA =============================== %
x = MixData;%ORed;%MixData;
K = 2;
iter = 20;
p = [];
verbose = 0;
mult1 = 100;
mult2 = 100;

[T,N]=size(x);

Alpha00 = rand(T,K)*mult2;%[Stats1(1),Stats2(1)];%,Stats3(1),Stats4(1)]*mult2;%[0.3,0.3] * mult2;%[Stats1(1),Stats2(1)]*mult2;%rand(T,K)*mult2;
Alpha01 = rand(T,K)*mult2;%[Stats1(2),Stats2(2)];%,Stats3(2),Stats4(2)]*mult2;%[0.3,0.3] * mult2;%[Stats1(2),Stats2(2)]*mult2;%rand(T,K)*mult2;
Alpha10 = rand(T,K)*mult2;%[Stats1(3),Stats2(3)];%,Stats3(3),Stats4(3)]*mult2;%[0.2,0.2] * mult2;%[Stats1(3),Stats2(3)]*mult2;%rand(T,K)*mult2;
Alpha11 = rand(T,K)*mult2;%[Stats1(4),Stats2(4)];%,Stats3(4),Stats4(4)]*mult2;%[0.2,0.2] * mult2;%[Stats1(4),Stats2(4)]*mult2;%rand(T,K)*mult2;

[Bmat,B,A,l,S,W,W1,gamma0]= bICA_Test(Alpha00,Alpha01,Alpha10,Alpha11,Stats1,Stats2,Stats3,mult1,mult2,Delta,x,K,iter,p,verbose);

B1 = Bmat(1,:); % Depending on columns
B2 = Bmat(2,:); % Depending on columns
B3 = Bmat(3,:); % Depending on columns
B4 = Bmat(4,:); % Depending on columns

StatsbICA1 = [B1(1,1),B2(1,1),B3(1,1),B4(1,1)];
StatsbICA2 = [B1(1,2),B2(1,2),B3(1,2),B4(1,2)];
%StatsbICA3 = [B1(1,3),B2(1,3)];%,B3(1,3),B4(1,3)];
%StatsbICA4 = [B1(1,4),B2(1,4)];%,B3(1,4),B4(1,4)];

plot3(B1(1,1),B2(1,1),B3(1,1),'bo','Linewidth',2.0);hold on;grid on;
plot3(B1(1,2),B2(1,2),B3(1,2),'ro','Linewidth',2.0);hold on;grid on;
% plot3(B1(1,3),B2(1,3),B3(1,3),'go','Linewidth',2.0);hold on;grid on;
% plot3(B1(1,4),B2(1,4),B3(1,4),'co','Linewidth',2.0);hold on;grid on;


%KLOrigbICA1 = KLDiv(Stats1,StatsbICA1)
%KLOrigbICA2 = KLDiv(Stats2,StatsbICA2)
%KLOrigbICA3 = KLDiv(Stats3,StatsbICA3)

KLOrigbICA1 = KLDiv(StatsbICA1,Stats1)
KLOrigbICA2 = KLDiv(StatsbICA2,Stats2)
% KLOrigbICA3 = KLDiv(StatsbICA3,Stats3)

text(0.8,1,1,strcat('KLdivOrig1__ICA1=',num2str(KLOrigbICA1)))
text(0.9,0.9,0.9,strcat('KLdivOrig2__ICA2=',num2str(KLOrigbICA2)))
% text(0.8,0.8,0.8,strcat('KLdivOrig3__ICA3=',num2str(KLOrigbICA3)))

% ----------------------------------------------------------------------- %
% [Bmat,B,A,l,S,W,W1,gamma0]=bICA_Test(B1,B2,B3,B4,Stats1,Stats2,Stats3,mult1,mult2,Delta,x,K,iter,p,verbose);
% 
% B1 = Bmat(1,:); % Depending on columns
% B2 = Bmat(2,:); % Depending on columns
% B3 = Bmat(3,:); % Depending on columns
% B4 = Bmat(4,:); % Depending on columns
% 
% StatsbICA1 = [B1(1,1),B2(1,1),B3(1,1),B4(1,1)];
% StatsbICA2 = [B1(1,2),B2(1,2),B3(1,2),B4(1,2)];
% StatsbICA3 = [B1(1,3),B2(1,3),B3(1,3),B4(1,3)];
% 
% plot3(B1(1,1),B2(1,1),B3(1,1),'bo','Linewidth',2.0);hold on;grid on;
% plot3(B1(1,2),B2(1,2),B3(1,2),'ro','Linewidth',2.0);hold on;grid on;
% plot3(B1(1,3),B2(1,3),B3(1,3),'go','Linewidth',2.0);hold on;grid on;
% 
% %KLOrigbICA1 = KLDiv(Stats1,StatsbICA1)
% %KLOrigbICA2 = KLDiv(Stats2,StatsbICA2)
% %KLOrigbICA3 = KLDiv(Stats3,StatsbICA3)
% 
% KLOrigbICA1 = KLDiv(StatsbICA1,Stats1)
% KLOrigbICA2 = KLDiv(StatsbICA2,Stats2)
% KLOrigbICA3 = KLDiv(StatsbICA3,Stats3)
% 
% text(0.8,1,1,strcat('KLdivOrig1__ICA1=',num2str(KLOrigbICA1)))
% text(0.9,0.9,0.9,strcat('KLdivOrig2__ICA2=',num2str(KLOrigbICA2)))
% text(0.8,0.8,0.8,strcat('KLdivOrig3__ICA3=',num2str(KLOrigbICA3)))


% x = ORed;%MixData;%ORed;%MixData;
% K = 2;
% iter = 503;
% p = [];
% verbose = 0;
% 
% [B1,A11,l11,S11,W11,W111,gamma011]=bBICA(x,K,iter,p,verbose);
% %%[B,A,l,S,W,W1,gamma0]=bBICA(MixData,2,500,[],0);

























