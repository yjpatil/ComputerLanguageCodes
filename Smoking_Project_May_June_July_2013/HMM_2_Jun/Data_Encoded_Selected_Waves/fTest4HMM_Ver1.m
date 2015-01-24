function[Log1,Log2,Log3,Log4,EstLabel,SpecialLabel] = fTest4HMM_Ver1(Data,Labels,HMM1,HMM2,HMM3,HMM4)
% This function test the Trained HMMs against the Train/Test Data set
% Data = Data set containing the Encoded Waves
% Labels = Labels for the Encoded Waves
% HMMi (i = 1, 2, ... 4) = Different HMMs for Different Acts

% OUTPUT ::
% EstLabel = Estimated Labels for the given Samples of Encoded Wave Based
% on its LogLkhd value
% EstLabel = [True_label Estimated_Label]

% Logi (i = 1, 2, ... 4) = Loglkhd values for a given act by applying 4
% HMM's

SpecialLabel = [0 0]

Names1 = fieldnames(Data); 

Itr1 = 1;
Itr2 = 1;


for i = 1 : 1 : length(Names1)    % Now start copying data from the same field in struct 1 to struct 2 
    
    DataArray = getfield(Data,Names1{i});  % Get the data of the ith field, which is the wave numbers  
    LabelArray = getfield(Labels,Names1{i});
    L = length(DataArray);
    
    if(isempty(DataArray))        
    else
        for j = 1 : 1 : L
            Log1(i).loglik(j) = dhmm_logprob(DataArray{j}, HMM1.prior, HMM1.transmat, HMM1.obsmat);    
            Log2(i).loglik(j) = dhmm_logprob(DataArray{j}, HMM2.prior, HMM2.transmat, HMM2.obsmat);    
            Log3(i).loglik(j) = dhmm_logprob(DataArray{j}, HMM3.prior, HMM3.transmat, HMM3.obsmat);    
            Log4(i).loglik(j) = dhmm_logprob(DataArray{j}, HMM4.prior, HMM4.transmat, HMM4.obsmat);
            
            Index = find( max([ Log1(i).loglik(j) Log2(i).loglik(j) Log3(i).loglik(j) Log4(i).loglik(j) ]) == [ Log1(i).loglik(j) Log2(i).loglik(j) Log3(i).loglik(j) Log4(i).loglik(j) ]);
            
            if(Index == 1)
                EstLabel(Itr1,1) = LabelArray(j);    % True Labels
                EstLabel(Itr1,2) = 1;    % Estimated Labels
                Itr1 = Itr1 + 1;
            elseif(Index == 2)
                EstLabel(Itr1,1) = LabelArray(j);    % True Labels
                EstLabel(Itr1,2) = 2;    % Estimated Labels
                Itr1 = Itr1 + 1;
            elseif(Index == 3)
                EstLabel(Itr1,1) = LabelArray(j);    % True Labels
                EstLabel(Itr1,2) = 3;    % Estimated Labels
                Itr1 = Itr1 + 1;
            elseif(Index == 4)
                EstLabel(Itr1,1) = LabelArray(j);    % True Labels
                EstLabel(Itr1,2) = 4;    % Estimated Labels
                Itr1 = Itr1 + 1;
            elseif(length(Index) > 1)    % Sometimes the array of [Log1 Log2 Log3 Log4] are all "-Inf", hence the Index = [1 2 3 4]
                SpecialLabel(Itr2,1) = LabelArray(j);
                SpecialLabel(Itr2,2) = 5;
                Itr2 = Itr2 + 1;
                EstLabel(Itr1,1) = LabelArray(j);    % True Labels
                EstLabel(Itr1,2) = 5;    % Estimated Labels
                Itr1 = Itr1 + 1;
            end                                        
        end
    end
    
end





end

%  Check which array in "EstLabel" has zero value, 
%  Log11 = dhmm_logprob(TstData.Read{23}, BestHmm1.prior, BestHmm1.transmat, BestHmm1.obsmat)
%  Log21 = dhmm_logprob(TstData.Read{23}, BestHmm2.prior, BestHmm2.transmat, BestHmm2.obsmat)
%  Log31 = dhmm_logprob(TstData.Read{23}, BestHmm3.prior, BestHmm3.transmat, BestHmm3.obsmat)
%  Log41 = dhmm_logprob(TstData.Read{23}, BestHmm4.prior, BestHmm4.transmat, BestHmm4.obsmat)
%  Index111 = find(max([Log11 Log21 Log31 Log41]) == [Log11 Log21 Log31 Log41])






