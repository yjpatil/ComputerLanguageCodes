function[SUB,Counter] = fDetermine_Samples_Ver1(SUB,I,Counter,SignalVT,SignalAS,Peaks,Valleys,Actcnt,WinSize,Activities,FigVT,FigAS)
% This function first extracts the given activity part from a given Tidal 
% Volume and Air Flow signal. It also stores the time-instances when the
% single breath cycle was captured.
% Date: 8 June 2013

Actcnt = Actcnt + 1;


T1 = Activities(Actcnt,1);
T2 = Activities(Actcnt,2);

% ------- Get the part of VT signal for the 'ith' Acivity ------- %
IndexVT = find(T1 <= SignalVT(:,1) & SignalVT(:,1) <= T2);
SignalVT = SignalVT(IndexVT,:);
% ------- Get the part of AS signal for the 'ith' Acivity ------- %
IndexAS = find(T1 <= SignalAS(:,1) & SignalAS(:,1) <= T2);
SignalAS = SignalAS(IndexAS,:);

%  Plot ith ACtivity VT signal  %
% figure(FigVT);hold on;title('Tidal Volume Signal');xlabel('time (sec)')
% plot(SignalVT(:,1),SignalVT(:,2));
%  Plot ith ACtivity AS signal  %
% figure(FigAS);hold on;title('Air Flow Signal');xlabel('time (sec)')
% plot(SignalAS(:,1),SignalAS(:,2));


% ------- Get the valleys of the VT signal for the 'ith' Activity ------- %
IndexVT = [];
IndexVT = find(T1 <= Valleys(:,1) & Valleys(:,1) <= T2);
Valleys = Valleys(IndexVT,:);
% plot(Valleys(:,1),Valleys(:,2),'*k');


IndexVT = [];
IndexVT = find(T1 <= Peaks(:,1) & Peaks(:,1) <= T2);
Peaks = Peaks(IndexVT,:);


% WinSize = 3; % No of valleys or No of breath cycles to be considered
%I = 1; % index for the matrix that holds the wheel coded waveform
it1 = 1;
% TimeInst = [];
% WaveNo = [];
while(it1 <= length(Valleys) - WinSize)
    T1 = Valleys(it1,1);
    it1 = it1 + WinSize;
    T2 = Valleys(it1,1);
    
    SUB(I).TimeInst(Counter,:) = [T1 T2];
    SUB(I).WaveNo(Counter) = Counter;
    
%     text( T1+((T2-T1)/2), 2.03, num2str(Counter));
%     text( T1+((T2-T1)/2), -2.03, num2str(T2-T1));
%     text( T1+((T2-T1)/2), -2.3, num2str(60/(T2-T1)));
    
%     plot([T1 T1],[-2 2],'-k');plot([T1 T2],[2 2],'-k');plot([T2 T2],[2 -2],'-k');plot([T2 T1],[-2 -2],'-k');
    
    
    % ------- Plot the segmentated part for Tidal Volume Signal -------- %
%     figure(FigVT);hold on;
%     plot([T1 T1],[-2 2],'-k');plot([T1 T2],[2 2],'-k');plot([T2 T2],[2 -2],'-k');plot([T2 T1],[-2 -2],'-k');
    % ------- Plot the segmentated part for Tidal Volume Signal -------- %
%     figure(FigAS);hold on;
%     plot([T1 T1],[-2 2],'-k');plot([T1 T2],[2 2],'-k');plot([T2 T2],[2 -2],'-k');plot([T2 T1],[-2 -2],'-k');
    % ----- Find the Tidal Volume Signal between the Valleys times T1 and
    % T2. And extract that Tidal Volume signal for Signal En-coding ----- %
    IndexVT = [];
    IndexVT = find(T1 <= SignalVT(:,1) & SignalVT(:,1) <= T2);
    VTts_temp = SignalVT(IndexVT,2);     
    SUB(I).SamplesVT(Counter) = length(VTts_temp);
    % ----- Find the Air Flow Signal between the Valleys times T1 and
    % T2. And extract that Air Flow signal for Signal En-coding ----- %
    IndexAS = [];
    IndexAS = find(T1 <= SignalAS(:,1) & SignalAS(:,1) <= T2);
    ASts_temp = SignalAS(IndexAS,2);      
    SUB(I).SamplesAS(Counter) = length(ASts_temp);
    
    Counter = Counter + 1;  
    
end





end



