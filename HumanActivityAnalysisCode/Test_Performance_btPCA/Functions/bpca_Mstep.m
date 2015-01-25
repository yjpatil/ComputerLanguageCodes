function [MoFA]=bpca_Mstep(MoFA,X,X2,Q,T,means_only,U_only);
% [MoFA]=bpca_Mstep(MoFA,X,X2,qcn,T,means_only,U_only)
% update parameters of the mixture of 'binary' PCAs.
% Extended to use the "expected transformed data" as in:
%  "Transformation invariant component analysis for binary images"
%  Z. Zivkovic and J.J. Verbeek
%  IEEE Conference on Computer Vision and Pattern Recognition, 2006.
%
% X     : data matrix (N data points in D dimensions as columns)
% X2=2*X-1
% T= tanh(Theta/2) ./ Theta;
% MoFA  : structure containing the Mixture of Factor Analyzers
%         MoFA.W (D x L x C) : factor loading matrices
%         MoFA.M (D x C)     : component means
%         MoFA.mix ( C x 1 ) : mixing weights
%         MoFA.U (L x N x C) : infered latent coordinates for the data
% qcn   : C x N matrix of component posterior probabilities
%
% Author: Zoran Zivkovic (based on the binary factor analysis code from Jakob Verbeek)
% http://www.zoranz.net
% Intelligent Systems Laboratory Amsterdam, University of Amsterdam, 2005.

[D,N,Ct]=size(X);
[D, L, C] = size(MoFA.W);
if (Ct==C) avg=1;else;avg=0;end;
if (~exist('U_only'));U_only=0;end;
 
% kind of E-step: update latent projections U
for c=1:C
    if avg;
    B =  (X2(:,:,c) - T(:,:,c).*(MoFA.M(:,c)*ones(1,N)))'*MoFA.W(:,:,c);%NxD * DxL => NxL
    else
    B =  (X2 - T(:,:,c).*(MoFA.M(:,c)*ones(1,N)))'*MoFA.W(:,:,c);%NxD * DxL => NxL
    end
    for n=1:N;	% U update
        A = MoFA.W(:,:,c)'*(MoFA.W(:,:,c).* (T(:,n,c)*ones(1,L)));%LxL matrix 
        MoFA.U(:,n,c) = mldivide(A,B(n,:)')';%solve a dxd liner system C*N times
    end
end

if U_only; return; end;

MoFA.mix=mean(Q,2);%update the mixing weights

%update only the mean - used sometimes in the initial iterations
if means_only;
    for c=1:C;
        if avg;
            alpha=X(:,:,c)*Q(c,:)'/sum(Q(c,:));
        else
            alpha=X*Q(c,:)'/sum(Q(c,:));
        end;
        %bound;
        minval=10e-6;
        alpha=(alpha<=minval).*minval+(alpha>minval).*alpha;
        alpha=(alpha>=(1-minval)).*(1-minval)+(alpha<(1-minval)).*alpha;
        MoFA.M(:,c)=log(alpha)-log(1-alpha);
    end;
    return;
end;

% update loading matrices and means 
for c=1:C
    U2 = [MoFA.U(:,:,c);ones(1,N)];%L+1 x N
    U2 = U2.*repmat(Q(c,:),L+1,1);
    if avg;
        B  =  X2(:,:,c)*U2';%D x L+1
    else
        B  =  X2*U2';%D x L+1
    end
    for d=1:D;	% V update
        A = [MoFA.U(:,:,c); ones(1,N)]*(U2'.* (T(d,:,c)'*ones(1,L+1)));%L+1 x L+1
        %A = U2*(U2'.* (T(d,:,c)'*ones(1,L+1)));
        V2 = mldivide(A,B(d,:)');%solve L+1 x L+1 linear system
        MoFA.M(d,c) = V2(end);
        if L>0; MoFA.W(d,:,c)   = V2(1:end-1);end
    end
end

end

