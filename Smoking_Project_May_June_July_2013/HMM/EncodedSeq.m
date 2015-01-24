function[Code] = EncodedSeq(Signal,Intervals,Levels)

%-----
%figure(111);hold on;
%plot(Signal(:,1),Signal(:,2))
%-----
%Intervals = 15;
it3 = 1;

count = 1; % This variable is for Code vector indices 

while(it3 < size(Signal,1)- Intervals) 
    
    %plot(Signal(it3,1),Signal(it3,2),'ok');
    
    x1 = Signal(it3,1);
    y1 = Signal(it3,2);
    x2 = Signal(it3+Intervals,1);
    y2 = Signal(it3+Intervals,2);
    Slope = (y2 - y1)/(x2 - x1);
    Theta = atand(Slope);
    if(Theta < 0)
        Theta = Theta + 360;
    end    
    [Code1] = AngleCode(Theta,Levels);    
    Code(count) = Code1;    
    %figure(111);
    %gcf;
    %text(Signal(it3,1) - 0.4, Signal(it3,2), num2str(Theta));
    
%     text(Signal(it3,1) - 0.1, Signal(it3,2), num2str(Code1));
    
    count = count + 1;
    it3 = it3 + Intervals;
end



% plot of the Tidal Volume Signal %
% figure;hold on;
% plot(VTts(:,1),VTts(:,2))
% SepVT = 15;
% it3 = 1;
% 
% while(it3 < size(VTts,1))    
%     plot(VTts(it3,1),VTts(it3,2),'ok');
%     x1 = VTts(it3,1);y1 = VTts(it3,2);
%     x2 = VTts(it3+SepVT,1);y2 = VTts(it3+SepVT,2); 
%     Slope = (y2 - y1)/(x2 - x1);
%     Theta = atand(Slope);
%     if(Theta < 0)
%         Theta = Theta + 360;
%     end
%     
%     [Code] = AngleCode(Theta,9);
%     
%     figure(2);gcf;
%     %text(VTts(it3,1) - 0.1, VTts(it3,2), num2str(Theta));
%     text(VTts(it3,1) - 0.1, VTts(it3,2), num2str(Code));
%     it3 = it3 + SepVT;
% end






end






