try fclose(s2); catch end
clear all; close all; clc;
addpath('rec_functions'); 

% % ------------------------------------
% ML=zeros(100,2,2);
% for i=1:100
%     ML(i,:,:)=[2,1;1,2];
% end
% figure(1)
% Plot_MLo_HistFit('MAP', ML, 1);
% figure(2)
% Plot_MLo_ROC(ML, 'k - d')
% % ------------------------------------

num_target=5;
load model_hmm;
bin_event_train=cell(1,num_target);
load event_6sens_target_77_L2100_train;    bin_event_train{1}=event_sens;
load event_6sens_target_140_L2100_train;   bin_event_train{2}=event_sens;
load event_6sens_target_256_L2100_train;   bin_event_train{3}=event_sens;
load event_6sens_target_378_L2100_train;   bin_event_train{4}=event_sens;
load event_6sens_target_499_L2100_train;   bin_event_train{5}=event_sens;
clear event_sens;

bin_event_test=bin_event_train;
num_sen=length(bin_event_test{1});

sel=[2,5];
sel_model = model_hmm(sel,:);
sel_data = bin_event_test(sel);

sel_model = sel_model(1,:);
sel_data = sel_data{2};

len_test=1600;
i_sen=1;
seq=sel_data{i_sen};
p_start=randi(size(seq,2)-len_test);
seq_seg=seq(:,p_start:p_start+len_test);
seq_seg=2-seq_seg;
seq_2ndst(1,:)=obser_2ndfunc(seq_seg(1,:));
seq_2ndst(2,:)=obser_2ndfunc(seq_seg(2,:));
seq_2ndst=sum(seq_2ndst)/2;
seq_pair=reshape(seq_seg,1,2*size(seq_seg,2));
seq_2ndp=obser_2nd_pair(seq_pair); 

[obser_s2nd,obser_s2pair]=hmm2stat(sel_model{i_sen}.tr,sel_model{i_sen}.em);
    
feature_test =[seq_2ndst,seq_2ndp];
feature_model=[obser_s2nd,obser_s2pair];

ml=-sum((feature_test-feature_model).^2)*2000







