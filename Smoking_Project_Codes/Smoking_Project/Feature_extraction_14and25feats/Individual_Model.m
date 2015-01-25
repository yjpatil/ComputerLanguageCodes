clc;clear all;close all;

load 'Subject.mat'

N = length(Subject); % No. of Subjects
I = 1;J = 1;
for I = 1 : 1 : N
    clear('S1','S2');
    S1 = Subject(I).Features; % Subject # I Features
    S2 = Subject(I).Labels;   % Subject # I Labels
    clear('Ind1','Ind2');
    Ind1 = find(S2 == 1);     % Obtain Indices for +1 labels and store in "Ind1"
    Ind2 = find(S2 == -1);    % Obtain Indices for -1 labels and store in "Ind2"
    clear('SP','SN');
    SP = [S1(Ind1,:) S2(Ind1)];   % "SP" contains "Features" and "Labels" for +1 Labels!
    SN = [S1(Ind2,:) S2(Ind2)];   % "SN" contains "Features" and "Labels" for -1 Labels!
    for J = 1 : 1 : 10
        clear('Rp','Rn');
        Rp = randperm(size(SP,1));    % "Rp" contains random ordering of indices for "SP" +1 Labels
        Rn = randperm(size(SN,1));    % "Rn" contains random ordering of indices for "SN" -1 Labels
        clear('lRn','lRp');
        lRp = length(Rp);             % "lRp" contains length for "Rp"
        lRn = length(Rn);             % "lRn" contains length for "Rn"
        clear('hRn','hRp');
        hRp = (round(lRp * 0.5));     % "hRp" contains value for half of the total length of "Rp"
        hRn = (round(lRn * 0.5));     % "hRn" contains value for half of the total length of "Rn"
        clear('hRn1','hRp1');
        hRp1 = Rp(1:hRp);             % FIRST HALF "hRp1" array contains Random-indices for elements of "SP"  FOR TRAINING
        hRn1 = Rn(1:hRn);             % FIRST HALF "hRn1" array contains Random-indices for elements of "SN"  FOR TRAINING
        clear('hRn2','hRp2');
        hRp2 = Rp(hRp+1:lRp);         % NEXT HALF "hRp2" array contains Random-indices for elements of "SP"  FOR TESTING
        hRn2 = Rn(hRn+1:lRn);         % NEXT HALF "hRn2" array contains Random-indices for elements of "SN"  FOR TESTING
        clear('PTrain_F','PTrain_L');
        PTrain_F = SP(hRp1,1:14);     % "PTrain_F" contains FEATURES for +1 Labels 
        PTrain_L = SP(hRp1,15);       % "PTrain_L" contains LABELS for +1 Labels
        clear('NTrain_F','NTrain_L');
        NTrain_F = SN(hRn1,1:14);     % "NTrain_F" contains FEATURES for -1 Labels 
        NTrain_L = SN(hRn1,15);       % "NTrain_L" contains LABELS for -1 Labels 
        clear('Train_F','Train_L');
        Train_L = cat(1,PTrain_L,NTrain_L);    % Final MATRIX of Labels (+1 and -1) for Training  
        Train_F = cat(1,PTrain_F,NTrain_F);    % Final MATRIX of Features (+1 and -1) for Training
        clear('PTest_F','PTest_L');
        PTest_F = SP(hRp2,1:14);      % "PTrain_F" contains FEATURES for +1 Labels 
        PTest_L = SP(hRp2,15);        % "PTest_L" contains LABELS for +1 Labels 
        clear('NTest_F','NTest_L');
        NTest_F = SN(hRn2,1:14);      % "NTest_F" contains FEATURES for -1 Labels 
        NTest_L = SN(hRn2,15);        % "NTest_L" contains LABELS for -1 Labels 
        Test_L = cat(1,PTest_L,NTest_L);      % Final MATRIX of Labels (+1 and -1) for Testing  
        Test_F = cat(1,PTest_F,NTest_F);      % Final MATRIX of Features (+1 and -1) for Testing
        
        BA = [0 0]; Acc = [0 0]; Prec = [0 0]; Rec = [0 0]; Sens = [0 0]; Spec = [0 0]; 
        for p1 = -15 : 1 : 15
            Cval = num2str(exp(p1)); %*** The value of C parameter in SVM
            for p2 = -15 : 1 : 15  %*** for loop for search of gamma value in RBF
                %c_v = p1;g_v = p2;
                gval = num2str(exp(p2));
                options = [' -s ',' 0 ',' -t ',' 2 ',' -c ',Cval,' -g ',gval];
                model = svmtrain(Train_L, Train_F,options);
                [predict_label_L, accuracy_L, dec_values_L] = svmpredict(Test_L,Test_F, model);
                tt = [predict_label_L Test_L predict_label_L-Test_L];
                
                clear('index1','index2','index3','index4');
                index1 = find(tt(:,2) == 1 & tt(:,3) == 0);
                % ** True Positive ** %
                i1 = isempty(index1);
                if i1 == 1
                    TP = 0;
                else
                    TP = length(index1);
                end
                % ** True Negative ** %
                index2 = find(tt(:,2) == -1 & tt(:,3) == 0);
                i2 = isempty(index2);
                if i2 == 1
                    TN = 0;
                else
                    TN = length(index2);
                end
                % ** False Positive ** %
                index3 = find(tt(:,2) == -1 & tt(:,3) == 2);
                i3 = isempty(index3);
                if i3 == 1
                    FP = 0;
                else
                    FP = length(index3);
                end
                % ** False Negative** %
                index4 = find(tt(:,2) == 1 & tt(:,3) == -2);
                i4 = isempty(index4);
                if i4 == 1
                    FN = 0;
                else
                    FN = length(index4);
                end
                % ** Accuracy** %
                Acc(1) = (TP + TN)/(TP+FP+TN+FN);
                i7 = isnan(Acc(1));
                if i7 == 1
                    Acc(1) = 0;
                else
                    Acc(1) = Acc(1);
                end
                Acc(1) = Acc(1)*100;
                if (Acc(1)>Acc(2))
                    Acc(2) = Acc(1);
                else
                end
                % ** Precision ** %
                Prec(1) = (TP)/(TP + FP);
                i8 = isnan(Prec(1));
                if i8 == 1
                    Prec(1) = 0;
                else
                    Prec(1) = Prec(1);
                end
                Prec(1) = Prec(1)*100;
                if (Prec(1)>Prec(2))
                    Prec(2) = Prec(1);
                else
                end
                % ** Specificity** %
                Spec(1) = TN/(TN + FP);
                i9 = isnan(Spec(1));
                if i9 == 1
                    Spec(1) = 0;
                else
                    Spec(1) = Spec(1);
                end
                Spec(1) = Spec(1)*100;
                if (Spec(1)>Spec(2))
                    Spec(2) = Spec(1);
                else
                end
                % ** Sensitivity & Recall** %
                Sens(1) = TP/(TP + FN);
                i0 = isnan(Sens(1));
                if i0 == 1
                    Sens(1) = 0;
                else
                    Sens(1) = Sens(1);
                end
                Sens(1) = Sens(1)*100;
                if (Sens(1)>Sens(2))
                    Sens(2) = Sens(1);
                else
                end
                BA(1) = (Sens(1)+Spec(1))/2; % ** Balanced Accuracy ** %
                %BA(1) = BA(1)*100; % ** BALANCED ACCURACY ** %            
                if (BA(1)>BA(2))
                    BA(2) = BA(1);
                else
                end
            end
        end
        Subj_Ind(I).Perf(J,1)= BA(2);Subj_Ind(I).Perf(J,2)= Acc(2);Subj_Ind(I).Perf(J,3)= Prec(2);
        Subj_Ind(I).Perf(J,4)= Sens(2);Subj_Ind(I).Perf(J,5)= Sens(2);Subj_Ind(I).Perf(J,6)= Spec(2);
    end
    Table(I,1)= mean(Subj_Ind(I).Perf(:,1));Table(I,2)= mean(Subj_Ind(I).Perf(:,2));
    Table(I,3)= mean(Subj_Ind(I).Perf(:,3));Table(I,4)= mean(Subj_Ind(I).Perf(:,4));
    Table(I,5)= mean(Subj_Ind(I).Perf(:,5));Table(I,6)= mean(Subj_Ind(I).Perf(:,6));
end
Final(1,1) = mean(Table(:,1));Final(1,2) = mean(Table(:,2));Final(1,3) = mean(Table(:,3));
Final(1,4) = mean(Table(:,4));Final(1,5) = mean(Table(:,5));Final(1,6) = mean(Table(:,6));
Final(2,1) = std(Table(:,1));Final(2,2) = std(Table(:,2));Final(2,3) = std(Table(:,3));
Final(2,4) = std(Table(:,4));Final(2,5) = std(Table(:,5));Final(2,6) = std(Table(:,6));
    

