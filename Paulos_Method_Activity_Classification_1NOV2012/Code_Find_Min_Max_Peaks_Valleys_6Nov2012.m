% *********************************************************************** %
%  ALL    Code to gets the statstics for peak and valley          %
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
    
    [AS,VT] = Normalization_tech(ASr,VTr,2,600,600,[-1 +1]);
    
    ASts = [ts AS];VTts = [ts VT];
    
    [ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal
    
    PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 
    PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];                                
    
    Stats_Min_Max_PV(I,:) = [mean(PtsAS(:,2)) std(PtsAS(:,2)) mean(VtsAS(:,2)) std(VtsAS(:,2)) mean(PtsVT(:,2)) std(PtsVT(:,2)) mean(VtsVT(:,2)) std(VtsVT(:,2))];                       
    
    figure(1);hold on;
    title('Across 20 Sub,Comparing pde for AS Peak Values Normalized using Min-Max')    
    H1_AS = gkde0(PtsAS(:,2));
    med_Jp_AS(I) = plot(H1_AS.x,H1_AS.f,'Color',[rand rand rand]);            
    
    figure(2);hold on;            
    title('Across 20 Sub,Comparing pde for VT Peak Values Normalized using Min-Max')
    H1_VT = gkde0(PtsVT(:,2));
    med_Jp_VT(I) = plot(H1_VT.x,H1_VT.f,'Color',[rand rand rand]);                       
    
    figure(3);hold on;
    title('Across 20 Sub,Comparing pde for AS Valley Values Normalized using Min-Max')
    H2_AS = gkde0(VtsAS(:,2));
    med_Jv_AS(I) = plot(H2_AS.x,H2_AS.f,'Color',[rand rand rand]);           
    
    figure(4);hold on;
    title('Across 20 Sub,Comparing pde for VT Valley Values Normalized using Min-Max')
    H2_VT = gkde0(VtsVT(:,2));
    med_Jv_VT(I) = plot(H2_VT.x,H2_VT.f,'Color',[rand rand rand]);                       
    
            
    I = I + 1;
end
%figure(1);gcf;
%legend([med_Jp(1) mn_Jp(1)],{strcat('Median',list(1,:)) strcat('Mean',list(1,:)) })





