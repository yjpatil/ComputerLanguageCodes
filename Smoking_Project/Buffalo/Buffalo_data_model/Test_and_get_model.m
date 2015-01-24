% This function allows to obtain a model depending upon the values of 'C'
% and 'gamma' 
clc;clear all;close all;
%load 'Subject_25.mat';
load 'Subject_25_noabs.mat';

load 'feat16best_GA.mat'
feat = feat16best_GA;
%feat = 1:25;
for i = 1 : 1 : length(Subject_25_noabs)
    S(i).F = Subject_25_noabs(i).Features(:,feat);
    S(i).L = Subject_25_noabs(i).Labels;
end

N = length(S);


L = length(Subject_25_noabs);
%L = length(S);

Test_F = [];Test_L = [];
Train_F = [];Train_L = [];
I = 16
for id = 1 : 1 : L        % for loop to separate Training and Test data
    if id == I
        %Test_F = Subject_25(id).Features;
        Test_F = S(id).F;
        %Test_L = Subject_25(id).Labels;
        Test_L = S(id).L;
    else
        %Train_F = cat(1,Train_F,Subject_25(id).Features);
        Train_F = cat(1,Train_F,S(id).F);
        %Train_L = cat(1,Train_L,Subject_25(id).Labels);
        Train_L = cat(1,Train_L,S(id).L);
    end
end

p1 = 33;          % C value in RBF
Cval = num2str(exp(p1));   % The value of C parameter in SVM

p2 = -10;      % gamma value in RBF
gval = num2str(exp(p2));
            
options = [' -s ',' 0 ',' -t ',' 2 ',' -c ',Cval,' -g ',gval]; 

model = svmtrain(Train_L, Train_F,options);

[predict_label_L, accuracy_L, dec_values_L] = svmpredict(Test_L,Test_F, model);

tt = [];
tt = [predict_label_L Test_L predict_label_L-Test_L]; 

clear('index1','index2','index3','index4');
% True Positive %

index1 = find(tt(:,2) == 1 & tt(:,3) == 0);
i1 = isempty(index1);

if (i1 == 1)
    TP = 0;
else
    TP = length(index1);
end
% True Negative %
index2 = find(tt(:,2) == -1 & tt(:,3) == 0);
i2 = isempty(index2);
if (i2 == 1)
    TN = 0;
else
    TN = length(index2);
end
% False Positive %
index3 = find(tt(:,2) == -1 & tt(:,3) == 2);
i3 = isempty(index3);
if (i3 == 1)
    FP = 0;
else
    FP = length(index3);
end
% False Negative %
index4 = find(tt(:,2) == 1 & tt(:,3) == -2);
i4 = isempty(index4);
if (i4 == 1)
    FN = 0;
else
    FN = length(index4);
end
% Accuracy %
Acc = (TP + TN)/(TP+FP+TN+FN);
i7 = isnan(Acc);
if (i7 == 1)
    Acc = 0;
else
    Acc = (Acc*100);
end
% Precision %
Prec = (TP)/(TP + FP);
i8 = isnan(Prec);
if (i8 == 1)
    Prec = 0;
else
    Prec = Prec*100;
end
% Specificiy %
Spec = TN/(TN + FP);
i9 = isnan(Spec);
if (i9 == 1)
    Spec = 0;
else
    Spec = Spec*100;
end
% Sensitivity %
Sens = TP/(TP + FN);
i0 = isnan(Sens);
if (i0 == 1)
    Sens = 0;
else
    Sens = Sens*100;
end
% Balance Accuracy %
BA = (Sens+Spec)/2; % ** Balanced Accuracy ** %
% *** F1 measure *** %
F1 = 2*((Prec*Sens)/(Prec+Sens));
if1 = isnan(F1);
if (if1 == 1)
    F1 = 0;
else
end

Perf1 = [];
Perf1 = [BA F1 Prec Sens Sens Spec p1 p2]
Perf2 = [];
Perf2 = [BA F1 Prec Sens Sens Spec p1 p2]


















