% Task: This code sees how the ratio of the Adaptive threshold stays across
% all subjects.
% Date: 22 August 2012

% TRAINING PHASE: using PUFF_SCORE matrix get the mean/median values for
% apneas in smoking instances. You find the MEAN,MEDIAN of the amplitude and MIN
% & MAX amplitude of the APNEA part. Find the value of R1.
% Ratio, R1 = 1 - MEAN(APNEA_part)/MEAN(Total_amplitude_smk_breadth)
% Ratio, R2 = 1 - MEAN(APNEA_part)/MEAN(Diff_ValleySmk_Valleynxtsmk)
clc;clear all;close all;
%_________________________________________________________________________%
                z90 = 1.645;z95 = 1.96;z97 = 2.17;z99 = 2.58; % Z-values for different Confidence Intervals
                       zvalue = z99;  %<****** Change Me *******>
%_________________________________________________________________________%
global sf ts1 Counter_TP Counter_FN Counter_FP ;
sf = 101.73;
Counter_TP = 0; Counter_FN = 0; Counter_FP = 0;

path = char('C:\Users\student\Documents\MATLAB\Buffalo_data_mat_files\');

list = char('DATA_PACT_105','DATA_PACT_107','DATA_PACT_108','DATA_PACT_109','DATA_PACT_114','DATA_PACT_117','DATA_PACT_118','DATA_PACT_120','DATA_PACT_122','DATA_PACT_124','DATA_PACT_127','DATA_PACT_128','DATA_PACT_129','DATA_PACT_132','DATA_PACT_134','DATA_PACT_136','DATA_PACT_138','DATA_PACT_140');

Size_List = size(list,1);

I = 1;    % Counter for Subjects

LS = 1;   % Counter for Lab_sessions 1 or 2

pf = 1;  % Counter for Puff_Scores

while(I <= Size_List)
    
    load(strcat(path(1,:),list(I,:),'.mat'));
    
    clear('AB','RC','VT','AS','ASts','VTts','AS_min','AS_max','VT_min','VT_max')
    
    ts1 = Signals(:,1);
    
    [AB,RC] = process_AB_RC(1,Signals(:,2),Signals(:,3));   % 1 = no-inversion, 2 = invert
    
    [AS1,VT1] = get_AS_VT(0,AB,RC,1,4);        % 0 = (AB+RC)/2,  1 = RC,  2 = AB.% + Filtering using Ideal Filter = 1 or WT filter = 2. ALso the threshold value (4) for the component removal
    
    [AS1,VT1] = Normalization_tech(AS1,VT1,1,600,600,[-1 +1]);
    
    LS = 1;
    
    COUNTER = 1;
    
    size_LS = size(Lab_sessions,1);  %% Size of the Lab-sesions == 2 %%
    
    while( COUNTER <= size_LS )
        % In this while loop Lab-session 1 is first considered for
        % obtaining STATISTICS using PUFF_SCORES ...
        ind_ts = [];ts = [];pf_score = [];ASts = [];VTts = [];
        PtsVT = []; VtsVT = [];PtsAS = []; VtsAS = [];n = [];
        
        ind_ts = find(Lab_sessions(LS,1)<= ts1 & ts1 <= Lab_sessions(LS,2));  %% For selection of 1/2 Lab_session time period %%
        
        ts = ts1(ind_ts);VT = VT1(ind_ts);AS = AS1(ind_ts);  %% Now get the time_stamps, Tidal_Volume and Air_Flow signal %%
        
        ind_pf = find(Lab_sessions(LS,1)<= puff_score(:,1) & puff_score(:,1) <= Lab_sessions(LS,2));  %% Selecting Puff_Score from "#LS" Lab_sessions only %%
        
        pf_score = puff_score(ind_pf,:); %% PuFF_Score Matrix for the given Lab_session only %%       
        
        ASts = [ts AS];VTts = [ts VT];
        
        [ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);
        
        PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; %% Peaks and Valleys for TIDAL VOLUME(VT) signal %%
        PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS]; %% Peaks and Valleys for AIR FLOW(AF) signal %%  
        
        pf = 1;     
        n = length(pf_score);   % <---- number of sample points collected
        SUB(I).LabS(LS).Sample_Points(LS,1) = n;
        SUB(I).LabS(LS).Sub_Name = list(I,:);
        
        SUB(I).LabS(LS).Stats_AS = [];
        SUB(I).LabS(LS).Stats_VT = [];
        
        while(pf <= size(pf_score,1))
            t1 = pf_score(pf,1);t2 = pf_score(pf,2);
            IndexAp = [];            
            IndexAp = find(t1 <= ts & ts <= t2 );
            
            [SUB(I).LabS(LS).Stats_AS(pf,:),SUB(I).LabS(LS).Stats_VT(pf,:)] = Get_Stats_AS_VT(t1,t2,IndexAp,VTts,ASts,PtsAS,VtsAS,PtsVT,VtsVT);
            
            pf = pf + 1;
        end
        
        [Lm_TD_AS,Um_TD_AS,Lm_R1_AS,Um_R1_AS,Um_Max_Mean_Dif_AS,Lm_Max_Mean_Dif_AS,Um_Min_Mean_Dif_AS,Lm_Min_Mean_Dif_AS] = Get_Overall_Values(SUB(I).LabS(LS).Stats_AS,zvalue,n);
        
        [Lm_TD_VT,Um_TD_VT,Lm_R1_VT,Um_R1_VT,Um_Max_Mean_Dif_VT,Lm_Max_Mean_Dif_VT,Um_Min_Mean_Dif_VT,Lm_Min_Mean_Dif_VT] = Get_Overall_Values(SUB(I).LabS(LS).Stats_VT,zvalue,n);
        
        %% Now Change the Lab Session Number %%
        if( LS == 1 )         
            LS = 2;
        elseif( LS == 2 )
            LS = 1; 
        end
        
        ind_ts = [];ts = [];pf_score = [];ASts = [];VTts = []; % Clear All variables
        PtsVT = []; VtsVT = [];PtsAS = []; VtsAS = [];  % Clear All variables
        
        ind_ts = find(Lab_sessions(LS,1)<= ts1 & ts1 <= Lab_sessions(LS,2)); 
        ts = ts1(ind_ts);VT = VT1(ind_ts);AS = AS1(ind_ts);
        
        ind_pf = find(Lab_sessions(LS,1)<= puff_score(:,1) & puff_score(:,1) <= Lab_sessions(LS,2));  %% Selecting Puff_Score from "#LS" Lab_sessions only %%       
        pf_score = puff_score(ind_pf,:); %% PuFF_Score Matrix
        
        ASts = [ts AS];VTts = [ts VT];
        
        [ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);
        
        PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT];   %% Peaks and Valleys for TIDAL VOLUME(VT) signal %%
        PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];   %% Peaks and Valleys for AIR FLOW(AF) signal %%    
        
        %            PLOT 1 for AS            %
