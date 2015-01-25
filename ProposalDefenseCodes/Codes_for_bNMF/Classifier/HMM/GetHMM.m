function[LogLkhd, HMM] = GetHMM(Data,States,Obs,MaxIt)
% The function intakes the Coded Data and the number of Hidden States and
% the Observation Matrix
% The output of this function is the LogLkhd and the Hidden Markov Model

% Now divide the 'ASdatasmk' matrix into Training and Testing
% Len_AS = length(ASdatasmk);
% HLen_AS = round(length(ASdatasmk)/2);    
% 
% ASdatasmkTrain = ASdatasmk(1:HLen_AS);    
% ASdatasmkTest = ASdatasmk(HLen_AS+1:length(ASdatasmk));       
% HMM initialization for class non-smoking % 
%     hmmNsmk.prior = [1 0 0];
%     hmmNsmk.transmat = rand(3,3);
%     hmmNsmk.transmat(2,1) = 0;hmmNsmk.transmat(3,1) = 0;hmmNsmk.transmat(3,2) = 0;
%     hmmNsmk.transmat = mk_stochastic(hmmNsmk.transmat);  
%     hmmNsmk.obsmat = rand(3, 16);  % 16 is the output symbols 
%     hmmNsmk.obsmat = mk_stochastic(hmmNsmk.obsmat);         

% HMM initialization for smoking class %
% States = 5;Obs = 19;

Prior = zeros(1,States);Prior(1,1) = 1;
HMM1.prior = Prior;

TransMat1 = rand(States,States);
[TransMat] = InitializeTransMat(TransMat1);


HMM1.transmat = TransMat;
%     hmmsmk.transmat(1,4) = 0;hmmsmk.transmat(1,5) = 0;
%     hmmsmk.transmat(2,1) = 0;hmmsmk.transmat(2,4) = 0;hmmsmk.transmat(2,5) = 0;
%     hmmsmk.transmat(3,1) = 0;hmmsmk.transmat(3,2) = 0;
%     hmmsmk.transmat(4,2) = 0;hmmsmk.transmat(4,3) = 0;
%     hmmsmk.transmat(5,1) = 0;hmmsmk.transmat(5,2) = 0;hmmsmk.transmat(5,3) = 0;hmmsmk.transmat(5,4) = 0;
HMM1.transmat = mk_stochastic(HMM1.transmat);
%HMM1.transmat

HMM1.obsmat = rand(States, Obs);
HMM1.obsmat = mk_stochastic(HMM1.obsmat);       

% fprintf('\n ======================================================== \n');
% fprintf('\n ============ HMM Trained for smoking Data ============== \n');    

[LogLkhd, HMM.prior, HMM.transmat, HMM.obsmat] = dhmm_em(Data, ...
    HMM1.prior, HMM1.transmat, HMM1.obsmat,'max_iter', MaxIt);    
% Evaluation of the Model trained for Smoking Data %
% fprintf('\n ======================================================== \n');
% fprintf('\n ======= Test Results for Applying HMM on smoking Data ===== \n');



%Array = randperm(length(ASdatansmk));    
% fprintf('\n ======================================================== \n');
% fprintf('\n ======= Test Results for Applying HMM on non-smoking Data ===== \n');
% 
% for i = 1 : 1 : length(ASdatansmk)
%     %j = Array(i);
%     loglikNSMK = dhmm_logprob(ASdatansmk{i},hmmsmk.prior, hmmsmk.transmat, hmmsmk.obsmat);
%     disp(sprintf('[class Non-SMK: %d -th data]model SMK:%.3f',i,loglikNSMK));
% end
% fprintf('\n ============================================================== \n');












end