function[Outputdata] = fHMMdata(prior0,transmat0,obsmat0,T,nex)
% This function outputs the HMM binary data to the user
% Date : 
% Q = 2 states, (State1: Not Crossing the sensor = 1(0);State2: Crossing the sensor = 2(1) )
% O = 2 output symbols, (Output1 = '1' if detected presence; Output2 = '0')
% nex = 20 sequences, (# of sensors present) 
% T = 10 bits, (length of each bit)
% transmat0 = The transition matrix will describe how much transmision is
% between states Crossing (large/less '1s') and no Crossing (or less/large '0s' )
% e.g. transmat0 = [(1,1) (1,2);(2,1) (2,2)] 
% transmat0 = [0.3 0.7;0.3 0.7] % for subjects that has large 1's
% transmat0 = [0.7 0.3;0.7 0.3] % for subjects that has large 0's
% prior0 = describes the state that will be the starting point
% e.g. prior0 = [1,0] = [State1,State2] % Initially on state 1
% prior0 = [0,1] % Initially on state 2
% obsmat0 = [State1Level1(0's);State1Level2(1's);State2Level1(0's);State2Level2(1's)]
% i.e. what is the prob that(for Row1,Col1)state1 will output 0, (for Row2,Col2)state2 will output 1
% obsmat0 = [0.3,0.7;0.3,0.7] % for large # of 1's
% obsmat0 = [0.7,0.3;0.7,0.3] % for large # of 0's


% O = 2; Q = 2;prior0 = [0,1];prior0 = [1,0]
% transmat0 = [0.1 0.9;0.1 0.9];transmat0 = [0.9 0.1;0.9 0.1]
% obsmat0 = [0.1,0.9;0.1,0.9];obsmat0 = [0.9,0.1;0.9,0.1]

% prior0 = normalise(rand(Q,1));          % prior state probs, i.e. on which state is the HMM initially present
% transmat0 = mk_stochastic(rand(Q,Q));   % Initial Transition matrix Prob distribution
% obsmat0 = mk_stochastic(rand(Q,O));     % Observation Matrix
% 
% T = 20; % bits length
% nex = 1; % Observations

Outputdata = dhmm_sample(prior0, transmat0, obsmat0, nex, T);  

Ind0 = find(Outputdata == 1);if(isempty(Ind0));else;Outputdata(Ind0)= 0;end;
Ind1 = find(Outputdata == 2);if(isempty(Ind1));else;Outputdata(Ind1)= 1;end;

end