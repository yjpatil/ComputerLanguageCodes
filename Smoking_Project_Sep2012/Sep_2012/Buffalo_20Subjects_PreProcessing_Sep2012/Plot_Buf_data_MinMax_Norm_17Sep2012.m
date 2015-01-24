% Code to plot the PACT subjects %
% Created : 14 Jun 2012

clc;clear all;close all;

global sf ts;
sf = 101.73;

path = char('C:\Users\student\Documents\MATLAB\Buffalo_data_mat_files\');

list = char('DATA_PACT_105','DATA_PACT_107','DATA_PACT_108','DATA_PACT_109','DATA_PACT_114','DATA_PACT_117','DATA_PACT_118','DATA_PACT_120','DATA_PACT_122','DATA_PACT_124','DATA_PACT_127','DATA_PACT_128','DATA_PACT_129','DATA_PACT_131','DATA_PACT_132','DATA_PACT_134','DATA_PACT_136','DATA_PACT_138','DATA_PACT_140');

Size_List = size(list,1);

I = 7;

%%while(I <= Size_List)
    
    load(strcat(path(1,:),list(I,:),'.mat'));
    
    clear('AB','RC','VT','AS','ASts','VTts','AS_min','AS_max','VT_min','VT_max')
    
    ts = Signals(:,1);
    
    [AB,RC] = process_AB_RC(1,Signals(:,2),Signals(:,3));   % 1 = no-inversion, 2 = invert
    
    %AB = AB/max(AB); RC = RC/max(RC);    % Normalise RC and AB
    
    [AS,VT] = get_AS_VT(0,AB,RC,1,4,ts);        % 0 = (AB+RC)/2,  1 = RC,  2 = AB.% + Filtering using Ideal Filter = 1 or WT filter = 2. ALso the threshold value for the component removal
%     figure
%     plot(ts,AS,'c');hold on;
%     plot(ts,VT,'b');
%     k = 1
    [AS,VT] = Normalization_tech(AS,VT,1,600,600,[-1 +1]);
% %     figure
% %     plot(ts,AS,'c');hold on;
% %     plot(ts,VT,'b');
% %     jy = 1

    ASts = [ts AS];VTts = [ts VT];
    
    %     peaks of VT signal      %
    %[LpVT,MpVT] = peakfinder(VT,0.018,-0.03,1);
    [LpVT,MpVT] = peakfinder(VT,0.018,0.01,1);
    %[LpVT,MpVT] = peakfinder(VT,0.03,0.0,1);
    LpVT = VTts(LpVT,1);
        
    %     valleys of VT signal    %
    %[LvVT,MvVT] = peakfinder(VT,0.03,0.01,-1);
    [LvVT,MvVT] = peakfinder(VT,0.018,-0.01,-1);
    LvVT = VTts(LvVT,1);    
    
    %     peaks of AS signal      %
    [LpAS,MpAS] = peakfinder(AS,0.018,0.01,1);
    %[LpAS,MpAS] = peakfinder(AS,0.03,0.0,1);
    LpAS = ASts(LpAS,1);
    
    %     valleys of AS signal    %
    [LvAS,MvAS] = peakfinder(AS,0.018,-0.01,-1);
    %[LvAS,MvAS] = peakfinder(AS,0.03,0.0,-1);
    LvAS = ASts(LvAS,1);
    
    PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 
    PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];
    
    %%[PtsAS] = Clean_Wave(PtsAS,VtsAS);
    
    %            PLOT            %
    figure;grid on;hold on;
    %title(list(I,:));xlabel('Time \it s');ylabel('\it VT , AS , PS ');    
    %plot(ts,Signals(:,4)/max(Signals(:,4)),'-g');title(list(I,:));xlabel('Time \it s');ylabel('\it VT , AS , PS ');grid on; hold on;
    O = 0.48*ones(size(puff_score,1));plot(puff_score(:,1),O,'og');title(list(I,:));plot(puff_score(:,2),O,'og');hold on;grid on;
    O = 0.18*ones(size(puff_score,1));h3 = plot(puff_score(:,1),O,'or');h4 = plot(puff_score(:,2),O,'ob');hold on;grid on;
    plot([Lab_sessions(1,2) Lab_sessions(1,2)],[1 -1],'--k');grid on;hold on;plot([Lab_sessions(2,1) Lab_sessions(2,1)],[1 -1],'--k');grid on;hold on;
    
    h1 = plot(ASts(:,1),ASts(:,2),'Color',[0.1 0.1 0.9]);%legend(h(1),'Air Flow');hold on; grid on;
%     plot(PtsAS(:,1),PtsAS(:,2),'om');grid on;hold on;
%     plot(VtsAS(:,1),VtsAS(:,2),'+r');grid on;hold on;
    

    %h2 = plot(ts,VT,'Color',[1 0.5 0.2]);hold on; grid on;
    %plot(LpVT,MpVT,'ob');grid on;hold on;   
    %plot(LvVT,MvVT,'+k');grid on;hold on; 
    
    legend([h1 h3(1) h4(1)],{'Air Flow' 'Start of Puff' 'End of Puff'});
% % %     legend([h1 h3(1) h4(1) q1_min q2_max q3_start q4_end],{'Air Flow' 'Start of Puff' 'End of Puff' 'Threshold above which the VT signal should stay' 'Threshold below which the VT signal should stay' 'Starting amplitude of VT' 'End amplitude of VT'});
    title(list(I,:));xlabel('Time \it s');
    
        
    %figure
    %title(list(I,:));xlabel('Time \it s');ylabel('\it VT , AS , PS ');    
    %plot(ts,Signals(:,4)/max(Signals(:,4)),'-g');title(list(I,:));xlabel('Time \it s');ylabel('\it VT , AS , PS ');grid on; hold on;
% %     O = 0.38*ones(size(puff_score,1));plot(puff_score(:,1),O,'or');title(list(I,:));plot(puff_score(:,2),O,'og');hold on;grid on;
% %     O = 0.28*ones(size(puff_score,1));h3 = plot(puff_score(:,1),O,'or');h4 = plot(puff_score(:,2),O,'ob');hold on;grid on;
    plot([Lab_sessions(1,2) Lab_sessions(1,2)],[1 -1],'--k');grid on;hold on;plot([Lab_sessions(2,1) Lab_sessions(2,1)],[1 -1],'--k');grid on;hold on;
    
        

    h2 = plot(ts,VT,'Color',[1 0.1 0.2]);hold on; grid on;
%     plot(LpVT,MpVT,'ob');grid on;hold on;   
%     plot(LvVT,MvVT,'+k');grid on;hold on; 
    
    legend([h1 h2 h3(1) h4(1)],{'Air Flow' 'Volume Tidal' 'Start of Puff' 'End of Puff'});
% % %     legend([h2 h3(1) h4(1) q1_min q2_max q3_start q4_end],{'Volume Tidal' 'Start of Puff' 'End of Puff' 'Threshold above which the VT signal should stay' 'Threshold below which the VT signal should stay' 'Starting amplitude of VT' 'End amplitude of VT'});
    title(list(I,:));xlabel('Time \it s');
    
    
    
    
    
    