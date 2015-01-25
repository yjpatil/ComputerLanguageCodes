% ======================================================================= %

%              Code for finding the unknown mixture coefficients

% ======================================================================= %
clc;clear all;close all;

addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\September2013\Test_Codes\Test_bICA_diGamma');
%addpath('C:\Users\Yuri\Dropbox\DrBobHaoResearch\Codes\September2013\Test_Codes\Test_bICA_diGamma');


% ----------------------- Initialization ------------------------------- %
mult1 = 1000;mult2 = 1000;
Rho1 = 0.2;Rho2 = 0.8;Rho3 = 0.7;
X1 = rand(1,10000) > (1-Rho1);
X2 = rand(1,10000) > (1-Rho2);

[X1Stats,p1,q1] = fFindBernStats2(X1,1);    
[X2Stats,p2,q2] = fFindBernStats2(X2,1);    

X = [X1;X2];


% % K = 2;
p = [];
verbose = 0;

ind = 1;
l = [];
tol = 1e-3;
inner_iter = 5;
% ============= CHANGES MADE BELOW ============== %
% ----------------Original
% Pi = [0.5,1] 
% [MixData,Leg3] = fCreateBernoulliMix2(Pi,X);
% [BernStats] = fFindBernStats(MixData,1);
% --------------------- Original --------------------- %

Nmix = 15;   % Number of randomly generated mixing 
MixCoeff = rand(Nmix,1);

%Pi1 = [0.23, 1]; 
% Pi1 = [0.1, 1];
Pi1 = [MixCoeff(1), 1];
[MixData1,ProbCount1,Leg111] = fCreateBernoulliMix3(Pi1,X);
[BernStats1] = fFindBernStats(MixData1,1);

%Pi2 = [0.25, 1];
%Pi2 = [0.2, 1];
Pi2 = [MixCoeff(2), 1];
[MixData2,ProbCount2,Leg222] = fCreateBernoulliMix3(Pi2,X);
[BernStats2] = fFindBernStats(MixData2,1);

%Pi3 = [0.2, 1]; 
%Pi3 = [0.3, 1]; 
Pi3 = [MixCoeff(3), 1];
[MixData3,ProbCount3,Leg333] = fCreateBernoulliMix3(Pi3,X);
[BernStats3] = fFindBernStats(MixData3,1);

%Pi4 = [0.18, 1]; 
%Pi4 = [0.4, 1]; 
Pi4 = [MixCoeff(4), 1];
[MixData4,ProbCount4,Leg444] = fCreateBernoulliMix3(Pi4,X);
[BernStats4] = fFindBernStats(MixData4,1);

%Pi5 = [0.88, 1]; 
% Pi5 = [0.5, 1]; 
Pi5 = [MixCoeff(5), 1];
[MixData5,ProbCount5,Leg555] = fCreateBernoulliMix3(Pi5,X);
[BernStats5] = fFindBernStats(MixData5,1);

%Pi6 = [0.87, 1]; 
% Pi6 = [0.6, 1]; 
Pi6 = [MixCoeff(6), 1];
[MixData6,ProbCount6,Leg666] = fCreateBernoulliMix3(Pi6,X);
[BernStats6] = fFindBernStats(MixData6,1);

%Pi7 = [0.83, 1]; 
%Pi7 = [0.7, 1]; 
Pi7 = [MixCoeff(7), 1];
[MixData7,ProbCount7,Leg777] = fCreateBernoulliMix3(Pi7,X);
[BernStats7] = fFindBernStats(MixData7,1);

%Pi8 = [0.8, 1]; 
%Pi8 = [0.8, 1];
Pi8 = [MixCoeff(8), 1];
[MixData8,ProbCount8,Leg888] = fCreateBernoulliMix3(Pi8,X);
[BernStats8] = fFindBernStats(MixData8,1);

%Pi9 = [0.89, 1]; 
%Pi9 = [0.9, 1]; 
Pi9 = [MixCoeff(9), 1];
[MixData9,ProbCount9,Leg999] = fCreateBernoulliMix3(Pi9,X);
[BernStats9] = fFindBernStats(MixData9,1);

