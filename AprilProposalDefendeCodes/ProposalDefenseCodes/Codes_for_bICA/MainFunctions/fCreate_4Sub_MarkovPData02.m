function[Data1,Data2,Data3,Data4,Data5,Data6,Data7,Data8,StatsData1,StatsData2,StatsData3,StatsData4,StatsData5,StatsData6,StatsData7,StatsData8] = fCreate_4Sub_MarkovPData02(N,MaxSensors)

% ======================= For Target 1 =================== Medium-Small 1's
% % Medium Angle % %
Stheta1 = 15; % -22.5 <= Stheta <= 22.5
Ltheta1 = 35; % -45 <= Stheta <= 45
Delta1 = 5;
Trans1 = [0.25 0.75; 0.25 0.75]; % **** Trans = [Ones, Zeros;Ones,Zeros]******
[Data01] = fCreateSinAlphaData(MaxSensors,Stheta1,Ltheta1,N,Trans1,Delta1);
for i = 1 : 1 : MaxSensors
    StatsData1(i,:) = fCal_Stats(Data01(i,:));
end

% ================= For Target 2 ======================== % Large 1's %
% % Small Angle % %
Stheta2 = 12; % -22.5 <= Stheta <= 22.5
Ltheta2 = 25; % -45 <= Stheta <= 45
Delta2 = 25;
Trans2 = [0.50 0.50; 0.50 0.50]; % **** Trans = [Ones, Zeros;Ones,Zeros]******
[Data02] = fCreateSinAlphaData(MaxSensors,Stheta2,Ltheta2,N,Trans2,Delta2);
for i = 1 : 1 : MaxSensors
    StatsData2(i,:) = fCal_Stats(Data02(i,:));
end
%figure;%title('Distribution');

% ================== For Target 3 ===================== Small 1's % 
% % Small-Large Angle % %
Stheta3 = 5; % -22.5 <= Stheta <= 22.5
Ltheta3 = 40; % -45 <= Stheta <= 45
Delta3 = 20;
Trans3 = [0.50 0.50; 0.50 0.50]; % **** Trans = [Ones, Zeros;Ones,Zeros]******
[Data03] = fCreateSinAlphaData(MaxSensors,Stheta3,Ltheta3,N,Trans3,Delta3);
for i = 1 : 1 : MaxSensors
    StatsData3(i,:) = fCal_Stats(Data03(i,:));
end
%figure;%title('Distribution');

% ================== For Target 4 =================== % Medium-Large 1's
% Small-Large Angle %
Stheta4 = 12; % -22.5 <= Stheta <= 22.5
Ltheta4 = 45; % -45 <= Stheta <= 45
Delta4 = 15;
Trans4 = [0.50 0.50; 0.50 0.50]; % **** Trans = [Ones, Zeros;Ones,Zeros]******
[Data04] = fCreateSinAlphaData(MaxSensors,Stheta4,Ltheta4,N,Trans4,Delta4);
for i = 1 : 1 : MaxSensors
    StatsData4(i,:) = fCal_Stats(Data04(i,:));
end
%figure;%title('Distribution');

% ================ For Target 5 ================== % Medium 1's
Stheta5 = 10; % -22.5 <= Stheta <= 22.5
Ltheta5 = 41; % -45 <= Stheta <= 45
Delta5 = 15;
Trans5 = [0.70 0.30; 0.70 0.30]; % **** Trans = [Ones, Zeros;Ones,Zeros]******
[Data05] = fCreateSinAlphaData(MaxSensors,Stheta5,Ltheta5,N,Trans5,Delta5);
for i = 1 : 1 : MaxSensors
    StatsData5(i,:) = fCal_Stats(Data05(i,:));
end

