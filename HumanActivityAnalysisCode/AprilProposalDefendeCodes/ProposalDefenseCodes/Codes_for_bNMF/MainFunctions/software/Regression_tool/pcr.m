function [calibVec,numOfFactor] = pcr(trSpec, trCon, numOfFactor)
%  
%Concentration Estimation of unknown test spectrum.
%  trSpec      -  [m x n] matrix of training spectra, spectra is in column vector. 
%  trCon       -  [n x 1] vector of corresponding training concentrations.       
%  testSpec    -  test spectra, can be a vector or a matrix.
%  numOfFactor -  specify the number of principle components in regression (usu. between 5-8).
%                 If unspecified, it is determined by cross-validation. 
%  calibVec    -  resulting calibration vector.



[m,n]=size(trSpec);
if (nargin == 2)
    % Determine numOfFactor by leave-one-out cross-validation
    for  i = 1:n                              
        
        [U,Sigma,V] = svd(trSpec(:,[1:i-1, i+1:n]),0);                % SVD of spectra matrix leaving #i out 
        sigma = diag(Sigma);
        
        for  factor =1:n-1                                             % # of factors included
            b = trCon([1:i-1,i+1:n])'*V(:,1:factor)*inv(Sigma(1:factor,1:factor))*U(:,1:factor)';
            
            c_est(i,factor) = b*trSpec(:,i);                              % concentration estimation
        end
    end
    %c_est = c_est.*(c_est>0);                                         % set negative values to 0
    error = c_est - trCon*ones(1,n-1);                                 % prediction error
    PRESS = sum(error.*error);                                         % Prediction error sum of squares
    RMSEP = sqrt(PRESS/n);                                             % Root mean squares error of prediction
    % figure,
    % plot(1:n-1,RMSEP,'-d'),
    % xlabel('# of factors'),ylabel('Error'),axis tight, grid on;
    [mn,mni] = min(RMSEP); 
    numOfFactor = mni(1);
%     % determine the number of factors automatically 
%     for j=1:n-1
%         if (abs((RMSEP(j+1)-RMSEP(j))/RMSEP(1))<=0.05 & j>=5)
%             if RMSEP(j+1)<RMSEP(j), numOfFactor=j+1; else numOfFactor=j; end 
%             break;
%         end    
%     end
    % fprintf('Number of principle components (numOfFactor) by cross-validation: %d\n',numOfFactor);
end

[U,Sigma,V] = svd(trSpec,0);
calibVec = trCon'*V(:,1:numOfFactor)*inv(Sigma(1:numOfFactor,1:numOfFactor))*U(:,1:numOfFactor)'; % row vec

return;

