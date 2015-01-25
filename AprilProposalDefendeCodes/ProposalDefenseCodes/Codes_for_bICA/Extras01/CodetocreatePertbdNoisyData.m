% This code creates Perturbated noise data %
clc;clear all;close all;

D = 4;   % Number of Sensors
N = 50;  % Number of Observations
MaxSensors = 12;  % Total number of Maximum Sensors


Trans = [0.5 0.5; 0.5 0.5];   % [State1-1 State1-2; State2-1 State2-2]
Emis = [1.0 0.0;0.0 1.0];   % <<< Imp Matrix [q 1-q;1-p p] || q = P(x = 0); p = P(x = 1)  <<< Emission of [Obs = 1(0)  Obs = 2(1);Obs = 1(0)  Obs = 2(1)]
  
[seq,states] = hmmgenerate(N,Trans,Emis);
index = find(seq == 1);seq(index) = 0;
index = find(seq == 2);seq(index) = 1;    
  
GndTruth = seq;

% [StatsGndTruth] = fCal_Stats(GndTruth);
% 
% figure;
% H0 = plot3(StatsGndTruth(1),StatsGndTruth(2),StatsGndTruth(3),'or','Linewidth',2.0);
% grid on;hold on;xlim([0 1]);ylim([0 1]);zlim([0 1]);
% xlabel('P00');ylabel('P01');zlabel('P10');
% xlim([0 1]);ylim([0 1]);zlim([0 1])
% hold on;

%t1 = 0.05;t2= 0.08;t3 = 0.1;t4 = 0.13;t5 = 0.17;t6 = 0.19; 

Prtbd = [0.0002,0.0003,0.0004,0.0005,0.0006,0.0007,0.0008,0.0009];
%Prtbd = [0.002,0.003,0.004,0.005,0.006,0.007,0.008,0.009];
%Prtbd = [0.002,0.003,-0.002,-0.003,0.004,0.005,-0.004,-0.005,0.006,0.007,-0.006,-0.007,0.008,0.009,-0.008,-0.009];
%Prtbd = [0.02,0.03,-0.02,-0.03,0.04,0.05,-0.04,-0.05,0.06,0.07,-0.06,-0.07,0.08,0.09,-0.08,-0.09];

[AllData] = fPrtbdNoisyData(Trans,Emis,MaxSensors, GndTruth, Prtbd); % << Comment this


counter1 = 1;

while(D <= MaxSensors)    
    
    NoisyData = AllData(1:D,:); % << Comment this
    
    % >> Uncomment Below << %
%     NoisyData = zeros(D,N);
%     for i = 1 : 1 : D
%         Pos1 = randperm(length(Rho)); 
%         Rho = Rho(Pos1(1)); % To randomly select percentages of Ones
%         [NoisyORedData] = fORedNoisyData(GndTruth, Rho);
%         NoisyData(i,:) = NoisyORedData;
%     end
    % >> Uncomment Above << %
    
    [StatsGndTruth] = fCal_Stats(GndTruth);
    
    StatsData = zeros(D,4); % Stats = [p00 p01 p10 p11]
    
    for i = 1 : 1 : D
        StatsData(i,:) = fCal_Stats(NoisyData(i,:));
    end
    
    figure;%title('Distribution');
    for I = 1 : 1 : D
        gcf;
        H1 = plot3(StatsData(I,1),StatsData(I,2),StatsData(I,3),'bx','Linewidth',2.0);
        hold on;grid on;
    end
        
    H2 = plot3(StatsGndTruth(1,1),StatsGndTruth(1,2),StatsGndTruth(1,3),'ro','Linewidth',2.0);
    
    xlabel('P00');ylabel('P01');zlabel('P10');title(strcat('Statistics for ',num2str(D),'sensors'))
    xlim([0 1]);ylim([0 1]);zlim([0 1])
    
    StatsPC = mean(StatsData);
    
    gcf;
    H3 = plot3(StatsPC(1),StatsPC(2),StatsPC(3),'gp','Linewidth',2.0);
    
    legend([H1 H2 H3],{'Noisy Data' 'Gnd Truth Data' 'Average Data'});
    
    KLdivGT_PC(1,counter1) = KLDiv(StatsGndTruth,StatsPC);
    KLdivGT_PC(2,counter1) = D;
    
    % Results Display %
    Stats(counter1).Sensors = D;
    Stats(counter1).Obs = N;
    Stats(counter1).Prtbd = Prtbd;   %<<<< Uncomment this
    Stats(counter1).StatsGndTruth = StatsGndTruth;
    Stats(counter1).StatsData = StatsData;
    Stats(counter1).StatsPC = StatsPC;        
    Stats(counter1).KLdivGT_PC = KLdivGT_PC;
    
    
      
    counter1 = counter1 + 1;
    
    D = D + 2;
    
end

figure(121);hold on;xlabel('Number of Sensors');ylabel('K-L Divergence')
plot(KLdivGT_PC(2,:),KLdivGT_PC(1,:),'-k');






























