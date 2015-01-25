

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%***********    %%%%%% Code for Communication Letter %%%%%%   ************%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
clear all;
close all;
clc;

list = char('sub_003','sub_004','sub_005','sub_006','sub_007','sub_008','sub_009','sub_010','sub_011','sub_012','sub_013','sub_014','sub_015','sub_016','sub_017','sub_019','sub_020','sub_021','sub_022','sub_023');

S = size(list); 
S = S(1,1)

PARA = 8        %% All the parameters including their standard deviation %%

I = 1;                     %% Iteration for subject (here, 1 <= I <= 20) %%

total_act = 12                             %% TOTAL NUMBEr OF ACTIVITIES %%
% TABLE FORMAT-> SUBJECT # | | # HG | MEAN_DUR | SD_M_DUR | DENSITY | Mean_AMP | SD_M_AMP | MAX_AMP | SD_MAX | 

TABLE = zeros(S , PARA * total_act); %%% FINAL TABLE %%%
%%
while (I <= S)
 
    load(strcat(list(I,1),list(I,2),list(I,3),list(I,4),list(I,5),list(I,6),list(I,7),'.mat'))
    
    samp_freq = 101.73;                               %% Sampling Frequency %%
    
    data = Data(:,2);
    
    PS = data/max(data);                      %% Contains data of actual NORMALISED of Proximity Sensor %%
    
    ps_sq = data/max(data);                  %% Contains normalised and EVENTUALLY Square Pulses of Proximity Sensor %%
    
    Th = 0.046 * (max(ps_sq));                       %%  Threshold or cut-off value %%
    
    L = length(ps_sq);                                       %% Length of ps %%
    
    ts = [1:L]/samp_freq;                            %% Time Stamp in seconds %%
    ts = ts';
    ts = ts-Activities(1,2);
    
    %%%%%% Square Pulses %%%%%%
    
    index = find(ps_sq >= Th);
    ps_sq = zeros(L,1);
    ps_sq(index) = 1;
    
    % plot(ts,ps,'b');
    % grid on; hold on;  plot([1 ts(l,1)],[Th Th],'-.k');  hold on;
    
    %%%%********** START of Activity PARAMETER ESTIMATION *************%%%%
    
    ia = 2;
    
    while (ia <= (length(Activities)))
        
        index12 = find( Activities(ia,1) <= ts & ts <= Activities(ia,2));
        
        ts12 = ts(index12);
        
        ps12_sq = ps_sq(index12);
        
        PS12 = PS(index12);                 
        
        %plot(ts12,ps12_sq,'m'); grid on;  hold on;
        
        %%****** Cleaning of the Proximity Sensor Signals to get EVEN # of
        %%                           Hand Gestures ***********%%
        
        i12 = 1;
        
        if (ps12_sq(i12) == 1)
            while (ps12_sq(i12) == 1 && i12 ~= length(ps12_sq))
                ps12_sq(i12) = 0;
                i12 = i12 + 1;
            end
        else
        end
                    
        i12 = length(ps12_sq);
        
        if (ps12_sq(i12) == 1 && i12 ~=1)
            while (ps12_sq(i12) == 1)
                ps12_sq(i12) = 0;
                i12 = i12 - 1;
            end
        else
        end
                    
        %%*** True Normalised Signal of PROXIMITY SENSOR For the given Activity ****%%
        
        PS12 = PS12 .* ps12_sq;              %% Multiplying with the Cleaned ps12 signal %%
        
        %plot(ts12,PS12); grid on; hold on;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        th12 = [Th Th]; %%%% <------- Check this It should be [Th Th]
        
        [TS12,y012] = intersections(ts12,ps12_sq,[0 ts(length(ts),1)],th12);
        
        % figure(12); plot(ts12,ps12_sq,TS12,y012,'ok');grid on; hold on;
        
               
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%********** First Check if the # HAND GESTURES == 0 **********%%
        %%*** IF IT IS, DONT BOTHER CALCULATING the PARAMETERS ASSIGN 'em 0 ***%%
        
        if (TS12 ~=0)
            %%%%%%% NUMBER of HAND GESTURE is length(TS12) divide by 2   %%%%%
            HG12 = (length(TS12)/2);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%%% Dividing the time-stamp TS12 into ODD and EVEN indices %%%
            
            odd = 1:2:length(TS12);
            even = 2:2:length(TS12);
            
            TSoe12 = zeros((length(TS12)/2),2);
            TSoe12(:,1) = TS12(odd);    %% TSoe is a matrix of "(length(TS12), 2) %%
            TSoe12(:,2) = TS12(even);
            
            %%%%%% length of TSoe matrix is its rows and not columns %%%%%%%
            %%%%%%% ****** Note : Replace length(TSoe12) by s12****** %%%%%%
            
            s12 = size(TSoe12);
            s12 = s12(1,1);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%%% Calculate the MEAN TIME-DURATION & STD DEviation for the 
            %%  HAND GESTURE in an activity %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            Array_t1t2 = (TSoe12(:,2) - TSoe12(:,1));
            
            MEAN_DURATION12 = mean(Array_t1t2);
            
            SD_M_DUR = std(Array_t1t2,1);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%% Calculate the DENSITY of hand gesture for an activity %%%%%
            
            DENSITY12 = (HG12/(ts12(length(ts12),1) - ts12(1,1)))*60;
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            %% Calculate MEAN & MAX AMPLITUDE of the proximity sensor
            %% while doing that activity %%
            
            mi = 0;
            
            MEAN = zeros(s12,1);
            
            MAX = zeros(s12,1);
            
            for mi = 1:1:s12
                ind12 = find(TSoe12(mi,1) <= ts12 & ts12 <= TSoe12(mi,2));
                MEAN(mi) = mean(PS12(ind12));
                MAX(mi) = max(PS12(ind12));
            end
                
            MEAN12 = mean(MEAN);
            SD_MEAN12 = std(MEAN,1);
            
            MAX12 = mean(MAX);
            SD_MAX12 = std(MAX,1);
            
            %plot([ts12(1,1) ts12(length(ts12),1)],[MEAN12 MEAN12],'-- k');
            %grid on; hold on;
            
        else
                HG12 = 0;
                MEAN_DURATION12 = 0;
                SD_M_DUR = 0;
                DENSITY12 = 0;
                MEAN12 = 0;
                SD_MEAN12 = 0;
                MAX12 = 0;
                SD_MAX12 = 0;
        end
        EIGHT = 1:8:96;
        
        E = EIGHT(ia - 1);
        
        TABLE(I,E) = HG12; 
        TABLE(I,E+1) = MEAN_DURATION12; 
        TABLE(I,E+2) = SD_M_DUR; 
        TABLE(I,E+3) = DENSITY12; 
        TABLE(I,E+4) = MEAN12; 
        TABLE(I,E+5) = SD_MEAN12; 
        TABLE(I,E+6) = MAX12; 
        TABLE(I,E+7) = SD_MAX12; 
        
        ia = ia + 1;
        
        clear index12; clear ts12; clear ps12_sq; clear PS12; clear TS12; clear TSoe12; clear s12; clear Array_t1t2;clear MEAN; clear MAX;
    end
    I = I + 1;
