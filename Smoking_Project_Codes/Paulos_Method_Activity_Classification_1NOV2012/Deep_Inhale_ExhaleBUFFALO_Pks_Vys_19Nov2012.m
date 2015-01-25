% *********************************************************************** %
%  ALL    Code to gets the statstics for peak and valley          %
%                  so as to get normalization for each subjects           %
%                         within a defined range                          %
% *********************************************************************** %
% Created = 5 Nov 2012 %

clc;clear all;close all;

global sf ts;
sf = 101.73;

path = char('C:\Users\student\Documents\MATLAB\Data update buffalo 11-oct-2012\');

list = char('DATA_PACT_105','DATA_PACT_107','DATA_PACT_109','DATA_PACT_114','DATA_PACT_117');

Size_List = size(list,1);

I = 1;

while(I <= Size_List)
   
    load(strcat(path(1,:),list(I,:),'.mat'));
    
    ts = Signals(:,1);       
    
    [AB,RC] = process_AB_RC(3,Signals(:,2),Signals(:,3));    % 2&3 = Invert the Signals 
    
    [ASr,VTr] = get_AS_VT(0,AB,RC,1,4);   % 0 = (AB+RC)/2,  1 = RC,  2 = AB.% + Filtering using Ideal Filter = 1 or WT filter = 2. ALso the threshold value (4) for the component removal    
    
    %[AS,VT] = Normalization_tech(ASr,VTr,2,600,600,[-1 +1]);
    
    ASts = [ts ASr];VTts = [ts VTr];
    
    [ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal
    
    PtsVT1 = [LpVT MpVT]; VtsVT1 = [LvVT MvVT]; 
    PtsAS1 = [LpAS MpAS]; VtsAS1 = [LvAS MvAS]; 
    
    Stats_Mean_before_Norm(I,:) = [mean(PtsAS1(:,2)) std(PtsAS1(:,2)) mean(VtsAS1(:,2)) std(VtsAS1(:,2)) mean(PtsVT1(:,2)) std(PtsVT1(:,2)) mean(VtsVT1(:,2)) std(VtsVT1(:,2))];
    
    Stats_Median_before_Norm(I,:) = [median(PtsAS1(:,2)) median(VtsAS1(:,2)) median(PtsVT1(:,2)) median(VtsVT1(:,2))];
            
    ASts = []; VTts = [];
    
    ASts = [ts ASr];VTts = [ts VTr];        
    
    PtsVT = []; VtsVT = []; 
    PtsAS = []; VtsAS = [];       
    %[ASnorm,VTnorm] = Normalization_Second_stage(ASts(:,2),VTts(:,2),Case_Value,VtsAS1(:,2),PtsAS1(:,2),VtsVT1(:,2),PtsVT1(:,2),[-1 +1]);   % Case_Value == 1, Median for P & V;Case_Value == 2, Mean for P & V        
    
    [ASnorm,VTnorm] = Normalization_Second_stage(ASts(:,2),VTts(:,2),[-1 +1],I);   % For min & max values obtained through deep inhale and exhale        
    
    ASts = []; VTts = [];            
    
    ASts = [ts ASnorm];VTts = [ts VTnorm];           
    
    [ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts);  %% Location and Amplitude of the signal    
    PtsVT = [LpVT MpVT]; VtsVT = [LvVT MvVT]; 
    PtsAS = [LpAS MpAS]; VtsAS = [LvAS MvAS];            
    
    Stats_Deep_Inhale_Exhale(I,:) = [mean(PtsAS(:,2)) std(PtsAS(:,2)) mean(VtsAS(:,2)) std(VtsAS(:,2)) mean(PtsVT(:,2)) std(PtsVT(:,2)) mean(VtsVT(:,2)) std(VtsVT(:,2))];           
    
    H1_AS = [];H2_AS = [];
    H1_VT = [];H2_VT = [];            
    
    figure(1);hold on;
    title('Across 5Sub,Comparing pde for AS Peak Values Normalized using Deep Inhale Exhale')
    H1_AS = gkde0(PtsAS(:,2));
    med_Jp_AS(I) = plot(H1_AS.x,H1_AS.f,'Color',[rand rand rand]);           
    
    figure(2);hold on;            
    title('Across 5Sub,Comparing pde for VT Peak Values Normalized using Deep Inhale Exhale')
    H1_VT = gkde0(PtsVT(:,2));
    med_Jp_VT(I) = plot(H1_VT.x,H1_VT.f,'Color',[rand rand rand]);                        
    
    figure(3);hold on;
    title('Across 5Sub,Comparing pde for AS Valley Values Normalized using Deep Inhale Exhale')
    H2_AS = gkde0(VtsAS(:,2));
    med_Jv_AS(I) = plot(H2_AS.x,H2_AS.f,'Color',[rand rand rand]);            
    
    figure(4);hold on;
    title('Across 5Sub,Comparing pde for VT Valley Values Normalized using Deep Inhale Exhale')
    H2_VT = gkde0(VtsVT(:,2));
    med_Jv_VT(I) = plot(H2_VT.x,H2_VT.f,'Color',[rand rand rand]);                    
 
    
            
    I = I + 1;
end



