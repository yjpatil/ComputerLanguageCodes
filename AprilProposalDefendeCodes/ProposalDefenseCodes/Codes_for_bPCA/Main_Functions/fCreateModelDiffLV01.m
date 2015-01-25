function[MSc01,MSc02,MSc03,MSc04,LLSc01LV1,LLSc02LV1,LLSc03LV1,LLSc04LV1] = fCreateModelDiffLV01(LineWidth,FontSize,LV,fig,Plot,TrSc01,TrSc02,TrSc03,TrSc04)
% This function creates models for the different scenarios
% if Plot == 1, then plot the figures with the loglkhds
% else          do not plot
% fig = figure number
% LV = number of latent variables
% Date: 2 Apr 2014


%%------ Train your btPCA model for Scenario 1 ----- %
[LLSc01LV1,MSc01,qcn01,RelChangeSc01LV1] = BTPCA_modify(TrSc01,LV,1,0,0);

% ------ Train your btPCA model for Scenario 2 ----- %
[LLSc02LV1,MSc02,qcn02,RelChangeSc02LV1] = BTPCA_modify(TrSc02,LV,1,0,0);

% ------ Train your btPCA model for Scenario 3 ----- %
MSc03 = [];LLSc03LV1 = [];
[LLSc03LV1,MSc03,qcn03,RelChangeSc03LV1] = BTPCA_modify(TrSc03,LV,1,0,0);

% ------ Train your btPCA model for Scenario 4 ----- %
MSc04 = [];LLSc04LV1 = [];
%[LLSc04LV1,MSc04,qcn04,RelChangeSc04LV1] = BTPCA_modify(TrSc04,LV,1,0,0);


if(Plot == 1)
    figure(fig);
    Legend1 = plot(LLSc01LV1,'--k','LineWidth',LineWidth);
    Legend2 = plot(LLSc02LV1,'-.k','LineWidth',LineWidth);
    Legend3 = plot(LLSc03LV1,':k','LineWidth',LineWidth);
    %Legend4 = plot(LLSc04LV1,'-k','LineWidth',LineWidth);
    legend([Legend1 Legend2 Legend3],{'Scenario1' 'Scenario2' 'Scenario3'},'FontSize',FontSize)
    %legend([Legend1 Legend2 Legend3 Legend4],{'Scenario1' 'Scenario2' 'Scenario3' 'Scenario4'},'FontSize',FontSize)
end







end



