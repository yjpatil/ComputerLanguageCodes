% ======================== INDIVIDUAL MODEL TRAINING ==================== %
% This is the main code to train and validate the HMM models for different
% acts. HMM model for each act is selected based on the loglikelihood value
% in the training phase. Then these HMM models are then applied on the
% validation data set and confusion matrix gives the performance of the HMM
% models classification
clc;clear all;close all;

tic
%  Add this path for HMM folder
addpath(genpath('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM'));

%  Add this path into the paths so as to access all HMM toolkit
addpath(genpath('C:\Users\student\Documents\MATLAB\HMM\HMMEverything'));

%  Add this path into the paths so as to access all Pre-processing functions for 20 Subjects  
addpath(genpath('C:\Users\student\Documents\MATLAB\BioBldg_20_Function_Get_AS_VT'));

addpath(genpath('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun'));

load('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\Data_Encoded_Selected_Waves\EnCod_4Div_200pts_VTASts_15Jul13')

clc;

VTEnCod = VTDividedSUB;
ASEnCod = ASDividedSUB;
ts = TimeDividedSUB;

clearvars -except VTEnCod ASEnCod ts  % Hope this command does not clears the addpath's

Len = length(VTEnCod);

for i = 1 : 1 : Len
    Labels(i).Sit = 1 * ones(length(VTEnCod(i).Sit),1);
    Labels(i).Read = 2 * ones(length(VTEnCod(i).Read),1);
    Labels(i).Walk = 3 * ones(length(VTEnCod(i).Walk),1);
    Labels(i).Smk = 4 * ones(length(VTEnCod(i).Smk),1);
end


I = 10;
%while(I <= Len)
    FullSit = length(VTEnCod(I).Sit);
    FullRead = length(VTEnCod(I).Read);
    FullWalk = length(VTEnCod(I).Walk);
    FullSmk = length(VTEnCod(I).Smk);
    
    HalfSit = round(FullSit/2);
    HalfRead = round(FullRead/2);
    HalfWalk = round(FullWalk/2);
    HalfSmk = round(FullSmk/2);   
    
    % ======= Train Data Set ======== %    
    TrSit = VTEnCod(I).Sit(1 : HalfSit);
    TrRead = VTEnCod(I).Read(1 : HalfRead);
    TrWalk = VTEnCod(I).Walk(1 : HalfWalk);
    TrSmk = VTEnCod(I).Smk(1 : HalfSmk);     
    % ======= Test Data Set ========= %
    TstSit = VTEnCod(I).Sit((HalfSit + 1):FullSit);
    TstRead = VTEnCod(I).Read((HalfRead + 1):FullRead);
    TstWalk = VTEnCod(I).Walk((HalfWalk + 1):FullWalk);
    TstSmk = VTEnCod(I).Smk((HalfSmk + 1):FullSmk);                
    
%     TestLabel.Sit = Labels(I).Sit;
%     TestLabel.Read = Labels(I).Read;
%     TestLabel.Walk = Labels(I).Walk;
%     TestLabel.Smk = Labels(I).Smk;             
    % ============================== %
    % HMM for Sit %
    BestStates = 0;BestObs = 0;BestIter = [];
    BestHmm = [];BestLogLkhd = -5000000;
    Iter1 = 1;MaxIter = 25;  % Number of iterations for per model
    
    Data = TrSmk;  % Which class Model you want to create
    
    
    for States = 35 : 1 : 45
        for Obs = 32 : 1 : 40
            HMM = [];loglk = [];
            
            [loglk,HMM] = GetHMM(Data,States,Obs,MaxIter);
            
            loglk = loglk(length(loglk));
            RecLogLkhd(Iter1) = loglk;
            if(RecLogLkhd(Iter1) > BestLogLkhd)
                BestLogLkhd = [];BestHmm = [];BestStates = 0;BestObs = 0;BestIter = [];
                BestStates = States;
                BestObs = Obs;
                BestIter = Iter1;
                BestLogLkhd = RecLogLkhd(Iter1)
                BestHmm = HMM
                BestIter = Iter1;
            else
            end
                
            Iter1 = Iter1 + 1;
        end
    end
    
    figure;hold on;title(strcat('Best LogLikelihood for I = ',num2str(I)))
    plot(RecLogLkhd);
    plot(BestIter,BestLogLkhd,'*r');
    