end
        
fprintf('||Act1 #HG| Total_DUR | SD_DUR | DENSITY | MEAN_AMP | SD_MEAN | MAX_AMP | SD_MAX|')
TABLE(:,1:8)
fprintf('||Act2 #HG| Total_DUR | SD_DUR | DENSITY | MEAN_AMP | SD_MEAN | MAX_AMP | SD_MAX|')
TABLE(:,9:16)
fprintf('||Act3 #HG| Total_DUR | SD_DUR | DENSITY | MEAN_AMP | SD_MEAN | MAX_AMP | SD_MAX|')
TABLE(:,17:24)
fprintf('||Act4 #HG| Total_DUR | SD_DUR | DENSITY | MEAN_AMP | SD_MEAN | MAX_AMP | SD_MAX|')
TABLE(:,25:32)
fprintf('||Act5 #HG| Total_DUR | SD_DUR | DENSITY | MEAN_AMP | SD_MEAN | MAX_AMP | SD_MAX|')
TABLE(:,33:40)
fprintf('||Act6 #HG| Total_DUR | SD_DUR | DENSITY | MEAN_AMP | SD_MEAN | MAX_AMP | SD_MAX|')
TABLE(:,41:48)
fprintf('||Act7 #HG| Total_DUR | SD_DUR | DENSITY | MEAN_AMP | SD_MEAN | MAX_AMP | SD_MAX|')
TABLE(:,49:56)
fprintf('||Act8 #HG| Total_DUR | SD_DUR | DENSITY | MEAN_AMP | SD_MEAN | MAX_AMP | SD_MAX|')
TABLE(:,57:64)
fprintf('||Act9 #HG| Total_DUR | SD_DUR | DENSITY | MEAN_AMP | SD_MEAN | MAX_AMP | SD_MAX|')
TABLE(:,65:72)
fprintf('||Act10 #HG| Total_DUR | SD_DUR | DENSITY | MEAN_AMP | SD_MEAN | MAX_AMP | SD_MAX|')
TABLE(:,73:80)
fprintf('||Act11 #HG| Total_DUR | SD_DUR | DENSITY | MEAN_AMP | SD_MEAN | MAX_AMP | SD_MAX|')
TABLE(:,81:88)
fprintf('||Act12 #HG| Total_DUR | SD_DUR | DENSITY | MEAN_AMP | SD_MEAN | MAX_AMP | SD_MAX|')
TABLE(:,89:96)

