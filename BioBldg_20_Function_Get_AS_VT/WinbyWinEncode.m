function[CODE] = WinbyWinEncode(Signal,Peaks,Valleys,Actcnt,WinSize,Sep,Div,Activities,Fign)
% This function first extracts the given activity part from a given signal
% Date: 28 May 2013

Actcnt = Actcnt + 1;



T1 = Activities(Actcnt,1);
T2 = Activities(Actcnt,2);

Index = find(T1 <= Signal(:,1) & Signal(:,1) <= T2);
Signal = Signal(Index,:);

figure(Fign);hold on;
plot(Signal(:,1),Signal(:,2));

Index = [];
Index = find(T1 <= Valleys(:,1) & Valleys(:,1) <= T2);
Valleys = Valleys(Index,:);

% plot(Valleys(:,1),Valleys(:,2),'*k');


Index = [];
Index = find(T1 <= Peaks(:,1) & Peaks(:,1) <= T2);
Peaks = Peaks(Index,:);


% WinSize = 3; % No of valleys or No of breath cycles to be considered
I = 1; % index for the matrix that holds the wheel coded waveform
it1 = 1;

while(it1 < length(Valleys) - WinSize)
    T1 = Valleys(it1,1);
    it1 = it1 + WinSize;
    T2 = Valleys(it1,1);
    plot([T1 T1],[-2 2],'-k');plot([T1 T2],[2 2],'-k');plot([T2 T2],[2 -2],'-k');plot([T2 T1],[-2 -2],'-k');
    Index = [];
    Index = find(T1 <= Signal(:,1) & Signal(:,1) <= T2);
    ASts_temp = Signal(Index,:);    
    %Levels = 5;
    [CodeAS] = EncodedSeq(ASts_temp,Sep,Div);  
    CODE{I} = CodeAS;
    I = I + 1;
    %it1 = it1 + 1;     
end













end