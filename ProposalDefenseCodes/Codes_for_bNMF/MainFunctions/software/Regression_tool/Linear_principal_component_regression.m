function Linear_principal_component_regression(P,scenario_num)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name:      Linear_principal_component_regression
% Function:  Visualize the classes of data points
% Inputs:    P               Coefficient of testing data 
%            scenario_num    Identified scenario number
% Output:    Visualization result of classes of orighinal data points
% Note:      Before applying this function to implement regression, be sure to
%            meet the requirements of this function, here it requares that the first
%            dimensionality of F should be not smaller than the second dimensionality of
%            F. Additionally, the second dimensionality of F should be equal to the
%            product of K and the total number of scenarios.

warning off;
P1 = [];
P2 = [];
P3 = [];
P4 = [];
P5 = [];
for ii = 1:length(scenario_num)
    if scenario_num(ii) == 0
        P1 = [P1 P(:,ii)];
    elseif scenario_num(ii) == 1
        P2 = [P2 P(:,ii)];
    elseif scenario_num(ii) == 2
        P3 = [P3 P(:,ii)];
    elseif scenario_num(ii) == 3
        P4 = [P4 P(:,ii)];
    else
        P5 = [P5 P(:,ii)];
    end
end
dimention = [size(P1,2),size(P2,2),size(P3,2),size(P4,2),size(P5,2)];
d = min(dimention);
new_P = [P1(:,1:d) P2(:,1:d) P3(:,1:d) P4(:,1:d) P5(:,1:d)];

data = new_P(:,1:2:end);
class_num = 5;
sample_num = size(data,2)/class_num;
color = {'k:+','r:*','b:o','y:square','g:diamond','b','y','g'};

fprintf('¡ª¡ª\n');
anim = input('Please choose to show figure or animation. 0-figure, 1-animation, [0]');
if isempty(anim), anim = 0; end
for ii = 1:class_num
    F = data(:,(ii-1)*sample_num+1:ii*sample_num);
    if ii == 1
        F = repmat(eps, [size(data,1) sample_num]);
    end
    K = size(F,2)/class_num;
    angle = (ii-1)*pi/4;
    s = repmat(angle,[1 5]);
    X=10^(-8)*cos(s);
    Y=10^(-8)*sin(s);
    p=[X(1)*ones(K,1);X(2)*ones(K,1);X(3)*ones(K,1);X(4)*ones(K,1);X(5)*ones(K,1)];
    H_X = pcr(F, p);
    p=[Y(1)*ones(K,1);Y(2)*ones(K,1);Y(3)*ones(K,1);Y(4)*ones(K,1);Y(5)*ones(K,1)];
    H_Y = pcr(F, p);

    pd1 = H_X*F;
    pd2 = H_Y*F;

    NEW(:,:,ii)=[pd1;pd2];
    
    if anim
       figure(111)
       for jj = 1:size(NEW,2)
           plot(NEW(1,jj,ii),NEW(2,jj,ii),color{ii},'linewidth',2);hold on;
           drawnow;
           pause(.1);
       end
    end
end
figure(222)
for jj = 1:size(NEW,2) 
    plot(NEW(1,jj,1),NEW(2,jj,1),color{1},NEW(1,jj,2),NEW(2,jj,2),color{2},NEW(1,jj,3),NEW(2,jj,3),color{3},NEW(1,jj,4),NEW(2,jj,4),color{4},NEW(1,jj,5),NEW(2,jj,5),color{5},'linewidth',2);hold on; legend('Scenario 1','Scenario 2','Scenario 3','Scenario 4','Scenario 5');
    set(gca, 'XTicklabel', '');
    set(gca, 'YTicklabel', '');
end
hold off;
