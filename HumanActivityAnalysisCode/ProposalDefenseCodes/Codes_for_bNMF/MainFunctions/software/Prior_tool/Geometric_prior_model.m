
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name:     Geometric_prior_model
% Function: Embedding geometric prior
% Inputs:   V        traingning data
%           VV       testing data
%           gType    the parameter of whether embedding geometric prior
% Outputs: geom_coefficient the coefficient of geometric prior
%         geom_diag_term   the diagnal matrix of laplacian graph for training data
%         geom_gragh_term  the laplacian graph for traing data
%         proj_diag_term   the diagnal matrix of laplacian graph for testing data
%         proj_graph_term  the laplacian graph for testing data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

graph = diag(ones(1,size(V,2)));
d = zeros(size(V,2),size(V,2));
geom_coefficient = 1;
geom_diag_term = eye(size(V,2));
geom_graph_term = zeros(size(V,2),size(V,2));
proj_geom_diag_term = eye(size(VV,2));
proj_geom_graph_term = zeros(size(VV,2),size(VV,2));

if gType
    fprintf('！！\n');
    t = input('Please choose the value of parameter t for heat kernel? 0-INF, [INF]');
    if isempty(t), t = inf; end
    fprintf('！！\n');
    p = input('Please choose the number of neighbors, 1-110, [10]');
    if isempty(p), p = 10; end
    fprintf('！！\n');
    lemta = input('Please choose the value of parameter lemta for embedding term? 0-10, [1]');
    if isempty(lemta), lemta = 1; end
end

for ii = 1:size(V,2)
    for jj = 1:size(V,2)
        if ii == jj
            d(ii,jj) = inf;
        else
            d(ii,jj) = exp(-norm(V(:,ii)-V(:,jj))/t);
        end
        d(ii,jj); 
    end
    for kk = 1:p
        neighbor = find(d(ii,:)==min(d(ii,:)));
       
        d(ii,neighbor(1)) = inf;
        graph(ii,neighbor(1)) = 1;
    end
    
end
G = graph;
D = sum(G);

pp = round(size(VV,2)/size(V,2)*p);
for jj = 1:size(VV,2)
    for kk = 1:size(VV,2)
        if jj == kk
            dd(jj,kk) = inf;
        else
            dd(jj,kk) = exp(-norm(VV(:,jj)-VV(:,kk))/t);
        end
        dd(jj,kk);
    end
    for mm = 1:pp
        neighbor = find(dd(jj,:)==min(dd(jj,:)));
        dd(jj,neighbor(1)) = inf;
        pgraph(jj,neighbor(1)) = 1;
    end
end
PG = pgraph;
PD = sum(PG);

if gType
    geom_coefficient = 2*lemta;
    geom_diag_term = diag(D);
    geom_gragh_term = G;
    proj_diag_term = diag(PD);
    proj_graph_term = PG;
end



















