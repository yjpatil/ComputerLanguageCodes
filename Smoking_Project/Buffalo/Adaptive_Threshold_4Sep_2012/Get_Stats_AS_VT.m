function [Stats_AS,Stats_VT] = Get_Stats_AS_VT(t1,t2,IndexAp,VTts,ASts,PtsAS,VtsAS,PtsVT,VtsVT)
% Task : This function provides an array of Stats for both AS and VT for a
% given puff score between t1 and t2. 
% "IndexAp" -- contains the part of AS and VT under-puff_score
% Date : 4 Sep 2012

VT = VTts(:,2);AS = ASts(:,2);

Stats_AS(1,1) = t1;Stats_VT(1,1) = t1;        % (1,1) -TIME Start of the Apnea period %% FOR BOTH AS and VT Signal

Stats_AS(1,2) = t2;Stats_VT(1,2) = t2;        % (1,2) -TIME End of the Apnea period %%  FOR BOTH AS and VT Signal

Stats_AS(1,3) = t2-t1;Stats_VT(1,3) = t2-t1;  % (1,3) -TIME Difference of the Apnea period %%  FOR BOTH AS and VT Signal

Stats_AS(1,4) = max(AS(IndexAp));Stats_VT(1,4) = max(VT(IndexAp));       % (1,4) -AMPLITUDE MAX in AirFlow/TidalVolume

Stats_AS(1,5) = min(AS(IndexAp));Stats_VT(1,5) = min(VT(IndexAp));       % (1,5) -AMPLITUDE MIN in AirFlow/TidalVolume

Stats_AS(1,6) = mean(AS(IndexAp));Stats_VT(1,6) = mean(VT(IndexAp));     % (1,6) -AMPLITUDE MEAN in AirFlow/TidalVolume

Stats_AS(1,7) = median(AS(IndexAp));Stats_VT(1,7) = median(VT(IndexAp)); % (1,7) -AMPLITUDE MEDIAN in AirFlow/TidalVolume

AS_Ind_TEMP_Peak = find( t2 <= PtsAS(:,1) & PtsAS(:,1) <= t2 + 65,1 );err_AS_pk = isempty(AS_Ind_TEMP_Peak);   % -Air Flow = Pick the first Peak that is immediately after the end of puff

AS_Ind_TEMP_Valley = find( t2 <= VtsAS(:,1) & VtsAS(:,1) <= t2 + 65,1 );err_AS_val = isempty(AS_Ind_TEMP_Valley); % -Air Flow = Pick the first Valley that is immediately after the end of puff           

VT_Ind_TEMP_Peak = find( t2 <= PtsVT(:,1) & PtsVT(:,1) <= t2 + 65,1 );err_VT_pk = isempty(VT_Ind_TEMP_Peak);   % -Tidal Volume = Pick the first Peak that is immediately after the end of puff

VT_Ind_TEMP_Valley = find( t2 <= VtsVT(:,1) & VtsVT(:,1) <= t2 + 65,1 );err_VT_val = isempty(VT_Ind_TEMP_Valley); % -Tidal Volume = Pick the first Valley that is immediately after the end of puff

if( err_AS_pk == 1 || err_AS_val == 1 )   % For AIR-FLOW Signal     
    Stats_AS(1,8) = 1;   % ONE because it will be in the denominator (1,8) -AMPLITUDE Height **COMMENT: If either the peak and the valley is not found then consider that to ONE
    PV_AS = 1;
else
    Stats_AS(1,8) = abs(PtsAS(AS_Ind_TEMP_Peak,2)) + abs(VtsAS(AS_Ind_TEMP_Valley,2));  % (1,8) -ABSOLUTE AMPLITUDE of Height of the Smoking WAVE - from peak to valley
    PV_AS = abs(PtsAS(AS_Ind_TEMP_Peak,2)) + abs(VtsAS(AS_Ind_TEMP_Valley,2));
end

if( err_VT_pk == 1 || err_VT_val == 1 )   % For TIDAL-VOLUME
    Stats_VT(1,8) = 1;   % SAME for TIDAL VOLUME **COMMENT: If either the peak and the valley is not found then consider that to ONE
    PV_VT = 1;
else
    Stats_VT(1,8) = abs(PtsVT(VT_Ind_TEMP_Peak,2)) + abs(VtsVT(VT_Ind_TEMP_Valley,2)); % (1,8) -ABSOLUTE AMPLITUDE of Height of the Smoking WAVE - from peak to valley
    PV_VT = abs(PtsVT(VT_Ind_TEMP_Peak,2)) + abs(VtsVT(VT_Ind_TEMP_Valley,2));
end

% First Important Stat % 
Stats_AS(1,9) = ( 1 - mean(AS(IndexAp)) )/PV_AS;  % (1,9) Ratio = ( 1 - mean(APNEA) )/(abs(P)+abs(V))
Stats_VT(1,9) = ( 1 - mean(VT(IndexAp)) )/PV_VT;  % SAME for Tidal Volume
% First Important Stat % 
Stats_AS(1,10) = ( 1 - median(AS(IndexAp)) )/PV_AS;  % (1,10) Ratio = ( 1 - median(APNEA) )/(abs(P)+abs(V))
Stats_VT(1,10) = ( 1 - median(VT(IndexAp)) )/PV_VT; % SAME for Tidal Volume
% Secnd Important Stat % 
Stats_AS(1,11) = abs( max(AS(IndexAp)) - mean(AS(IndexAp)) ); % (1,11) Absolute_Difference = MAX(Apnea) - MEAN(Apnea)
Stats_VT(1,11) = abs( max(VT(IndexAp)) - mean(VT(IndexAp)) ); % (1,11) Absolute_Difference = MAX(Apnea) - MEAN(Apnea)

Stats_AS(1,12) = abs( mean(AS(IndexAp)) - min(AS(IndexAp)) ); % (1,12) Absolute_Difference = MEAN(Apnea) - MIN(Apnea)
Stats_VT(1,12) = abs( mean(VT(IndexAp)) - min(VT(IndexAp)) ); % (1,12) Absolute_Difference = MEAN(Apnea) - MIN(Apnea)
% Second Important Stat % 
Stats_AS(1,13) = abs( max(AS(IndexAp)) - median(AS(IndexAp)) ); % (1,11) Absolute_Difference = MAX(Apnea) - MEDIAN(Apnea)
Stats_VT(1,13) = abs( max(VT(IndexAp)) - median(VT(IndexAp)) ); % (1,11) Absolute_Difference = MAX(Apnea) - MEDIAN(Apnea)

Stats_AS(1,14) = abs( median(AS(IndexAp)) - min(AS(IndexAp)) ); % (1,12) Absolute_Difference = MEDIAN(Apnea) - MIN(Apnea)
Stats_VT(1,14) = abs( median(VT(IndexAp)) - min(VT(IndexAp)) ); % (1,12) Absolute_Difference = MEDIAN(Apnea) - MIN(Apnea)




end




