function[I] = Plot_General(PSraw,PS,ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,Score,I,list,Case)
% This is a general function to plot the AirFlow, TidalVolume and Proximity
% Signal for the 20 Subjects or Buffalo Data
% Created : 6 Nov 2012

global ts;

if(Case == 1)
    figure;hold on;grid on;title(strcat(list(I,:)));xlabel('Time \it s');    
    %Hraw = plot(ts,PSraw,'m');         
    H0 = plot(ts,PS,'g');    
    H1 = plot(ASts(:,1),ASts(:,2),'-c');
    % %     plot(PtsAS(:,1),PtsAS(:,2),'+k');grid on;hold on;
    % %     plot(VtsAS(:,1),VtsAS(:,2),'+r');grid on;hold on; 
    H2 = plot(VTts(:,1),VTts(:,2),'b');
    % %     plot(PtsVT(:,1),PtsVT(:,2),'ob');grid on;hold on;
    plot(VtsVT(:,1),VtsVT(:,2),'ok');grid on;hold on;     
    %%%plot(tsintZVT,ampintZVT,'or');
    %%%plot(tsintZAS,ampintZAS,'ob');    
    O = 2*ones(size(Score,1));
    H3 = plot(Score(:,3),O,'ob');
    H4 = plot(Score(:,4),O,'or');        
    legend([H0 H1 H2 H3(1) H4(1)],{'Proximity Sensor' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});    
    %legend([Hraw H0 H1 H2 H3(1) H4(1)],{'Raw PS' 'Proximity Sensor' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});    
elseif(Case == 2)
    figure(1);hold on;grid on;title(strcat(list(I,[1:3,5:7]),'AirFlow'));xlabel('Time \it s');    
    %Hraw = plot(ts,PSraw,'m');         
    H0 = plot(ts,PS,'g');    
    H1 = plot(ASts(:,1),ASts(:,2),'-c');
    % %     plot(PtsAS(:,1),PtsAS(:,2),'+k');grid on;hold on;
    % %     plot(VtsAS(:,1),VtsAS(:,2),'+r');grid on;hold on; 
    O = 0.02*ones(size(Score,1));
    H3 = plot(Score(:,3),O,'ob');
    H4 = plot(Score(:,4),O,'or');        
    
    %legend([H0 H1 H2 H3(1) H4(1)],{'Proximity Sensor' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});
    
    figure(2);hold on;grid on;title(strcat(list(I,[1:3,5:7]),'TidalVolume'));xlabel('Time \it s');    
    %Hraw = plot(ts,PSraw,'m');         
    H0 = plot(ts,PS,'g');    
    H2 = plot(VTts(:,1),VTts(:,2),'b');
    % %     plot(PtsVT(:,1),PtsVT(:,2),'ob');grid on;hold on;
    % %     plot(VtsVT(:,1),VtsVT(:,2),'ok');grid on;hold on;     
    %%%plot(tsintZVT,ampintZVT,'or');
    %%%plot(tsintZAS,ampintZAS,'ob');    
    O = 0.02*ones(size(Score,1));
    H3 = plot(Score(:,3),O,'ob');
    H4 = plot(Score(:,4),O,'or');        
    %legend([H0 H1 H2 H3(1) H4(1)],{'Proximity Sensor' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});    
    %legend([Hraw H0 H1 H2 H3(1) H4(1)],{'Raw PS' 'Proximity Sensor' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});

end






end