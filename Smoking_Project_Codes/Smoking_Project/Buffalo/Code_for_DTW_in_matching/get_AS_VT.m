function [AS,VT] = get_AS_VT(Case,AB,RC)
% Created : 19 MAy 2012
% Function : to generate Air-Flow and Volume-Tidal signals depending on the
% value of 'Case'.
global sf ts;
if(Case == 0)
    VT = (AB + RC)/2;
    VT = idealfilter(VT,0.1,1000,sf);
    VT = fastsmooth(VT,15,3,0);
    
    AS = diff(VT)./diff(ts);AS = [AS;0];
elseif(Case == 1)
    VT = (RC)/2;
    VT = idealfilter(VT,0.1,1000,sf);
    VT = fastsmooth(VT,15,3,0);
    
    AS = diff(VT)./diff(ts);AS = [AS;0];
elseif(Case == 2)
    VT = (AB)/2;
    VT = idealfilter(VT,0.1,1000,sf);
    VT = fastsmooth(VT,15,3,0);
    
    AS = diff(VT)./diff(ts);AS = [AS;0];
else
end



end