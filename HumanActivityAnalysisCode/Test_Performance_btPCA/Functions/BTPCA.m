function [LogL,MoFA,qcn] = BTPCA(X,L,C,ti,dia,model)
% [LogL,mfa,qcn] = BTPCA(X,L,C,dia,model);
%
%Implementation of the:
% "Transformation invariant component analysis for binary images"
% Z. Zivkovic and J.J. Verbeek
% IEEE Conference on Computer Vision and Pattern Recognition, 2006.
%
%Input:
% X         : data matrix (N data points in D dimensions as columns)
% L         : latent dimensionality
% C         : number of mixture components
% ti        : transformation invariant (integrate over all possible 2D image
%             shifts) if 1 (default=0)
% model     : supply a model - this model will be used as
%             a starting point for the EM iterations.
% dia       : verbosity. 0=no output (default), 1=log-likelihood monitoring, 2=posterior
%             plotting, 3=show images(only for the image data)
%
%Output:
% LogL  : row vector of log-likelihoods after each EM iteration
% MoFA  : structure containing the Mixture of BPCAs
%         MoFA.W (D x L x C) : factor loading matrices
%         MoFA.M (D x C)     : component means
%         MoFA.mix ( C x 1 ) : mixing weights
%         MoFA.U (L x N x C) : inferred latent coordinates for the data
% qcn   : C x N matrix of component posterior probabilities
%
%Example:
% >>load walk;%loads the segmented walk sequence
% >>[LogL,MoFA]=BTPCA(x,1,1,1,3);
% >>figure,plot(MoFA.U);%plot the inferred latent coordinates
%
% Author: Zoran Zivkovic (based on the factor analysis code from Jakob Verbeek)
% http://www.zoranz.net
% Intelligent Systems Laboratory Amsterdam, University of Amsterdam.
% Date: 12-6-2006

epsilon       = 1e-3;                                     % relative log-likelihood increase threshold for convergence
max_iters     = 30;                                       % maximum number of EM iterations
min_iters     = 5;                                        % minimum number of EM iterations
mean_iters    = 5;                                        % a few first iterations where only means are used

%%%%%%%%%%%%%%%%%%%%%%%
%handle options, data types etc...
%%%%%%%%%%%%%%%%%%%%%%%
[D,N]         = size(X);
%handle image data, precompute ffts and reseve memory
if (ndims(X)==3); img=1;else;img=0;end;
if exist('model'); if size(model.W,1)~=D;if size(model.W,1)==N*D;img=1;else;disp('data dimension error');end;end;end;
if img;[nHeight,nWidth,N]=size(X);D=[nHeight*nWidth];
    if ti; 
        Xfft   = zeros(nHeight,nWidth,N);conjXfft = zeros(nHeight,nWidth,N);
        for t = 1:N;Xfft(:,:,t)   = fft2(X(:,:,t));conjXfft(:,:,t) = conj(Xfft(:,:,t));end;
    end
    X=reshape(X,[],N);%make flat
end
if ~exist('dia');dia=0;end;
if dia
    fprintf('--> running EM for BPCA\n');
	fprintf('    mixture components: %d\n',C);
	fprintf('    latent dimensions : %d\n',L);
	fprintf('    data: %d points in %d dimensions\n',N,D);
    if exist('model'); fprintf('    initial model supplied\n');end;
    if ti;  fprintf('    integrating over data shifts\n');end
end

% --------   Initialisation
if exist('model');
    %init from a given model
    MoFA=model;model=1;
else
    model=0;
    MoFA.mix   = ones (C,1)/C;                                          % mixing weights
    MoFA.M     = randperm(N); MoFA.M     = X(:,MoFA.M(1:C));            % means
    %MoFA.M     = X(:,1:C);% means
    %MoFA.M     = mean(X,2);
    MoFA.M     = (MoFA.M-0.5)*0.1;
    MoFA.W     = 1e-4*randn(D,L,C);                                     % factor loadings
    MoFA.U     = 1e-4*randn(L,N,C);                                     % random coefficients
end;

%precompute some additional variables and reserve memory
if ~ti;X2=2*X-1;end;
LLcn = zeros(C,N);
T=zeros(D,N,C);
Xe=zeros(D,N,C);
qcn = ones(C,N)/C;

if (dia>=3) figure(2),showMoFAImages(MoFA,nHeight,nWidth);end;

