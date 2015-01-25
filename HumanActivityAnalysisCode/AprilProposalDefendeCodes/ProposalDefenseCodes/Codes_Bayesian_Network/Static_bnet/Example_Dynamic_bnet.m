% ------------------------------------------------------- %
% Code to create bayesian network for Dynamic Inference   %
% ------------------------------------------------------- %

clc; clear all;close all;


% Define the structure %
N = 3; % the total number of nodes
intra = zeros(N);
intra(1,2) = 1;
intra(1,3) = 1;

% specify the type of node :: discrete, binary %
node_sizes = [2 2 2];
onodes = 2:3; % observed nodes
dnodes = 1:3; % all the nodes per time slice

% inter 
inter = zeros(N);
inter(1,1) = 1;

% parameter tying reduces the amount %
% of data needed for learning %
eclass1 = 1:3; % all the nodes per time slice
eclass2 = [4 2:3];
eclass = [eclass1 eclass2];

% instantitate the DBN %
dynBnet = mk_dbn(intra,inter,node_sizes,'discrete',dnodes,...
                'eclass1',eclass1,'eclass2',eclass2,'observed',onodes);

% prior p(agreeing)
dynBnet.CPD{1} = tabular_CPD(dynBnet,1,[0.5 0.5]);

% P(2|1) head node given agreeing %
dynBnet.CPD{2} = tabular_CPD(dynBnet,2,[0.8 0.2 0.2 0.8]);

% P(3|1) smile given agreeing %
dynBnet.CPD{3} = tabular_CPD(dynBnet,3,[0.5 0.9 0.5 0.1]);


% P(4|1) smile given agreeing %
dynBnet.CPD{4} = tabular_CPD(dynBnet,4,[0.9 0.2 0.1 0.8]);


%[dynBnet2, LL, engine2] = learn_params_dbn_em(engine, cases, 'max_iter', 20);


%instantiate an inference engine
engine2 = smoother_engine(jtree_2TBN_inf_engine(dynBnet));

engine2 = enter_evidence(engine2, evidence);

m= marginal_nodes(engine2, 1, 2); % referring to 1st node (hidden class node) in 2nd time slice (t+1)

inferredClass= argmax(m.T);