%         figure(1);hold on;grid on;title(strcat(list(I,:),'Air Flow'));xlabel('Time \it s');
%         [H1,H3,H4] = PLOT_ME(pf_score,ASts,PtsAS,VtsAS);
%         legend([H1 H3(1) H4(1)],{'Air Flow' 'Start of Puff' 'End of Puff'});   
%         %            PLOT 2 for VT            %
%         figure(2);hold on;grid on;title(strcat(list(I,:),'Volume Tidal'));xlabel('Time \it s');
%         [H2,H3,H4] = PLOT_ME(pf_score,VTts,PtsVT,VtsVT);
%         legend([H2 H3(1) H4(1)],{'Volume Tidal' 'Start of Puff' 'End of Puff'});
        
        pCount = 3;
        
        Counter_TP=0; Counter_FN = 0; Counter_FP = 0; % Initialize the values of TP, FN, FP
        while( pCount <= size(PtsAS,1)-5 ) %% For each peak of Air_Flow Signal
            time0 = PtsAS(pCount-1,1); %% Previous Peak of the Air_Flow signal 
            time1 = PtsAS(pCount,1);   %% Next Peak of the Air_Flow signal 
            indTemp = find(time0 <= VtsAS(:,1) & VtsAS(:,1) <= time1);  %% Check if there is a VALLEY present between the peak
            err0 = isempty(indTemp); % Check if there is valley between the two peaks !!
            if(err0 == 1) % If it is empty that means there is no valley. Hence it is not a valid peak
                flag = 1;
                while(flag == 1 )  % Raise a Flag for an invalid peak
                    pCount = pCount + 1; % Increase the peak count by 1
                    time0 = PtsAS(pCount-1,1); 
                    time1 = PtsAS(pCount,1);
                    indTemp = find(time0 <= VtsAS(:,1) & VtsAS(:,1) <= time1); % Check if the new peak has VALLEY in-between
                    errTemp = isempty(indTemp);  % if Value of errTemp is 1 then again there is no valley in-between
                    if(errTemp == 1)
                        flag = 1; % Raise Flag again
                    else
                        flag = 0; % Lower Flag
                    end
                end
            end
           %----------------------------------------------------------- %
           [Actual_score] = find_actual_score(time0,time1,pf_score);    % get the actual score of the 
           %----------------------------------------------------------- %
           ind_prevValley = find(time0 <= VtsAS(:,1) & VtsAS(:,1) <= time1,1);           
           
           ind_currValley = find(time1 <= VtsAS(:,1) & VtsAS(:,1) <= time1+75,1);
           
           V_ts_prev = VtsAS(ind_prevValley,1);V_amp_prev = VtsAS(ind_prevValley,2); % Previous valley amplitude and Time-stamp
           V_ts_curr = VtsAS(ind_currValley,1);V_amp_curr = VtsAS(ind_currValley,2); % Current Valley Amplitude and Time-stamp
           P_ts_curr = PtsAS(pCount,1);P_amp_curr = PtsAS(pCount,2); % Current Peak Amplitude and Time-stamp
           
           T11 = V_ts_prev;T22 = P_ts_curr; % Now get the part between the Prev VALLEY and Current PEAK
           
           Indx_tstemp = find(T11 <= ts & ts <= T22); %8888888888888888888888888888 MAIN PART 8888888888888888888888888888888888%
           
           tstemp = ts(Indx_tstemp);
           AStemp = AS(Indx_tstemp);
           
           sum_PV = abs(P_amp_curr) + abs(V_amp_curr); % Current Peak and Valley Difference to find the Ratio for the Adaptive Threshold
           
           Lm_Th1 = 1 - (Lm_R1_AS * sum_PV);
           Um_Th1 = 1 - (Um_R1_AS * sum_PV);
           
           Lm_Th2 = Lm_Th1 - Lm_Min_Mean_Dif_AS;
           Um_Th2 = Um_Th1 + Um_Min_Mean_Dif_AS;
           
