function[ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,PS,PSraw] = All_Buffalo_Signals_Processed(Signals)
% This function performs the pre-processing of all signals to give the
% AirFlow and TidalVolume signals
% Date: 27 May 2013

global ts;

% % L = length(Data);

% % ts = [1:L]/sf;ts = ts';ts = ts-(Activities(1,2));    

PSraw = Signals(:,4)/max(Signals(:,4)); % Normalized Proximity Sensor before passing to merge function    

PS = Signals(:,5);

PSraw = PSraw .* 1;           

[AB,RC] = process_AB_RC(1,Signals(:,2),Signals(:,3));    % 2 & 3 = Invert the Signals     

[ASr,VTr] = get_AS_VT(0,AB,RC,1,4);        % 0 = (AB+RC)/2,  1 = RC,  2 = AB.% + Filtering using Ideal Filter = 1 or WT filter = 2. ALso the threshold value (4) for the component removal            

ASts = [ts ASr];VTts = [ts VTr];    

[ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal    

PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 

PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];     

[ASnorm,VTnorm] = Normalization_Second_stage(ASts(:,2),VTts(:,2),1,VtsAS(:,2),PtsAS(:,2),VtsVT(:,2),PtsVT(:,2),[-1 +1]);  % Check if the choice for min/max is "MEDIAN == 1" or "MEAN == 2"    

ASts = []; VTts = [];   

ASts = [ts ASnorm];VTts = [ts VTnorm];    

[ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal    

PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT];     %% Peaks and Valleys for TIDAL VOLUME(VT) signal %%

PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS]; %% Peaks and Valleys for AIR FLOW(AF) signal %%




end