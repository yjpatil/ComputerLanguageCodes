clc;clear all;close all;

%  Add this path into the paths so as to acess all HMM toolkit 
addpath(genpath('C:\Users\student\Documents\MATLAB\HMM\HMMEverything'));
% ---- Path for Data ----- %
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_17Feb2014\Scenario1_No_Sync\Large_Iterations')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_17Feb2014\Scenario1_No_Sync\Large_Iterations_Part2')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_17Feb2014\Scenario2_Sync_talking\Data01')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_17Feb2014\Scenario2_Sync_talking\Data02')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_17Feb2014\Scenario3_FetchingCoffee\Data01')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_17Feb2014\Scenario3_FetchingCoffee\Data02')
addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bNMF\Data_NMF_17Feb2014\Scenario3_FetchingCoffee\Data03')
%  Initialize all the data set in cell format  %
clc
% %--------- Activity (1) = DATA (1) --------- %
load('Data_Large_Iter');

Act1Loc{1} = round(Hist1/10)+1; 
Act1Loc{2} = round(Hist2/10)+1; 

Act1Dir{1} = round(Direction1/10)+1;
Act1Dir{2} = round(Direction2/10)+1;

Direction = [];Direction1 = [];Direction2 = [];Location1 = [];Location2 = [];Hist1 = [];Hist2 = [];
% %--------- Activity (1) = DATA (2) --------- %
load('Data_Large_Iter_Part2');

Act1Loc{3} = round(Hist1/10)+1; 
Act1Loc{4} = round(Hist2/10)+1; 

Act1Dir{3} = round(Direction1/10)+1;
Act1Dir{4} = round(Direction2/10)+1;

Direction = [];Direction1 = [];Direction2 = [];Location1 = [];Location2 = [];
% %--------- Activity (2) = DATA (1) --------- %
load('Data01_talk_walk')

Act2Loc{1} = round(Hist1/10)+1; 
Act2Loc{2} = round(Hist2/10)+1; 

Act2Dir{1} = round(Direction1/10)+1;
Act2Dir{2} = round(Direction2/10)+1;

Direction = [];Direction1 = [];Direction2 = [];Location1 = [];Location2 = [];
% %--------- Activity (2) = DATA (2) --------- %
load('Data02_talk_walk');

Act2Loc{3} = round(Hist1/10)+1; 
Act2Loc{4} = round(Hist2/10)+1; 

Act2Dir{3} = round(Direction1/10)+1;
Act2Dir{4} = round(Direction2/10)+1;

Direction = [];Direction1 = [];Direction2 = [];Location1 = [];Location2 = [];

% %--------- Activity (3) = DATA (1) --------- %
load('Data01_fetch_coffee')

Act3Loc{1} = round(Hist1/10)+1; 
Act3Loc{2} = round(Hist2/10)+1; 

Act3Dir{1} = round(Direction1/10)+1;
Act3Dir{2} = round(Direction2/10)+1;

Direction = [];Direction1 = [];Direction2 = [];Location1 = [];Location2 = [];
% %--------- Activity (3) = DATA (2) --------- %
load('Data02_fetch_coffee');

Act3Loc{3} = round(Hist1/10)+1; 
Act3Loc{4} = round(Hist2/10)+1; 

Act3Dir{3} = round(Direction1/10)+1;
Act3Dir{4} = round(Direction2/10)+1;

Direction = [];Direction1 = [];Direction2 = [];Location1 = [];Location2 = [];
% %--------- Activity (3) = DATA (3) --------- %
load('Data03_fetch_coffee');

Act3Loc{3} = round(Hist1/10)+1; 
Act3Loc{4} = round(Hist2/10)+1; 

Act3Dir{3} = round(Direction1/10)+1;
Act3Dir{4} = round(Direction2/10)+1;

Direction = [];Direction1 = [];Direction2 = [];Location1 = [];Location2 = [];

% % ------------------------------------------------------------------- % %
% Initialize Activity # 1 Model  %

