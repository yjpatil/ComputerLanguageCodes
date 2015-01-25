function model_hmm=train_hmm(bin_event_train,num_sen)

num_target=length(bin_event_train);
%num_sen=length(bin_event_train{1});
model_hmm=cell(num_target,num_sen);

% ----------- set para for hmmtrain -------------------
n_state=4;
n_obser=4;
TR_pr = [80 40 40 20; 
        40 80 20 40;
        40 20 80 40;
        20 40 40 80;];
TR_pr = TR_pr./(sum(TR_pr,2)*ones(1,n_state));
EM_pr = [80 40 40 20; 
        40 80 20 40;
        40 20 80 40;
        20 40 40 80;];
EM_pr = EM_pr./(sum(EM_pr,2)*ones(1,n_obser));

TR_Guess = [80 40 40 20; 
            40 80 20 40;
            40 20 80 40;
            20 40 40 80;];
TR_Guess = TR_Guess./(sum(TR_Guess,2)*ones(1,n_state));
EM_Guess = [80 40 40 20; 
            40 80 20 40;
            40 20 80 40;
            20 40 40 80;];
EM_Guess = EM_Guess./(sum(EM_Guess,2)*ones(1,n_obser));
% --------------------------------------------------------

for i_tar=1:num_target
    for i_sen=1:num_sen
        seq=bin_event_train{i_tar}{i_sen};
        seq=[2,1]*seq+1;
        [model_hmm{i_tar,i_sen}.tr,model_hmm{i_tar,i_sen}.em,logliks] = ...
            hmmtrain_MAP_real(seq,TR_Guess,EM_Guess,TR_pr,EM_pr);
    end   
end












