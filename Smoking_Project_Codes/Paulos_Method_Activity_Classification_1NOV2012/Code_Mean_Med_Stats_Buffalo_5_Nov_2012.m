%    This code Normalizes the Buffalo Data using Max Inhale Sample Amp    %
% Date : 5 Nov 2012

clc;clear all;close all;

global sf ts;
sf = 101.73;

path = char('C:\Users\student\Documents\MATLAB\unsync buffalo data\');

list = char('PACT_105','PACT_107','PACT_109','PACT_114','PACT_117');

Size_List = size(list,1);

I = 1;

while(I <= Size_List)
    
    load(strcat(path(1,:),list(I,:),'.mat'));
     
    L = length(Data);
    
    ts = [1:L]/sf;
    ts = ts';
    ts = ts-(Activities(1,2));
    
    [AB,RC] = process_AB_RC(3,Data(:,3),Data(:,4));    % 2 & 3 = Invert the Signals
    
    [ASr,VTr] = get_AS_VT(0,AB,RC,1,4);        % 0 = (AB+RC)/2,  1 = RC,  2 = AB.% + Filtering using Ideal Filter = 1 or WT filter = 2. ALso the threshold value (4) for the component removal    
    
    
    I = I + 1;
end