function model_st = train_st(bin_event_train,num_sen)
%
% Output:: model_st = 
%

num_target = length(bin_event_train); % Actually , # of Gaits
% num_sen=length(bin_event_train{1});
model_st = cell(num_target,num_sen);

for i_tar = 1:num_target% num_gaits
    for i_sen = 1:num_sen
        seq = bin_event_train{i_tar}{i_sen}; % Eventhough there are 6 sensors(initially), only 4 of them are chosen!!
        seq = 2-seq;
        
        seq_2ndst(1,:) = obser_2ndfunc(seq(1,:));  % The function obser_2ndfunc() Gives you the second order statistics
        seq_2ndst(2,:) = obser_2ndfunc(seq(2,:));  % The function obser_2ndfunc() Gives you the second order statistics
        
        seq_2ndst = sum(seq_2ndst)/2;
        
        seq_pair = reshape(seq,1,2*size(seq,2));
        seq_2ndp = obser_2nd_pair(seq_pair); 
        
        model_st{i_tar,i_sen} = [seq_2ndst,seq_2ndp];
        
    end   
end












