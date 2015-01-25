% This is a code for HMM data which tries to find the mixing components for
% the HMM data Probabilistic Mixture p00,p01,p10,p11
% Date :: 31 Jan 2013
clc;clear all;close all;

addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bICA\MainFunctions\')

N = 1000; % # of bits in each sensor observations
Sensors = 1;

% ========================== For Target 1 =========================== %
% <> ----- A Target with high Prob of creating 1's ---- <>
Levels = 2; States = 2;
prior1 = [0,1];
transmat1 = [0.1 0.9;0.1 0.9];
obsmat1 = [0.1,0.9;0.1,0.9];

[X1] = fHMMdata(prior1,transmat1,obsmat1,N,Sensors);
StatsT1data = fCal_Stats(X1);
T1_p00 = StatsT1data(1);T1_p01 = StatsT1data(2);
T1_p10 = StatsT1data(3);T1_p11 = StatsT1data(4);
% ========================== For Target 2 =========================== %
% <> ----- A Target with low Prob of creating 1's ---- <>
Levels = 2; States = 2;
prior2 = [1,0];
transmat2 = [0.85 0.15;0.85 0.15];
obsmat2 = [0.85,0.15;0.85,0.15];

[X2] = fHMMdata(prior2,transmat2,obsmat2,N,Sensors);
StatsT2data = fCal_Stats(X2);
T2_p00 = StatsT2data(1);T2_p01 = StatsT2data(2);
T2_p10 = StatsT2data(3);T2_p11 = StatsT2data(4);
% ========================== For Target 3 =========================== %
% <> ----- A Target with Medium Prob of creating 1's ---- <>
Levels = 2; States = 2;
prior3 = [0.5,0.5];
transmat3 = [0.5 0.5;0.5 0.5];
obsmat3 = [0.5,0.5;0.5,0.5];

[X3] = fHMMdata(prior3,transmat3,obsmat3,N,Sensors);
StatsT3data = fCal_Stats(X3);
T3_p00 = StatsT3data(1);T3_p01 = StatsT3data(2);
T3_p10 = StatsT3data(3);T3_p11 = StatsT3data(4);
% X ----- X ----- X ----- X ------ X %


X = [X1;X2];
%X = [X2;X3];
%X = [X3;X1];

p = [];
verbose = 0;

ind = 1;
l = [];
tol = 1e-3;
inner_iter = 5;

% ============= CHANGES MADE BELOW ============== %
% In order to create random Probability mixture for more than two sources, 
% create a random matrix. Use the rand num and minus it from one to get a 
% value. Use this value and divide it into half. Each of the value gives
% you the mixing prob value
% e.g. rand = 0.56. Pi1 = 0.56, Pi2 =Pi3 = (1-0.56)/2
% Actually, For 3 sources :: pi1 = MixCoeff(1); pi2 = pi1 + (1-pi1)/2; 
% pi3 = 1; Pi1 = [pi1,pi2,pi3]
% Actually, For 4 sources :: pi1 = MixCoeff(1); pi2 = pi1 + (1-pi1)/3; 
% pi3 = pi2 + (1-pi1)/3;pi4 = 1; Pi1 = [pi1,pi2,pi3,pi4] and so on ... 


Nmix = 15;   % Number of randomly generated mixing e.g. 15 Mixing Coeff
MixCoeff = rand(Nmix,1); % Randomly create their distribution value

[MixData00,BernStats,Pie] = fCreateProbMixtureData(MixCoeff,X);

x = MixData00;

[T,N]=size(x);

[Delta00,Delta01,Delta10,Delta11] = fGet_deltas_mats(x); % To get the delta functions for HMM data [p00,p01,p10,p11]

% <> -------------------------- <> -------------------------- <> %

Sources = [Rho2;Rho3;Rho1];%

K = size(Sources,1);

W = repmat(Sources,1,N);  % alphas
W1 = 1 - W; % betas

W = W * mult1;
W1 = W1 * mult1;

alpha0=ones(K,1);
beta0=alpha0;
gamma0=ones(1,K);

elogW = exp(psi(W)-psi(W+W1));  % elog
elog1W = exp(psi(W1)-psi(W+W1));

S = rand(T,K)* mult2

A11 = S./max(eps,repmat(sum(S,1),T,1));

A = S ./max(eps,repmat(sum(S,2),1,K));
Aini = A

elogS = exp( psi(S) - repmat(psi(sum(S,2)),1,K) );

B = W./(W+W1);

[Stats11] = fFindBernStats(B(1),2);
[Stats22] = fFindBernStats(B(2),2);



iter = 50;
ind = 1;
l01 = [];
l = [];
tol = 1e-8;
inner_iter = 5; % seems to be enough
testing = 1;
Rec = [0,0,0];
p = [];
verbose = 1;

for i = 1 : 1 : iter    
    
   
    
    for inner=1:inner_iter
        
        elogS = exp( psi(S) - repmat(psi(sum(S,2)),1,K) ); % elog                 
        
        %S = repmat(gamma0,T,1) + elogS .* ((x./max(eps,elogS*elogW))*elogW') + elogS .* ( ((1-x)./max(eps,elogS*elog1W))*(elog1W)'); % var params     
        
        S = repmat(gamma0,T,1) + elogS .* ((Delta00./max(eps,elogS*elogW))*elogW') + elogS .* ( (Delta01./max(eps,elogS*elog1W))*(elog1W)') ...
                    + elogS .* ((Delta10./max(eps,elogS*elogW))*elogW') + elogS .* ( (Delta11./max(eps,elogS*elog1W))*(elog1W)');     
        
        [l,ind,lik] = fBound_Revised(l,alpha0,beta0,gamma0,W,W1,S,elogW,elog1W,elogS,x,verbose,'bo',ind);
        
        if (i>1) & (abs(l(end)-l(end-1))<tol), 
            break;
        end
    end
  
  
   B = (W./(W+W1));
   A = S ./max(eps,repmat(sum(S,2),1,K));
   A11 = S./max(eps,repmat(sum(S,1),T,1));


Rec(i,1) = B(1);Rec(i,2) = B(2);
Rec(i,3) = A(1);Rec(i,4) = lik;

end


% returning the posterior means
B = (W./(W+W1));
A11 = S./max(eps,repmat(sum(S,1),T,1));
A = S ./max(eps,repmat(sum(S,2),1,K));

AwithSum = [A;sum(A)]
Sources'
Pie


sum(A)
% =========================
B = W./(W+W1);

[Stats11] = fFindBernStats(B(1),2);
[Stats22] = fFindBernStats(B(2),2);





















