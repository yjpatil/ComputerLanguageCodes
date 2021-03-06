function [AS,VT] = get_AS_VT(Case,AB,RC,filter_choice,Thresh_choice)
% Created : 19 MAy 2012
% Function : This functin generates Air-Flow and Volume-Tidal signals 
% depending on the value of 'Case'. The different 'Case' decide which belts
% should be used to calculate the AS and VT signals.
% Also the variable "filter_choice" decides which filtering technique
% should be applied along with smoothing technique
              % ************ Important NOTICE *********** %
% When you use One Belt for calculation see the formula for calculating VT

global sf ts;

if(Case == 0)
    VT = (AB + RC)/2;
    %%figure(111)
    %%plot(ts,VT,'-k');hold on;grid on;      
elseif(Case == 1)
    VT = (RC); 
elseif(Case == 2)
    VT = (AB);    
else
end

if(filter_choice == 1)
    VT = idealfilter(VT,0.1,1000,sf);
    %VT = fastsmooth(VT,45,3,1);
    VT = fastsmooth(VT,50,3,1);
    AS = diff(VT)./diff(ts);AS = [AS;0];
    %%AS = fastsmooth(AS,45,3,1);
elseif(filter_choice == 2)
    %VT = VT - median(VT);
    VT = VT - mean(VT);
    %figure
    %plot(ts,VT,'r');hold on;
    [VT]=denoise(VT, Thresh_choice);    
    %figure
    %plot(ts,VT,'g');hold on;
    %VT = fastsmooth(VT,45,3,1);
    VT = fastsmooth(VT,50,3,1);
    %figure
    %plot(ts,VT,'k');hold on;
    AS = diff(VT)./diff(ts);AS = [AS;0];
    %AS = fastsmooth(AS,45,3,1);    
else
    printf(' Wrong filtering choice. Please check your filter choice ');
end

end