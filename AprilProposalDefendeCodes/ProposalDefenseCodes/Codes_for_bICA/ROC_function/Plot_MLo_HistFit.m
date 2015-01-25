function Plot_MLo_HistFit(type, MLo, iSub)
%=========================================================================
%% Plot Result:
%=========================================================================
%RANGE for P: -500 to 0
%Threash Span:

ML = MLo;

[test_round, aaa, subject_Count] = size(ML);

P_MAX        = max(reshape(ML, 1, test_round*subject_Count*subject_Count))+10;
P_MIN        = min(reshape(ML, 1, test_round*subject_Count*subject_Count))-10;
P_SPAN       = 1;

%% -
% Histgram 2

P_SELF_TEST  = zeros(1, test_round * subject_Count);
P_SELF_INDEX = 1;

P_CROSS_TEST = zeros(1, test_round * (subject_Count^2 - subject_Count));
P_CROSS_INDEX = 1;

D = 0;

for i_r=1: test_round
    for i_sub1=1: subject_Count
        for i_sub2=1: subject_Count
            
            if (i_sub1 == i_sub2)
                P_SELF_TEST(P_SELF_INDEX)= ML(i_r,i_sub1,i_sub2);
                P_SELF_INDEX = P_SELF_INDEX+1;
            else
                P_CROSS_TEST(P_CROSS_INDEX) = ML(i_r,i_sub1,i_sub2)+D;
                P_CROSS_INDEX = P_CROSS_INDEX+1;
            end
            
        end
    end
end

histfit(P_CROSS_TEST,60); % grey
h = get(gca,'Children');
set(h(2),'FaceColor',[0.7 0.7 0.7])
set(h(1),'Color',[0.3 0.3 0.3]); set(h(1),'LineWidth',3);
hold on;

histfit(P_SELF_TEST,20) % black
h = get(gca,'Children');
set(h(2),'FaceColor',[0 0 0]); set(h(2),'EdgeColor',[0.1 0.1 0.1]);
set(h(1),'Color',[0 0 0]); set(h(1),'LineWidth',3);

%title(['SEQUENCE FEATURE of ' type])
xlim([P_MIN P_MAX]);
hold off
