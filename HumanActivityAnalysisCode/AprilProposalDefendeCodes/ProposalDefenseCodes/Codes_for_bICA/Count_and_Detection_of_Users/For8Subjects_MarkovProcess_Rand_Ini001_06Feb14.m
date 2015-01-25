% ---------------------- <> <> <> <> <> <> ------------------------------ %
%
%
% ---------------------- <> <> <> <> <> <> ------------------------------ %
clc;clear all;close all;

% Accuracy1 = [84.21];Accuracy2 = [94.73];Accuracy3 = [88.89];Accuracy4 = [85];Accuracy = [84.21,94.73,88.88,85];
% figure(111);hold on;title('Recognition Rate vs Different Cases');xlabel('Different Subjects Combination');ylabel('Recognition Rate');
% L1 = bar(1,Accuracy1,.3,'r');L2 = bar(2,Accuracy2,.3,'b');L3 = bar(3,Accuracy3,.3,'k');L4 = bar(4,Accuracy4,.3,'m')
% legend([L1 L2 L3 L4],{'Sub2,3,4,5 present' 'Sub1,2,3 present' 'Sub1,3,4 present' 'Sub1,2,3,4,5 present 6 absent'});ylim([0,100])

addpath('C:\Users\student\Dropbox\DrBobHaoResearch\Codes\ProposalDefenseCodes\Codes_for_bICA\MainFunctions\')

mult1 = 500;mult2 = 500;
N = 10000;  % Number of Observations
MaxSensors = 1;  % Total number of Maximum Sensors

%[Data1,Data2,Data3,Data4,Data5,Data6,StatsData1,StatsData2,StatsData3,StatsData4,StatsData5,StatsData6] = fCreate_4Sub_MarkovPData(N,MaxSensors);
[Data1,Data2,Data3,Data4,Data5,Data6,Data7,Data8,StatsData11,StatsData22,StatsData33,StatsData44,StatsData55,StatsData66,StatsData77,StatsData88] = fCreate_4Sub_MarkovPData02(N,MaxSensors);

X1orig = Data8; % ---(1) Medium-Small 1's --- %
X2orig = Data3; % ---(2) Largest 1's --- %
X3orig = Data6; % ---(3) Very Small 1's --- %
X4orig = Data7; % ---(4) Medium-Large 1's --- %
X5orig = Data4; % ---(5) Medium 1's --- %

X6orig = Data5; % ---(6) Small-Medium 1's --- %
X7orig = Data1; % ---(7) Larger 1's --- %

X8orig = Data2; % ---(8) Almost Very Small 1's --- %

StatsData1 = StatsData88;    
StatsData2 = StatsData33;
StatsData3 = StatsData66;
StatsData4 = StatsData77;
StatsData5 = StatsData44;

StatsData6 = StatsData55;
StatsData7 = StatsData11;

StatsData8 = StatsData22;

PerbRate = 20; % <>-------- Perturbation Rate % of bits flipping <>||
NoPerbRate = 0;

[X1] = fperturb01(X1orig,PerbRate);
[X2] = fperturb01(X2orig,PerbRate);
[X3] = fperturb01(X3orig,PerbRate);
[X4] = fperturb01(X4orig,PerbRate);
[X5] = fperturb01(X5orig,PerbRate);

[X6] = fperturb01(X6orig,PerbRate);
[X7] = fperturb01(X7orig,PerbRate);

[X8] = fperturb01(X8orig,PerbRate);

[X1Stats,p1,q1] = fFindBernStats2(X1,1);% [Signal,Pertubation Rate]    
[X2Stats,p2,q2] = fFindBernStats2(X2,1);% [Signal,Pertubation Rate]    
[X3Stats,p3,q3] = fFindBernStats2(X3,1);% [Signal,Pertubation Rate]    
[X4Stats,p4,q4] = fFindBernStats2(X4,1);
[X5Stats,p5,q5] = fFindBernStats2(X5,1);

[X6Stats,p6,q6] = fFindBernStats2(X6,1);
[X7Stats,p7,q7] = fFindBernStats2(X7,1);

[X8Stats,p8,q8] = fFindBernStats2(X8,1);

% <> ----- <> 
X = [X1;X2];  % <>------------------ Which Sources are present <>
Sources00 = [StatsData1(1);StatsData2(1);StatsData5(1)];
Sources01 = [StatsData1(2);StatsData2(2);StatsData5(2)];
Sources10 = [StatsData1(3);StatsData2(3);StatsData5(3)];
Sources11 = [StatsData1(4);StatsData2(4);StatsData5(4)];

% % <> ----- <> 
% X = [X4;X2;X3;X1];  % <>------------------ Which Sources are present <>
% Sources00 = [StatsData2(1);StatsData4(1);StatsData3(1);StatsData1(1);StatsData5(1)];
% Sources01 = [StatsData2(2);StatsData4(2);StatsData3(2);StatsData1(2);StatsData5(2)];
% Sources10 = [StatsData2(3);StatsData4(3);StatsData3(3);StatsData1(3);StatsData5(3)];
% Sources11 = [StatsData2(4);StatsData4(4);StatsData3(4);StatsData1(4);StatsData5(4)];
% <> ----------------- <> ------------------ <> %

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
Nmix = 40;   % Number of randomly generated mixing e.g. 15 Mixing Coeff
% min1 = 0.01;max1 = 0.99;
% diff = max1 - min1;
% m1 = diff/Nmix;
% o1 = ones(Nmix,1);
% o1 = m1 * o1;
% 
% MixCoeff = cumsum(o1); % Randomly create their distribution value

MixCoeff = rand(Nmix,1); % Randomly create their distribution value

[MixData00,BernStats,Pie] = fCreateProbMixtureData(MixCoeff,X);

x = MixData00;

[T,N]=size(x);

[Delta00,Delta01,Delta10,Delta11] = fGet_deltas_mats(x); % To get the delta functions for HMM data [p00,p01,p10,p11]
% ----------------------------------------------------------------------- %
K = size(Sources00,1);

%%% W = repmat(Sources,1,N);  % alphas
%%% W1 = 1 - W; % betas
W00 = repmat(Sources00,1,N);W100 = 1 - W00;  % alphas
W01 = repmat(Sources01,1,N);W101 = 1 - W01;  % alphas
W10 = repmat(Sources10,1,N);W110 = 1 - W10;  % alphas
W11 = repmat(Sources11,1,N);W111 = 1 - W11;  % alphas
%%% W = W * mult1;
%%% W1 = W1 * mult1;
W00 = W00 * mult1;W100 = W100 * mult1;
W01 = W01 * mult1;W101 = W101 * mult1;
W10 = W10 * mult1;W110 = W110 * mult1;
W11 = W11 * mult1;W111 = W111 * mult1;
%%% 
alpha0 = ones(K,1);
beta0 = alpha0;
gamma0 = ones(1,K);
% <><> ------------------------------------------------------------- <><> %
%%% elogW = exp(psi(W)-psi(W+W1));  % elog
elogW00 = exp(psi(W00) - psi(W00+W01+W10+W11));
elogW01 = exp(psi(W01) - psi(W00+W01+W10+W11));
elogW10 = exp(psi(W10) - psi(W00+W01+W10+W11));
elogW11 = exp(psi(W11) - psi(W00+W01+W10+W11));
%%%elog1W = exp(psi(W1)-psi(W+W1));
elog1W00 = exp(psi(W100)-psi(W00+W01+W10+W11));
elog1W01 = exp(psi(W101)-psi(W00+W01+W10+W11));
elog1W10 = exp(psi(W110)-psi(W00+W01+W10+W11));
elog1W11 = exp(psi(W111)-psi(W00+W01+W10+W11));
% <><> ------------------------------------------------------------- <><> %
S = rand(T,K)* mult2

A = S ./max(eps,repmat(sum(S,2),1,K));
Aini = A

elogS = exp( psi(S) - repmat(psi(sum(S,2)),1,K) );
%elogS = exp( psi(S) - repmat(psi(sum(S,1)),T,1) );

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
        
        %S = repmat(gamma0,T,1) + elogS .* ((x./max(eps,elogS*elogW))*elogW') + elogS .* ( ((1-x)./max(eps,elogS*elog1W))*(elog1W)'); % var params     
        
        S = repmat(gamma0,T,1) + elogS .* ((Delta00./max(eps,elogS*elogW00))*elogW00') + elogS .* ( (Delta01./max(eps,elogS*elogW01))*(elogW01)')...
                               + elogS .* ((Delta10./max(eps,elogS*elogW10))*elogW10') + elogS .* ( (Delta11./max(eps,elogS*elogW11))*(elogW11)'); % var params     
        S00 = elogS .* ((Delta00./max(eps,elogS*elogW00))*elogW00');
        S01 = elogS .* ((Delta01./max(eps,elogS*elogW01))*elogW01');
        S10 = elogS .* ((Delta10./max(eps,elogS*elogW10))*elogW10');
        S11 = elogS .* ((Delta11./max(eps,elogS*elogW11))*elogW11');
        %[l,ind,lik] = fBound_Revised(l,alpha0,beta0,gamma0,W,W1,S,elogW,elog1W,elogS,x,verbose,'bo',ind);
        
%         if (i>1) & (abs(l(end)-l(end-1))<tol), 
%             break;
%         end
    end
  
%   if verbose==1,
%       figure(222)
%       plot(l);xlabel('VB-EM loops');ylabel('Log Evidence Bound');grid on;hold on;
% %       figure(2);
% %       subplot(131);plot(l01);xlabel('VB-EM loops');ylabel('Log Evidence Bound');
% %       subplot(132);imagesc(1-S./repmat(sum(S),K,1));colormap gray; 
% %       xlabel('Data points');ylabel('Posterior expectation of mixing coeffs')
% %       subplot(133);imagesc(1-W./(W+W1));colormap gray; 
% %       ylabel('Data features');xlabel('Posterior expectation of components')
% %       drawnow;
%   end
  % =========================
   A = S ./max(eps,repmat(sum(S,2),1,K));     
   
   
end


% returning the posterior means
A = S ./max(eps,repmat(sum(S,2),1,K));

AwithSum = [A;sum(A)];
% Pie
% Sources'


% S00
% S01
% S10
% S11
Pie
A
Tot = sum(A)
PieSum = sum(Pie)

Abs1 = find(Tot == min(Tot))
fprintf('\n Subject :: %d is absent \n',Abs1)

% Abs1 = find(Tot < 1.1)
% if(isempty(Abs1))   
%     fprintf('\n All Subjects are Present\n');
% elseif(~isempty(Abs1))
%     fprintf('\n Subject :: %d is absent \n',Abs1)
% end
PerbRate
% StatsData1
% StatsData2
% StatsData3






























