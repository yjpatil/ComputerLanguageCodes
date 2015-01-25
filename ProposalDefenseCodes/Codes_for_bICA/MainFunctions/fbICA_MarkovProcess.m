function[A] = fbICA_MarkovProcess(T,N,mult1,mult2,Sources00,Sources01,Sources10,Sources11,Delta00,Delta01,Delta10,Delta11)

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
S = rand(T,K)* mult2;

A = S ./max(eps,repmat(sum(S,2),1,K));
% % Aini = A

elogS = exp( psi(S) - repmat(psi(sum(S,2)),1,K) );

% =========================
iter = 25;
inner_iter = 5;

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
        
    end 

   A = S ./max(eps,repmat(sum(S,2),1,K));     
      
end


% returning the posterior means
A = S ./max(eps,repmat(sum(S,2),1,K));

% % AwithSum = [A;sum(A)];
% % 
% % Pie
% % A
% % Tot = sum(A)
% % PieSum = sum(Pie)
% % 
% % Abs1 = find(Tot == min(Tot))
% % fprintf('\n Subject :: %d is absent \n',Abs1)
% % 
% % 
% % PerbRate




end








