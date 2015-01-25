%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[B,A,l,S,W,W1,gamma0]=bBICA(x,K,iter,p,verbose);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variational Bayesian convex-linear factorisation for binary data.
% example call: [B,A,l,S,W,W1,gamma0]=bBICA(x,2,500,[],1); 
% Ata Kaban
% Last modified 28 August 2006
%
% OUTPUTS: W and W1: variational parameters of the binary factors
%          B: posterior mean of binary factors, computed from W and W1
%          S: variational parameters of the convex mixing proportions
%          A: posterior mean computed from S - these sum to 1
%          l: the evidence bound 
%          gamma0 = 1 (the hyperparameter for A)
% INPUTS:
%          x: the data (attributes x instances)
%          K: nr of components
%          iter: nr iterations // note less iters are needed in testing mode
%          p: use [] in training mode
%             in testing mode, p.W and p.W1 must be set the (unmodified) W & W1 obtained from training
%          verbose: \in {0,1,2}. When 0, there is no displaying during the run.
% Dependences: Tom Minka's code for computing 'digamma', downloadable from his web page is needed for running this code.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References: Ata Kaban and Ella Bingham. ICA-based Binary Feature Construction. 
%                Proc. of the 6-th International Conference on Independent Component Analysis and Blind Source Separation (ICA06). 
%                LNCS 3889. (c) Springer. Eds: J Rosca, D Erdogmus, J.C Principe, S Haykin. pp. 140-148, 2006. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load('Mix_Sig')
% x = Mix_Sig;
% K = 4;
% iter = 500;
% p = [];
% verbose = 1;

[T,N]=size(x);

if nargin<5, verbose=0;end
if nargin<4 | ~isstruct(p),
	W=rand(T,K)*30;
	W1=rand(T,K)*30;
	testing=0;
else 
    W=p.W; W1=p.W1;
    elogW=exp(digamma(W)-digamma(W+W1));  % elog
    elog1W=exp(digamma(W1)-digamma(W+W1)); % elog
    testing=1;
end

alpha0=ones(1,K);
beta0=alpha0;
gamma0=ones(K,1);

S=rand(K,N)*30;
elogS=exp(digamma(S)-repmat(digamma(sum(S)),K,1) );

ind=1;
l=[];
tol=1e-3;
inner_iter=5; % seems to be enough

for i=1:iter
  if ~testing
   for inner=1:inner_iter       
       elogW=exp(digamma(W)-digamma(W+W1));  % elog
       elog1W=exp(digamma(W1)-digamma(W+W1)); % elog
       
       W= repmat(alpha0,T,1) + elogW.*(( x ./ max(eps,elogW*elogS) )*elogS'); % var params 
       W1= repmat(beta0,T,1) + elog1W.*(( (1-x) ./ max(eps,elog1W*elogS) )*elogS');   % var params
       
       [l,ind]=bound(l,alpha0,beta0,gamma0,W,W1,S,elogW,elog1W,elogS,x,verbose,'bo',ind);
       if (i>1) & (abs(l(end)-l(end-1))<tol), 
           break;
       end
   end
  end
  
  for inner=1:inner_iter
      elogS=exp(digamma(S)-repmat(digamma(sum(S)),K,1) ); % elog     
      S = repmat(gamma0,1,N)+elogS.*(elogW'*(x./max(eps,elogW*elogS))) + elogS.*((elog1W)'*((1-x)./max(eps,elog1W*elogS))); % var params
      
      [l,ind]=bound(l,alpha0,beta0,gamma0,W,W1,S,elogW,elog1W,elogS,x,verbose,'rx',ind);
      if (i>1) & (abs(l(end)-l(end-1))<tol), break;end
  end
  
  if verbose==1,
      figure(2);
      subplot(131);plot(l);xlabel('VB-EM loops');ylabel('Log Evidence Bound');
      subplot(132);imagesc(1-S./repmat(sum(S),K,1));colormap gray; 
      xlabel('Data points');ylabel('Posterior expectation of mixing coeffs')
      subplot(133);imagesc(1-W./(W+W1));colormap gray; 
      ylabel('Data features');xlabel('Posterior expectation of components')
      drawnow;
  end
  
end
% returning the posterior means
B=W./(W+W1);
A=S./max(eps,repmat(sum(S),K,1));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [l,ind]=bound(l,alpha0,beta0,gamma0,W,W1,S,elogW,elog1W,elogS,x,verbose,marker,ind)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin < 12, verbose=0;end
[T,N]=size(x);K=length(gamma0);

% terms from Dirichlet mixing matrix
err = gammaln(sum(gamma0))-gammaln(sum(S)) + sum(gammaln(S))-sum(gammaln(gamma0))...
    -sum(   (S-repmat(gamma0,1,N)).*...
    (digamma(S)-repmat(digamma(sum(S)),K,1))   ) ;   % 1 x N

% terms from Beta sources
err1=repmat(gammaln(alpha0+beta0),T,1)-gammaln(W+W1)...
    +gammaln(W)+gammaln(W1)-repmat(gammaln(alpha0),T,1)-repmat(gammaln(beta0),T,1)...
    - (W-repmat(alpha0,T,1)).*(digamma(W)-digamma(W+W1))...
    -(W1-repmat(beta0,T,1)).*(digamma(W1)-digamma(W+W1)); % T x K

% terms from the likelihood
temp=elogW*elogS;temp1=elog1W*elogS;
e1=...  %x.*log(max(eps,temp))+(1-x).*log(max(eps,temp1));
    log( x.*temp + (1-x).*temp1 );
e1=e1./((x.*temp)+((1-x).*temp1));
e1=elogS.*(elogW'*(e1.*x)) + elogS.*(elog1W'*(e1.*(1-x)));         

% terms to correct for synchronisation
elogWn=exp(digamma(W)-digamma(W+W1)); 
elog1Wn=exp(digamma(W1)-digamma(W+W1));
elogSn=exp(digamma(S)-repmat(digamma(sum(S)),K,1) );
sync=sum(sum( (x.*( (elogW.*(log(max(eps,elogWn))-log(max(eps,elogW))))*elogS)+(1-x).*( (elog1W.*(log(max(eps,elog1Wn))-log(max(eps,elog1W))))*elogS)...
    +x.*(elogW*(elogS.*(log(max(eps,elogSn))-log(max(eps,elogS))))) + (1-x).*(elog1W*(elogS.*(log(max(eps,elogSn))-log(max(eps,elogS)))))...
    )./((x.*temp)+((1-x).*temp1)) ));

% adding all together
lik = err + sum(sort(e1));  % both terms are 1 x N
lik=sum(sort(lik));
lik=lik+sum(sort(sum(sort(err1'))));   
lik=lik+sync;
lik=lik/(N*T);
l=[l lik];  
if verbose==2, 
    figure(1);hold on; plot(ind,l(end),marker,'linewidth',1);drawnow;ind=ind+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





