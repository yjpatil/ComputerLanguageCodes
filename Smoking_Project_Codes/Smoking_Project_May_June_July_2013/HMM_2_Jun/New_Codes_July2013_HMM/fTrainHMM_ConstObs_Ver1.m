function[BestLogLkhd,BestHmm,BestStates,BestObs,BestIter,RecLogLkhd] = fTrainHMM_ConstObs_Ver1(StartState,EndState,Sep,MaxIter,Data)
% This function outputs the sub-optimal HMM model for a given act based on
% the score obtained for Log Likelihood

% Date : 15 July 2013

% StartState = Begining value in the for loop for States Grid Search
% EndState = End value in the for loop for States Grid Search
% StartObs = Begining value in the for loop for States Grid Search
% EndObs = End value in the for loop for States Grid Search
% MaxIter = Number of iterations for per model
% Data = Data required for Training

BestStates = 0;BestObs = 0;BestIter = 1;BestHmm = [];BestLogLkhd = -50000000;

Iter1 = 1;

%%%%MaxIter = 25;  % Number of iterations for per model

%%%%Data = TrRead;  % Which class Model you want to create

Obs = Sep; % Will equal to the number of fixed points

for States = StartState : 1 : EndState
    %for Obs = StartObs : 1 : EndObs
        HMM = [];loglk = [];
        [loglk,HMM] = GetHMM(Data,States,Obs,MaxIter);
        loglk = loglk(length(loglk));
        RecLogLkhd(Iter1) = loglk;
        if(RecLogLkhd(Iter1) > BestLogLkhd)
            BestLogLkhd = [];BestHmm = [];BestStates = 0;BestObs = 0;BestIter = [];
            BestStates = States;
            BestObs = Obs;
            BestIter = Iter1;
            BestLogLkhd = RecLogLkhd(Iter1);
            BestHmm = HMM;
            BestIter = Iter1;
        else
        end
        
        Iter1 = Iter1 + 1;
    %end
end



end