function [context_prior,tracking_prediction] = BNMF_main(V,VV,base_num,real_num,prior,reg)
addpath('Prior_tool','Regression_tool','Algorithms(Decomposition)','Recognition(Learning)','Desired_information');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name:     BNMF_conditioning
% Function: BNMF conditioning for contextual information extraction
% Inputs:   V         training data
%           VV        testing data
%           base_num  the number of bases
%           real_num  real category of scenario
%           prior     the parameter of whether choosing prior or not
%           reg       the parameter of whether choosing regression or not
% Outputs:   Context_prior     the prior gained from the contextual information
%           Track_prediction  the predict parameter of trajectory
% Note:     the training data and testing data in this algorithm must be a dataset in 
%           a 2-dimentional matrix, and the instances are vectorized in columns.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 W = rand(size(V,1),base_num);
 H = rand(base_num,size(V,2));
 Project = rand(size(H,1),size(VV,2));

 if prior
    fprintf('！！\n');
    gType = input('Please choose whether apply geometrical prior. 0-No, 1-Yes, [1]');
    if isempty(gType), gType = 1; end
    fprintf('！！\n');
    sType = input('Please choose whether apply statistic prior. 0-No, 1-Yes, [1]');
    if isempty(sType), sType = 1; end
 else
      gType = 0; sType = 0; t = inf; p = 10;
   
 end

 Geometric_prior_model;
 Statistic_prior_model;
 BNMF;
 Scenario_recognition;
 reconstruct_data = W*Proj;
 Illustration;
 
 if reg
    fprintf('！！\n');
    rType = input('Please choose the type of regression. 0-Linear, 1-Nonlinear, [0]');
    if isempty(rType), rType = 0;end
       if rType
          Nonlinear_principal_component_regression;
       else
          Linear_principal_component_regression(Project,scenario_num);
       end
 end

 context_prior = Context_to_prior(gType);
 tracking_prediction = Track_prediction(gType);


