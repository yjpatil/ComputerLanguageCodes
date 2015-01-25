clc;clear all;
addpath('Data','Regression_tool');
warning off;

load demo_coefficient
class_num = 5;
sample_num = size(data,2)/class_num;
color = {'k:+','r:*','b:o','y:square','g:diamond','b','y','g'};

animation = input('Please choose to show figure or animation. 0-figure, 1-animation, [0]');
if isempty(animation), animation = 0;end

for ii = 1:class_num
    
    F = data(:,(ii-1)*sample_num+1:ii*sample_num);
    if ii == 1
        F = repmat(eps, [size(data,1) sample_num]);
    end
    K = size(F,2)/class_num;

    angle = (ii-1)*pi/40;
    s = repmat(angle,[1 5]);
    X=10^(-7)*cos(s);
    Y=10^(-7)*sin(s);
    p=[X(1)*ones(K,1);X(2)*ones(K,1);X(3)*ones(K,1);X(4)*ones(K,1);X(5)*ones(K,1)];
    H_X = pcr(F, p);
    p=[Y(1)*ones(K,1);Y(2)*ones(K,1);Y(3)*ones(K,1);Y(4)*ones(K,1);Y(5)*ones(K,1)];
    H_Y = pcr(F, p);
     
    pd1 = H_X*F;
    pd2 = H_Y*F;
    NEW(:,:,ii)=[pd1;pd2];
    x_axis(ii) = (max(pd1)-min(pd1))/2;
    m(1,ii) = x_axis(ii)+min(pd1);
    y_axis(ii) = (max(pd2)-min(pd2))/2;
    m(2,ii) = y_axis(ii)+min(pd2);
    if x_axis(ii) == 0
        x_axis(ii) = 2*10^(-10);
    end
    if y_axis(ii) == 0
        y_axis(ii) = 10^(-10);
    end
    
    t = linspace(-pi,pi);
    %x = x_axis(ii)*cos(t)+m(1,ii);
    %y = y_axis(ii)*sin(t)+m(2,ii);
    x = sin(t+(ii-1)*pi/20)'*linspace(0,2*x_axis(ii),4)+m(1,ii);
    y = cos(t)'*linspace(0,2*y_axis(ii)+10^(-9),4)+m(2,ii);
    xx(:,:,ii) = x;
    yy(:,:,ii) = y;
    if animation   
       figure(111)
       for jj = 1:size(NEW,2)
           plot(NEW(1,jj,ii),NEW(2,jj,ii),color{ii},'linewidth',2);hold on;
           drawnow;
           pause(.1);
       end
        plot(x,y,'linewidth',0.3);
    end
end
figure(222)
for jj = 1:size(NEW,2) 
    plot(NEW(1,jj,1),NEW(2,jj,1),color{1},NEW(1,jj,2),NEW(2,jj,2),color{2},NEW(1,jj,3),NEW(2,jj,3),color{3},NEW(1,jj,4),NEW(2,jj,4),color{4},NEW(1,jj,5),NEW(2,jj,5),color{5},'linewidth',2);hold on; legend('Scenario 1','Scenario 2','Scenario 3','Scenario 4','Scenario 5','Location','Southwest');
    set(gca, 'XTicklabel', '');
    set(gca, 'YTicklabel', '');
end
for ii = 1:size(xx,3)
    plot(xx(:,:,ii),yy(:,:,ii),':');
end
hold off;