%     data0 = Train.Sit;
%     data1 = Train.Read;
%     data2 = Train.Walk;
%     data3 = Train.Smk;
    
    for dt = 1 : 1 : length(TrSit)
        loglike0(dt) = dhmm_logprob(TrSit{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Sit: %d-th data] model Walk: %.3f\n',dt,loglike0(dt)));
    end
    for dt = 1 : 1 : length(TrRead)
        loglike1(dt) = dhmm_logprob(TrRead{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Read: %d-th data] model Walk: %.3f\n',dt,loglike1(dt)));
    end
    for dt = 1 : 1 : length(TrWalk)
        loglike2(dt) = dhmm_logprob(TrWalk{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Walk: %d-th data] model Walk: %.3f\n',dt,loglike2(dt)));
    end
    for dt = 1 : 1 : length(TrSmk)
        loglike3(dt) = dhmm_logprob(TrSmk{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Smk: %d-th data] model Walk: %.3f\n',dt,loglike3(dt)));
    end
    
    figure;hold on;title('Train Results LogLikelihood of Sit Model on 4 acts')
    P1 = plot(loglike0,'g');P2 = plot(loglike1,'k');P3 = plot(loglike2,'b');P4 = plot(loglike3,'r');
    legend([P1 P2 P3 P4],{'Sit' 'Read' 'Walk' 'Smk'})
    
    Time1 = toc
    
%     data10 = Test.Sit;
%     data11 = Test.Read;
%     data12 = Test.Walk;
%     data13 = Test.Smk;
    
    for dt = 1 : 1 : length(TstSit)
        loglike10(dt) = dhmm_logprob(TstSit{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Sit: %d-th data] model Walk: %.3f\n',dt,loglike10(dt)));
    end
    for dt = 1 : 1 : length(TstRead)
        loglike11(dt) = dhmm_logprob(TstRead{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Read: %d-th data] model Walk: %.3f\n',dt,loglike11(dt)));
    end
    for dt = 1 : 1 : length(TstWalk)
        loglike12(dt) = dhmm_logprob(TstWalk{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Walk: %d-th data] model Walk: %.3f\n',dt,loglike12(dt)));
    end
    for dt = 1 : 1 : length(TstSmk)
        loglike13(dt) = dhmm_logprob(TstSmk{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Smk: %d-th data] model Walk: %.3f\n',dt,loglike13(dt)));
    end
    
    figure;hold on;title('Test Results LogLikelihood of Sit Model on 4 acts')
    Q1 = plot(loglike10,'g');Q2 = plot(loglike11,'k');Q3 = plot(loglike12,'b');Q4 = plot(loglike13,'r')
    legend([Q1 Q2 Q3 Q4],{'Sit' 'Read' 'Walk' 'Smk'})
    
    
    figure;hold on;title(strcat('PDF of Train on Train LogLikelihood for I = ',num2str(I)))
    [Ldgnd0] = Plot_PDF_LogLk(loglike0);
    [Ldgnd1] = Plot_PDF_LogLk(loglike1);
    [Ldgnd2] = Plot_PDF_LogLk(loglike2);
    [Ldgnd3] = Plot_PDF_LogLk(loglike3);
    
    legend([Ldgnd0 Ldgnd1 Ldgnd2 Ldgnd3],{'Sit' 'Read' 'Walk' 'Smk'})
    
    figure;hold on;title(strcat('PDF of Train on Test LogLikelihood for I = ',num2str(I)))
    [Ldgnd10] = Plot_PDF_LogLk(loglike10);
    [Ldgnd11] = Plot_PDF_LogLk(loglike11);
    [Ldgnd12] = Plot_PDF_LogLk(loglike12);
    [Ldgnd13] = Plot_PDF_LogLk(loglike13);
    
    legend([Ldgnd10 Ldgnd11 Ldgnd12 Ldgnd13],{'Sit' 'Read' 'Walk' 'Smk'})
    
    Time2 = toc
            
    
    %I = I + 1;
%end











