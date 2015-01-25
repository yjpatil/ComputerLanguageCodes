% ----------------------------------------------------------------------- %
%     This code is for Buffalo Data Individual Model Training Results     %
% ----------------------------------------------------------------------- %
tic
clc;clear all;close all;

load 'Subject_25feat_Buffalo.mat'


N = length(Subject_25feat_Buffalo); % No. of Subjects

%I = 1;J = 1;
for I = 1 : 1 : N  
    clear 'TTP'
    %%% TTP = Subject_25feat_Buffalo(I).T_TP;   <----- Wrong %%%
    clear('ind1','ind2','ind3');
    
    ind1 = find(Subject_25feat_Buffalo(I).lab_sessions(1,1) <= Subject_25feat_Buffalo(I).SE(:,1) & Subject_25feat_Buffalo(I).SE(:,1) <=Subject_25feat_Buffalo(I).lab_sessions(1,2));
    Train1_feats = Subject_25feat_Buffalo(I).Features(ind1,:);
    Train1_labels = Subject_25feat_Buffalo(I).Labels(ind1,:);
    ind2 = find(Subject_25feat_Buffalo(I).lab_sessions(2,1) <= Subject_25feat_Buffalo(I).SE(:,1) & Subject_25feat_Buffalo(I).SE(:,1) <=Subject_25feat_Buffalo(I).lab_sessions(2,2));
    Train2_feats = Subject_25feat_Buffalo(I).Features(ind2,:);
    Train2_labels = Subject_25feat_Buffalo(I).Labels(ind2,:);
    Train_L = cat(1,Train1_labels,Train2_labels);    % Final MATRIX of Labels (+1 and -1) for Training  
    Train_F = cat(1,Train1_feats,Train2_feats);   % Final MATRIX of Features (+1 and -1) for Training 
    
    ind3 = find(Subject_25feat_Buffalo(I).lab_sessions(1,2) <= Subject_25feat_Buffalo(I).SE(:,1) & Subject_25feat_Buffalo(I).SE(:,1) <=Subject_25feat_Buffalo(I).lab_sessions(2,1));
    Test_L = Subject_25feat_Buffalo(I).Labels(ind3,:);      % Final MATRIX of Labels (+1 and -1) for Testing  
    Test_F = Subject_25feat_Buffalo(I).Features(ind3,:);      % Final MATRIX of Features (+1 and -1) for Testing
    
    ind4 = find(Subject_25feat_Buffalo(I).lab_sessions(1,2) <= puff_score(:,1) & puff_score(:,1) <=Subject_25feat_Buffalo(I).lab_sessions(2,1));
    TTP = length(ind4);
    for p1 = -25 : 1 : 25
        Cval = num2str(exp(p1)); %*** The value of C parameter in SVM
        for p2 = -25 : 1 : 25  %*** for loop for search of gamma value in RBF
            gval = num2str(exp(p2));
            options = [' -s ',' 0 ',' -t ',' 2 ',' -c ',Cval,' -g ',gval];
            model = svmtrain(Train_L, Train_F,options);
            [predict_label_L, accuracy_L, dec_values_L] = svmpredict(Test_L,Test_F, model);
            
            tt = [predict_label_L Test_L predict_label_L-Test_L];
            
            clear('index1','index2','index3','index4');
            % ** True Positive ** %
            index1 = find(tt(:,2) == 1 & tt(:,3) == 0);                
            i1 = isempty(index1);
            if (i1 == 1)
                TP = 0;
            else
                TP = length(index1);
            end
            % ** True Negative ** %
            index2 = find(tt(:,2) == -1 & tt(:,3) == 0);
            i2 = isempty(index2);
            if (i2 == 1)
                TN = 0;
            else
                TN = length(index2);
            end
            % ** False Positive ** %
            index3 = find(tt(:,2) == -1 & tt(:,3) == 2);
            i3 = isempty(index3);
            if (i3 == 1)
                FP = 0;
            else
                FP = length(index3);
            end
            % ** False Negative** %
            index4 = find(tt(:,2) == 1 & tt(:,3) == -2);
            i4 = isempty(index4);
            if (i4 == 1)
                FN = 0;
            else
                FN = length(index4);
            end
            % ** Accuracy** %
            Acc = (TP + TN)/(TP+FP+TN+FN);
            i7 = isnan(Acc);
            if (i7 == 1)
                Acc = 0;
            else
            end
            Acc = Acc*100;
            
            % ** Precision ** %
            Prec = (TP)/(TP + FP);
            i8 = isnan(Prec);
            if (i8 == 1)
                Prec = 0;
            else
            end
            Prec = Prec*100;
            
            % ** Specificity** %
            Spec = TN/(TN + FP);
            i9 = isnan(Spec);
            if (i9 == 1)
                Spec = 0;
            else
            end
            Spec = Spec*100;
            
            % ** Sensitivity & Recall** %
            Sens = TP/(TTP);
            i0 = isnan(Sens);
            if (i0 == 1)
                Sens = 0;
            else
            end
            Sens = Sens*100;
            % *** Balanced Accuracy *** %
            BA = (Sens + Spec)/2;                
            % *** F1 measure *** %
            F1 = 2*((Prec*Sens)/(Prec+Sens));
            if1 = isnan(F1);
            if (if1 == 1)
                F1 = 0;
            else
            end
            % *****
            if (BA < Pfm1(1,1))
            else
                Pfm1 = [];
                Pfm1 = [BA F1 Prec Sens Sens Spec Acc p1 p2];
            end
            % *****
            if (F1 < Pfm2(1,2))
            else
                Pfm2 = [];
                Pfm2 = [BA F1 Prec Sens Sens Spec Acc p1 p2];
            end
        end   % For loop for gamma_value
    end       % For loop for C_value
    % Table for BA %
    Table_BA(I,1)= Pfm1(1);Table_BA(I,2)= Pfm1(2);Table_BA(I,3)= Pfm1(3);
    Table_BA(I,4)= Pfm1(4);Table_BA(I,5)= Pfm1(5);Table_BA(I,6)= Pfm1(6);
    % Table for F1 %
    Table_F1(I,1)= Pfm2(1);Table_F1(I,2)= Pfm2(2);Table_F1(I,3)= Pfm2(3);
    Table_F1(I,4)= Pfm2(4);Table_F1(I,5)= Pfm2(5);Table_F1(I,6)= Pfm2(6);
