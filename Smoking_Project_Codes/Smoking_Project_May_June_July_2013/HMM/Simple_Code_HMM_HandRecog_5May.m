clc;clear all;

%  Add this path into the paths so as to acess all HMM toolkit 
addpath(genpath('C:\Users\student\Documents\MATLAB\HMM\HMMEverything'));
%  Initialize all the data set in cell format  %
%  This is actually the coding of the digits to feed for HMM training %
data0{1} = [9 8 8 7 7 7 6 6 6 5 5 5 4 4 3 2 1 16 15 15 15 15 14 14 14 13 ...
13 13 12 12 11 10 9 9 8 ];
data0{2} = [8 8 7 7 7 6 6 5 5 5 5 4 4 3 2 1 1 16 15 15 15 15 15 14 14 14 ...
14 13 12 11 10 10 9 9 9 ];
data0{3} = [7 6 6 6 6 6 6 5 5 5 4 3 2 1 16 16 16 15 15 15 15 14 14 14 14 ...
14 14 13 11 10 9 9 8 8 8 8 7 7 6 6 ];
% Coding of the data set for Hand written 1's %
data1{1} = [5 5 5 5 5 5 5 5 5 5 5 4 ];
data1{2} = [5 6 6 6 6 6 6 6 6 5 5 4 ];
data1{3} = [5 5 5 6 6 6 6 6 6 7 6 4 3]; 
% Initialize Model 0 for Hand written 0's %
hmm0.prior = [1 0 0];
hmm0.transmat = rand(3,3);
hmm0.transmat(2,1) = 0;hmm0.transmat(3,1) = 0;hmm0.transmat(3,2) = 0; % Why they did this step?
% This is because the "Graphical Model" is constructed in this way. For
% example, there is transition between state 1 and 3, but not the other way
% Therefore, you will have "zero" in (3,1) and not in (1,3)
hmm0.transmat = mk_stochastic(hmm0.transmat);   
hmm0.obsmat = rand(3, 16);  % 16 is the output symbols 
hmm0.obsmat = mk_stochastic(hmm0.obsmat);   
% Initialize Model 1 for Hand written 1's %
hmm1.prior = [1 0];
hmm1.transmat = rand(2,2);
hmm1.transmat(2,1) = 0; % Same reason as for hmm0.transmat
hmm1.transmat = mk_stochastic(hmm1.transmat);
hmm1.obsmat = rand(2, 16);
hmm1.obsmat = mk_stochastic(hmm1.obsmat);


% Train the initial model with the given data set for class '0'
[LL0, hmm0.prior, hmm0.transmat, hmm0.obsmat] = dhmm_em(data0, ...
    hmm0.prior, hmm0.transmat, hmm0.obsmat,'max_iter', 50);
% Train the initial model with the given data set for class '1'
[LL1, hmm1.prior, hmm1.transmat, hmm1.obsmat] = dhmm_em(data1, ...
    hmm1.prior, hmm1.transmat, hmm1.obsmat,'max_iter', 50);


for dt =1:length(data0)
    loglike0 = dhmm_logprob(data0{dt}, hmm0.prior, hmm0.transmat, ...
        hmm0.obsmat);
    loglike1 = dhmm_logprob(data0{dt}, hmm1.prior, hmm1.transmat, ...
        hmm1.obsmat);
    disp(sprintf('\n\n [class 0: %d-th data] model 0: %.3f, model 1: %.3f\n',dt, ...
        loglike0, loglike1));
end



for dt =1:length(data1)
    loglike0 = dhmm_logprob(data1{dt}, hmm0.prior, hmm0.transmat, ...
        hmm0.obsmat);
    loglike1 = dhmm_logprob(data1{dt}, hmm1.prior, hmm1.transmat, ...
        hmm1.obsmat);
    disp(sprintf('\n\n [class 0: %d-th data] model 0: %.3f, model 1: %.3f\n',dt, ...
        loglike0, loglike1));
end



































 
  