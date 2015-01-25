function[LogLkhd] = TestHMM(Data,HMM)
% This function intakes the Data{i}, and outputs the LogLikelihood of the HMM 
% Date: 28 May2013

LogLkhd = dhmm_logprob(Data,HMM.prior, HMM.transmat, HMM.obsmat);        

%disp(sprintf('[class SMK: %d -th data]model SMK:%.3f',i,loglikSMK));
end