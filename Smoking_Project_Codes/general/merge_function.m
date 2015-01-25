function merge = merge_function(dat,ts,th,SD,LD,merge_time)
%****NOTE: You need 'intersection' function from MATLAB file-exchange****%

% function merge = merge_function1(dat,ts,th,SD,LD)

% "dat" contains the original (Proximity Sensor) signal on which the operation is to be done
% "dat" should be normalized before passing through this function.
% "ts" should contain the time-stamps for the "dat" values.
% ts = [1:length(Data(:,2))]/sf;       %% Methodology for obtaining time-stamps %%
% ts = ts';
% ts = ts-Activities(1,2);

% This Function eliminates signals of amplitude < "th" value and signals
% with amplitude > "th" and converted into square pulses.
% This Function merges two nearby pulses (having time-difference<"merge_time") 
% and eliminates pulses with short duration("SD") & long duration("LD").


%%% Conversion of PS signals to normalised square-pulses %%%
index = find(dat >= th);
dat = zeros(length(dat),1);
dat(index) = 1;

%%% The folowing part checks if there are incomplete HG's in the PS signals
flag = 1;
while(flag == 1)
    if(dat(1) == 1)
        i = 1; temp = 1;
        while(temp ~= 0)
            temp = dat(i);
            dat(i) = 0;
            i = i + 1;
        end
        flag = 0;
    else
        flag = 0;
    end
end

flag = 1;
while(flag == 1)
    if(dat(length(dat)) == 1)
        i = length(dat); temp = 1;
        while(temp ~= 0)
            temp = dat(i);
            dat(i) = 0;
            i = i - 1;
        end
        flag = 0;
    else
        flag = 0;
    end
end
% % figure(101)
% % plot(ts,dat,'-y');grid on;hold on;

% Merging of two nearby pulses having time difference less than merge_time
%%% Merge Function Implementation: If difference of end of HG and start of
%%% next HG is less than merge time, MERGE

[tintdat,ydat] = intersections(ts,dat,[ts(1) ts(length(ts))],[0.5 0.5],1);

error1 = mod(length(tintdat),2);

if(error1 == 0)
else
    disp('Error in merge_function:There are no paired HGs (i.e. start and end of HG)');
    stop;    
end

SEtdat(:,1) = tintdat(1:2:(length(tintdat)));
SEtdat(:,2) = tintdat(2:2:(length(tintdat)));

for i = 1 : 1 : length(SEtdat)-1
    d = SEtdat(i+1,1) - SEtdat(i,2);
    if(d <= merge_time)
        index1 = find(SEtdat(i,1) <= ts & ts <= SEtdat(i+1,2));
        dat(index1) = 1;
    else
    end
end
% % figure(102)
% % plot(ts,dat,'-m');grid on;hold on;

%%% TO implement the deletion of Short Duration(SD) and Long Duration (LD) signals

clear('tintdat','SEtdat')
[tintdat,ydat] = intersections(ts,dat,[ts(1) ts(length(ts))],[0.5 0.5],1);

SEtdat(:,1) = tintdat(1:2:(length(tintdat)));
SEtdat(:,2) = tintdat(2:2:(length(tintdat)));

Dif = SEtdat(:,2) - SEtdat(:,1);

index11 = find(Dif <= SD);
for i11 = 1 : 1 : length(index11)
    index22 = find(SEtdat(index11(i11),1) <= ts & ts <= SEtdat(index11(i11),2));
    dat(index22) = 0;
end
% % figure(103)
% % plot(ts,dat,'-g');grid on;hold on;
index33 = find(Dif >= LD);
for i33 = 1 : 1 : length(index33)
    index44 = find(SEtdat(index33(i33),1) <= ts & ts <= SEtdat(index33(i33),2));
    dat(index44) = 0;
end
% % figure(104)
% % plot(ts,dat,'-k');grid on;hold on;
merge = dat;


end

