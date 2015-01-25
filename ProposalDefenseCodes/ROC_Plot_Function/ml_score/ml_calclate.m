function ml=ml_calclate(sel_model,sel_data,len_test)

num_sen=length(sel_model);
% ---------------------------------------------------------
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
% ---------------------------------------------------------

ml=zeros(1,num_sen);
test_hmm = cell(1,num_sen);
for i_sen=1:1%num_sen
    seq=sel_data{i_sen};
    p_start=randi(size(seq,2)-len_test);
    seq_seg=seq(:,p_start:p_start+len_test);
    seq_seg=[2,1]*seq_seg+1;
    
    [test_hmm{i_sen}.tr,test_hmm{i_sen}.em,logliks] = ...
            hmmtrain_MAP_real(seq_seg,TR_Guess,EM_Guess,TR_pr,EM_pr);
        
    test_hmm{i_sen}.tr = ...
        reshape(test_hmm{i_sen}.tr,1,numel(test_hmm{i_sen}.tr));
    test_hmm{i_sen}.em = ...
        reshape(test_hmm{i_sen}.em,1,numel(test_hmm{i_sen}.em)); 
    
    sel_model{i_sen}.tr = ...
        reshape(sel_model{i_sen}.tr,1,numel(sel_model{i_sen}.tr));
    sel_model{i_sen}.em = ...
        reshape(sel_model{i_sen}.em,1,numel(sel_model{i_sen}.em)); 
    
    feature_test =[test_hmm{i_sen}.tr];
    feature_model=[sel_model{i_sen}.tr];
    
    ml(i_sen)=-sum((feature_test-feature_model).^2);
end
ml = sum(ml);




