%Pi10 = [0.15, 1]; 
% Pi10 = [0.45, 1]; 
Pi10 = [MixCoeff(10), 1];
[MixData10,ProbCount10,Leg1010] = fCreateBernoulliMix3(Pi10,X);
[BernStats10] = fFindBernStats(MixData10,1);

%Pi11 = [0.29, 1]; 
%Pi11 = [0.59, 1]; 
Pi11 = [MixCoeff(11), 1];
[MixData11,ProbCount11,Leg1011] = fCreateBernoulliMix3(Pi11,X);
[BernStats11] = fFindBernStats(MixData11,1);

Pi12 = [MixCoeff(12), 1];
[MixData12,ProbCount12,Leg1212] = fCreateBernoulliMix3(Pi12,X);
[BernStats12] = fFindBernStats(MixData12,1);

Pi13 = [MixCoeff(13), 1];
[MixData13,ProbCount13,Leg1313] = fCreateBernoulliMix3(Pi13,X);
[BernStats13] = fFindBernStats(MixData13,1);

Pi14 = [MixCoeff(14), 1];
[MixData14,ProbCount14,Leg1414] = fCreateBernoulliMix3(Pi14,X);
[BernStats14] = fFindBernStats(MixData14,1);

Pi15 = [MixCoeff(15), 1];
[MixData15,ProbCount15,Leg1515] = fCreateBernoulliMix3(Pi15,X);
[BernStats15] = fFindBernStats(MixData15,1);

MixData = [MixData1;MixData2;MixData3;MixData4;MixData5;MixData6;MixData7;MixData8;MixData9;MixData10;...
           MixData11;MixData12;MixData13;MixData14;MixData15];

x = MixData;

[T,N]=size(x);

figure(111)
Leg11 = plot3(X1Stats(1,1),X1Stats(1,2),X1Stats(1,3),'bx','Linewidth',2.0);hold on;grid on;
Leg12 = plot3(X2Stats(1,1),X2Stats(1,2),X2Stats(1,3),'rx','Linewidth',2.0);
Leg13 = plot3(BernStats1(1,1),BernStats1(1,2),BernStats1(1,3),'kx','Linewidth',2.0);

xlabel('P00');ylabel('P01');zlabel('P10');
xlim([0 1]);ylim([0 1]);zlim([0 1]);%title('ORed Mix Bern Data');

% ----------------------------------------------------------------------- %



%Rho4 = 0.7;
Sources = [Rho1;Rho2;Rho3];%;Rho4];
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
%S = rand(T,K)* 0

A11 = S./max(eps,repmat(sum(S,1),T,1))
A = S ./max(eps,repmat(sum(S,2),1,K))
Aini = A

elogS = exp( psi(S) - repmat(psi(sum(S,2)),1,K) );
%elogS = exp( psi(S) - repmat(psi(sum(S,1)),T,1) );
% =========================
figure(111);gcf;
B = W./(W+W1);

[Stats11] = fFindBernStats(B(1),2);
[Stats22] = fFindBernStats(B(2),2);

% plot3(Stats11(1,1),Stats11(1,2),Stats11(1,3),'bx','Linewidth',1);hold on;grid on;
% plot3(Stats22(1,1),Stats22(1,2),Stats22(1,3),'rx','Linewidth',1);


