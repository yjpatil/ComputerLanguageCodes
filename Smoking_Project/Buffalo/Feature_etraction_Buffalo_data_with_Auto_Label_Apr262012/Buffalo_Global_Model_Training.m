% ----------------------------------------------------------------------- %
%      This code finds the Global Model Training for Buufalo Data         %
% ----------------------------------------------------------------------- %

tic

clc;clear all;close all;

load 'Subject_25feat_Buffalo.mat'


Perf1 = [0 0 0 0 0 0 0 0];% ** Perf1 = [BA F1 Prec Sens Sens Spec p1 p2];
Perf2 = [0 0 0 0 0 0 0 0];% ** Perf2 = [BA F1 Prec Sens Sens Spec p1 p2];

L = length(Subject_25feat_Buffalo);


for I = 1 : 1 : L;    
    %tic
    Perf1 = [0 0 0 0 0 0 0 0];
    Perf2 = [0 0 0 0 0 0 0 0];
    Test_F = [];Test_L = [];
    Train_F = [];Train_L = [];
    for id = 1 : 1 : L        % for loop to separate Training and Test data
        if id == I
            Test_F = Subject_25feat_Buffalo(id).Features;
            %Test_F = S(id).F;
            Test_L = Subject_25feat_Buffalo(id).Labels;
            %Test_L = S(id).L;
            TTP = Subject_25feat_Buffalo(id).TTP;
        else
            Train_F = cat(1,Train_F,Subject_25feat_Buffalo(id).Features);
            %Train_F = cat(1,Train_F,S(id).F);
            Train_L = cat(1,Train_L,Subject_25feat_Buffalo(id).Labels);
            %Train_L = cat(1,Train_L,S(id).L);
        end
    end
    %i = 0;
    for p1 = -25 : 1 : 25          % for loop for search of C value in RBF
        Cval = num2str(exp(p1));   % The value of C parameter in SVM
        for p2 = -25 : 1 : 25      % for loop for search of gamma value in RBF
            
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
            %Perf(i,9) = TP;                  
            % True Negative %
            index2 = find(tt(:,2) == -1 & tt(:,3) == 0);
            i2 = isempty(index2);
            if (i2 == 1)
                TN = 0;
            else
                TN = length(index2);
            end
            %Perf(i,10) = TN; 
            % False Positive %
            index3 = find(tt(:,2) == -1 & tt(:,3) == 2);
            i3 = isempty(index3);
            if (i3 == 1)
                FP = 0;
            else
                FP = length(index3);
            end
            %Perf(i,11) = FP;
            % False Negative %
            index4 = find(tt(:,2) == 1 & tt(:,3) == -2);
            i4 = isempty(index4);
            if (i4 == 1)
                FN = 0;
            else
                FN = length(index4);
            end
            %Perf(i,12) = FN;
            % Accuracy %
            Acc = (TP + TN)/(TP+FP+TN+FN);
            i7 = isnan(Acc);
            if (i7 == 1)
                Acc = 0;
            else
                Acc = (Acc*100);
            end
            %Perf(i,2) = Acc*100;
            % Precision %
            Prec = (TP)/(TP + FP);
            i8 = isnan(Prec);
            if (i8 == 1)
                Prec = 0;
            else
                Prec = Prec*100;
            end
            %Perf(i,3) = Prec*100; 
            % Specificiy %
            Spec = TN/(TN + FP);
            i9 = isnan(Spec);
            if (i9 == 1)
                Spec = 0;
            else
                Spec = Spec*100;
            end
            %Perf(i,5) = Spec*100;
            % Sensitivity %
            Sens = TP/(TTP);
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
            % ******
            if (BA < Perf1(1,1))% (Prec < Perf(1,2))(BA < Perf(1,1))
            else 
                Perf1 = [];
                Perf1 = [BA F1 Prec Sens Sens Spec p1 p2];
            end
            
            if (F1 < Perf2(1,2))% (Prec < Perf(1,2))(BA < Perf(1,1))
            else 
                Perf2 = [];
                Perf2 = [BA F1 Prec Sens Sens Spec p1 p2];
            end
            
        end       % for loop for gamma values
    end           % for loop for C values
    Table_BA(I,:) = Perf1;
    
    Table_F1(I,:) = Perf2;
    %toc
    %Table(1,:) = Perf;
end
toc
    
