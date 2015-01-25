% ------------------------------------------------------ %
% Code to create bayesian network for Static Inference   %
% ------------------------------------------------------ %

clc; clear all;close all;

% % ---------------------------- % %
% create a directed acylic graph % 
N = 9; % total nodes
dag = zeros(N); % Initialize the dag matrix, that defines the 
G1 =1; F1 = 2; F2 = 3; I = 4; T = 5; L = 6; B1 = 7; B2 = 8; B3 = 9; 

dag(G1, [F1 F2]) = 1;% Define the connections %
dag(F1, [I T L]) = 1;% Define the connections %
dag(F2, [I T L]) = 1;% Define the connections %
dag(I, [B1 B2 B3]) = 1;% Define the connections %
dag(T, [B1 B2 B3]) = 1;% Define the connections %
dag(L, [B1 B2 B3]) = 1;% Define the connections %

% % ---------------------------- % %
% Create a Bayesian Net %
discrete_nodes = 1:N; % Total nodes
node_sizes = 2*ones(1,N);   % state size -> Total values (True/False)
%%node_sizes(4:6) = 3; % First node (S) contains ??
bnet = mk_bnet(dag, node_sizes, 'discrete', discrete_nodes);  % Create the Network

% % ---------------------------- % %
% input parameters' values
bnet.CPD{G1} = tabular_CPD(bnet, G1, [0.3 0.7]);
bnet.CPD{F1} = tabular_CPD(bnet, F1, [0.95 0.05 0.05 0.95]);
bnet.CPD{F2} = tabular_CPD(bnet, F2, [0.85 0.15 0.15 0.85]);
bnet.CPD{I} = tabular_CPD(bnet, I, [0.5 0.9 0.1 0.1 0.5 0.1 0.9 0.9]);
bnet.CPD{T} = tabular_CPD(bnet, T, [0.5 0.8 0.1 0.2 0.5 0.2 0.9 0.8]);
bnet.CPD{L} = tabular_CPD(bnet, L, [0.5 0.8 0.3 0.4 0.5 0.2 0.7 0.6]);
bnet.CPD{B1} = tabular_CPD(bnet, B1, [0.99 0.45 0.75 0.15 0.9 0.35 0.15 0.1 0.01 0.55 0.25 0.85 0.1 0.65 0.85 0.9]);
bnet.CPD{B2} = tabular_CPD(bnet, B2, [0.99 0.35 0.75 0.25 0.85 0.1 0.35 0.2 0.01 0.65 0.25 0.75 0.15 0.9 0.65 0.8]);
bnet.CPD{B3} = tabular_CPD(bnet, B3, [0.01 0.15 0.25 0.9 0.35 0.55 0.85 0.99 0.99 0.85 0.75 0.1 0.65 0.45 0.15 0.01]);

% % ----- Make Inference ----- % %
engine = jtree_inf_engine(bnet);

% % ---------------------------- % %
% computing marginal probability

evidence = cell(1,N);
evidence{G1} = 2;
%evidence{F1} = 2;
evidence{I} = 2;
evidence{T} = 1;
%evidence{L} = 2;

[engine, loglik] = enter_evidence(engine, evidence);
marg = marginal_nodes(engine, B1);
marg.T
marg = marginal_nodes(engine, B2);
marg.T
marg = marginal_nodes(engine, B3);
marg.T
% % ---------------------------- % %    
% computing joint probability
% engine = jtree_inf_engine(bnet);
% evidence = cell(1,N);
% [engine, loglik] = enter_evidence(engine, evidence);
% joint = marginal_nodes(engine, [S W R]);






