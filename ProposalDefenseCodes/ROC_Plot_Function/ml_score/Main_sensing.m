try fclose(s2); catch end
clear all; close all; clc;
addpath('geo_functions');

Itarget=499;
for Igait=2000+[77 140 256 378 499]
clear sensing_sys; clear target_geo; close all;
% Itarget: [77 140 256 378 499]
% Igait:   2000+[77 140 256 378 499]
num_sens_player=6;
num_target=1;
num_step=2100;
d=0.82; d_shift=0;
% tar_mode=1: fixed path; tar_mode=2: random path
tar_mode=1;
% sens_mode=1: symmetric array; sens_mode=2: unsymmetric array
sens_mode=1;
h_sens=[0]; % 0<=h_sens(i)<=1

sensing_sys=geometry_thermal_sensing(num_sens_player,d,d_shift,sens_mode);
% sensing_sys.angle_sensor/pi*180;
%sensing_sys=geometry_laser_sensing(num_sensor,h_sensor);
%sensing_sys=geometry_fiber_sensing(num_sensor);

% --------- Target geometry ------------------------------
target_geo(1:num_target)=struct('l',0,'alpha',0,'theta0',0);
l=[0.3,0.8];
%alpha=50/180*pi;
alpha=0/180*pi;

theta0=[15 60]/180*pi;
tr=[80 40 40 20; 
    40 80 20 40;
    40 20 80 40;
    20 40 40 80;];
dtr=20;
em=[80 40 40 20; 
    40 80 20 40;
    40 20 80 40;
    20 40 40 80;];
dem=20;

rng('default');     rand(Itarget); % make sure the rand will be the same at 240
% for different targets to specific random seeds: [77 140 256 378 499]
for i_tar=1:num_target
    target_geo(i_tar).l=l(1)+(l(2)-l(1))*rand(1,2);
    target_geo(i_tar).alpha=alpha*rand;
    
    rng('default');     rand(Igait);
    target_geo(i_tar).theta0=cell(1,2);
    theta_t=theta0(1)+(theta0(2)-theta0(1))*rand(1,2);
    target_geo(i_tar).theta0{1}=[-theta_t(1),theta_t(1)];
    target_geo(i_tar).theta0{2}=[-theta_t(2),theta_t(2)];
    
    target_geo(i_tar).tr=tr+dtr*(-1+2*rand(size(tr)));
    target_geo(i_tar).em=tr+dem*(-1+2*rand(size(em)));
    target_geo(i_tar).tr=target_geo(i_tar).tr./(sum(target_geo(i_tar).tr,2)*ones(1,4));
    target_geo(i_tar).em=target_geo(i_tar).em./(sum(target_geo(i_tar).em,2)*ones(1,4));
%     target_geo(i_tar).tr
end
rng('shuffle');  % make sure the rand will be different each time

target_geo=target_geomtry(h_sens,num_step,sensing_sys,target_geo,tar_mode);

% --------- Generate events ------------------------------
% event_sens=cell(num_layer,num_sensor);
event_sens=events_generate(sensing_sys,target_geo);
%save events_sim_2target13_ event_sens

% --------- Animation ------------------------------
if sensing_sys.s==1
    animation_thermal(sensing_sys,target_geo);
elseif sensing_sys.s==2
    animation_laser;
else
    animation_fiber;
end

filenm=['tar', num2str(Itarget),'_gt', num2str(Igait),'_event_', ...
    num2str(num_sens_player), 'sens_target_','L',num2str(num_step),'_test'];
save (filenm, 'event_sens');
% for i=1:size(event_sens,1)
%     for j=1:size(event_sens,2)
%         seq=event_sens{i,j};
%         p11=sum(seq(1,:))/length(seq(1,:))
%         p21=sum(seq(2,:))/length(seq(2,:))
%     end
% end


end


figure




