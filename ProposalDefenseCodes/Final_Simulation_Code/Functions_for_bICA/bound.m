%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [l,ind]=bound(l,alpha0,beta0,gamma0,W,W1,S,elogW,elog1W,elogS,x,verbose,marker,ind)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin < 12 
    verbose=0;
end

[T,N]=size(x);

K=length(gamma0);

% terms from -----> Dirichlet mixing <------ matrix
err = gammaln(sum(gamma0))-gammaln(sum(S)) + sum(gammaln(S))-sum(gammaln(gamma0))...
-sum(   (S-repmat(gamma0,1,N)).*...
(digamma(S)-repmat(digamma(sum(S)),K,1))   ) ;   % 1 x N

% terms from ------> Beta <----- sources
err1 = repmat(gammaln(alpha0+beta0),T,1)-gammaln(W+W1)...
     +gammaln(W)+gammaln(W1)-repmat(gammaln(alpha0),T,1)-repmat(gammaln(beta0),T,1)...
     - (W-repmat(alpha0,T,1)).*(digamma(W)-digamma(W+W1))...
     -(W1-repmat(beta0,T,1)).*(digamma(W1)-digamma(W+W1)); % T x K

% terms from --------> likelihood <----------
temp = elogW*elogS;
temp1 = elog1W*elogS;

e1 = log( x.*temp + (1-x).*temp1 );  %x.*log(max(eps,temp))+(1-x).*log(max(eps,temp1));
              
e1 = e1./((x.*temp)+((1-x).*temp1));

e1 = elogS.*(elogW'*(e1.*x)) + elogS.*(elog1W'*(e1.*(1-x)));         

% terms to correct for ------>synchronisation<------
elogWn = exp(digamma(W)-digamma(W+W1)); 
elog1Wn = exp(digamma(W1)-digamma(W+W1));
elogSn = exp(digamma(S)-repmat(digamma(sum(S)),K,1) );

sync = sum(sum( (x.*( (elogW.*(log(max(eps,elogWn))-log(max(eps,elogW))))*elogS)+(1-x).*( (elog1W.*(log(max(eps,elog1Wn))-log(max(eps,elog1W))))*elogS)...
    +x.*(elogW*(elogS.*(log(max(eps,elogSn))-log(max(eps,elogS))))) + (1-x).*(elog1W*(elogS.*(log(max(eps,elogSn))-log(max(eps,elogS)))))...
)./((x.*temp)+((1-x).*temp1)) ));

% -------- adding all together --------
lik = err + sum(sort(e1));  % both terms are 1 x N

lik = sum(sort(lik));
  
lik = lik + sum(sort(sum(sort(err1')))); 

lik = lik + sync;

lik = lik/(N*T);

l = [l lik];  
if verbose==2, 
    figure(1);hold on; 
    plot(ind,l(end),marker,'linewidth',1);
    drawnow;
    ind=ind+1
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





end


