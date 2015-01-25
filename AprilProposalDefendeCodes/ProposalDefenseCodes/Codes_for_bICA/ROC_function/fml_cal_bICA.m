function [ml] = fml_cal_bICA(sel_model,sel_data);
% This function calculates the mixture coefficients sum %

feature_model = sel_model{1};

feature_test = sel_data{1};

ml = -sum((feature_test-feature_model).^2);

%ml = norm(feature_test-feature_model);
%ml = sum(ml);


end


