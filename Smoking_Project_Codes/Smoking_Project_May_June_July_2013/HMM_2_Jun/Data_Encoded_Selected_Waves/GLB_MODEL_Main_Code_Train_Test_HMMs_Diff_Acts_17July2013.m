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

load('C:\Users\student\Documents\MATLAB\Smoking_Project_May_June_July_2013\HMM_2_Jun\Data_Encoded_Selected_Waves\EnCod_7Div_100pts_VTASts_15Jul13')

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
    Sit1 = [];Read1 = [];
    Walk1 = [];Smk1 = [];    
    for i = 1 : 1 : Len
        if(I == i)
            Test.Sit = VTEnCod(i).Sit;
            Test.Read = VTEnCod(i).Read;
            Test.Walk = VTEnCod(i).Walk;
            Test.Smk = VTEnCod(i).Smk;
            
            TestLabel.Sit = Labels(i).Sit;
            TestLabel.Read = Labels(i).Read;
            TestLabel.Walk = Labels(i).Walk;
            TestLabel.Smk = Labels(i).Smk;
        else
            Sit1 = cat(2,Sit1,VTEnCod(i).Sit);
            Read1 = cat(2,Read1,VTEnCod(i).Read);
            Walk1 = cat(2,Walk1,VTEnCod(i).Walk);
            Smk1 = cat(2,Smk1,VTEnCod(i).Smk);
        end
    end
    Train.Sit = Sit1;
    Train.Read = Read1;
    Train.Walk = Walk1;
    Train.Smk = Smk1;
    
    % HMM for Sit %
    BestStates = 0;BestObs = 0;BestIter = [];
    BestHmm = [];BestLogLkhd = -5000000;
    Iter1 = 1;MaxIter = 20;  % Number of iterations for per model
    Data = Train.Smk;  % Which class Model you want to create
    for States = 5 : 1 : 18
        for Obs = 15 : 1 : 20
            HMM = [];loglk = [];
            [loglk,HMM] = GetHMM(Data,States,Obs,MaxIter);
            loglk = loglk(length(loglk));
            RecLogLkhd(Iter1) = loglk;
            if(RecLogLkhd(Iter1) > BestLogLkhd)
                BestLogLkhd = [];BestHmm = [];
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
    
    data0 = Train.Sit;
    data1 = Train.Read;
    data2 = Train.Walk;
    data3 = Train.Smk;
    
    for dt = 1 : 1 : length(data0)
        loglike0(dt) = dhmm_logprob(data0{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Sit: %d-th data] model Walk: %.3f\n',dt,loglike0(dt)));
    end
    for dt = 1 : 1 : length(data1)
        loglike1(dt) = dhmm_logprob(data1{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Read: %d-th data] model Walk: %.3f\n',dt,loglike1(dt)));
    end
    for dt = 1 : 1 : length(data2)
        loglike2(dt) = dhmm_logprob(data2{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Walk: %d-th data] model Walk: %.3f\n',dt,loglike2(dt)));
    end
    for dt = 1 : 1 : length(data3)
        loglike3(dt) = dhmm_logprob(data3{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Smk: %d-th data] model Walk: %.3f\n',dt,loglike3(dt)));
    end
    
    figure;hold on;title('LogLikelihood of Sit Model on 4 acts')
    plot(loglike0,'g');plot(loglike1,'k');plot(loglike2,'b');plot(loglike3,'r')
    
    Time1 = toc
    
    data10 = Test.Sit;
    data11 = Test.Read;
    data12 = Test.Walk;
    data13 = Test.Smk;
    
    for dt = 1 : 1 : length(data10)
        loglike10(dt) = dhmm_logprob(data10{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Sit: %d-th data] model Walk: %.3f\n',dt,loglike10(dt)));
    end
    for dt = 1 : 1 : length(data11)
        loglike11(dt) = dhmm_logprob(data11{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Read: %d-th data] model Walk: %.3f\n',dt,loglike11(dt)));
    end
    for dt = 1 : 1 : length(data12)
        loglike12(dt) = dhmm_logprob(data12{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Walk: %d-th data] model Walk: %.3f\n',dt,loglike12(dt)));
    end
    for dt = 1 : 1 : length(data13)
        loglike13(dt) = dhmm_logprob(data13{dt}, BestHmm.prior, BestHmm.transmat,BestHmm.obsmat);    
        disp(sprintf('\n\n [class Smk: %d-th data] model Walk: %.3f\n',dt,loglike13(dt)));
    end
    
    figure;hold on;title('LogLikelihood of Sit Model on 4 acts')
    plot(loglike10,'g');plot(loglike11,'k');plot(loglike12,'b');plot(loglike13,'r')
    
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











