clc;clear all;

addpath('Data','Utility');
load training_data_SL126_120; V = double(V); 
load test_structure; VV = double(test.signal);

base_num = 16;
W = rand(size(V,1),base_num);
H = rand(base_num,size(V,2));
Project = rand(size(H,1),size(VV,2));
 
graph = diag(ones(1,size(V,2)));
d = zeros(size(V,2),size(V,2));
geom_coefficient = 1;
geom_diag_term = eye(size(V,2));
geom_graph_term = zeros(size(V,2),size(V,2));
proj_geom_diag_term = eye(size(VV,2));
proj_geom_graph_term = zeros(size(VV,2),size(VV,2));

stat_base_term = eye(size(W,2));
stat_coef_term = eye(size(W,2));


M = size(V,1); 
N = size(V,2);
A = ones(M,N);
B = ones(1,M);
C = ones(N,1);
D = ones(M,base_num);
E = ones(base_num,N);
AA = ones(M,size(VV,2));
iteration = 600;
real_num = test.number;
prior = 0;
gType = prior;
sType = prior;
  
coef_addition = geom_coefficient*H*geom_graph_term;

for jj = 1:iteration
      % KL-divergence
      W = W./(A*H'+W*stat_base_term).*((V./(W*H+eps))*H');
      H = H./(W'*A+geom_coefficient*stat_coef_term*H*geom_diag_term).*(W'*(V./(W*H+eps))+coef_addition);
end

cluster = zeros(size(H,1),5);
for i = 1:size(H,2)
    if mod(i-1,5) == 0
       cluster(:,1) = cluster(:,1) + H(:,i);
    elseif mod(i-1,5) == 1
           cluster(:,2) = cluster(:,2) + H(:,i);
    elseif mod(i-1,5) == 2
           cluster(:,3) = cluster(:,3) + H(:,i);
    elseif mod(i-1,5) == 3
           cluster(:,4) = cluster(:,4) + H(:,i);
    elseif mod(i-1,5) == 4
        cluster(:,5) = cluster(:,5) + H(:,i); 
    end
end

for it_number = 1:iteration
    proj_addition = geom_coefficient*Project*proj_geom_graph_term;
    Project = Project./(W'*AA+geom_coefficient*stat_coef_term*Project*proj_geom_diag_term).*(W'*(VV./(W*Project+eps))+proj_addition);   
end

for ii = 1:size(VV,2)
    for jj = 1:size(H,2)
        distance(jj) = norm(Project(:,ii) - H(:,jj));
    end
    ind = find(distance == min(distance));
    index(ii) = mod(ind(1)-1,5); 
end
scenario_num = index;

for ii = 1:size(Project,1)
    for jj = 1:size(Project,2)
        if prior & gType & sType
            if Project(ii,jj) <= 0.1
                Proj(ii,jj) = 0;
            else
                Proj(ii,jj) = Project(ii,jj);
            end
        elseif (prior & gType) || (prior & sType)
            if Project(ii,jj) <= 0.8
                Proj(ii,jj) = 0;
            else
                Proj(ii,jj) = Project(ii,jj);
            end
        else
            if Project(ii,jj) <= 1.5
               Proj(ii,jj) = 0;
            else
               Proj(ii,jj) = Project(ii,jj);
               
            end
        end
    end
end

figure
for ii = 1:size(W,2)
    subplot(sqrt(size(W,2)),sqrt(size(W,2)),ii); imagesc(1-reshape(W(:,ii),8,126));colormap(gray);axis off;
end
figure
for jj = 1:size(W,2)
    subplot(sqrt(size(W,2)),sqrt(size(W,2)),jj); hist(W(:,jj),20);axis([0 1 0 1000]);
end

reconstruct_data = W*Proj;
 Illustration;