% xlabel('P00');ylabel('P01');zlabel('P10');
% xlim([0 1]);ylim([0 1]);zlim([0 1]);%title('Bern Mix Bern Data');
% =========================


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
    
    if ~testing 
        for inner=1:inner_iter
            
            elogW = exp(psi(W)-psi(W+W1));  % elog
            elog1W = exp(psi(W1)-psi(W+W1)); % elog
            
            W = repmat(alpha0,1,N) + elogW .* ( elogS' * ( x ./ max(eps,elogS*elogW) ) ); % var params 
            W1 = repmat(beta0,1,N) + elog1W .* ( elogS' * ( (1-x)./ max(eps,elogS*elogW) ) );   % var params
            
            %W = repmat(alpha0,1,N) + elogW .* ( S' * ( x ./ max(eps,S*elogW) ) ); % var params 
            %W1 = repmat(beta0,1,N) + elog1W .* ( S' * ( (1-x)./ max(eps,S*elogW) ) );   % var params
            
            [l,ind,lik] = fBound_Revised(l,alpha0,beta0,gamma0,W,W1,S,elogW,elog1W,elogS,x,verbose,'bo',ind);
            
            if (i>1) & (abs(l(end)-l(end-1))<tol), 
                break;
            end
        end
    end
    
    for inner=1:inner_iter
        
        elogS = exp( psi(S) - repmat(psi(sum(S,2)),1,K) ); % elog     
        %elogS = exp( psi(S) - repmat(psi(sum(S,1)),T,1) ); % elog     
        
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
A11 = S./max(eps,repmat(sum(S,1),T,1))
A = S ./max(eps,repmat(sum(S,2),1,K))
AwithSum = [A;sum(A)]

Pi = [Pi1(1), 1-Pi1(1);Pi2(1),1-Pi2(1);Pi3(1),1-Pi3(1);Pi4(1),1-Pi4(1);Pi5(1),1-Pi5(1);...
      Pi6(1),1-Pi6(1);Pi7(1),1-Pi7(1);Pi8(1),1-Pi8(1);Pi9(1),1-Pi9(1);Pi10(1),1-Pi10(1);...
      Pi11(1),1-Pi11(1);Pi12(1),1-Pi12(1);Pi13(1),1-Pi13(1);Pi14(1),1-Pi15(1);Pi15(1),1-Pi15(1)]

[ProbCount1;ProbCount2;ProbCount3;ProbCount4;ProbCount5;ProbCount6;...
    ProbCount7;ProbCount8;ProbCount9;ProbCount10;ProbCount11];

Sources'

sum(A)
% =========================
figure(111);gcf;
B = W./(W+W1);

[Stats11] = fFindBernStats(B(1),2);
[Stats22] = fFindBernStats(B(2),2);
Leg14 = plot3(Stats11(1,1),Stats11(1,2),Stats11(1,3),'bo','Linewidth',2);hold on;grid on;   
Leg15 = plot3(Stats22(1,1),Stats22(1,2),Stats22(1,3),'ro','Linewidth',2);

legend([Leg11 Leg12 Leg13 Leg14 Leg15],{'x1' 'x2' 'mix(x1,x2)' 'est(x1)' 'est(x2)' })


figure(333)
Leg1 = plot3(Rec(length(Rec),1),Rec(length(Rec),3),Rec(length(Rec),4),'cx','Linewidth',1.0);hold on;grid on;
figure(334)
Leg2 = plot3(Rec(length(Rec),1),Rec(length(Rec),3),Rec(length(Rec),4),'cx','Linewidth',1.0);hold on;grid on;


% ============ Now find the optimal loglikelihood ================ %
% alpha0 = [p1,p2];
% beta0 = 1 - alpha0;
% gamma0 = [Pi1(1), 1 - Pi1(1)];        
% 
% %W = alpha0;W1 = beta0;
% W = [p1,p2] * mult1;
% W1 = (1 - alpha0) * mult1;        
% 
% elogW = exp( psi(W) - psi(W+W1) );
% elog1W = exp( psi(W1) - psi(W+W1) );                        
% 
% S = [Pi1(1), 1 - Pi1(1)] * mult2; 
% 
% elogS = exp(psi(S) - repmat(psi(sum(S)),1,K) );                            
% 
% [l,ind,lik] = fBound_Contour(l,alpha0,beta0,gamma0,W,W1,S,elogW,elog1W,elogS,x,verbose,'bo',ind);
% 
% 
% B = (W./(W+W1))
% A = S ./max(eps,sum(S))
% 
% figure(333)
% Leg3 = plot3(B(1),A(1),lik,'mx','Linewidth',1.0);hold on;grid on;
% legend([Leg1 Leg3],{'Estimated' 'Optimal'})
% figure(334)
% Leg4 = plot3(B(1),A(1),lik,'mx','Linewidth',1.0);hold on;grid on;
% 
% legend([Leg2 Leg4],{'Estimated' 'Optimal'})
% 
% 