end    % For loop for Iterations for the 20 Subjects
Final_BA(1,1) = mean(Table_BA(:,1));Final_BA(1,2) = mean(Table_BA(:,2));Final_BA(1,3) = mean(Table_BA(:,3));
Final_BA(1,4) = mean(Table_BA(:,4));Final_BA(1,5) = mean(Table_BA(:,5));Final_BA(1,6) = mean(Table_BA(:,6));
Final_BA(2,1) = std(Table_BA(:,1));Final_BA(2,2) = std(Table_BA(:,2));Final_BA(2,3) = std(Table_BA(:,3));
Final_BA(2,4) = std(Table_BA(:,4));Final_BA(2,5) = std(Table_BA(:,5));Final_BA(2,6) = std(Table_BA(:,6));

Final_F1(1,1) = mean(Table_F1(:,1));Final_F1(1,2) = mean(Table_F1(:,2));Final_F1(1,3) = mean(Table_F1(:,3));
Final_F1(1,4) = mean(Table_F1(:,4));Final_F1(1,5) = mean(Table_F1(:,5));Final_F1(1,6) = mean(Table_F1(:,6));
Final_F1(2,1) = std(Table_F1(:,1));Final_F1(2,2) = std(Table_F1(:,2));Final_F1(2,3) = std(Table_F1(:,3));
Final_F1(2,4) = std(Table_F1(:,4));Final_F1(2,5) = std(Table_F1(:,5));Final_F1(2,6) = std(Table_F1(:,6));

toc 

