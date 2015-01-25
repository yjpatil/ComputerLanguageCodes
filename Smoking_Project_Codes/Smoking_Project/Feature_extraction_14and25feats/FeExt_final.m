clc; clear all; close all;
sf = 101.73;%% Sampling Frequency %% 
oo = 10;
H = 1;
list = char('sub_003','sub_004','sub_005','sub_007','sub_010','sub_011','sub_012','sub_013','sub_014','sub_015','sub_016','sub_017','sub_019','sub_022');
%list = char('sub_003','sub_004','sub_005','sub_006','sub_007','sub_008','sub_009','sub_010','sub_011','sub_012','sub_013','sub_014','sub_015','sub_016','sub_017','sub_019','sub_020','sub_021','sub_022','sub_023');
s = size(list);s = s(1,1);I = 1;%% Iteration for subject (here, 1 <= I <= 20) %%

while (I <= s)
 
    H = 1;hamp = [1:2:150]; ha = 1;  
    
    load(strcat(list(I,1),list(I,2),list(I,3),list(I,4),list(I,5),list(I,6),list(I,7),'.mat'))
    
    L = length(Data);ts = [1:L]/sf;ts = ts';ts = ts-Activities(1,2);
    
    Z = zeros(L,1); Z1 = zeros(L,1); Z2 = zeros(L,1);
    
    ind1 = find(Activities(11,1) <= ts & ts <= Activities(11,2));Z(ind1) = 1;Z1(ind1) = 1;
    
    ind2 = find(Activities(13,1) <= ts & ts <= Activities(13,2));Z(ind2) = 1;Z2(ind2) = 1;
    
    PB = (Data(:,1))/max(Data(:,1));PB = PB .* Z;
    
    PS1 = (Data(:,2))/max(Data(:,2)); PS1 = PS1.* Z; ind0 = find(PS1 >= 0.046); clear 'PS1';
    
    PS2 = zeros(L,1); PS2(ind0) = 1; PS = merge_func(ts,PS2,2.2);
    
    ASa = (Data(:,3))/max(Data(:,3)); RC = (Data(:,4))/max(Data(:,4)); AB = (Data(:,5))/max(Data(:,5));
    
    RC = RC .* Z; AB = AB .* Z;VT1 = (AB + RC)/2;
    
    ind3 = find(VT1 > 0); nvt1 = length(ind3); Mvt = (sum(VT1))/nvt1;  %% Procedure to find the mean-value %%
    
    VT = VT1 - Mvt; VT = -1 * VT; VT = VT + Mvt; VT = VT .* Z;   %% Inverted VT signal %%
    
    VT = idealfilter(VT,0.1,1000,sf); VT = VT .* Z;
    
    VT = fastsmooth(VT,25,1,0); ts1 = ts .* Z; AS = diff(VT)./diff(ts1);AS = [AS;0]; %% Following Program to remove NaN %%
    
    for i1 = 1:1:L
    if (Z(i1,1) == 0)
        AS(i1,1) = 0;
    else
        AS(i1,1) = AS(i1,1);
    end
    end
    
    AS = fastsmooth(AS,45,1,0);
    
    [LpVT,MpVT] = peakfinder(VT,0.0099,-0.02,1);
    LpVT = LpVT/sf;
    LpVT = LpVT-(Activities(1,2));
    
    
    [LvVT,MvVT] = peakfinder(VT,0.0099,0.02,-1);
    LvVT = LvVT/sf;
    LvVT = LvVT-(Activities(1,2));    
    
    [LpAS,MpAS] = peakfinder(AS,0.0099,-0.02,1);
    LpAS = LpAS/sf;
    LpAS = LpAS-(Activities(1,2));
    
    [LvAS,MvAS] = peakfinder(AS,0.0099,0.02,-1);
    LvAS = LvAS/sf;
    LvAS = LvAS-(Activities(1,2));
    
    PS5 = PS.*Z1; [inttsPS1,y111] = intersections(ts,PS5,[0 ts(length(ts),1)],[0.1 0.1],1);
    
    PS6 = PS.*Z2; [inttsPS2,y111] = intersections(ts,PS6,[0 ts(length(ts),1)],[0.1 0.1],1);
    
    err1 = mod(length(inttsPS1),2);
    if err1 == 0
    else
    disp('Error in INTERSECTION of Proximity Sensor (Sittiing PART)with Thres (ODD #)');
    stop;    
    end
    err2 = mod(length(inttsPS2),2);
    if err2 == 0
    else
    disp('Error in INTERSECTION of Proximity Sensor (Standing PART) with Thres (ODD #)');
    stop;
    end
    
    SORTtsPS1(:,1) = inttsPS1(1:2:(length(inttsPS1))); %%START in Column 1 with (multi-rows) SITTING%%
    SORTtsPS1(:,2) = inttsPS1(2:2:(length(inttsPS1))); %%END in Column 1 with (multi-rows) SITTING%%
    
    SORTtsPS2(:,1) = inttsPS2(1:2:(length(inttsPS2))); %%START in Column 1 with (multi-rows) STANDING%%
    SORTtsPS2(:,2) = inttsPS2(2:2:(length(inttsPS2))); %%END in Column 1 with (multi-rows) STANDING%%
    
    SEtsPS = cat(1,SORTtsPS1,SORTtsPS2); %% Contains time stamps for START && END of PS signals MATRIX OF (N X 2) %%
    
    EtsPS = cat(1,SORTtsPS1(:,2),SORTtsPS2(:,2));  %% Contains only time stamp for END of PS signals %%
    
    PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 
    
    PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];
    
    
    IT = 0; IND = 0;i = 1;          %% <|========== To calculate median of AS +-10% Threshold "Roughly" %%
        PEAK_AS_INSP = [0 0];
        for IT = 1 : 1 : length(EtsPS)
            IND = find(EtsPS(IT)-0.15 <= LpAS   & LpAS <= EtsPS(IT)+ 3.1,1); 
            ERR1 = isempty(IND);
            if(ERR1 == 1)
            else
                PEAK_AS_INSP(i,1) = PtsAS(IND,1);    %% Contains the TIME STAMPS for PEAK_AS_INSP PARAMETER %%
                PEAK_AS_INSP(i,2) = PtsAS(IND,2);    %% Contains the PEAK AMPLITUDE VALUES for PEAK_AS_INSP PARAMETER %%
                i = i + 1;
            end
        end
        clear 'IND'
        %figure(1)
        %plot(PEAK_AS_INSP(:,1),PEAK_AS_INSP(:,2),'*b');grid on;hold on;
        thp10 = median(PEAK_AS_INSP(:,2)) * (+0.1);
        [tsintthp10AS,ampintthp10AS] = intersections(ts,AS,[0 ts(length(ts),1)],[thp10 thp10],1);
        
        thm10 = median(PEAK_AS_INSP(:,2)) * (-0.1);
        [tsintthm10AS,ampintthm10AS] = intersections(ts,AS,[0 ts(length(ts),1)],[thm10 thm10],1);
    
    [tsintZVT,ampintZVT] = intersections(ts,VT,[0 ts(length(ts),1)],[1e-7 1e-7],1);   %%% INTERSECTION of ZERO line with VT %%%
    
    while(H <= length(SEtsPS) && oo == 10)
        
        S(I).h(4,hamp(ha)+1) = SEtsPS(H,2) - SEtsPS(H,1);     %% <|============ PARAMETER # 4  %%
        S(I).h(4,hamp(ha)) = SEtsPS(H,2) - SEtsPS(H,1);     
        
        IND = find(EtsPS(H)-0.12 <= LpAS  & LpAS <= EtsPS(H)+ 25,1);       %% <|============ PARAMETER # 6  %%
        ERR1 = isempty(IND);
        if(ERR1 == 1)
            disp('Error in the parameter 6 (First) calculation');
            stop;
            %S(I).h(6,hamp(ha)+1) = 0; %% Time Stamp in the even column #
            %S(I).h(6,hamp(ha)) = 0;   %% Amplitude in the odd column #
        else
            S(I).h(6,hamp(ha)+1) = PtsAS(IND,1); %% Time Stamp in the even column #
            S(I).h(6,hamp(ha)) = PtsAS(IND,2);   %% Amplitude in the odd column #
        end
        clear 'IND'
        IND = find(S(I).h(6,hamp(ha)+1) <= LpVT   & LpVT <= S(I).h(6,hamp(ha)+1) + 25,1);    %% <|============ PARAMETER # 5  %%
        S(I).h(5,hamp(ha)+1) = PtsVT(IND,1); %% Time Stamp in the even column #
        S(I).h(5,hamp(ha)) = PtsVT(IND,2);   %% Amplitude in the odd column #
        clear 'IND'
        IND = find(S(I).h(5,hamp(ha)+1) <= VtsVT & VtsVT <= S(I).h(5,hamp(ha)+1)+ 25,1);     %% <|============ PARAMETER # 11  %%
        ERR11 = isempty(IND);
        if(ERR11 == 1)
            S(I).h(11,hamp(ha)+1) = 0;
            S(I).h(11,hamp(ha)) = 0;
        else
            S(I).h(11,hamp(ha)+1) = VtsVT(IND,1); %% Time Stamp in the even column #
            S(I).h(11,hamp(ha)) = VtsVT(IND,2);   %% Amplitude in the odd column #
        end
        clear 'IND';clear 'ERR11';
        
        IND5 = find(S(I).h(11,hamp(ha)+1) <= tsintZVT & tsintZVT <= S(I).h(11,hamp(ha)+1) + 25,1);   %% <|============ PARAMETER # 12  %%
        ERR1 = isempty(IND5);
        if(ERR1 == 1)
            S(I).h(12,hamp(ha)+1) = 0;
            S(I).h(12,hamp(ha)) = 0;
        else
            S(I).h(12,hamp(ha)+1) = tsintZVT(IND5) - S(I).h(11,hamp(ha)+1);
            S(I).h(12,hamp(ha)) = tsintZVT(IND5) - S(I).h(11,hamp(ha)+1);
        end
        clear 'ERR1';
        S(I).h(2,hamp(ha)+1) = S(I).h(6,hamp(ha)+1) - SEtsPS(H,1);     %% <|============ PARAMETER # 2  %%
        S(I).h(2,hamp(ha)) = S(I).h(6,hamp(ha)+1) - SEtsPS(H,1);
        
        IND1 = find(SEtsPS(H,1) >= VtsAS(:,1) & VtsAS(:,1) >= SEtsPS(H,1) - 25,1,'last');       %% <|============ PARAMETER # 1  %%
        
        IND = find(VtsAS(IND1,1) >= tsintZVT & tsintZVT >= VtsAS(IND1,1) - 15,1,'last');
        
        S(I).h(1,hamp(ha)+1) = SEtsPS(H,1) - tsintZVT(IND);
        S(I).h(1,hamp(ha)) = SEtsPS(H,1) - tsintZVT(IND);
        clear 'IND'
        clear 'IND1'
        
        IND1 = find(SEtsPS(H,1) <= tsintthp10AS & tsintthp10AS <= SEtsPS(H,1) + 15,1,'last');   %% <|============ PARAMETER # 3 %%
        S(I).h(3,hamp(ha)+1) =  tsintthp10AS(IND1) - SEtsPS(H,1);
        S(I).h(3,hamp(ha)) =  tsintthp10AS(IND1) - SEtsPS(H,1);
                
        IND = find(tsintthp10AS(IND1) <= tsintthm10AS & tsintthm10AS <= tsintthp10AS(IND1) + 10,1);     %% <|============ PARAMETER # 7 %%
        S(I).h(7,hamp(ha)+1) =  tsintthm10AS(IND) - tsintthp10AS(IND1);
        S(I).h(7,hamp(ha)) =  tsintthm10AS(IND) - tsintthp10AS(IND1);
                
        S(I).h(8,hamp(ha)+1) = tsintthm10AS(IND) - SEtsPS(H,2);     %% <|============ PARAMETER # 8 %%
        S(I).h(8,hamp(ha)) = tsintthm10AS(IND) - SEtsPS(H,2);
        clear 'IND1'; clear 'IND'
        IND = find(S(I).h(6,hamp(ha)+1) <= tsintthp10AS & tsintthp10AS <= S(I).h(6,hamp(ha)+1) + 10,1);
        
        IND1 = find(S(I).h(6,hamp(ha)+1) <= tsintthm10AS & tsintthm10AS <= S(I).h(6,hamp(ha)+1) + 10,1);
        
        IND2 = find(tsintthm10AS(IND1) <= tsintZVT & tsintZVT <= tsintthm10AS(IND1)+10,1);
        
        S(I).h(9,hamp(ha)+1) = tsintthm10AS(IND1) - tsintthp10AS(IND);
        S(I).h(9,hamp(ha)) = tsintthm10AS(IND1) - tsintthp10AS(IND);
        
        S(I).h(10,hamp(ha)+1) = tsintZVT(IND2) - tsintthm10AS(IND1);
        S(I).h(10,hamp(ha)) = tsintZVT(IND2) - tsintthm10AS(IND1);
        
        clear 'IND'; clear 'IND1'; clear 'IND2';
        
        ha = ha + 1;        
        H = H + 1; 
    oo = input('Type value 10 to continue');
    end
    clear 'ind0';clear 'ind1';clear 'ind2';
    clear 'L';clear 'PB';clear 'PS2';clear 'AB';clear 'RC';clear 'ASa';clear 'AS';clear 'Mvt';clear 'VT1';clear 'VT';
    clear 'hamp';clear 'thp10';clear 'PEAK_AS_INSP';clear 'thm10';clear 'tsintZVT';clear 'ampintZVT';
    clear 'Z';clear 'Z1';clear 'Z2';clear 'PS'; clear 'LpVT';clear 'MpVT';clear 'LvVT';clear 'MvVT';
    clear 'LpAS';clear 'MpAS';clear 'LvAS';clear 'MvAS';
    clear 'PS5';clear 'PS6';clear 'inttsPS1';clear 'inttsPS2';clear 'y111';clear 'SORTtsPS1';clear 'SORTtsPS2';
    clear 'SEtsPS';clear 'EtsPS';
    clear 'PtsVT';clear 'VtsVT';clear 'PtsAS';clear 'VtsAS';
    clear 'tsintthp10AS';clear 'ampintthp10AS';clear 'tsintthm10AS';clear 'ampintthm10AS';
    I = I + 1;
end