% =============== For Target 6 =================== % Small-Medium 1's %
% Small-Large Angle % %
Stheta6 = 5.0; % -22.5 <= Stheta <= 22.5
Ltheta6 = 42; % -45 <= Stheta <= 45
Delta6 = 20;
Trans6 = [0.45 0.55; 0.45 0.55]; % **** Trans = [Ones, Zeros;Ones,Zeros]******
[Data06] = fCreateSinAlphaData(MaxSensors,Stheta6,Ltheta6,N,Trans6,Delta6);
for i = 1 : 1 : MaxSensors
    StatsData6(i,:) = fCal_Stats(Data06(i,:));
end

% =============== For Target 7 =================== % Medium-Larger 1's
% Stheta7 = 12; % -22.5 <= Stheta <= 22.5
% Ltheta7 = 25; % -45 <= Stheta <= 45
% Delta7 = 25;
% Trans7 = [0.07 0.93; 0.07 0.93]; 
% [Data07] = fCreateSinAlphaData(MaxSensors,Stheta7,Ltheta7,N,Trans7,Delta7);
% for i = 1 : 1 : MaxSensors
%     StatsData7(i,:) = fCal_Stats(Data07(i,:));
% end
Stheta7 = 12; % -22.5 <= Stheta <= 22.5
Ltheta7 = 45; % -45 <= Stheta <= 45
Delta7 = 15;
Trans7 = [0.75 0.25; 0.75 0.25]; % **** Trans = [Ones, Zeros;Ones,Zeros]******
[Data07] = fCreateSinAlphaData(MaxSensors,Stheta7,Ltheta7,N,Trans7,Delta7);
for i = 1 : 1 : MaxSensors
    StatsData7(i,:) = fCal_Stats(Data07(i,:));
end
% ================== For Target 8 ===================== Small 1's % 
% % Small-Large Angle % %
Stheta8 = 5; % -22.5 <= Stheta <= 22.5
Ltheta8 = 40; % -45 <= Stheta <= 45
Delta8 = 20;
Trans8 = [0.60 0.40; 0.60 0.40];
[Data08] = fCreateSinAlphaData(MaxSensors,Stheta8,Ltheta8,N,Trans8,Delta8);
for i = 1 : 1 : MaxSensors
    StatsData8(i,:) = fCal_Stats(Data08(i,:));
end

% =========================xxxxxxxxx================================== %
Data1 = Data01(1,:);%Data01(2,:);
Data2 = Data02(1,:);%Data03(1,:);
Data3 = Data03(1,:);%Data04(3,:);
Data4 = Data04(1,:);%Data02(2,:);
Data5 = Data05(1,:);
Data6 = Data06(1,:);
Data7 = Data07(1,:);
Data8 = Data08(1,:);

