% [Feature_gesture Label_gesture] = featext_waveform(Data, time_stamp, cress)
 
%  clear all
%  close all
%  
% load Data

function [Feature_gesture Label_gesture] = featext_waveform(Signals, samp_freq, puffs)

%% SENSORS signals
time_scale = Signals(:,1);
VT = Signals(:,2);    % Normalized
AS = Signals(:,3);        % Normalized
proximity_sensor = Signals(:,4);
proximity_square = Signals(:,5); % Rectify proximity signal to high '1' and low '0' above 5% of amplitude
   
%%  Feature and Label Extraction 

index = find(time_scale >= 0 & time_scale <= max(time_scale));
Start = [];
End = [];
j = 2;
l = 1;
m = 1;
for k = 1:length(index)-1 % find begining and end of hand gesture
   if proximity_square(index(k)) == 0 & proximity_square(index(k+1))==1
       Start(l,1) = index(k+1);
       l = l+1;
   elseif proximity_square(index(k)) == 1 & proximity_square(index(k+1))==0
       End(m,1) = index(k);
       m = m+1;
   end          
end

% Make sure Start and End are paired
if length(Start)~=0
   index_end = find(End > Start(1));
   End = End(index_end);           
   if length(Start) < length(End)
       End = End([1:length(Start)]);
   elseif length(Start) > length(End)
       Start = Start([1:length(End)]);
   end
end

if length(Start)==0
   Hand_gesture{j-1,1} = 0;
   Hand_gesture{j-1,2} = 0;
   Hand_gesture{j-1,3} = 0;
   Hand_gesture{j-1,4} = 0;
   Hand_gesture{j-1,5} = 0;

   % for labels
   Label_gesture{j-1,1} = 0;
   Label_gesture{j-1,2} = 0;
   Label_gesture{j-1,3} = 0;
   Label_gesture{j-1,4} = 0;  
   Label_gesture{j-1,5} = 0;  

else                   
   duration = time_scale(End)-time_scale(Start); 
   index_duration = find(duration > 0.005); % Eliminate very short start-end detections
   Start = Start(index_duration);
   End =  End(index_duration);
   Hand_gesture{j-1,2} = time_scale(End)-time_scale(Start); % Duration

   for n = 1:length(Start)
       Hand_gesture{j-1,3}(n) = max (proximity_sensor(Start(n):End(n)));    % Max value of HG
       Hand_gesture{j-1,4}(n) = mean (proximity_sensor(Start(n):End(n)));   % Mean value of HG 
   end

   Hand_gesture{j-1,1} = length(Start); % Number of HG
   Hand_gesture{j-1,5} = length(Start)/(max(time_scale)-0)*60; % Density HG over time

   % ---- Features -------
   size_extraction = 500;
   for n = 1:length(Start)
       if Start(n)+size_extraction < length(VT)
           Feature_gesture(n,:) = [ Hand_gesture{j-1,2}(n)...
                                           Hand_gesture{j-1,3}(n)...
                                           Hand_gesture{j-1,4}(n)...
                                           VT(Start(n):Start(n)+size_extraction)'...
                                           AS(Start(n):Start(n)+size_extraction)'...
                                           proximity_sensor(Start(n):Start(n)+size_extraction)'];
       else
           Feature_gesture(n,:) = [ Hand_gesture{j-1,2}(n)...
                                           Hand_gesture{j-1,3}(n)...
                                           Hand_gesture{j-1,4}(n)...
                                           VT(Start(n):length(VT))' zeros(1,size_extraction-length(VT)-Start(n))...
                                           AS(Start(n):length(AS))' zeros(1,size_extraction-length(VT)-Start(n))...
                                           proximity_sensor(Start(n):length(proximity_sensor))' zeros(1,size_extraction-length(VT)-Start(n))];      
       end
        % Visualize feature vector waveform       
        %        plot(Feature_gesture{j-1,1}{1,n})
        %        hold on
   end

   %----------LABELS----------
   % '-1' is a no smoking puff hand gesture
   % '+1' is a smoking puff label
   Label_gesture(:,1) = -1*ones(1,length(Start)); % Initially label all hand gestures '-1' as non-puffs 
   Label_gesture(:,2) = time_scale(Start);        % Starting points of gesture
   Label_gesture(:,3) = time_scale(End);          % Ending points of gesture
   for k = 1:length(Start) % find overlap between hand gesture and scored puff
       % [Start End]/samp_freq
       % puffs
       index = find(puffs > time_scale(Start(k)) & puffs < time_scale(End(k)));
       index_before = find(puffs(:,1) < time_scale(Start(k)));
       index_after = find(puffs(:,2) > time_scale(End(k)));
       if length(index)~=0
           display('First case')
           Label_gesture(k,1) = 1; % Relabel this particular hand gesture to '1' puff
       else
           if length(index_before)~=0 && length(index_after)~=0
               if index_before(max(index_before) == index_after,1)
                   display('Second case')
                   Label_gesture(k,1) = 1; % Relabel this particular hand gesture to '1' puff
               end
           end
       end
   end
   
   
end

%% Visualize Signals, puff scores and puff labels.
figure(2)
plot(time_scale, VT)
hold on
plot(time_scale, AS,'c');
plot(time_scale, proximity_sensor,'g');
scatter(puffs(:,1),zeros(length(puffs),1),'or');
scatter(puffs(:,2),zeros(length(puffs),1),'or');
% --------------------------------
% Visualize labeled HG into puffs.
ind_puffHG = find(Label_gesture == 1);
Locate_puffs = (Label_gesture(ind_puffHG, 2)+ Label_gesture(ind_puffHG, 3))/2;
scatter(Locate_puffs, ones(length(Locate_puffs),1),'ok');
% --------------------------------
legend('VT','AS','PS','Validation puffs','Labeled HG as puff')
scatter(puffs(:,2),zeros(length(puffs),1),'or');
xlabel('Time (Seconds)');  
ylim([-1.5 1.5]);




