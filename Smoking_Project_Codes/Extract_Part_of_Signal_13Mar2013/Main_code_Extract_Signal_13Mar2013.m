% This code Extracts a particular part of a signal when the user inputs the
% T1 and T2 time intervals. T1 is the start time and T2 is the end time.
% Value of T1 = T1.Position(1,1)
% First Column == TIME
% Second Column == AIR-FLOW
% Third Column == TIDAL-VOLUME
%clearvars -except VTts ASts puff_score list T1 T2 I
Ind_VT = find( T1.Position(1,1)<= VTts(:,1) & VTts(:,1) <= T2.Position(1,1));
VTts_SubXX = VTts(Ind_VT,:);
Ind_AS = find( T1.Position(1,1)<= ASts(:,1) & ASts(:,1) <= T2.Position(1,1));

ASts_SubXX = ASts(Ind_AS,:);
Ind_PS = find( T1.Position(1,1)<= puff_score(:,1) & puff_score(:,1) <= T2.Position(1,1));
Puff_Score = puff_score(Ind_PS,:);



Err1 = isempty(Ind_PS);

if(Err1 == 1)
    fprintf('No puff score found !');
    Puff_Score = [];%zeros(length(ASts_SubXX(:,1)),2);
else
    temp_ts = ASts_SubXX(:,1);
    Temp1 = zeros(length(ASts_SubXX(:,1)),1);
    L1 = size(Puff_Score,1);
    for i = 1 : 1: L1
        temp_T1 = Puff_Score(i,1);
        temp_T2 = Puff_Score(i,2);
        temp_Ind1 = find(temp_T1 <= ASts_SubXX & ASts_SubXX <= temp_T2);
        Temp1(temp_Ind1) = 2;
    end
    Puff_Score = [temp_ts Temp1];
end

figure;hold on;
H1 = plot(ASts_SubXX(:,1),ASts_SubXX(:,2),'-c');
H2 = plot(VTts_SubXX(:,1),VTts_SubXX(:,2),'-b');
%O = 2*ones(size(Puff_Score,1));
if(isempty(Puff_Score))
else
    H3 = plot(Puff_Score(:,1),Puff_Score(:,2),'-. k');
end
%H4 = plot(Puff_Score(:,2),O,'or'); 



Sub109123cig_22Mar13.name = list(I,:);
Sub109123cig_22Mar13.startend = [T1 T2];
Sub109123cig_22Mar13.Wav = [ASts_SubXX VTts_SubXX(:,2)];
Sub109123cig_22Mar13.Puff_score = Puff_Score;

%save('C:\Users\student\Documents\MATLAB\Smoking_Project_Mar_2013\Spectrogram\Sub105NSLS1','Sub105NSLS1')
save('C:\Users\student\Documents\MATLAB\Smoking_Project_Mar_2013\Threshold_PreAnalysis_of_Waveform22March2013\Sub109123cig_22Mar13','Sub109123cig_22Mar13')


