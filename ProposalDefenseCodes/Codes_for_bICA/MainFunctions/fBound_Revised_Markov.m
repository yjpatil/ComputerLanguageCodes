%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [l,ind,lik] = fBound_Revised_Markov(l,gamma0,S,elogW00,elogW01,elogW10,elogW11,...
                       elog1W00,elog1W01,elog1W10,elog1W11,Delta00,Delta01,Delta10,Delta11,elogS,x,verbose,marker,ind)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 12, 
    verbose=0;
end

[T,N]=size(x);

K=length(gamma0);

% terms from Dirichlet mixing matrix
err = gammaln(sum(gamma0))-gammaln(sum(S,2)) + sum(gammaln(S),2) - sum(gammaln(gamma0))...
      - sum( (S - repmat(gamma0,T,1)) .* ( psi(S) - repmat(psi(sum(S,2)),1,K)),2 ) ;   % 1 x N

% terms from Beta sources
% *** This will be zero, becase we already know the sources %
err1 = 0;% repmat(gammaln(alpha0+beta0),1,N) - gammaln(W+W1) + gammaln(W) + gammaln(W1)...
     % - repmat(gammaln(alpha0),1,N) - repmat(gammaln(beta0),1,N)...
      % -( W - repmat(alpha0,1,N)) .* (psi(W)-psi(W+W1)) - (W1-repmat(beta0,1,N)).*(psi(W1)-psi(W+W1)); % T x K

% terms from the likelihood
%<> temp = elogS * elogW; <>%
temp00 = elogS * elogW00;
temp01 = elogS * elogW01;
temp10 = elogS * elogW10;
temp11 = elogS * elogW11;

%<> temp1 = elogS * elog1W; <>%
temp100 = elogS * elog1W00;
temp101 = elogS * elog1W01;
temp110 = elogS * elog1W10;
temp111 = elogS * elog1W11;


%<> e1 = log( x .* temp + (1-x) .* temp1 ); % <> %x.*log(max(eps,temp))+(1-x).*log(max(eps,temp1));
e1 = log(Delta00 .* temp00 + Delta01 .* temp01 + Delta10 .* temp10 + Delta11 .* temp11);
 
% <> e1 = e1./((x .* temp)+((1-x) .* temp1)); % <>
e1 = e1./((Delta00 .* temp00) + (Delta01 .* temp01) + (Delta10 .* temp10) + (Delta11 .* temp11));

% <> e1 = elogS .* ((e1.*x)*elogW') + elogS .* ((e1.*(1-x))*elog1W');       %<>  
e1 = elogS .* ((e1.*Delta00)*elogW00') + elogS .* ((e1.*Delta01)*elogW01') + elogS .* ((e1.*Delta10)*elogW10') + elogS .* ((e1.*Delta11)*elogW11');
% terms to correct for synchronisation
% elogWn=exp(psi(W)-psi(W+W1)); 
% elog1Wn=exp(psi(W1)-psi(W+W1));
% elogSn=exp(psi(S)-repmat(psi(sum(S)),K,1) );
% sync=sum(sum( (x.*( (elogW.*(log(max(eps,elogWn))-log(max(eps,elogW))))*elogS)+(1-x).*( (elog1W.*(log(max(eps,elog1Wn))-log(max(eps,elog1W))))*elogS)...
%     +x.*(elogW*(elogS.*(log(max(eps,elogSn))-log(max(eps,elogS))))) + (1-x).*(elog1W*(elogS.*(log(max(eps,elogSn))-log(max(eps,elogS)))))...
% )./((x.*temp)+((1-x).*temp1)) ));


% ========= % adding all together % ========= % 
lik = err + sum(sort(e1),2);  % both terms are 1 x N <--- Now T x 1

lik=sum(sort(lik));

lik = lik + sum(sort(sum(sort(err1')))); 

%lik=lik+sync;

lik=lik/(N*T);

l=[l lik];  


if verbose==2, 
    figure(1);hold on; plot(ind,l(end),marker,'linewidth',1);drawnow;ind=ind+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%T = 6;K = 4;
%S = rand(T,K);
%N = 100;
%W = rand(K,N);
%W1 = 1 - W;
%alpha0 = ones(K,1);
%beta0 = alpha0;
%gamma0 = ones(1,K);
%elogW = exp(psi(W) - psi(W + W1));
%elog1W = exp(psi(W1) - psi(W + W1));
%elogS = exp(psi(S) - repmat(psi(sum(S,1)),T,1) )











