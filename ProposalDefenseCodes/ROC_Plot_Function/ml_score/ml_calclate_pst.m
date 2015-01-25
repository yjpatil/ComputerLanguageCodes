function ml = ml_calclate_pst(sel_model,sel_data,len_test)
% 
% 
num_sen = length(sel_model);  % length = 4


ml = zeros(1,num_sen);

for i_sen=1:num_sen
    seq = sel_data{i_sen};
    % Randomly pick a starting index in the data set of 2101 (from 1 to 2101 - 800)
    p_start = randi(size(seq,2)-len_test);
    seq_seg = seq(:,p_start:p_start+len_test); % Select all rows and random starting point to start_point+800
    
    % Now calculate the stats as before % 
    seq_seg = 2-seq_seg;    
    seq_2ndst(1,:) = obser_2ndfunc(seq_seg(1,:));
    seq_2ndst(2,:) = obser_2ndfunc(seq_seg(2,:));
    seq_2ndst = sum(seq_2ndst)/2;
    seq_pair = reshape(seq_seg,1,2*size(seq_seg,2));
    seq_2ndp = obser_2nd_pair(seq_pair); 
    
    % % 
    feature_test = [seq_2ndst,seq_2ndp];  % Statistics
    feature_model = sel_model{i_sen}; % Select the 'i_sen'th column from train Stats
    
    ml(i_sen) = -sum((feature_test-feature_model).^2);
end
ml = sum(ml);




end













