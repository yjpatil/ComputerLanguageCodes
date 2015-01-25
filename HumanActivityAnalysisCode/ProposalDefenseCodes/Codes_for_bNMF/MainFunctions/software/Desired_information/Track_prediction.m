function Tracking_prediction = tracking_prediction(gType)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name:     tracking_prediction
% Function: Predict trajectory
% Inputs:   base         learned bases of training data
%           feature      feature coefficient of training data
%           pfeature     feature coefficient of testing data
%           scenario_num the specific scenario identified
% Output:   Tracking_prediction the predicted trajectory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  Tracking_prediction = eps;