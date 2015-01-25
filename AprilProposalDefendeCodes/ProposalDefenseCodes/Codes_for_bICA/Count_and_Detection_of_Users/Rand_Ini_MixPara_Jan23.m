% ======================================================================= %
%
%              Code for finding the unknown mixture coefficients
%
% ======================================================================= %
clc;clear all;close all;

addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bICA\MainFunctions');


% ----------------------- Initialization ------------------------------- %
mult1 = 100;mult2 = 100;

Rho1 = 0.1;Rho2 = 0.3;Rho3 = 0.5;Rho4 = 0.8;

X1orig = rand(1,10000) > (1-Rho1);
X2orig = rand(1,10000) > (1-Rho2);
X3orig = rand(1,10000) > (1-Rho3);
X4orig = rand(1,10000) > (1-Rho4);

[X1origStats,p1,q1] = fFindBernStats2(X1orig,1);    
[X2origStats,p2,q2] = fFindBernStats2(X2orig,1);
[X3origStats,p3,q3] = fFindBernStats2(X3orig,1);
[X4origStats,p4,q4] = fFindBernStats2(X4orig,1);

PerbRate = 29; % <>-------- Perturbation Rate % of bits flipping <>||
NoPerbRate = 0;

[X1] = fperturb01(X1orig,PerbRate);
[X2] = fperturb01(X2orig,PerbRate);
[X3] = fperturb01(X3orig,NoPerbRate);
[X4] = fperturb01(X4orig,NoPerbRate);

[X1Stats,p1,q1] = fFindBernStats2(X1,1);% [Signal,Pertubation Rate]    
[X2Stats,p2,q2] = fFindBernStats2(X2,1);% [Signal,Pertubation Rate]    
[X3Stats,p3,q3] = fFindBernStats2(X3,1);% [Signal,Pertubation Rate]    
[X4Stats,p4,q4] = fFindBernStats2(X4,1);% [Signal,Pertubation Rate]
% <> ----- <> 
%X = [X1;X2];
X = [X1;X2];
%X = [X1;X3];

%Sources = [Rho1;Rho2;Rho3];
Sources = [Rho1;Rho2;Rho3];
%Sources = [Rho1;Rho3;Rho2];
% <> ----- <> 

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

% ----------------------------------------------------------------------- %


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
%elogS = exp( psi(S) - repmat(psi(sum(S,1)),T,1) );
% =========================
%figure(111);gcf;
B = W./(W+W1);

[Stats11] = fFindBernStats(B(1),2);
[Stats22] = fFindBernStats(B(2),2);

% plot3(Stats11(1,1),Stats11(1,2),Stats11(1,3),'bx','Linewidth',1);hold on;grid on;% plot3(Stats22(1,1),Stats22(1,2),Stats22(1,3),'rx','Linewidth',1);
% xlabel('P00');ylabel('P01');zlabel('P10');xlim([0 1]);ylim([0 1]);zlim([0 1]);%title('Bern Mix Bern Data');
% =========================

iter = 25;
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
        
        S = repmat(gamma0,T,1) + elogS .* ((x./max(eps,elogS*elogW))*elogW') + elogS .* ( ((1-x)./max(eps,elogS*elog1W))*(elog1W)'); % var params     
        
        [l,ind,lik] = fBound_Revised(l,alpha0,beta0,gamma0,W,W1,S,elogW,elog1W,elogS,x,verbose,'bo',ind);
        
        if (i>1) & (abs(l(end)-l(end-1))<tol), 
            break;
        end
    end
  
  if verbose==1,
      figure(222)
      plot(l);xlabel('VB-EM loops');ylabel('Log Evidence Bound');grid on;hold on;
%       figure(2);
%       subplot(131);plot(l01);xlabel('VB-EM loops');ylabel('Log Evidence Bound');
%       subplot(132);imagesc(1-S./repmat(sum(S),K,1));colormap gray; 
%       xlabel('Data points');ylabel('Posterior expectation of mixing coeffs')
%       subplot(133);imagesc(1-W./(W+W1));colormap gray; 
%       ylabel('Data features');xlabel('Posterior expectation of components')
%       drawnow;
  end
  % =========================
%    figure(111);gcf;
   B = (W./(W+W1));
   A = S ./max(eps,repmat(sum(S,2),1,K));
   A11 = S./max(eps,repmat(sum(S,1),T,1));
%    [Stats11] = fFindBernStats(B(1),2);
%    [Stats22] = fFindBernStats(B(2),2);
%    plot3(Stats11(1,1),Stats11(1,2),Stats11(1,3),'bx','Linewidth',1);hold on;grid on;   
%    plot3(Stats22(1,1),Stats22(1,2),Stats22(1,3),'rx','Linewidth',1);
%    % =========================

Rec(i,1) = B(1);Rec(i,2) = B(2);
Rec(i,3) = A(1);Rec(i,4) = lik;
% 
% figure(333)
% plot3(Rec(i,1),Rec(i,2),Rec(i,3),'cx','Linewidth',1.0);hold on;grid on;
% figure(334)
% plot3(Rec(i,1),Rec(i,2),Rec(i,3),'cx','Linewidth',1.0);hold on;grid on;

end


% returning the posterior means
B = (W./(W+W1));
A11 = S./max(eps,repmat(sum(S,1),T,1));
A = S ./max(eps,repmat(sum(S,2),1,K));

AwithSum = [A;sum(A)];
Pie
Sources'

Tot = sum(A)
Abs1 = find(Tot == min(Tot))
fprintf('\n Subject :: %d is absent \n',Abs1)

% % ========================= %
%figure(111);gcf;
B = W./(W+W1);

[Stats11] = fFindBernStats(B(1),2);
[Stats22] = fFindBernStats(B(2),2);

PerbRate




















