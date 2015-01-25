%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name:     Generate_new_data
% Function: Generate new simulation data
% Inputs:   dataType              the type of data
% Outputs:  targetNumber          the initial target number 
%           nodeNumber            the number of nodes using in simulation procedure
%           visibilityModulation  the type of visibility
%           baseNumber            the number of bases
%           prior                 the parameter of whether applying prior
%           regression            the parameter of whether choosing regression
%           algorithmType         the type of algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Please set up the parameters of system. \n\n');

targetNumber = input('Please choose the number of targets? 1-4, [4] ');
    if isempty(targetNumber), targetNumber = 4; end;
    
    nodeNumber = input('Please choose the number of nodes fusion? 1-4, [1] ');
    if isempty(nodeNumber), nodeNumber = 1; end;
    
    visibilityModulation = input('Please choose the type of visibility? 0-regular visibility, 1-pseudo_random visibility, [0] ');
    if isempty(visibilityModulation), visibilityModulation = 0; end;
    
    baseNumber = input('Please choose the number of bases? 1-60, [16] ');
    if isempty(baseNumber), baseNumber = 16; end;
    
    prior = input('Please choose whether introduce priors? 0-without prior, 1-with prior, [0]');
    if isempty(prior), prior = 0; end;
    
    regression = input('Please choose whether implement regression? 0-No, 1-Yes, [0]');
    if isempty(regression), regression = 0;end
    
    algorithmType = input('Please choose the type of algorithm? 1-BNMF, 2-VBNMF, 3-PCA, 4-BPCA, 5-ICA, 6-BICA, [1] ');
    if isempty(algorithmType), algorithmType = 1; end;
    
    switch algorithmType
        case 1
            [X Y] = func_data_generation(targetNumber,nodeNumber,visibilityModulation);
           [Context_prior,Track_prediction] = BNMF_coditioning(X,Y,baseNumber);
        case 2
           [X Y] = func_data_generation(targetNumber,nodeNumber,visibilityModulation);
            NMF(X,Y,baseNumber);
            
        case 3
            VBNMF;
        case 4
            [X Y] = func_data_generation(targetNumber,nodeNumber,visibilityModulation);
            PCA(X,Y,baseNumber,targetNumber);
        case 5
            [X Y] = func_data_generation(targetNumber,nodeNumber,visibilityModulation);
            BPCA(X,Y,baseNumber,targetNumber);
        case 6
            ICA;
        case 7
            BICA;
    end