function [context_prior,tracking_prediction] = VBNMF_main(V,VV,base_num,real_num,prior,regression)
addpath('Prior_tool','Regression_tool','Algorithms(Decomposition)','Recognition(Learning)','Desired_information');

x = V;
W = rand(size(V,1),base_num);
H = rand(base_num,size(V,2));
%Project = rand(size(H,1),size(VV,2));

%  if prior
%     fprintf('！！\n');
%     gType = input('Please choose whether apply geometrical prior. 0-No, 1-Yes, [1]');
%     if isempty(gType), gType = 1; end
%     fprintf('！！\n');
%     sType = input('Please choose whether apply statistic prior. 0-No, 1-Yes, [1]');
%     if isempty(sType), sType = 1; end
%  else
%       gType = 0; sType = 0; t = inf; p = 10;
%    
%  end

%  Geometric_prior_model;
%  Statistic_prior_model;
 VBNMF;
 Scenario_recognition_vb;
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