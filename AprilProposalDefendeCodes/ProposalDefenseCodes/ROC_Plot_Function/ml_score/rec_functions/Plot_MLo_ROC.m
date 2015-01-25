function Plot_MLo_ROC(MLo, type)
%=========================================================================
%% Plot Result:
%=========================================================================
%RANGE for P: -500 to 0
%Threash Span:

ML = MLo;

[test_round, aaa, subject_Count] = size(ML);

P_MAX        = max(reshape(ML, 1, test_round*subject_Count*subject_Count)) + 100;
P_MIN        = min(reshape(ML, 1, test_round*subject_Count*subject_Count)) - 100;

P_SPAN       = 1;
HIST_COLUMNS = fix((P_MAX - P_MIN) / P_SPAN);

HIST_TP      = zeros(1, HIST_COLUMNS);
HIST_FP      = zeros(1, HIST_COLUMNS);

for i_col=1: HIST_COLUMNS
    Low_Bound = P_MIN + (i_col-1)*P_SPAN;
    Up_Bound = Low_Bound + P_SPAN;
    
    for i_r=1: test_round
        for i_sub1=1: subject_Count
            for i_sub2=1: subject_Count
                if (i_sub1 == i_sub2)
                    
                    %Ture Positive (TP) cases
                    if (ML(i_r,i_sub1,i_sub2)>=Low_Bound) && ...
                            (ML(i_r,i_sub1,i_sub2)<Up_Bound)
                        HIST_TP(i_col) = HIST_TP(i_col) + 1;
                    end
                    
                else
                    
                    %False Positive (FP) cases
                    if (ML(i_r,i_sub1,i_sub2)>=Low_Bound) && ...
                            (ML(i_r,i_sub1,i_sub2)<Up_Bound)
                        HIST_FP(i_col) = HIST_FP(i_col) + 1;
                    end
                end
            end
        end
    end
end

if (sum(HIST_TP) ~= test_round * subject_Count),
    disp('Warning: sum(HIST_TP) != 1'),
end;

if (sum(HIST_FP) ~= test_round * (subject_Count^2 - subject_Count)),
    disp('Warning: sum(HIST_FP) != 1'),
end;

HIST_TP = HIST_TP / (test_round * subject_Count);
HIST_FP = HIST_FP / (test_round * (subject_Count^2 - subject_Count));

%% -
% Plot the ROC

ROC_TP = zeros(1, HIST_COLUMNS); ROC_FP = zeros(1, HIST_COLUMNS);

for i_col=1: HIST_COLUMNS
    for i_cum=i_col: HIST_COLUMNS
        ROC_TP(i_col) = ROC_TP(i_col) + HIST_TP(i_cum);
        ROC_FP(i_col) = ROC_FP(i_col) + HIST_FP(i_cum);
    end
end

%plot(ROC_FP, ROC_TP, color, 'd','LineWidth', 3); %, title('Roc');
plot(ROC_FP, ROC_TP, type,'MarkerSize', 4.5, 'MarkerFaceColor', 'k', 'LineWidth', 1.5);
xlim([-0.01 1.01]); ylim([0 1.01]);
ylabel('TP Rate','FontSize',12); xlabel('FP Rate','FontSize',12);
