clear all;
close all;
clc;
addpath('Data','Utility');

dataType = input('Please choose the type of data? 0-Simulation Data, 1-Experiment Data, 2-Generate New Data, [0] ');
if isempty(dataType), dataType = 0; end;

if dataType == 2
    Generate_new_data;    
else
    baseNumber = input('Please choose the number of bases? 1-60, [49] ');
    if isempty(baseNumber), baseNumber = 25; end;
    
    prior = input('Please choose whether introduce priors? 0-without prior, 1-with prior, [0]');
    if isempty(prior), prior = 0; end;
    
    regression = input('Please choose whether implement regression? 0-No, 1-Yes, [0]');
    if isempty(regression), regression = 0;end
    
    algorithmType = input('Please choose the type of algorithm? 1-BNMF, 2-VBNMF, 3-PCA, 4-BPCA, 5-ICA, 6-BICA, [1] ');
    if isempty(algorithmType), algorithmType = 1; end;
    
    switch algorithmType
        case 1
            load training_data_SL126_120; V = double(V); X = V;
            load test_structure; VV = double(test.signal);
            [p,prediction] = BNMF_main(X,VV,baseNumber,test.number,prior,regression);
        case 2
            load training_data_SL126_120; V = double(V); X = V;
            load test_structure; VV = double(test.signal);
            [p,prediction] = VBNMF_main(X,VV,baseNumber,test.number,prior,regression);
        case 3
            PCA(X,Y,baseNumber,targetNumber);
        case 4
            BPCA(X,Y,baseNumber,targetNumber);
        case 5
            ICA;
        case 6
            BICA;
       
            
    end
end
    