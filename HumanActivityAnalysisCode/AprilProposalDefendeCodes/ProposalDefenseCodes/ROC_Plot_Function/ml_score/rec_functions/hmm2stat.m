function [obser_s2nd,obser_s2pair]=hmm2stat(tr,em)

I=eye(length(tr));
A=tr-I+ones(size(tr));
pi_tr=ones(1,length(tr))/A;

obser_s2pair=pi_tr*em;
obser_s2pair=fliplr(obser_s2pair);

obser_4pair=ones(size(em,2),1)*pi_tr.*em'*(tr*em);

% p11
obser_s2nd1(1)=obser_4pair(3,3)+obser_4pair(3,4)...
              +obser_4pair(4,3)+obser_4pair(4,4);
% p10
obser_s2nd1(2)=obser_4pair(3,1)+obser_4pair(3,2)...
              +obser_4pair(4,1)+obser_4pair(4,2);
% p01
obser_s2nd1(3)=obser_4pair(1,3)+obser_4pair(1,4)...
              +obser_4pair(2,3)+obser_4pair(2,4);
% p00
obser_s2nd1(4)=obser_4pair(1,1)+obser_4pair(1,2)...
              +obser_4pair(2,1)+obser_4pair(2,2);
% --------------------------------------------------
obser_s2nd2=obser_s2nd1;
% p11
obser_s2nd2(1)=obser_4pair(2,2)+obser_4pair(2,4)...
              +obser_4pair(4,2)+obser_4pair(4,4);
% p10
obser_s2nd2(2)=obser_4pair(2,1)+obser_4pair(2,3)...
              +obser_4pair(4,1)+obser_4pair(4,3);
% p01
obser_s2nd2(3)=obser_4pair(1,2)+obser_4pair(1,4)...
              +obser_4pair(3,2)+obser_4pair(3,4);
% p00
obser_s2nd2(4)=obser_4pair(1,1)+obser_4pair(1,3)...
              +obser_4pair(3,1)+obser_4pair(3,3);

 obser_s2nd=(obser_s2nd1+obser_s2nd2)/2;         














