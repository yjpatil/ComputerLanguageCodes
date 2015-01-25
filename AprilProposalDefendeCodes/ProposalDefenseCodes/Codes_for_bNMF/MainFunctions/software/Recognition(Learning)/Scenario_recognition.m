%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name:     Scenario_recognition
% Function: Learn the coefficients of testing data and recognize scenarios
% Inputs:   Project      the initial coefficient matrix of testing data
%           H            the coefficient matrix of training data
% Outputs:  scenario_num the index of recognized scenarios
%           proj         processed coefficient of testing data   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
