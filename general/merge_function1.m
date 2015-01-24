function merge = merge_function1(dat,ts,th,SD,LD,merge_time)
%function merge = merge_function1(dat,ts,th,SD,LD)

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

%****NOTE: You need intersection function from MATLAB exchange file ****%

l = length(dat);      


%%% Conversion of PS signals to normalised square-pulses %%%
index = find(dat >= th);
dat = zeros(length(dat),1);
dat(index) = 1;

% if dat(1) == 1
%     dat(1) = 0;
% else
% end
% if dat(l) == 1
%     dat(l) = 0;
% else
% end


% Merging of two nearby pulses having time difference less than merge_time

PSn = [dat ts];
ic =1;

for i = 1:1:l
    if PSn(i,1) == 1
        PS1(ic,1)= PSn(i,1);   %%% A new n-by-3 Matrix PS1 with First Column containing 1's %%%
        PS1(ic,2)= PSn(i,2);   %%% Second Column containing the time %%%
        PS1(ic,3)= i;         %%% Third Column containing the index of the 1 %%%     
        ic = ic + 1;
    else
      
    end
end
%%%% PS1 is a matrix of n-by-3 with indices and timing of 1's only %%%
% figure(113)
l1 = length(PS1);   %% Get the length of PS1 matrix %%%
% it =1;   %%% Iteration index of max value of that of length PS1  %%%
% m_t = 20;  %%% Merge Time variable  %%%
for it = 1:1:l1-1
    if PS1(it + 1, 3) - PS1(it, 3) > 1      %%% check index difference if > 1   ...contd
        if PS1(it + 1, 2) - PS1(it, 2) <= merge_time    %%% and if the separation between them is <= merge time
            for m = PS1(it,3):1:PS1(it+1,3)    %%% ... then fill with ones in that gap
        dat(m,1) = 1;
            end
        else              %%% ... if the separation between them is > merge time leave it as it is
        end
    else               %%%% if the index difference is = 1 leave it as it is
    end
end

[tintdat,ydat] = intersections(ts,dat,[0 ts(length(ts),1)],[0.5 0.5],1);
%[tintdat,ydat] = intersections(ts,dat,[0 ts(length(ts),1)],[0.1 0.1],1);
clear 'error1'
error1 = mod(length(tintdat),2);
if error1 == 0
    S1 = tintdat(1:2:(length(tintdat)));
    E2 = tintdat(2:2:(length(tintdat)));
    length(S1)
    length(E2)
else
    S1 = tintdat(1:2:(length(tintdat)));
    E2 = tintdat(2:2:(length(tintdat)));
    disp(S1);disp(E2);
    length(S1)
    length(E2)
    disp('Error in INTERSECTION of Proximity Sensor(dat)in merge_function');
    stop;    
end

SEtdat(:,1) = tintdat(1:2:(length(tintdat)));
SEtdat(:,2) = tintdat(2:2:(length(tintdat)));

Dif = SEtdat(:,2) - SEtdat(:,1);

index11 = find(Dif <= SD);
for i11 = 1 : 1 : length(index11)
    index22 = find(SEtdat(index11(i11),1) <= ts & ts <= SEtdat(index11(i11),2));
    dat(index22) = 0;
end

index33 = find(Dif >= LD);
for i33 = 1 : 1 : length(index33)
    index44 = find(SEtdat(index33(i33),1) <= ts & ts <= SEtdat(index33(i33),2));
    dat(index44) = 0;
end
merge = dat;

