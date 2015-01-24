function [ LpVT,MpVT,LvVT,MvVT,LpAS,MpAS,LvAS,MvAS ] = Peak_Processor(ASts,VTts)
% Task : This function find the peaks for both VT and AS signals and return
% their information in arrays.
% Date : 4 September 2012

AS = ASts(:,2); VT = VTts(:,2);

[LpVT,MpVT] = peakfinder(VT,0.018,0.01,1);LpVT = VTts(LpVT,1);%peaks of VT signal%  
%[LpVT,MpVT] = peakfinder(VT,0.038,0.04,1);LpVT = VTts(LpVT,1);%peaks of VT signal%  

[LvVT,MvVT] = peakfinder(VT,0.018,-0.01,-1);LvVT = VTts(LvVT,1);%valleys of VT signal%
%[LvVT,MvVT] = peakfinder(VT,0.038,-0.0,-1);LvVT = VTts(LvVT,1);%valleys of VT signal%

[LpAS,MpAS] = peakfinder(AS,0.018,0.01,1);LpAS = ASts(LpAS,1);%peaks of AS signal%
%[LpAS,MpAS] = peakfinder(AS,0.038,0.04,1);LpAS = ASts(LpAS,1);%peaks of AS signal%

[LvAS,MvAS] = peakfinder(AS,0.018,-0.01,-1);LvAS = ASts(LvAS,1);%valleys of AS signal%
%%[LvAS,MvAS] = peakfinder(AS,0.038,-0.0,-1);LvAS = ASts(LvAS,1);%valleys of AS signal%



% % % % %%%[LpVT,MpVT] = peakfinder(VT,0.018,0.01,1);LpVT = VTts(LpVT,1);%peaks of VT signal%  
% % % % [LpVT,MpVT] = peakfinder(VT,0.028,0.0,1);LpVT = VTts(LpVT,1);%peaks of VT signal%  
% % % % 
% % % % %%%[LvVT,MvVT] = peakfinder(VT,0.018,-0.01,-1);LvVT = VTts(LvVT,1);%valleys of VT signal%
% % % % [LvVT,MvVT] = peakfinder(VT,0.028,-0.0,-1);LvVT = VTts(LvVT,1);%valleys of VT signal%
% % % % 
% % % % %%%[LpAS,MpAS] = peakfinder(AS,0.018,0.01,1);LpAS = ASts(LpAS,1);%peaks of AS signal%
% % % % [LpAS,MpAS] = peakfinder(AS,0.028,0.0,1);LpAS = ASts(LpAS,1);%peaks of AS signal%
% % % % 
% % % % %%%[LvAS,MvAS] = peakfinder(AS,0.018,-0.01,-1);LvAS = ASts(LvAS,1);%valleys of AS signal%
% % % % [LvAS,MvAS] = peakfinder(AS,0.028,-0.0,-1);LvAS = ASts(LvAS,1);%valleys of AS signal%

end