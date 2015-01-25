function[MixData,BernStats,Pie] = fCreateProbMixtureData(MixCoeff,X)
% X = [Source1;Source2;Source3; ... ]
% MixCoeff single rand initialized value
% Now the building MixCoeff matrix is bit different
% If size(X,1) = 2, Pi = [rand,1]
% elseif size(X,1) = 3, pi1 = MixCoeff(1); pi2 = pi1 + (1-pi1)/2; 
% pi3 = 1; Pi1 = [pi1,pi2,pi3]
% elseif size(X,1) = 4,pi1 = MixCoeff(1); pi2 = pi1 + (1-pi1)/3; 
% pi3 = pi2 + (1-pi1)/3;pi4 = 1; Pi1 = [pi1,pi2,pi3,pi4]

MixData = [];
if(size(X,1) == 2)
    
    for i = 1 : 1 : length(MixCoeff)
        
        Pi = [];TempMixData = [];
        Pi = [MixCoeff(i), 1];
        Pie(i,:) = [MixCoeff(i), 1-MixCoeff(i)];        
        
        [TempMixData,TempProbCount,TempLeg] = fCreateBernoulliMix3(Pi,X);
        [BernStats(i,:)] = fFindBernStats(TempMixData,1); 
        MixData = cat(1,MixData,TempMixData);
    end            
    
elseif(size(X,1) == 3)
    
    for i = 1 : 1 : length(MixCoeff)
        
        Pi = [];TempMixData = [];
        pi1 = MixCoeff(i); pi2 = pi1 + (1-pi1)/2;pi3 = 1; 
        Pi = [pi1,pi2,pi3];
        Pie(i,:) = [pi1,(1-pi1)/2,(1-pi1)/2];
        
        [TempMixData,TempProbCount,TempLeg] = fCreateBernoulliMix3(Pi,X);
        [BernStats(i,:)] = fFindBernStats(TempMixData,1); 
        MixData = cat(1,MixData,TempMixData);
    end
    
elseif(size(X,1) == 4)
    
    for i = 1 : 1 : length(MixCoeff)
        
        Pi = [];TempMixData = [];
        pi1 = MixCoeff(i); pi2 = pi1 + (1-pi1)/3;pi3 = pi2 + (1-pi1)/3;pi4 = 1; 
        Pi = [pi1,pi2,pi3,pi4];
        Pie(i,:) = [pi1,(1-pi1)/3,(1-pi1)/3,(1-pi1)/3];
        
        [TempMixData,TempProbCount,TempLeg] = fCreateBernoulliMix3(Pi,X);
        [BernStats(i,:)] = fFindBernStats(TempMixData,1); 
        MixData = cat(1,MixData,TempMixData);
    end
    
elseif(size(X,1) == 5)    
    
    for i = 1 : 1 : length(MixCoeff)        
        Pi = [];TempMixData = [];
        pi1 = MixCoeff(i); pi2 = pi1 + (1-pi1)/4;pi3 = pi2 + (1-pi1)/4;pi4 = pi3 + (1-pi1)/4;pi5 = 1; 
        Pi = [pi1,pi2,pi3,pi4,pi5];
        Pie(i,:) = [pi1,(1-pi1)/4,(1-pi1)/4,(1-pi1)/4,(1-pi1)/4];
        
        [TempMixData,TempProbCount,TempLeg] = fCreateBernoulliMix3(Pi,X);
        [BernStats(i,:)] = fFindBernStats(TempMixData,1); 
        MixData = cat(1,MixData,TempMixData);
    end
    
end
   
    
    

       
       
end    




