
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name:     Statistic_prior_model
% Function: Introducing statistic prior
% Inputs:   W    the bases of training data
%           H    the coefficients of bases
% Outputs:   stat_base_term   the diagnal matrix of prior for columns of W 
%           stat_coef_term   the diagnal matrix of prior for rows of H
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stat_base_term = eye(size(W,2));
stat_coef_term = eye(size(W,2));

    
for ii = 1:size(W,2)
    betW(ii) = 1/(norm(W(:,base_num)));
    betH(ii) = 1/(norm(H(base_num,:)));
end

if sType
    stat_base_term = diag(betW);
    stat_coef_term = diag(betH);
else
    stat_base_term = eye(size(W,2));
    stat_coef_term = eye(size(W,2));
end

