StatsData1 = StatsData1(1,:);
StatsData2 = StatsData2(1,:);
StatsData3 = StatsData3(1,:);
StatsData4 = StatsData4(1,:);
StatsData5 = StatsData5(1,:);
StatsData6 = StatsData6(1,:);
StatsData7 = StatsData7(1,:);
StatsData8 = StatsData8(1,:);
% <>  <>  <>   <>   ====== Plot Section ======== <>   <>   <>   <> %
% ------------------------------------- (1) ----------------------------- %
% % % figure;%title('Distribution');
% % % for I = 1 : 1 : MaxSensors
% % %     gcf;
% % %     H11 = plot3(StatsData1(I,1),StatsData1(I,2),StatsData1(I,3),'bx','Linewidth',2.0);
% % %     hold on;grid on;
% % % end
% % % xlabel('P00');ylabel('P01');zlabel('P10');%title(strcat('Statistics for ',num2str(D),'sensors'))
% % % xlim([0 1]);ylim([0 1]);zlim([0 1])
% % % %legend([H11],{'8 Sensor Stats for Target 1'});
% % % % ------------------------------------- (2) ----------------------------- %
% % % for I = 1 : 1 : MaxSensors
% % %     gcf;
% % %     H22 = plot3(StatsData2(I,1),StatsData2(I,2),StatsData2(I,3),'rx','Linewidth',2.0);
% % %     hold on;grid on;
% % % end
% % % xlabel('P00');ylabel('P01');zlabel('P10');%title(strcat('Statistics for ',num2str(D),'sensors'))
% % % xlim([0 1]);ylim([0 1]);zlim([0 1])
% % % legend([H11 H22],{'8 Sensor Stats for Target 1' '8 Sensor Stats for Target 2'});
% % % % ------------------------------------- (3) ----------------------------- %
% % % for I = 1 : 1 : MaxSensors
% % %     gcf;
% % %     H33 = plot3(StatsData3(I,1),StatsData3(I,2),StatsData3(I,3),'mx','Linewidth',2.0);
% % %     hold on;grid on;
% % % end
% % % xlabel('P00');ylabel('P01');zlabel('P10');%title(strcat('Statistics for ',num2str(D),'sensors'))
% % % xlim([0 1]);ylim([0 1]);zlim([0 1])
% % % legend([H11 H22 H33],{'8 Sensor Stats for Target 1' '8 Sensor Stats for Target 2' '8 Sensor Stats for Target 3'});
% % % % ------------------------------------- (4) ----------------------------- %
% % % for I = 1 : 1 : MaxSensors
% % %     gcf;
% % %     H44 = plot3(StatsData4(I,1),StatsData4(I,2),StatsData4(I,3),'gx','Linewidth',2.0);
% % %     hold on;grid on;
% % % end
% % % xlabel('P00');ylabel('P01');zlabel('P10');%title(strcat('Statistics for ',num2str(D),'sensors'))
% % % xlim([0 1]);ylim([0 1]);zlim([0 1])
% % % % ------------------------------------- (5) ----------------------------- %
% % % for I = 1 : 1 : MaxSensors
% % %     gcf;
% % %     H55 = plot3(StatsData5(I,1),StatsData5(I,2),StatsData5(I,3),'kx','Linewidth',2.0);
% % %     hold on;grid on;
% % % end
% % % xlabel('P00');ylabel('P01');zlabel('P10');%title(strcat('Statistics for ',num2str(D),'sensors'))
% % % xlim([0 1]);ylim([0 1]);zlim([0 1])
% % % % ------------------------------------- (6) ----------------------------- %
% % % for I = 1 : 1 : MaxSensors
% % %     gcf;
% % %     H66 = plot3(StatsData6(I,1),StatsData6(I,2),StatsData6(I,3),'cx','Linewidth',2.0);
% % %     hold on;grid on;
% % % end
% % % xlabel('P00');ylabel('P01');zlabel('P10');%title(strcat('Statistics for ',num2str(D),'sensors'))
% % % xlim([0 1]);ylim([0 1]);zlim([0 1])
% % % % ------------------------------------- (7) ----------------------------- %
% % % for I = 1 : 1 : MaxSensors
% % %     gcf;
% % %     H77 = plot3(StatsData7(I,1),StatsData7(I,2),StatsData7(I,3),'x','Color',[0.3,0.5,0.1],'Linewidth',2.0);
% % %     hold on;grid on;
% % % end
% % % xlabel('P00');ylabel('P01');zlabel('P10');%title(strcat('Statistics for ',num2str(D),'sensors'))
% % % xlim([0 1]);ylim([0 1]);zlim([0 1])
% % % % ------------------------------------- (8) ----------------------------- %
% % % for I = 1 : 1 : MaxSensors
% % %     gcf;
% % %     H88 = plot3(StatsData8(I,1),StatsData8(I,2),StatsData8(I,3),'x','Color',[0.5,0.5,0.9],'Linewidth',2.0);
% % %     hold on;grid on;
% % % end
% % % xlabel('P00');ylabel('P01');zlabel('P10');%title(strcat('Statistics for ',num2str(D),'sensors'))
% % % xlim([0 1]);ylim([0 1]);zlim([0 1])
% % % % ------------------------------------- (0) ----------------------------- %
% % % 
% % % legend([H88 H33 H66 H77 H44 H55 H11 H22],{'Target 1' 'Target 2' 'Target 3' 'Target 4' 'Target 5' 'Target 6' 'Target 7' 'Target 8'});




end












