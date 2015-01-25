function Context_prior = context_to_prior(gType)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name:     context_to_prior
% Function: transform contextual information to priors for tracking and recognition
% Inputs:   base         learned bases of training data
%           feature      feature coefficient of training data
%           pfeature     feature coefficient of testing data
%           scenario_num the specific scenario identified
% Output:   Context_prior the priors converted from contextual information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  Context_prior.scenario = gType;