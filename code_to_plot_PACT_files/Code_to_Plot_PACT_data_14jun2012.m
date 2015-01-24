% Code to score the Brian Scored 5 PACT subjects %
% Created : 14 Jun 2012

clc;%clear all;%close all;

global sf ts;
sf = 101.73;

path = char('C:\Users\student\Documents\MATLAB\Buffalo_data_mat_files\');

list = char('DATA_PACT_105','DATA_PACT_107','DATA_PACT_108','DATA_PACT_109','DATA_PACT_114','DATA_PACT_117','DATA_PACT_118','DATA_PACT_120','DATA_PACT_122','DATA_PACT_124','DATA_PACT_131','DATA_PACT_132','DATA_PACT_134','DATA_PACT_138','DATA_PACT_140');

Size_List = size(list,1);

I = 5;

%%while(I <= Size_List)
    
    load(strcat(path(1,:),list(I,:),'.mat'));
    
    clear('AB','RC','VT','AS','ASts','VTts')
    
    ts = Signals(:,1);
    
    [AB,RC] = process_AB_RC(1,Signals(:,2),Signals(:,3));   % 1 = no-inversion, 2 = invert
    
    AB = AB/max(AB); RC = RC/max(RC);    % Normalise RC and AB
    
    [AS,VT] = get_AS_VT(0,AB,RC);        % 0 = (AB+RC)/2,  1 = RC,  2 = AB.
    
    ASts = [ts AS];VTts = [ts VT];
    
    %     peaks of VT signal      %
    %[LpVT,MpVT] = peakfinder(VT,0.018,-0.03,1);
    [LpVT,MpVT] = peakfinder(VT,0.03,0.0,1);
    LpVT = VTts(LpVT,1);
    
    %     valleys of VT signal    %
    %[LvVT,MvVT] = peakfinder(VT,0.018,0.01,-1);
    [LvVT,MvVT] = peakfinder(VT,0.018,0.0,-1);
    LvVT = VTts(LvVT,1);
    
    %     peaks of AS signal      %
    %[LpAS,MpAS] = peakfinder(AS,0.018,-0.03,1);
    [LpAS,MpAS] = peakfinder(AS,0.03,0.0,1);
    LpAS = ASts(LpAS,1);
    
    %     valleys of AS signal    %
    %[LvAS,MvAS] = peakfinder(AS,0.018,0.01,-1);
    [LvAS,MvAS] = peakfinder(AS,0.03,0.0,-1);
    LvAS = ASts(LvAS,1);
    
    PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 
    PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];
    
    %            PLOT            %
    figure
    %title(list(I,:));xlabel('Time \it s');ylabel('\it VT , AS , PS ');title(list(I,:));
    plot(ts,Signals(:,4)/max(Signals(:,4)),'-g');title(list(I,:));xlabel('Time \it s');ylabel('\it VT , AS , PS ');grid on; hold on;
    O = 0.78*ones(size(puff_score,1));plot(puff_score(:,1),O,'or');plot(puff_score(:,2),O,'ob');hold on;grid on;
    O = 0.18*ones(size(puff_score,1));plot(puff_score(:,1),O,'or');plot(puff_score(:,2),O,'ob');hold on;grid on;
    plot([Lab_sessions(1,2) Lab_sessions(1,2)],[2 -2],'--k');grid on;hold on;plot([Lab_sessions(2,1) Lab_sessions(2,1)],[2 -2],'--k');grid on;hold on;
    plot(ts,AS,'c');hold on; grid on;
    %plot(LpAS,MpAS,'ok');grid on;hold on;
    %plot(LvAS,MvAS,'or');grid on;hold on;
    
    plot(ts,VT,'b');hold on; grid on;
    plot(LpVT,MpVT,'ob');grid on;hold on;
    plot(LvVT,MvVT,'ok');grid on;hold on; 
    
        
    
    I = I + 1;
%%end

