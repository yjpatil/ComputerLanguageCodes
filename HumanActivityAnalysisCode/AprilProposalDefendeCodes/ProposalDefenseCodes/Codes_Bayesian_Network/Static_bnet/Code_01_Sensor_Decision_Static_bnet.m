% ------------------------------------------------------ %
% Code to create bayesian network for Sensor Decision    %
% ------------------------------------------------------ %

clc; clear all;close all;
FontSize = 11.0;
% % ---------------------------- % %
% create a directed acylic graph % 
N = 10; % total nodes
ObserNodes = 6;% Out of 'N' nodes only 6 can be observed !!!
dag = zeros(N); % Initialize the dag matrix, that defines the 
SNR =1; FRQ = 2; SAT = 3; NOISE = 4; TL = 5; TD = 6; 
FBW = 7; AG = 8; ADCRes = 9; SWT = 10;

dag(SNR, [NOISE]) = 1;% Define the connections %
dag(FRQ, [TL TD]) = 1;% Define the connections %
dag(SAT, [TL TD]) = 1;% Define the connections %
dag(NOISE, [FBW AG]) = 1;% Define the connections %
dag(TL, [ADCRes SWT]) = 1;% Define the connections %
dag(TD, [AG ADCRes SWT]) = 1;% Define the connections %

% % ---------------------------- % %
% Create a Bayesian Net %
discrete_nodes = 1:N; % Total nodes
node_sizes = 2*ones(1,N);   % state size -> Total values (True/False)
%%node_sizes(4:6) = 3; % First node (S) contains ??
bnet = mk_bnet(dag, node_sizes, 'discrete', discrete_nodes);  % Create the Network

% % ---------------------------- % %
% input parameters' values
bnet.CPD{SNR} = tabular_CPD(bnet, SNR, [0.3 0.7]);
bnet.CPD{FRQ} = tabular_CPD(bnet, FRQ, [0.5 0.5]);
bnet.CPD{SAT} = tabular_CPD(bnet, SAT, [0.5 0.5]);
bnet.CPD{NOISE} = tabular_CPD(bnet, NOISE, [0.99 0.05 0.01 0.95]);
bnet.CPD{TL} = tabular_CPD(bnet, TL, [0.9 0.2 0.2 0.05 0.1 0.8 0.8 0.95]);
bnet.CPD{TD} = tabular_CPD(bnet, TD, [0.01 0.8 0.8 0.99 0.99 0.2 0.2 0.01]);
bnet.CPD{FBW} = tabular_CPD(bnet, FBW, [0.1 0.9 0.9 0.1]);
bnet.CPD{AG} = tabular_CPD(bnet, AG, [0.9 0.85 0.1 0.3 0.1 0.15 0.9 0.7]);
bnet.CPD{ADCRes} = tabular_CPD(bnet, ADCRes, [0.6 0.2 0.7 0.1 0.4 0.8 0.3 0.9]);
bnet.CPD{SWT} = tabular_CPD(bnet, SWT, [0.2 0.99 0.01 0.15 0.8 0.01 0.99 0.85]);

% % ----- Make Inference ----- % %
% % engine = jtree_inf_engine(bnet);
% % 
% % % % ---------------------------- % %
% % % computing marginal probability
% % 

% % evidence = cell(1,N);
% % evidence{SNR} = 2;
% % evidence{FRQ} = 2;
% % evidence{SAT} = 2;

% % %evidence{NOISE} = 1;
% % %evidence{TL} = 2;
% % 
% % [engine, loglik] = enter_evidence(engine, evidence);
% % marg = marginal_nodes(engine, FBW);
% % marg.T
% % marg = marginal_nodes(engine, AG);
% % marg.T
% % marg = marginal_nodes(engine, SWT);
% % marg.T




% % ----- Make Inference ----- % %
engine = jtree_inf_engine(bnet);

% % ---------------------------- % %
% % computing marginal probability % %
max = 15;
evidence1 = cell(max,N); % evidence is a ROW Matrix
evidence = cell(1,N);
for i = 1 : 1 : max
    for j = 1 : 1 : ObserNodes
        temp1 = randperm(2);
        temp1 = temp1(1);
        evidence1{i,j} = temp1;
        evidence{1,j} = temp1;
    end
    % % evidence = evidence1{i,:};
    [engine, loglik] = enter_evidence(engine,evidence);
    marg1 = marginal_nodes(engine, FBW);if(marg1.T(1)>marg1.T(2));Result(i,1) = 1;else;Result(i,1) = 2;end;
    marg2 = marginal_nodes(engine, AG);if(marg2.T(1)>marg2.T(2));Result(i,2) = 1;else;Result(i,2) = 2;end;
    marg3 = marginal_nodes(engine, ADCRes);if(marg3.T(1)>marg3.T(2));Result(i,3) = 1;else;Result(i,3) = 2;end;
    marg4 = marginal_nodes(engine, SWT);if(marg4.T(1)>marg4.T(2));Result(i,4) = 1;else;Result(i,4) = 2;end;
end

InpData = cell2mat(evidence1);
adder = [0:2:24];
InpData = cat(2,InpData,Result);

figure(1);hold on;
for i = 1 : 1 : size(InpData,2)    
    temp2 = InpData(:,i);gcf;    
    temp2 = temp2 + adder(i);
    stairs(temp2,'-k');
end

title('Sensor Optimization');xlabel('samples -->');set(gca,'FontSize',FontSize);
set(gca,'YTickLabel',{'','SNR','FRQ','SAT','Noise','Tgt Loc','Tgt Dist','FltrB.W.','AmpG','ADCRes','SWTon/off'});
xlim([1 max+1]);
set(gca,'FontSize',FontSize);
ylim([0 adder(size(InpData,2) + 2)])




%
% evidence = cell(1,N);       
%         
% evidence{SNR} = 2;
% evidence{FRQ} = 2;
% evidence{SAT} = 1;
% % evidence{NOISE} = 2;
% % evidence{TL} = 1;
% % evidence{TD} = 2;
% 
% [engine, loglik] = enter_evidence(engine, evidence);
% 
% marg = marginal_nodes(engine, FBW);
% marg.T
% marg = marginal_nodes(engine, AG);
% marg.T
% marg = marginal_nodes(engine, ADCRes);
% marg.T
% marg = marginal_nodes(engine, SWT);
% marg.T

% % ---------------------------- % %    

% computing joint probability
% engine = jtree_inf_engine(bnet);
% evidence = cell(1,N);
% [engine, loglik] = enter_evidence(engine, evidence);
% joint = marginal_nodes(engine, [S W R]);