%[LogLkhdAct1, HMMAct1] = GetHMM(Act1Dir',5,25,20);


hmm1.prior = zeros(1,6);hmm1.prior(1) = 1;
hmm1.transmat = rand(6,6);
%hmm1.transmat(1,3) = 0;
% hmm1.transmat(2,1) = 0;%hmm1.transmat(2,4) = 0;
% hmm1.transmat(3,1) = 0;hmm1.transmat(3,2) = 0;
% %hmm1.transmat(4,1) = 0;hmm1.transmat(4,2) = 0;
% hmm1.transmat(4,3) = 0;
hmm1.transmat = mk_stochastic(hmm1.transmat);   
hmm1.obsmat = rand(6, 25);  % 16 is the output symbols 
hmm1.obsmat = mk_stochastic(hmm1.obsmat);
% Initialize Activity # 2 Model  %
hmm2.prior = zeros(1,6);hmm2.prior(1) = 1;
hmm2.transmat = rand(6,6);
% hmm2.transmat(1,3) = 0;
% hmm2.transmat(2,1) = 0;hmm2.transmat(2,4) = 0;
% hmm2.transmat(3,1) = 0;hmm2.transmat(3,2) = 0;
% hmm2.transmat(4,1) = 0;hmm2.transmat(4,2) = 0;hmm2.transmat(4,3) = 0;
hmm2.transmat = mk_stochastic(hmm2.transmat);
hmm2.obsmat = rand(6, 25);  % 16 is the output symbols 
hmm2.obsmat = mk_stochastic(hmm2.obsmat);
% Initialize Activity # 3 Model  %
hmm3.prior = zeros(1,6);hmm3.prior(1) = 1;
hmm3.transmat = rand(6,6);
% hmm3.transmat(1,3) = 0;
% hmm3.transmat(2,1) = 0;hmm3.transmat(2,4) = 0;
% hmm3.transmat(3,1) = 0;hmm3.transmat(3,2) = 0;
% hmm3.transmat(4,1) = 0;hmm3.transmat(4,2) = 0;hmm3.transmat(4,3) = 0;
hmm3.transmat = mk_stochastic(hmm3.transmat);
hmm3.obsmat = rand(6, 25);  % 16 is the output symbols 
hmm3.obsmat = mk_stochastic(hmm3.obsmat);
% % ------------------ Training Phase -------------------- % %
% Train the Activity # 1 model %
data1 = Act1Loc;%Act1Loc
[LL1, hmm1.prior, hmm1.transmat, hmm1.obsmat] = dhmm_em(data1, ...
    hmm1.prior, hmm1.transmat, hmm1.obsmat,'max_iter', 50);

% Train the Activity # 2 model %
data2 = Act2Loc;%Act2Loc
[LL2, hmm2.prior, hmm2.transmat, hmm2.obsmat] = dhmm_em(data2, ...
    hmm2.prior, hmm2.transmat, hmm2.obsmat,'max_iter', 50);

% Train the Activity # 3 model %
data3 = Act3Loc;%Act3Loc
[LL3, hmm3.prior, hmm3.transmat, hmm3.obsmat] = dhmm_em(data3, ...
    hmm3.prior, hmm3.transmat, hmm3.obsmat,'max_iter', 50);








for dt =1:length(data1)
    loglike1 = dhmm_logprob(data1{dt}, hmm1.prior, hmm1.transmat, ...
        hmm1.obsmat);
    loglike2 = dhmm_logprob(data2{dt}, hmm1.prior, hmm1.transmat, ...
        hmm1.obsmat);
    disp(sprintf('\n\n [class 0: %d-th data] model 0: %.3f, model 1: %.3f\n',dt, ...
        loglike1, loglike2));
end


% 
for dt =1:length(data2)
    loglike1 = dhmm_logprob(data2{dt}, hmm1.prior, hmm1.transmat, ...
        hmm1.obsmat);
    loglike2 = dhmm_logprob(data2{dt}, hmm2.prior, hmm2.transmat, ...
        hmm1.obsmat);
    disp(sprintf('\n\n [class 0: %d-th data] model 0: %.3f, model 1: %.3f\n',dt, ...
        loglike1, loglike2));
end



































 
  