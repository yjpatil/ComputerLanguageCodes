% This code plots the 20 subjects 
% Created : 9 Jan 2013

clc;clear all;close all;
global sf ts;
sf = 101.73;

path = char('C:\Users\student\Documents\MATLAB\Biology_bldg_20subjects\');

list = char('Sub_003','Sub_004','Sub_005','Sub_006','Sub_007','Sub_008','Sub_009','Sub_010','Sub_011','Sub_012','Sub_013','Sub_014','Sub_015','Sub_016','Sub_017','Sub_019','Sub_020','Sub_021','Sub_022','Sub_023');

Size_List = size(list,1);

I = 8;

load(strcat(path(1,:),list(I,:),'.mat'));           

L = length(Data);    

ts = [1:L]/sf;ts = ts';ts = ts-(Activities(1,2));    

PSraw = Data(:,2)/max(Data(:,2)); % Normalized Proximity Sensor before passing to merge function    

PS = merge_function(PSraw,ts,0.046,0.5,8,1.2);     
PSraw = PSraw .* 1;           

[AB,RC] = process_AB_RC(3,Data(:,4),Data(:,5));    % 2 & 3 = Invert the Signals     

[ASr,VTr] = get_AS_VT(0,AB,RC,1,4);        % 0 = (AB+RC)/2,  1 = RC,  2 = AB.% + Filtering using Ideal Filter = 1 or WT filter = 2. ALso the threshold value (4) for the component removal            
ASts = [ts ASr];VTts = [ts VTr];    

[ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal   

PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 
PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];     

[ASnorm,VTnorm] = Normalization_Second_stage(ASts(:,2),VTts(:,2),1,VtsAS(:,2),PtsAS(:,2),VtsVT(:,2),PtsVT(:,2),[-1 +1]);  % Check if the choice for min/max is "MEDIAN == 1" or "MEAN == 2"    

ASts = []; VTts = [];    

ASts = [ts ASnorm];VTts = [ts VTnorm];    

[ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal    

PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; %% Peaks and Valleys for TIDAL VOLUME(VT) signal %%
PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS]; %% Peaks and Valleys for AIR FLOW(AF) signal %%              

% %     [I] = Plot_General(PSraw,10*PS,ASts,VTts,PtsAS,VtsAS,PtsVT,VtsVT,Score,I,list);

figure;hold on;grid on;title(strcat(list(I,:)));xlabel('Time \it s');ylabel('amplitude')    

%Hraw = plot(ts,5*PSraw,'m');         

H0 = plot(ts,5*PS,'-g');

H1 = plot(ASts(:,1),ASts(:,2),'-c');
% plot(PtsAS(:,1),PtsAS(:,2),'+k');grid on;hold on;
% plot(VtsAS(:,1),VtsAS(:,2),'ok');grid on;hold on; 
% 
% H2 = plot(VTts(:,1),VTts(:,2),'-b');
% plot(PtsVT(:,1),PtsVT(:,2),'ob');grid on;hold on;
% plot(VtsVT(:,1),VtsVT(:,2),'ok');grid on;hold on;    

%%%plot(tsintZVT,ampintZVT,'or');
%%%plot(tsintZAS,ampintZAS,'ob');   

O = 0.02*ones(size(Score,1));
H3 = plot(Score(:,3),O,'ob');
H4 = plot(Score(:,4),O,'or');        
% 
% legend([H0 H1 H2 H3(1) H4(1)],{'Proximity Sensor' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});    
%legend([Hraw H1 H2 H3(1) H4(1)],{'Raw PS' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});    

it1 = 2;
while(it1 <= length(Activities))
    temp1 = [rand rand rand];        
    plot([Activities(it1,1) Activities(it1,1)],[-4 6],'Color',temp1,'LineWidth',2); 
    plot([Activities(it1,2) Activities(it1,2)],[-4 6],'Color',temp1,'LineWidth',2); 
    it1 = it1 + 1;
end

Sep = 6;
it3 = 1;
T1 = 0;T2 = 0;
while(T2 < size(ASts,1)-Sep)
    T1 = it3;
    T2 = it3 + Sep;
    plot(ASts(T2,1),ASts(T2,2),'*k');
    it3 = T2;
end



% ----------------------

figure;hold on;grid on;title(strcat(list(I,:)));xlabel('Time \it s');ylabel('amplitude')    

%Hraw = plot(ts,5*PSraw,'m');         

H0 = plot(ts,5*PS,'-g');

% H1 = plot(ASts(:,1),ASts(:,2),'-c');
% plot(PtsAS(:,1),PtsAS(:,2),'+k');grid on;hold on;
% plot(VtsAS(:,1),VtsAS(:,2),'ok');grid on;hold on; 
% 
H2 = plot(VTts(:,1),VTts(:,2),'-b');
% plot(PtsVT(:,1),PtsVT(:,2),'ob');grid on;hold on;
% plot(VtsVT(:,1),VtsVT(:,2),'ok');grid on;hold on;    

%%%plot(tsintZVT,ampintZVT,'or');
%%%plot(tsintZAS,ampintZAS,'ob');   

O = 0.02*ones(size(Score,1));
H3 = plot(Score(:,3),O,'ob');
H4 = plot(Score(:,4),O,'or');        
% 
% legend([H0 H1 H2 H3(1) H4(1)],{'Proximity Sensor' 'Air Flow' 'Tidal Volume' 'Start of Puff' 'End of Puff'});
    
it1 = 2;
while(it1 <= length(Activities))
    temp1 = [rand rand rand];        
    plot([Activities(it1,1) Activities(it1,1)],[-4 6],'Color',temp1,'LineWidth',2); 
    plot([Activities(it1,2) Activities(it1,2)],[-4 6],'Color',temp1,'LineWidth',2); 
    it1 = it1 + 1;
end

% Sep = 11;
it3 = 1;
T1 = 0;T2 = 0;
while(T2 < size(VTts,1)-Sep)
    T1 = it3;
    T2 = it3 + Sep;
    plot(VTts(T2,1),VTts(T2,2),'*k');
    it3 = T2;
end    
    
    
    
    
    
    
    
    
    
    

    
    
    
   
