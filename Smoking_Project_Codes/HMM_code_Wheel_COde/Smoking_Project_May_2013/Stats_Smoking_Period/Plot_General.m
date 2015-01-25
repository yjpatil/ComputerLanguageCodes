function[I] = Plot_General(PSraw,PS,ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,Score,I,list)
% This is a general function to plot the AirFlow, TidalVolume and Proximity
% Signal for the 20 Subjects or Buffalo Data
% Created : 6 Nov 2012

global ts;
    figure;hold on;grid on;title(strcat(list(I,:)));xlabel('Time \it s');
    
    %Hraw = plot(ts,PSraw,'m');     
    
    H0 = plot(ts,PS,'Color',[0.0 1.0 0.0]);    
    H1 = plot(ASts(:,1),ASts(:,2),'-c');
% %     plot(PtsAS(:,1),PtsAS(:,2),'+k');grid on;hold on;
% %     plot(VtsAS(:,1),VtsAS(:,2),'+r');grid on;hold on; 
    H2 = plot(VTts(:,1),VTts(:,2),'Color',[0.0 0.0 1.0]);
% %     plot(PtsVT(:,1),PtsVT(:,2),'ob');grid on;hold on;
% %     plot(VtsVT(:,1),VtsVT(:,2),'ok');grid on;hold on; 
    
    %%%plot(tsintZVT,ampintZVT,'or');
    %%%plot(tsintZAS,ampintZAS,'ob');
    
    O = 2*ones(size(Score,1));
    H3 = plot(Score(:,3),O,'ob');
    H4 = plot(Score(:,6),O,'or');    
    
    legend([H0 H1 H2 H3(1) H4(1)],{'Proximity Sensor' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});    
    %legend([Hraw H0 H1 H2 H3(1) H4(1)],{'Raw PS' 'Proximity Sensor' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});    

end