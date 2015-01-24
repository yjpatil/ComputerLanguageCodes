% This code combines the separate fields of the same act into one single
% field
% Date : 22 July 2013
clc;clear all;close all;

%load('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\Waveform_Numbering\SubWNos')

load('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\Waveform_Numbering\WholeSubWNos') %  <------ MAKE SURE You change this and the line Below

SubWNos = WholeSubWNos;  %  <------ MAKE SURE You change this 



C = size(SubWNos,2);

for I = 1 : 1 : C
    ComSubWNos(I).Sit = cat(2,SubWNos(I).Sit1,SubWNos(I).Sit2,SubWNos(I).Sit3,SubWNos(I).Sit4);%,SubWNos(I).SWalk1,SubWNos(I).SWalk2,SubWNos(I).FWalk1,SubWNos(I).FWalk2); % If you dont want the data set with Sit2 then you can discard its name
    ComSubWNos(I).Read = cat(2,SubWNos(I).Read1,SubWNos(I).Read2,SubWNos(I).Read3,SubWNos(I).Read4); % If you dont want the data set with Read4 then you can discard its name
    %ComSubWNos(I).SWalk = cat(2,SubWNos(I).SWalk1,SubWNos(I).SWalk2); % If you dont want the data set with SWalk2 then you can discard its name
    %ComSubWNos(I).FWalk = cat(2,SubWNos(I).FWalk1,SubWNos(I).FWalk2); % If you dont want the data set with FWalk2 then you can discard its name
    ComSubWNos(I).Walk = cat(2,SubWNos(I).SWalk1,SubWNos(I).SWalk2,SubWNos(I).FWalk1,SubWNos(I).FWalk2);
    ComSubWNos(I).Smk = cat(2,SubWNos(I).SmkSitN,SubWNos(I).SmkSitE,SubWNos(I).SmkStdN,SubWNos(I).SmkStdE); % If you dont want the data set with SmkStd2 then you can discard its name
end


save('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\Waveform_Numbering\ComWhole_Sit_Walk_Sep','ComSubWNos')


LenSit = 0;
LenRead = 0;
LenWalk = 0;
LenSmk = 0;

SitFlag = 0;
ReadFlag = 0;
SmkFlag = 0;


for I = 1 : 1 : C
    temp1 = length(ComSubWNos(I).Sit);
    LenSit = LenSit + temp1;
    if(isempty(ComSubWNos(I).Sit))
        SitFlag = SitFlag + 1;
        Isit = I
    end
    temp2 = length(ComSubWNos(I).Read);
    LenRead = LenRead + temp2;
    if(isempty(ComSubWNos(I).Read))
        ReadFlag = ReadFlag + 1;
        Iread = I
    end
%     temp3 = length(ComSubWNos(I).Walk);
%     LenWalk = LenWalk + temp3;
    temp4 = length(ComSubWNos(I).Smk);
    LenSmk = LenSmk + temp4;
    if(isempty(ComSubWNos(I).Smk))
        SmkFlag = SmkFlag + 1;
        Ismk = I
    end
end

LenSit 
LenRead
LenWalk
LenSmk

SitFlag
ReadFlag
SmkFlag












