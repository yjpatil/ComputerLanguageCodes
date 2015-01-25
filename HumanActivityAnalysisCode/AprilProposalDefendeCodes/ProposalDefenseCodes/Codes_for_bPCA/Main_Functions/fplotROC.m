function[AUC] = fplotROC(Outputs,Targets,fig)
% This code plots the ROC curve and then ouputs the AUC value

%  Targets = [1,0,0,1,0,0;0,1,0,0,1,0;0,0,1,0,0,1];

[tpr,fpr] = roc(Targets,Outputs);

figure(fig);hold on;box on;
title('ROC curve');xlabel('False Positive Rate');
ylabel('True Positive Rate');
plot(fpr,tpr)

AUC = [];

end