tic
for iter=1:max_iters; % EM loops
    if iter<=mean_iters; means_only=1;else;means_only=0;end;%flag to use just means
    %%%%%%%
    % BPCA
    %%%%%%%
    if ~ti
        %E step: compute likelihood and the bound
        for c = 1:C
            if means_only
                T(:,:,c)    = MoFA.M(:,c)*ones(1,N);
            else
                T(:,:,c)    = MoFA.W(:,:,c)*MoFA.U(:,:,c) + MoFA.M(:,c)*ones(1,N);%no of operations: c*[N*D*L]
            end
        
            LLcn(c,:) = sum( X.*T(:,:,c) - log(1+exp(T(:,:,c)))  , 1 );%no of operations: c*[N*D]
        end

        %add class membership priors
        LLcn = LLcn + log(MoFA.mix+realmin)*ones(1,N);
        %compute posterior class probability 
        qcn    = LLcn - repmat(max(LLcn,[],1),C,1);
        qcn    = exp(qcn)+realmin;
        qcn    = qcn ./ repmat(sum(qcn,1),C,1);
        LLn    = sum(qcn.*(-log(qcn+realmin) + LLcn),1);%this follows from the tight lower bound qc*log(pc*Pc/qc)      
        
        LogL(iter) = sum(LLn);

        %M step
        [MoFA]=bpca_Mstep(MoFA,X,X2,qcn,tanh(T/2) ./ T,means_only,0);       
    end
    %%%%%%%
    % shift invariant BPCA
    %%%%%%%
    if ti
        %E step: compute likelihood and the bound
        for c=1:C;
            if means_only
                T(:,:,c)    = MoFA.M(:,c)*ones(1,N);
            else
                T(:,:,c)    = MoFA.W(:,:,c)*MoFA.U(:,:,c) + MoFA.M(:,c)*ones(1,N);%no of operations: c*[N*D*d]
            end
        end
        %go over images and t's
        for iImage=1:N
            LLcnt=zeros(D,C);
            for c=1:C;
                energy = real(ifft2(fft2(reshape(T(:,iImage,c),nHeight,nWidth))...
                    .* conjXfft(:,:,iImage)));%+log(pt);                
                qtn_c = energy-max(max(energy));
                qtn_c = exp(qtn_c);%+realmin;
                qtn_c = qtn_c/sum(sum(qtn_c));%normalize
                qtn_cfft=fft2(qtn_c);
                %Expected transformed data
                Xe(:,iImage,c)=reshape(real(ifft2((qtn_cfft.* Xfft(:,:,iImage)))),[],1);
                
                %add class membership priors + ...
                LLcnt(:,c)=energy(:)+log(MoFA.mix(c)+realmin)*ones(D,1)...
                    - sum(log(1+exp(T(:,iImage,c))));
            end
            %compute posterior class probability 
            qtnc = LLcnt-max(max(LLcnt));
            qtnc = exp(qtnc);%+realmin;
            qtnc = qtnc/sum(sum(qtnc));%normalize
            qcn(:,iImage)  = sum(qtnc,1)';
            LLn(iImage) = sum(sum(qtnc.*(-log(qtnc+realmin) + LLcnt),1));%this follows from the tight lower bound qc*log(pc*Pc/qc)
        end
        
        LogL(iter) = sum(LLn);
        
        %M step
        [MoFA]=bpca_Mstep(MoFA,Xe,2*Xe-1,qcn,tanh(T/2) ./ T,means_only,0);
    end
       
    %show
    if iter > 1;
        rel_change = (LogL(end)-LogL(end-1)) / abs(mean(LogL(end-1:end)));
        if rel_change < 0; fprintf('--> Log likelihood decreased in iteration %d,  relative change %f\n',iter,rel_change);end
        if dia; fprintf('iteration %3d   Logl %.2f  relative increment  %.6f\n',iter, LogL(end),rel_change);end
        if (rel_change < epsilon) & (iter > min_iters); break;end
    end
    if dia>1; figure(1);clf;set(gcf,'Double','on');image(255*qcn);xlabel('data point index');ylabel('mixture component index');set(gca,'ytick',1:C);colormap gray;colorbar;title('Posterior distributions on mixture components given data point');drawnow;end
    if dia>2;figure(2);showMoFAImages(MoFA,nHeight,nWidth);end;
end

toc

function showMoFAImages(MoFA,nHeight,nWidth)
[D,L,C]=size(MoFA.W); 
cnt=0;
for c=1:C;cnt=cnt+1; subplot(C,1+L,cnt);
    alpha=exp(reshape(MoFA.M(:,c),nHeight,nWidth));image(255*alpha./(1+alpha)); colormap(gray(255));axis image ;axis off;drawnow;
    for k = 1:L;cnt=cnt+1; subplot(C,1+L,cnt);imagesc(reshape(MoFA.W(:,k,c),nHeight,nWidth)*255); colormap(gray(255));axis image ;axis off;drawnow;
        if (c==1) title(['factor ' num2str(k)]); drawnow; end;
    end
end

function r=sigmoid(x)
r=(1+exp(-x)).^-1;

