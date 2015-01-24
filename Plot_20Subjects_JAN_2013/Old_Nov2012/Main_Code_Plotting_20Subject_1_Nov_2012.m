% *********************************************************************** %
%               Code to extarct features for Activity                     %
%                         Classification                                  %
% *********************************************************************** %
% Created = 1 Nov 2012 %
clc;clear all;%close all;

global sf ts;
sf = 101.73;

path = char('C:\Users\student\Documents\MATLAB\Biology_bldg_20subjects\');

list = char('Sub_003','Sub_004','Sub_005','Sub_006','Sub_007','Sub_008','Sub_009','Sub_010','Sub_011','Sub_012','Sub_013','Sub_014','Sub_015','Sub_016','Sub_017','Sub_019','Sub_020','Sub_021','Sub_022','Sub_023');

Size_List = size(list,1);

I = 8;

%while(I <= Size_List)
   
    load(strcat(path(1,:),list(I,:),'.mat'));
    
    L = length(Data);
    
    ts = [1:L]/sf;ts = ts';ts = ts-(Activities(1,2));
    
    dat = Data(:,2)/max(Data(:,2)); % Normalized Proximity Sensor before passing to merge function
    PS = merge_function(dat,ts,0.046,0.5,8,1.2);    
    
    [AB,RC] = process_AB_RC(3,Data(:,4),Data(:,5));    % 2 = Invert the Signals 
    [ASr,VTr] = get_AS_VT(0,AB,RC,1,4);        % 0 = (AB+RC)/2,  1 = RC,  2 = AB.% + Filtering using Ideal Filter = 1 or WT filter = 2. ALso the threshold value (4) for the component removal    
    
    [AS,VT] = Normalization_tech(ASr,VTr,2,500,500,[-1 +1]);
    
    ASts = [ts AS];VTts = [ts VT];
    
    [ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal
    
    PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; %% Peaks and Valleys for TIDAL VOLUME(VT) signal %%
    PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS]; %% Peaks and Valleys for AIR FLOW(AF) signal %% 
    
    [ASnorm,VTnorm] = Normalization_Second_stage(ASts(:,2),VTts(:,2),1,VtsAS(:,2),PtsAS(:,2),VtsVT(:,2),PtsVT(:,2),[-1 +1]);
    
    ASts = []; VTts = [];
    
    ASts = [ts ASnorm];VTts = [ts VTnorm];
    
    [ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal
    
    PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; %% Peaks and Valleys for TIDAL VOLUME(VT) signal %%
    PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS]; %% Peaks and Valleys for AIR FLOW(AF) signal %% 
    
    figure;hold on;grid on;title(strcat(list(I,:)));xlabel('Time \it s');
    
    H0 = plot(ts,PS,'Color',[0.1 0.3 0.9]);    
    H1 = plot(ASts(:,1),ASts(:,2),'Color',[0.7 0.3 0.6]);
    %plot(LpAS,MpAS,'+k');grid on;hold on;
    %plot(LvAS,MvAS,'+r');grid on;hold on; 
    H2 = plot(VTts(:,1),VTts(:,2),'Color',[0.1 0.7 0.5]);
    %plot(LpVT,MpVT,'ob');grid on;hold on;
    %plot(LvVT,MvVT,'ok');grid on;hold on; 
    
    O = 0.28*ones(size(Score,1));
    H3 = plot(Score(:,4),O,'ob');
    H4 = plot(Score(:,5),O,'or');    
    
    legend([H0 H1 H2 H3(1) H4(1)],{'Proximity Sensor' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});
    
    it1 = 2;
    while(it1 <= length(Activities))
        temp1 = [rand rand rand];
        plot([Activities(it1,1) Activities(it1,1)],[-4 4],'Color',temp1,'LineWidth',2); 
        plot([Activities(it1,2) Activities(it1,2)],[-4 4],'Color',temp1,'LineWidth',2); 
        it1 = it1 + 1;
    end
    
    
    
    
    
    
%end






