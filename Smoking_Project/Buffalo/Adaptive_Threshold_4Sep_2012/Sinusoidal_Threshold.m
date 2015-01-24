function [sinu_Th,t] = Sinusoidal_Threshold(Fc,T1,T2,range)
% Task: This function produces a sinusoidal wave between range(1) and
% range(2). T1 is the start time of the sinusoidal wave, while T2 is the
% end time of the sinusoidal wave.

Fs = 8000; % sample points
dt = 1/Fs; % separation between each sample points

st = 0.25;
T2 = T2 + st;

t = (T1 : dt : T2 - dt);  % 


x = cos(2*pi*Fc*t); % the sinusoidal signal

% Following code normalizes the signal to given range/limits

r1 = range(1);   % Minimum Value

r2 = range(2);   % Maximum Value

min_x = min(x);
max_x = max(x);

x_norm = (((x - min_x)./(max_x - min_x)).*(r2 - r1)) + r1;


sinu_Th = x_norm;


end