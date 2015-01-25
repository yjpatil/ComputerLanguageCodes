function[CODEVT,CODEAS,TimeInst] = fBWinbyWinEncode1Ver(SignalVT,SignalAS,Peaks,Valleys,Actcnt,WinSize,Sep,Div,Time1,Time2,FigVT,FigAS,Score)
% This function first extracts the given activity part from a given Tidal 
% Volume and Air Flow signal. It also stores the time-instances when the
% single breath cycle was captured.
% Date: 8 June 2013




% ------- Get the part of VT signal for the 'ith' Acivity ------- %
IndexVT = find(Time1 <= SignalVT(:,1) & SignalVT(:,1) <= Time2);
SignalVT = SignalVT(IndexVT,:);
% ------- Get the part of AS signal for the 'ith' Acivity ------- %
IndexAS = find(Time1 <= SignalAS(:,1) & SignalAS(:,1) <= Time2);
SignalAS = SignalAS(IndexAS,:);
% ------- Get the part of PS signal for the 'ith' Acivity ------- %
IndexPS = find(Time1 <= Score(:,1) & Score(:,1) <= Time2);
Score = Score(IndexPS,:);

%  Plot ith ACtivity VT signal  %
figure(FigVT);hold on;title('Tidal Volume Signal');xlabel('time (sec)')
plot(SignalVT(:,1),SignalVT(:,2));
O = 0.02*ones(size(Score,1));plot(Score(:,1),O,'ob');plot(Score(:,2),O,'or');
%  Plot ith ACtivity AS signal  %
% figure(FigAS);hold on;title('Air Flow Signal');xlabel('time (sec)')
% plot(SignalAS(:,1),SignalAS(:,2));


% ------- Get the valleys of the VT signal for the 'ith' Activity ------- %
IndexVT = [];
IndexVT = find(Time1 <= Valleys(:,1) & Valleys(:,1) <= Time2);
Valleys = Valleys(IndexVT,:);
plot(Valleys(:,1),Valleys(:,2),'*k');


IndexVT = [];
IndexVT = find(Time1 <= Peaks(:,1) & Peaks(:,1) <= Time2);
Peaks = Peaks(IndexVT,:);


% WinSize = 3; % No of valleys or No of breath cycles to be considered
I = 1; % index for the matrix that holds the wheel coded waveform
it1 = 1;
TimeInst = [];

while(it1 <= length(Valleys) - WinSize)
    T1 = Valleys(it1,1);
    it1 = it1 + WinSize;
    T2 = Valleys(it1,1);
    TimeInst(I,:) = [T1 T2];
    % ------- Plot the segmentated part for Tidal Volume Signal -------- %
    figure(FigVT);hold on;
    plot([T1 T1],[-2 2],'-k');plot([T1 T2],[2 2],'-k');plot([T2 T2],[2 -2],'-k');plot([T2 T1],[-2 -2],'-k');
    % ------- Plot the segmentated part for Tidal Volume Signal -------- %
%     figure(FigAS);hold on;
%     plot([T1 T1],[-2 2],'-k');plot([T1 T2],[2 2],'-k');plot([T2 T2],[2 -2],'-k');plot([T2 T1],[-2 -2],'-k');
    % ----- Find the Tidal Volume Signal between the Valleys times T1 and
    % T2. And extract that Tidal Volume signal for Signal En-coding ----- %
    IndexVT = [];
    IndexVT = find(T1 <= SignalVT(:,1) & SignalVT(:,1) <= T2);
    VTts_temp = SignalVT(IndexVT,:);    
    %Levels = 5;
%     figure(FigVT);hold on;
    [CodeVT] = EncodedSeq(VTts_temp,Sep,Div);  
    CODEVT{I} = CodeVT;
    % ----- Find the Air Flow Signal between the Valleys times T1 and
    % T2. And extract that Air Flow signal for Signal En-coding ----- %
    IndexAS = [];
    IndexAS = find(T1 <= SignalAS(:,1) & SignalAS(:,1) <= T2);
    ASts_temp = SignalAS(IndexAS,:);    
    %Levels = 5;
%     figure(FigAS);hold on;
    [CodeAS] = EncodedSeq(ASts_temp,Sep,Div);  
    CODEAS{I} = CodeAS;
    
    I = I + 1;
    %%%%%%it1 = it1 + 1;     
end





end