figure(16)
bar([1 2 3 4 5 6 7 8 9 10 11 12],[mean(TABLE(:,1)) mean(TABLE(:,9)) mean(TABLE(:,17)) mean(TABLE(:,25)) mean(TABLE(:,33)) mean(TABLE(:,41)) mean(TABLE(:,49)) mean(TABLE(:,57)) mean(TABLE(:,65)) mean(TABLE(:,73)) mean(TABLE(:,81)) mean(TABLE(:,89))])
title('Mean for the Number of Hand Gestures for each activity');grid on;hold on;

figure(17) 
bar([1 2 3 4 5 6 7 8 9 10 11 12],[mean(TABLE(:,2)) mean(TABLE(:,10)) mean(TABLE(:,18)) mean(TABLE(:,26)) mean(TABLE(:,34)) mean(TABLE(:,42)) mean(TABLE(:,50)) mean(TABLE(:,58)) mean(TABLE(:,66)) mean(TABLE(:,74)) mean(TABLE(:,82)) mean(TABLE(:,90))])
title('Mean for the Total Duration for each activity');grid on;hold on;

figure(18) 
bar([1 2 3 4 5 6 7 8 9 10 11 12],[mean(TABLE(:,4)) mean(TABLE(:,12)) mean(TABLE(:,20)) mean(TABLE(:,28)) mean(TABLE(:,36)) mean(TABLE(:,44)) mean(TABLE(:,52)) mean(TABLE(:,60)) mean(TABLE(:,68)) mean(TABLE(:,76)) mean(TABLE(:,84)) mean(TABLE(:,92))])
title('Mean for the Density (#HG/min) for each activity');grid on;hold on;

figure(19) 
bar([1 2 3 4 5 6 7 8 9 10 11 12],[mean(TABLE(:,5)) mean(TABLE(:,13)) mean(TABLE(:,21)) mean(TABLE(:,29)) mean(TABLE(:,37)) mean(TABLE(:,45)) mean(TABLE(:,53)) mean(TABLE(:,61)) mean(TABLE(:,69)) mean(TABLE(:,77)) mean(TABLE(:,85)) mean(TABLE(:,93))])
title('Mean for the Amplitude of the PS Signal in an activity');grid on;hold on;

figure(20) 
bar([1 2 3 4 5 6 7 8 9 10 11 12],[mean(TABLE(:,7)) mean(TABLE(:,15)) mean(TABLE(:,23)) mean(TABLE(:,31)) mean(TABLE(:,39)) mean(TABLE(:,47)) mean(TABLE(:,55)) mean(TABLE(:,63)) mean(TABLE(:,71)) mean(TABLE(:,79)) mean(TABLE(:,87)) mean(TABLE(:,95))])
title('Mean for the Maximum Amplitude of the PS Signal in an activity');grid on;hold on;


toc