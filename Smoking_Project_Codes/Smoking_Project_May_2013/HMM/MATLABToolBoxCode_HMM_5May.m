% This code is to understand the MATLAB toolbox for HMM
% 5 May 2013
clc;clear all;close all;

TRANS = [.9 .1; .05 .95;];

% Emission matrix is 2 X 6 because we know that there are "2" states and 
% "6" emission values
EMIS = [1/6, 1/6, 1/6, 1/6, 1/6, 1/6;...
7/12, 1/12, 1/12, 1/12, 1/12, 1/12];

[seq,states] = hmmgenerate(1000,TRANS,EMIS);

% Most likely state sequence %
likelystates = hmmviterbi(seq, TRANS, EMIS);

sum(states==likelystates)/1000

[TRANS_EST, EMIS_EST] = hmmestimate(seq, states)