% %            figure(1);grid on; hold on;
% %            Yp1 = plot([V_ts_prev P_ts_curr],[Lm_Th1 Lm_Th1],'Color',[0.9 0.1 0.3]);
% %            Yp2 = plot([V_ts_prev P_ts_curr],[Um_Th1 Um_Th1],'Color',[0.1 0.1 0.9]);
% %            
% %            Yp3 = plot([V_ts_prev P_ts_curr],[Lm_Th2 Lm_Th2],'Color',[0.2 0.5 0.8]);
% %            Yp4 = plot([V_ts_prev P_ts_curr],[Um_Th2 Um_Th2],'Color',[0.3 0.4 0.5]);
% %            
% %            legend([Yp1 Yp2 Yp3 Yp4],{'Lower mean Th' 'Upper Mean Th' 'Lower Min Th' 'Upper Max Th'});
           
           Case21 = 2;
           if(Case21 == 1)
               [int_AS_LTh2,y0010] = intersections(tstemp,AStemp,[tstemp(1) tstemp(length(tstemp))],[Lm_Th2 Lm_Th2]);
               
               [int_AS_UTh2,y0020] = intersections(tstemp,AStemp,[tstemp(1) tstemp(length(tstemp))],[Um_Th2 Um_Th2]);
           elseif(Case21 == 2)
               Fc = 260;   % Frequency of the sine wave
               [sinu_Th,time_sinu] = Sinusoidal_Threshold(Fc,tstemp(1),tstemp(length(tstemp)),[Lm_Th2 Um_Th2]);
               
               [int_AS_sinu,yint_AS_sinu] = intersections(tstemp,AStemp,time_sinu,sinu_Th);               
           end
            
           if( isempty(int_AS_sinu) )
           else
               %T1 = int_AS_LTh2(1);
               %T2 = int_AS_UTh2(length(int_AS_UTh2));
               T1 = int_AS_sinu(1);
               T2 = int_AS_sinu(length(int_AS_sinu));
               if(T2 - T1 >= Um_TD_AS)
                   Predicted_Score = +1;
                   [u1] = Determine_Score(Actual_score,Predicted_Score);
%                    if( Actual_score == Predicted_Score )
%                        gcf;plot([T2 T1],[0.08 0.08],'-*g')
%                    end
%                    plot([T1 T1],[Lm_Th2 Um_Th2],'-k','LineWidth',2);plot([T1 T2],[Um_Th2 Um_Th2],'-k','LineWidth',2);plot([T2 T2],[Um_Th2 Lm_Th2],'-k','LineWidth',2);plot([T2 T1],[Lm_Th2 Lm_Th2],'-k','LineWidth',2);
               else
                   Predicted_Score = -1; 
                   [u1] = Determine_Score(Actual_score,Predicted_Score);                   
               end
               
           end
           
           pCount = pCount + 1;
        end
        Prec = 0;Rec = 0;F1score = 0;
        Prec = (Counter_TP/(Counter_TP + Counter_FP));
        Rec = (Counter_TP/(length(pf_score)));
        F1score = 2*((Prec*Rec)/(Prec + Rec));
        %------------------------ For Air Flow Signal ---------------------%
        if(LS == 1)
            LS1_Table_AS_Adaptive(I,:) = [F1score*100 Prec*100 Rec*100 Counter_TP  (length(pf_score)-Counter_TP) Counter_FP length(pf_score) ((ts(length(ts))-ts(1))/60)];
        elseif(LS == 2)
            LS2_Table_AS_Adaptive(I,:) = [F1score*100 Prec*100 Rec*100 Counter_TP  (length(pf_score)-Counter_TP) Counter_FP length(pf_score) ((ts(length(ts))-ts(1))/60)];
        end                 
        COUNTER = COUNTER + 1;  
    end
    
    
    I = I + 1;
    
end
