%*********************************************************%
%**********      Concatenation Code       ****************%
%*********************************************************%

clc;clear all;close all;

load 'Subsa.mat';load 'Subsal.mat';load 'Subnsa.mat';load 'Subnsal.mat'

for i = 1 : 1 : 20
    clear ('matrix1','matrix1','Lmatrix1','Lmatrix1');    
    matrix1 = Subsa(i).hg;
    matrix2 = Subnsa(i).Features;
    Lmatrix1 = Subsal(i).L;
    Lmatrix2 = Subnsal(i).Labels;
    Subject(i).Features = cat(1,matrix1,matrix2);
    Subject(i).Labels = cat(1,Lmatrix1,Lmatrix2);
end
    