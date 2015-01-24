% ----------------------------------------------------------------------- %
%      This code builds the Global Model Training for Buffalo Data         %
% ----------------------------------------------------------------------- %

tic
sf = 101.73
clc;clear all;%close all;

load 'Subject_25feat_Buffalo_lowth.mat'
load 'DATA_PACT_105.mat'

Perf1 = [0 0 0 0 0 0 0 0];% ** Perf1 = [BA F1 Prec Sens Sens Spec p1 p2];
Perf2 = [0 0 0 0 0 0 0 0];% ** Perf2 = [BA F1 Prec Sens Sens Spec p1 p2];

L = length(Subject_25feat_Buffalo_lowth);

I = 1;
%for I = 1 : 1 : L;    
    %tic
    Perf1 = [0 0 0 0 0 0 0 0];
    Perf2 = [0 0 0 0 0 0 0 0];
    Test_F = [];Test_L = [];
    Train_F = [];Train_L = [];TTP = [];
    for id = 1 : 1 : L        % for loop to separate Training and Test data
        if id == I
            Test_F = Subject_25feat_Buffalo_lowth(id).Features;
            %Test_F = S(id).F;
            Test_L = Subject_25feat_Buffalo_lowth(id).Labels;
            %Test_L = S(id).L;
            TTP = Subject_25feat_Buffalo_lowth(id).T_TP;
        else
            Train_F = cat(1,Train_F,Subject_25feat_Buffalo_lowth(id).Features);
            %Train_F = cat(1,Train_F,S(id).F);
            Train_L = cat(1,Train_L,Subject_25feat_Buffalo_lowth(id).Labels);
            %Train_L = cat(1,Train_L,S(id).L);
        end
    end
    %i = 0;
    p1 = 31;
    %for p1 = -25 : 1 : 25          % for loop for search of C value in RBF
        Cval = num2str(exp(p1));   % The value of C parameter in SVM
        p2 = -11;
        %for p2 = -25 : 1 : 25      % for loop for search of gamma value in RBF
            
            gval = num2str(exp(p2));
            
            options = [' -s ',' 0 ',' -t ',' 2 ',' -c ',Cval,' -g ',gval]; 
            
            model = svmtrain(Train_L, Train_F,options);
            
            [predict_label_L, accuracy_L, dec_values_L] = svmpredict(Test_L,Test_F, model);
            
            tt = [];
            tt = [predict_label_L Test_L predict_label_L-Test_L];
            
            
            ts = Signals(:,1);                             % time-stamps with proper offset values
            RC = Signals(:,2);RC = RC/(max(RC));           % Raw rib-cage belt data, Normalized
            AB = Signals(:,3);AB = AB/(max(AB));           % Raw abdominal belt data, Normalized
            Signals(:,4) = Signals(:,4)/max(Signals(:,4)); % Normalized Actual PS signal in column 4 of Signals
            PS = Signals(:,5);                             % Proximity Signal normalised, thresholded, eliminated SD and LD signals
            %figure(1);plot(ts,PS,'-r');grid on;hold on;
            PS = check_PS(PS); %plot(ts,PS,'-k');grid on;hold on;
            %figure(2)
            VT = (RC + AB)/2; %plot(ts,VT,'-r');grid on;hold on;
            % % mVT = mean([VT]);  % Mean Value of VT signal
            % % VT = VT - mVT;
            % % VT = -1 * VT; VT = VT + mVT; %plot(ts,VT,'-g');grid on;hold on;
            VT = idealfilter(VT,0.1,1000,101.73);%plot(ts,VT,'-g');grid on;hold on;
            VT = fastsmooth(VT,15,3,0);%plot(ts,VT,'-b');grid on;hold on;
            AS = diff(VT)./diff(ts);AS = [AS;0];%plot(ts,AS,'-r');grid on;hold on;
            %AS = fastsmooth(AS,5,3,0);plot(ts,AS,'-m');grid on;hold on;  %% you
            %dont need this step of smoothning the AS
            % ============================================================================= %
            ASts = [ts AS];  %% time stamps in 1st Column and Amplitude of AS in 2nd Column %
            VTts = [ts VT];  %% time stamps in 1st Column and Amplitude of VT in 2nd Column %
            % ============================================================================= %
            % ======================================================================= %
            % In the following steps you find the peaks & valleys of AS and VT signals
            % ======================================================================= %
            [LpVT,MpVT] = peakfinder(VT,0.03,0.0,1);
            LpVT = VTts(LpVT,1);
            
            [LvVT,MvVT] = peakfinder(VT,0.03,0.0,-1);
            LvVT = VTts(LvVT,1);
            
            [LpAS,MpAS] = peakfinder(AS,0.03,0.0,1);
            LpAS = ASts(LpAS,1);
            
            [LvAS,MvAS] = peakfinder(AS,0.03,0.0,-1);
            LvAS = ASts(LvAS,1);
            % ======================================================================= %
            % % % % % % % LpVT = LpVT(14:length(LpVT)-5);MpVT = MpVT(14:length(MpVT)-5); % Dont delete first few and last few now
            % % % % % % % LvVT = LvVT(14:length(LvVT)-5);MvVT = MvVT(14:length(MvVT)-5);
            % % % % % % % LpAS = LpAS(14:length(LpAS)-5);MpAS = MpAS(14:length(MpAS)-5);
            % % % % % % % LvAS = LvAS(14:length(LvAS)-5);MvAS = MvAS(14:length(MvAS)-5);
            % ================= PLOTS ======================= %
            figure%(123)
            %title(list(I,:));xlabel('Time \it s');ylabel('\it VT , AS , PS ');
            plot(ts,Signals(:,4),'-m');title('PACT105');xlabel('Time \it s');ylabel('\it VT , AS , PS ');grid on; hold on;
            O = 0.4*ones(size(puff_score));
            plot(puff_score,O,'og');hold on; grid on; % Puff score plot %
            plot(ts,AS,'b');hold on; grid on;     % AS signal %
            %plot(LpAS,MpAS,'+k');grid on;hold on; % Peaks for AS signal %
            %plot(LvAS,MvAS,'+r');grid on;hold on; % Valleys for AS signal %
            plot(ts,VT,'y');hold on; grid on;     % VT signal %
            %plot(LpVT,MpVT,'ob');grid on;hold on; % Peaks for VT signal %
            %plot(LvVT,MvVT,'ok');grid on;hold on; % Valleys for VT signal %
            
            for Y1 = 1 : 1 : length(predict_label_L)
                if(predict_label_L(Y1)==+1)
                    plot([Subject_25feat_Buffalo_lowth(I).SE(Y1,1) Subject_25feat_Buffalo_lowth(I).SE(Y1,2)],[0.37 0.37],'ob');grid on;hold on;
                else
                end
            end
            
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
            
        %end       % for loop for gamma values
    %end           % for loop for C values
    Table_BA(I,:) = Perf1;
    
    Table_F1(I,:) = Perf2;
    %toc
    %Table(1,:) = Perf;
%end
toc





