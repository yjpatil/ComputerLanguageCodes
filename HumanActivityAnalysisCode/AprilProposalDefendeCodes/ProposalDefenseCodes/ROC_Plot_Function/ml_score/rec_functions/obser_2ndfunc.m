% Calculate the observation transition matrix 'Otran' of HMM, of which 
% Otran(i,j) is the probability that given obervation(t)=i, the obervation(t+1)=j.

function seq_2ndst=obser_2ndfunc(seq)

seq_in=seq;
Len = size(seq_in, 2);
seq_2ndst=zeros(2,2)+eps;

for i=1:Len-1
    if     (seq_in(i)==1)&(seq_in(i+1)==1), seq_2ndst(1,1)=seq_2ndst(1,1)+1;
    elseif (seq_in(i)==1)&(seq_in(i+1)==2), seq_2ndst(1,2)=seq_2ndst(1,2)+1;
    elseif (seq_in(i)==2)&(seq_in(i+1)==1), seq_2ndst(2,1)=seq_2ndst(2,1)+1;
    elseif (seq_in(i)==2)&(seq_in(i+1)==2), seq_2ndst(2,2)=seq_2ndst(2,2)+1;
    end
end
seq_2ndst=reshape(seq_2ndst',1,4);
%seq_2ndst=seq_2ndst/sum(seq_2ndst);
if sum(seq_2ndst)>1
    seq_2ndst=seq_2ndst/sum(seq_2ndst);
else
    seq_2ndst=zeros(size(seq_2ndst));
end














