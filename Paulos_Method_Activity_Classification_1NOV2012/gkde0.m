function p=gkde0(x,N,h)
% GKDE  Gaussian Kernel Density Estimation
% 
% Usage:
% p = gkde(d) returns an estimate of pdf of the given random data d in p,
%             where p.f is the pdf vector estimated at p.x locations and
%             p.h is the bandwidth used for the estimation.
% p = gkde(d,n) calculates the pdf estimate using n numer of intervals,
%             (default n = 100).
% p = gkde(d,n,h) estimates the pdf with specified bandwidth, h.
%
% Without output, gkde(d), gkde(d,n) or gkde(d,n,h) will disply the pdf plot.
%

% Example 1: Normal distribution
%{
gkde0(randn(1e4,1));
%}
% Example 2: Uniform distribution
%{
gkde0(rand(1e3,1));
%}
% Example 3: Intigal of PDF etc
%{
p=gkde0([randn(1e3,1)-3;randn(1e3,1)*randn]);
dx=mean(diff(p.x));
subplot(211)
plot(p.x,p.f,'linewidth',2)
ylabel('f(x)')
grid
title('PRobability Density Function')
subplot(212)
plot(p.x,cumsum(p.f*dx),'linewidth',2)
ylabel('F(x)')
title('Probability Function: F(x)=\int_-_\infty^xf(x)dx')
xlabel('x')
grid
meanx = sum(p.x.*p.f*dx);
varx = sum((p.x-meanx).^2.*p.f*dx);
text(min(p.x),0.6,sprintf('mean(x) = %g\n var(x) = %g\n',meanx,varx)) 
%}

% V2.1 by Yi Cao at Cranfield University on 12th March 2008
%

% Check input and output
error(nargchk(1,3,nargin));
error(nargoutchk(0,1,nargout));

% Default parameters
if nargin<2
    N=100;
end
n=length(x);
if nargin<3
    % optimal bandwidth
    h=std(x)*(4/3/n)^0.2;
end

xmax=max(x);
xmin=min(x);
xmax=xmax+3*h;
xmin=xmin-3*h;
dx=(xmax-xmin)/(N-1);
p.x=xmin+(0:N-1)*dx;
p.f=zeros(1,N);
for k=1:N
    p.f(k)=sum(exp(-((p.x(k)-x)/h).^2/2))/sqrt(2*pi)/n/h;
end
p.h=h;

% Plot
if ~nargout
    plot(p.x,p.f)
    set(gca,'ylim',[0 max(p.f)*1.1])
    ylabel('f(x)')
    xlabel('x')
    title('Estimated Probability Density Function');
end

