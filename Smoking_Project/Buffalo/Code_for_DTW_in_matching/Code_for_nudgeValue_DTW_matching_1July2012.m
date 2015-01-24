% ----------------------------------------------------------------------- %
%       Description: This code tests the templates of VT and AS saved     %
%     against the outdoor sessions.                                    
% ----------------------------------------------------------------------- %

clc;clear all;
close all;

global sf ts;

sf = 101.73;

path = char('C:\Users\Yuri\Documents\MATLAB\Smoking_Project\DTW\Buffalo_data_mat_files\');

pathVT = char('C:\Users\Yuri\Documents\MATLAB\Smoking_Project\DTW\PACT_114_Templates_26Jun2012\Templates_for_Smoking_VT\');

pathAS = char('C:\Users\Yuri\Documents\MATLAB\Smoking_Project\DTW\PACT_114_Templates_26Jun2012\Templates_FOR_smoking_AS\');

pathPS = char('C:\Users\Yuri\Documents\MATLAB\Smoking_Project\DTW\PACT_114_Templates_26Jun2012\Templates_FOR_smoking_PS\');

list = char('DATA_PACT_105','DATA_PACT_107','DATA_PACT_108','DATA_PACT_109','DATA_PACT_114','DATA_PACT_117','DATA_PACT_118','DATA_PACT_120','DATA_PACT_122','DATA_PACT_124','DATA_PACT_131','DATA_PACT_132','DATA_PACT_134','DATA_PACT_138','DATA_PACT_140');

listVT = char('PACT114_Volume_Tidal_005');

listAS = char('PACT114_Air_Flow_003');

listPS = char('PACT114_Proximity_Sensor_001');

Size_List = size(list,1);

I = 5;


    load(strcat(path(1,:),list(I,:),'.mat'));
    
    load(strcat(pathVT(1,:),listVT(1,:),'.mat'));
    
    load(strcat(pathAS(1,:),listAS(1,:),'.mat'));
    
    %load(strcat(pathPS(1,:),listPS(1,:),'.mat'));     
    
    clear('AB','RC','VT','AS','ASts','VTts')
    
    ts = Signals(:,1);
    
    [AB,RC] = process_AB_RC(1,Signals(:,2),Signals(:,3));   % 1 = no-inversion, 2 = invert
    
    AB = AB/max(AB); RC = RC/max(RC);    % Normalise RC and AB
    
    [AS,VT] = get_AS_VT(0,AB,RC);        % 0 = (AB+RC)/2,  1 = RC,  2 = AB.
    
    AS1 = AS;
    
    AS = AS + abs(min(AS))*ones(length(AS),1);
    VT = VT + abs(min(VT))*ones(length(VT),1);
    %figure
    %plot(ts,VT,'g');hold on; grid on;
    
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
    
    PtsVTind = find(Lab_sessions(1,2) <= PtsVT(:,1) & PtsVT(:,1) <= Lab_sessions(2,1));
    newPtsVT = PtsVT(PtsVTind,:);
    %plot(newPtsVT(:,1),newPtsVT(:,2),'or');grid on;hold on;
    
    VtsVTind = find(Lab_sessions(1,2) <= VtsVT(:,1) & VtsVT(:,1) <= Lab_sessions(2,1));
    newVtsVT = VtsVT(VtsVTind,:);
    
    PtsASind = find(Lab_sessions(1,2) <= PtsAS(:,1) & PtsAS(:,1) <= Lab_sessions(2,1));
    newPtsAS = PtsAS(PtsASind,:);
    
    VtsASind = find(Lab_sessions(1,2) <= VtsAS(:,1) & VtsAS(:,1) <= Lab_sessions(2,1));
    newVtsAS = VtsAS(VtsASind,:);
    
    %            PLOT            %
% % %     figure
% % %     %title(list(I,:));xlabel('Time \it s');ylabel('\it VT , AS , PS ');title(list(I,:));
% % %     plot(ts,Signals(:,4)/max(Signals(:,4)),'-g');title(list(I,:));xlabel('Time \it s');ylabel('\it VT , AS , PS ');grid on; hold on;
% % %     O = 0.78*ones(size(puff_score,1));plot(puff_score(:,1),O,'or');plot(puff_score(:,2),O,'ob');hold on;grid on;
% % %     O = 0.18*ones(size(puff_score,1));plot(puff_score(:,1),O,'or');plot(puff_score(:,2),O,'ob');hold on;grid on;
% % %     plot([Lab_sessions(1,2) Lab_sessions(1,2)],[2 -2],'--k');grid on;hold on;plot([Lab_sessions(2,1) Lab_sessions(2,1)],[2 -2],'--k');grid on;hold on;
% % %     plot(ts,AS,'c');hold on; grid on;
% % %     %plot(LpAS,MpAS,'ok');grid on;hold on;
% % %     %plot(LvAS,MvAS,'or');grid on;hold on;
% % %     
% % %     plot(ts,VT,'b');hold on; grid on;
% % %     %plot(LpVT,MpVT,'ob');grid on;hold on;
% % %     plot(newPtsVT(:,1),newPtsVT(:,2),'ob');grid on;hold on;
    
    %plot(LvVT,MvVT,'ok');grid on;hold on; 
    
    figure
    %plot(ts,Signals(:,4)/max(Signals(:,4)),'b');hold on; grid on;
    %plot(ts,VT,'g');hold on; grid on;
    %plot(newPtsVT(:,1),newPtsVT(:,2),'or');grid on;hold on;
    plot(ts,AS1,'b');hold on; grid on;%plot(newPtsAS(:,1),newPtsAS(:,2),'or');grid on;hold on;
    plot([ts(1) ts(length(ts))],[0 0],'--k');grid on;hold on;
    O = 0.1*ones(size(puff_score,1));plot(puff_score(:,1),O,'og');plot(puff_score(:,2),O,'og');hold on;grid on;
    plot([Lab_sessions(1,2) Lab_sessions(1,2)],[2 -2],'--k');grid on;hold on;plot([Lab_sessions(2,1) Lab_sessions(2,1)],[2 -2],'--k');grid on;hold on;
    
    IT = 2700;
    offset1 = -2.00883;
    offset2 = +2.52654;
    count = 1;
    while(IT <= length(newPtsVT))
        P1 = newPtsVT(IT,1);
        %indtest = find(P1+offset1 <= VTts(:,1) & VTts(:,1) <= P1+offset2);
        indtest = find(P1+offset1 <= ASts(:,1) & ASts(:,1) <= P1+offset2);
        %indtest = find(P1+offset1 <= Signals(:,1) & Signals(:,1) <= P1+offset2);
        %test = VTts(indtest,2)'; % as row vector
        %test = test + abs(min(test))*ones(1,length(test));
        test = ASts(indtest,2)'; % as row vector
        test = test + abs(min(test))*ones(1,length(test));
        %test = (Signals(indtest,4)/max(Signals(indtest,4)))'; % as row vector
        %temp = PACT114_Volume_Tidal_005(:,2)';
        %temp = temp + abs(min(test))*ones(1,length(temp));
        temp = PACT114_Air_Flow_003(:,2)';
        temp = temp + abs(min(test))*ones(1,length(temp));
        %temp = (PACT114_Proximity_Sensor_001/max(PACT114_Proximity_Sensor_001))';
        [MatchScore,D,K,w] = dtw(temp,test);
        time(count) = P1;%+offset1;time(IT,2) = P1+offset2;
        ms(count) = MatchScore/10;
        clear('D','K','w');        
        IT = IT + 1;count = count + 1;
    end
        gcf;
        plot(time,ms,'k');%hold on; grid on;
    
    
    
    
    
    
    
    
    
    