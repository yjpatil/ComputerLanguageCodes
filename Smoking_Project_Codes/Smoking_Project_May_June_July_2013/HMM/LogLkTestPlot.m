function[I] = LogLkTestPlot(Signal1,Signal2,TimeInst,Actcnt,Activities,Fig1,Fig2,Score)
% This plots the Air_Flow and Tidal_Volume Signal.
% Plot the scores also if 'Actcnt' is for Smoking activities
% Date: 8 June 2013

Actcnt = Actcnt + 1;


T1 = Activities(Actcnt,1);
T2 = Activities(Actcnt,2);

% ------- Get the part of VT signal for the 'ith' Acivity ------- %
Index1 = find(T1 <= Signal1(:,1) & Signal1(:,1) <= T2);
Signal1 = Signal1(Index1,:);
% ------- Get the part of AS signal for the 'ith' Acivity ------- %
Index2 = find(T1 <= Signal2(:,1) & Signal2(:,1) <= T2);
Signal2 = Signal2(Index2,:);

%  Plot ith ACtivity VT signal  %
figure(Fig1);hold on;title('Tidal Volume Signal');xlabel('time (sec)')
plot(Signal1(:,1),Signal1(:,2));
%  Plot ith ACtivity AS signal  %
figure(Fig2);hold on;title('Air Flow Signal');xlabel('time (sec)')
plot(Signal2(:,1),Signal2(:,2));

% Observe that you have added '1' to Actcnt variable
if(Actcnt == 11 || Actcnt == 13)
    Ind = find(T1 <= Score(:,6) & Score(:,6) <= T2);
    Score = Score(Ind,:);
    O = 0.01*ones(size(Score,1));
    figure(Fig1);hold on;
    plot(Score(:,3),O,'ob');
    plot(Score(:,6),O,'or');
    figure(Fig2);hold on;
    plot(Score(:,3),O,'ob');
    plot(Score(:,6),O,'or');    
end
     

I = 1; % index 

while(I <= length(TimeInst))
    T1 = TimeInst(I,1);
    T2 = TimeInst(I,2);
     
    % ------- Plot the segmentated part for Tidal Volume Signal -------- %
    figure(Fig1);hold on;
    plot([T1 T1],[-2 2],'-k');plot([T1 T2],[2 2],'-k');plot([T2 T2],[2 -2],'-k');plot([T2 T1],[-2 -2],'-k');
    % ------- Plot the segmentated part for Tidal Volume Signal -------- %
    figure(Fig2);hold on;
    plot([T1 T1],[-2 2],'-k');plot([T1 T2],[2 2],'-k');plot([T2 T2],[2 -2],'-k');plot([T2 T1],[-2 -2],'-k');
        
    I = I + 1;
    %%%%%%it1 = it1 + 1;     
end








end