% *********************************************************************** %
%  MEAN only    Code to gets the statstics for peak and valley            %
%                  so as to get normalization for each subjects           %
%                         within a defined range                          %
% *********************************************************************** %
% Created = 5 Nov 2012 %

clc;clear all;close all;

global sf ts;
sf = 101.73;

path = char('C:\Users\student\Documents\MATLAB\Biology_bldg_20subjects\');

list = char('Sub_003','Sub_004','Sub_005','Sub_006','Sub_007','Sub_008','Sub_009','Sub_010','Sub_011','Sub_012','Sub_013','Sub_014','Sub_015','Sub_016','Sub_017','Sub_019','Sub_020','Sub_021','Sub_022','Sub_023');

Size_List = size(list,1);

I = 1;

while(I <= Size_List)
   
    load(strcat(path(1,:),list(I,:),'.mat'));
    
    L = length(Data);
    
    ts = [1:L]/sf;ts = ts';ts = ts-(Activities(1,2));
    
    dat = Data(:,2)/max(Data(:,2)); % Normalized Proximity Sensor before passing to merge function
    PS = merge_function(dat,ts,0.046,0.5,8,1.2);    
    
    [AB,RC] = process_AB_RC(3,Data(:,4),Data(:,5));    % 2&3 = Invert the Signals 
    
    [ASr,VTr] = get_AS_VT(0,AB,RC,1,4);        % 0 = (AB+RC)/2,  1 = RC,  2 = AB.% + Filtering using Ideal Filter = 1 or WT filter = 2. ALso the threshold value (4) for the component removal    
    
    %[AS,VT] = Normalization_tech(ASr,VTr,2,600,600,[-1 +1]);
    
    ASts = [ts ASr];VTts = [ts VTr];
    
    [ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal
    
    PtsVT1 = [LpVT MpVT]; VtsVT1 = [LvVT MvVT]; %% Peaks and Valleys for TIDAL VOLUME(VT) signal %%
    PtsAS1 = [LpAS MpAS]; VtsAS1 = [LvAS MvAS]; %% Peaks and Valleys for AIR FLOW(AF) signal %% 
    
    Stats_Mean_before_Norm(I,:) = [mean(PtsAS1(:,2)) std(PtsAS1(:,2)) mean(VtsAS1(:,2)) std(VtsAS1(:,2)) mean(PtsVT1(:,2)) std(PtsVT1(:,2)) mean(VtsVT1(:,2)) std(VtsVT1(:,2))];
    
    Stats_Median_before_Norm(I,:) = [median(PtsAS1(:,2)) median(VtsAS1(:,2)) median(PtsVT1(:,2)) median(VtsVT1(:,2))];
    
    Case_Value = 2;% Case_Value ==2 for MEAN
    
    %while(Case_Value <= 1)
        
        PtsVT = []; VtsVT = []; %% Peaks and Valleys for TIDAL VOLUME(VT) signal %%
        PtsAS = []; VtsAS = []; %% Peaks and Valleys for AIR FLOW(AF) signal %% 
        
        [ASnorm,VTnorm] = Normalization_Second_stage(ASts(:,2),VTts(:,2),Case_Value,VtsAS1(:,2),PtsAS1(:,2),VtsVT1(:,2),PtsVT1(:,2),[-1 +1]);   % Case_Value == 1, Median values of Peaks and Valleys;Case_Value == 2, Mean values of P&V
        ASts = []; VTts = [];    
        ASts = [ts ASnorm];VTts = [ts VTnorm];   
        [ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal    
        PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; %% Peaks and Valleys for TIDAL VOLUME(VT) signal %%
        PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS]; %% Peaks and Valleys for AIR FLOW(AF) signal %%     
        %if(Case_Value == 1)
            %Stats_Median_PV(I,:) = [mean(PtsAS(:,2)) std(PtsAS(:,2)) mean(VtsAS(:,2)) std(VtsAS(:,2)) mean(PtsVT(:,2)) std(PtsVT(:,2)) mean(VtsVT(:,2)) std(VtsVT(:,2))];
        %elseif(Case_Value == 2)
            Stats_Mean_PV(I,:) = [mean(PtsAS(:,2)) std(PtsAS(:,2)) mean(VtsAS(:,2)) std(VtsAS(:,2)) mean(PtsVT(:,2)) std(PtsVT(:,2)) mean(VtsVT(:,2)) std(VtsVT(:,2))];
        %end
            
        %Case_Value = Case_Value + 1;
    %end
    
    
    
    
    
    I = I + 1;
end







