try fclose(s2); catch end
clear all; %close all; clc;
addpath('rec_functions'); 
addpath('data_fix_path_tar_gait_train');
addpath('data_fix_path_tar_gait_test');

num_target=5;

type='-k+'
sel_tar=5;
sel_gait=5;
 % diff row for diff tar, diff col for diff gait
bin_event_train=load_data(2);
bin_event_train=bin_event_train(:,sel_gait);
% bin_event_train=bin_event_train(sel_tar,:);

model_st=train_st(bin_event_train);

feature=zeros(3,5);

for i_g=1:5
    for i_sen=1:4
    p2ndst=model_st{i_g,i_sen}(1:4);
    p2nd_pair=model_st{i_g,i_sen}(5:end);
    
    eta=p2ndst(1)+p2ndst(2);
    theta=log(p2ndst(1)*p2ndst(4)/p2ndst(2)/p2ndst(3));
    theta12=log(p2nd_pair(4)*p2nd_pair(4)/p2nd_pair(2)/p2nd_pair(3));
    end
    feature(1,i_g)=feature(1,i_g)+eta;
    feature(2,i_g)=feature(2,i_g)+theta;
    feature(3,i_g)=feature(3,i_g)+theta12;
end

figure(1)
%plot3(feature(1,:),feature(2,:),feature(3,:),mline,'MarkerFaceColor','r','MarkerSize',8)
plot3(feature(1,:),feature(2,:),feature(3,:),type)
hold on
plot3([feature(1,1),feature(1,end)],[feature(2,1),feature(2,end)],...
    [feature(3,1),feature(3,end)],type)

xlabel('\eta','fontsize',15); ylabel('\theta','fontsize',15);
zlabel('\theta12','fontsize',15);
grid on; hold on






    
    
    
    
    

