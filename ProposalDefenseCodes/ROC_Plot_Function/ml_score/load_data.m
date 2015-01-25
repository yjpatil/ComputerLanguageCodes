function bin_event=load_data(data)

num_gait=5;
num_target=5;
bin_event=cell(num_gait,num_target);

if data==1
    % --- target 1 ----------
    load tar77_gt2077_event_6sens_target_L2100_train; 
    bin_event{1,1}=event_sens;
    load tar77_gt2140_event_6sens_target_L2100_train; 
    bin_event{1,2}=event_sens;
    load tar77_gt2256_event_6sens_target_L2100_train; 
    bin_event{1,3}=event_sens;
    load tar77_gt2378_event_6sens_target_L2100_train; 
    bin_event{1,4}=event_sens;
    load tar77_gt2499_event_6sens_target_L2100_train; 
    bin_event{1,5}=event_sens;
    % --- target 2 ----------
    load tar140_gt2077_event_6sens_target_L2100_train; 
    bin_event{2,1}=event_sens;
    load tar140_gt2140_event_6sens_target_L2100_train; 
    bin_event{2,2}=event_sens;
    load tar140_gt2256_event_6sens_target_L2100_train; 
    bin_event{2,3}=event_sens;
    load tar140_gt2378_event_6sens_target_L2100_train; 
    bin_event{2,4}=event_sens;
    load tar140_gt2499_event_6sens_target_L2100_train; 
    bin_event{2,5}=event_sens;
    % --- target 3 ----------
    load tar256_gt2077_event_6sens_target_L2100_train; 
    bin_event{3,1}=event_sens;
    load tar256_gt2140_event_6sens_target_L2100_train; 
    bin_event{3,2}=event_sens;
    load tar256_gt2256_event_6sens_target_L2100_train; 
    bin_event{3,3}=event_sens;
    load tar256_gt2378_event_6sens_target_L2100_train; 
    bin_event{3,4}=event_sens;
    load tar256_gt2499_event_6sens_target_L2100_train; 
    bin_event{3,5}=event_sens;
    % --- target 4 ----------
    load tar378_gt2077_event_6sens_target_L2100_train; 
    bin_event{4,1}=event_sens;
    load tar378_gt2140_event_6sens_target_L2100_train; 
    bin_event{4,2}=event_sens;
    load tar378_gt2256_event_6sens_target_L2100_train; 
    bin_event{4,3}=event_sens;
    load tar378_gt2378_event_6sens_target_L2100_train; 
    bin_event{4,4}=event_sens;
    load tar378_gt2499_event_6sens_target_L2100_train; 
    bin_event{4,5}=event_sens;
    % --- target 5 ----------
    load tar499_gt2077_event_6sens_target_L2100_train; 
    bin_event{5,1}=event_sens;
    load tar499_gt2140_event_6sens_target_L2100_train; 
    bin_event{5,2}=event_sens;
    load tar499_gt2256_event_6sens_target_L2100_train; 
    bin_event{5,3}=event_sens;
    load tar499_gt2378_event_6sens_target_L2100_train; 
    bin_event{5,4}=event_sens;
    load tar499_gt2499_event_6sens_target_L2100_train; 
    bin_event{5,5}=event_sens;
    
elseif data==2
    % --- target 1 ----------
    load tar77_gt2077_event_6sens_target_L2100_test; 
    bin_event{1,1}=event_sens;
    load tar77_gt2140_event_6sens_target_L2100_test; 
    bin_event{1,2}=event_sens;
    load tar77_gt2256_event_6sens_target_L2100_test; 
    bin_event{1,3}=event_sens;
    load tar77_gt2378_event_6sens_target_L2100_test; 
    bin_event{1,4}=event_sens;
    load tar77_gt2499_event_6sens_target_L2100_test; 
    bin_event{1,5}=event_sens;
    % --- target 2 ----------
    load tar140_gt2077_event_6sens_target_L2100_test; 
    bin_event{2,1}=event_sens;
    load tar140_gt2140_event_6sens_target_L2100_test; 
    bin_event{2,2}=event_sens;
    load tar140_gt2256_event_6sens_target_L2100_test; 
    bin_event{2,3}=event_sens;
    load tar140_gt2378_event_6sens_target_L2100_test; 
    bin_event{2,4}=event_sens;
    load tar140_gt2499_event_6sens_target_L2100_test; 
    bin_event{2,5}=event_sens;
    % --- target 3 ----------
    load tar256_gt2077_event_6sens_target_L2100_test; 
    bin_event{3,1}=event_sens;
    load tar256_gt2140_event_6sens_target_L2100_test; 
    bin_event{3,2}=event_sens;
    load tar256_gt2256_event_6sens_target_L2100_test; 
    bin_event{3,3}=event_sens;
    load tar256_gt2378_event_6sens_target_L2100_test; 
    bin_event{3,4}=event_sens;
    load tar256_gt2499_event_6sens_target_L2100_test; 
    bin_event{3,5}=event_sens;
    % --- target 4 ----------
    load tar378_gt2077_event_6sens_target_L2100_test; 
    bin_event{4,1}=event_sens;
    load tar378_gt2140_event_6sens_target_L2100_test; 
    bin_event{4,2}=event_sens;
    load tar378_gt2256_event_6sens_target_L2100_test; 
    bin_event{4,3}=event_sens;
    load tar378_gt2378_event_6sens_target_L2100_test; 
    bin_event{4,4}=event_sens;
    load tar378_gt2499_event_6sens_target_L2100_test; 
    bin_event{4,5}=event_sens;
    % --- target 5 ----------
    load tar499_gt2077_event_6sens_target_L2100_test; 
    bin_event{5,1}=event_sens;
    load tar499_gt2140_event_6sens_target_L2100_test; 
    bin_event{5,2}=event_sens;
    load tar499_gt2256_event_6sens_target_L2100_test; 
    bin_event{5,3}=event_sens;
    load tar499_gt2378_event_6sens_target_L2100_test; 
    bin_event{5,4}=event_sens;
    load tar499_gt2499_event_6sens_target_L2100_test; 
    bin_event{5,5}=event_sens;
end





















    