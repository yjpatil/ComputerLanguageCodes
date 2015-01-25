function [m,n] = truncate(x)
flag=0;
% % disp(x);
if(x<0)
flag=1;
end;
y=abs(x);
m=double(char(y));
if(flag==1)
    m=-m;
end
 n=abs(x-m);
end