function[Log] = fTestHMM(TrainData,HMM,PlotYesNo,Fig1,Fig2,ACTlist,ActNo)


Names1 = fieldnames(TrainData); 

for i = 1 : 1 : length(Names1)    % Now start copying data from the same field in struct 1 to struct 2    
    Array = getfield(TrainData,Names1{i});  % Get the data of the ith field, which is the wave numbers   
    L = length(Array);
    if(isempty(Array))        
    else
        for j = 1 : 1 : L
            Log(i).loglik(j) = dhmm_logprob(Array{j}, HMM.prior, HMM.transmat, HMM.obsmat);    
            %%disp(sprintf('\n\n [class X1: %d-th data] model X2: %.3f\n',dt,Log(i).loglik(j)));            
        end
    end
    
end


if(PlotYesNo == 1)
    figure(Fig1);hold on;title(strcat('Train Data Set Results LogLikelihood of', ACTlist(ActNo,:) ,'HMM on 4 acts'));
    P1 = plot(Log(1).loglik,'g');
    P2 = plot(Log(2).loglik,'k');
    P3 = plot(Log(3).loglik,'b');
    P4 = plot(Log(4).loglik,'r');
    legend([P1 P2 P3 P4],{'Sit' 'Read' 'Walk' 'Smk'})
    
    figure(Fig2);hold on;title(strcat('Train Data Set Results PDF LogLikelihood of', ACTlist(ActNo,:) ,'HMM on 4 acts'));
    [Ldgnd0] = Plot_PDF_LogLk(Log(1).loglik);
    [Ldgnd1] = Plot_PDF_LogLk(Log(2).loglik);
    [Ldgnd2] = Plot_PDF_LogLk(Log(3).loglik);
    [Ldgnd3] = Plot_PDF_LogLk(Log(4).loglik);
    legend([Ldgnd0 Ldgnd1 Ldgnd2 Ldgnd3],{'Sit' 'Read' 'Walk' 'Smk'})
else
end








end