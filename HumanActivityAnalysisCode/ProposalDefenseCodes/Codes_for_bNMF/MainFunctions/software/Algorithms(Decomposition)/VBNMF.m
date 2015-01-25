%function [W,H,Project] = VBNMF(train,test)


% Number of Rows
M = size(x,1);

% Number of Columns
N = size(x,2);
% Number of templates
I = base_num;

% Set prior parameters 
a_tm = 10*ones(M, I);   % Shape
b_tm = ones(M, I);        % Scale
a_ve = ones(I, N);
b_ve = 100*ones(I, N);

% Generate a random template and excitation
% gamrnd is part of statistics toolbox
T = gamrnd(a_tm, b_tm);
V = gamrnd(a_ve, b_ve);


% Execute the fixed point iterations
[g] = vb(x, a_tm, b_tm, a_ve, b_ve, 'EPOCH', 2000, 'UPDATE', 10,...
                                    'tie_a_ve', 'tie_all', ...
                                    'tie_b_ve', 'tie_all',...
                                    'tie_a_tm', 'tie_all', ...
                                    'tie_b_tm', 'tie_all' ...
);


H = g.E_V;
W = g.E_T;

Project = inv(W'*W)*W'*VV;


