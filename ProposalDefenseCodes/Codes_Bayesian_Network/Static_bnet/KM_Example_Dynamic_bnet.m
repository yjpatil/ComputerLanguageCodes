% ------------------------------------------------------- %
% Code to create bayesian network for Dynamic Inference   %
% ------------------------------------------------------- %

clc; clear all;close all;


% Define the structure %
N = 2; % the total number of nodes

intra = zeros(N);

intra(1,2) = 1; % node1 in slice t connects to node 2 in slice t

inter = zeros(2);
inter(1,1) = 1; % node1 in slice t-1 connects to node 1 in slice t

Q = 2; % num of hidden states
O = 2; % num of observable symbols

ns = [Q,O];
dnodes = 1:2;
bnet = mk_dbn(intra,inter,ns,'discrete',dnodes);

for i = 1 : 1 : 4
    bnet.CPD{i} = tabular_CPD(bnet,i);
end



