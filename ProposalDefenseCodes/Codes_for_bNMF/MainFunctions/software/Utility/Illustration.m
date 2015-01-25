%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name:     Illustration
% Function: Illustrate the identification result and the region of intrerest
% Inputs:   VV                testing data
%           reconstruct_data  the restruction data obtained via bases and coefficients
%           scenario_num      the recognized scenario catergory
%           real_num          the ground truth of scenario catergory
% Outputs:  recognized scenario
%           region of interest
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sample_num = 30;
number_path = 3;
unit = 8;
for jj = 1:number_path
    sample(:,unit*(jj-1)+1:unit*jj) = VV(:,jj*150+1:jj*150+unit);
    reconstruct(:,unit*(jj-1)+1:unit*jj) = reconstruct_data(:,jj*150+1:jj*150+unit);
    sample_scenario_num(:,unit*(jj-1)+1:unit*jj) = scenario_num(:,jj*150+1:jj*150+unit);
    sample_real_num(:,unit*(jj-1)+1:unit*jj) = real_num(:,jj*150+1:jj*150+unit);
    sample_path_num(:,unit*(jj-1)+1:unit*jj) = jj;
end
for ii = 1:size(sample,1)
    for jj = 1:size(sample,2)
        if reconstruct(ii,jj) <= 0.85
            reconstruct(ii,jj) = 0;
        else
            reconstruct(ii,jj) = 1;
        end
    end
end

region = sample.*reconstruct;
for mm = 1:size(sample_scenario_num,2)
    signal(:,:,mm) = reshape(sample(:,mm),8,126);
    signal_show(:,:,mm) = signal(:,1:120,mm);
    roi(:,:,mm) = reshape(region(:,mm),8,126);
end
          
scenario = repmat(sample_scenario_num,7,1);
real_scenario = repmat(sample_real_num,7,1);
scenario = reshape(scenario,1,size(scenario,1)*size(scenario,2));
real_scenario = reshape(real_scenario,1,size(real_scenario,1)*size(real_scenario,2));
for pp = 1:size(scenario,2)
    if scenario(1,pp) == real_scenario(1,pp)
        error(pp) = 0;
    else
        error(pp) = 1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set basic data for drawing rectangle and trapezoid 
reco_unit_yvalue = [0 1 2 2 2 1 0];
reco_yvalue = repmat(reco_unit_yvalue,1,sample_num);
reco_unit_xvalue = zeros(7,sample_num);
for i = 1:sample_num
    reco_unit_xvalue(:,i) = (i-1)*6:(i-1)*6+6;
end
reco_xvalue = reshape(reco_unit_xvalue,1,size(reco_unit_xvalue,1)*size(reco_unit_xvalue,2));
scenario_color = ['w','y','c','m','g','b'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Draw the original signal, real scenario category, recognized scenario categary, region of interest signal
fprintf('¡ª¡ª\n');
animation = input('Please choose to show figure or animation. 0-figure, 1-animation, [0]');
if isempty(animation), animation = 0; end

figure
hold off;
for ii = 1:sample_num-10
    
    subplot(2,1,1);colormap(gray), imagesc(1-squeeze(signal_show(:,:,ii)));xlabel('Time unit');ylabel('Sensor number');axis([0 120 0.5 8.5]); title('Original signal');set(gca,'xticklabel',{reco_xvalue((ii-1)*size(reco_unit_yvalue,2)+1):reco_xvalue((ii-1)*size(reco_unit_yvalue,2)+1)+7});
    subplot(2,1,2);colormap(gray), imagesc(1-squeeze(roi(:,1:120,ii)));xlabel('Time unit');ylabel('Sensor number');axis([0 120 0.5 8.5]); title('Region of interest');set(gca,'xticklabel',{reco_xvalue((ii-1)*size(reco_unit_yvalue,2)+1):reco_xvalue((ii-1)*size(reco_unit_yvalue,2)+1)+7});hold on;    
    if animation
       pause(.8);
       drawnow;
    end
end

figure
for ii = 1:sample_num-10
    subplot(5,1,1);colormap(gray), imagesc(1-squeeze(signal_show(:,:,ii)));axis([0 120 1 8]); title('Original signal');set(gca,'xticklabel',{reco_xvalue((ii-1)*size(reco_unit_yvalue,2)+1):reco_xvalue((ii-1)*size(reco_unit_yvalue,2)+1)+7});
    subplot(5,1,2);colormap(gray), imagesc(1-squeeze(roi(:,1:120,ii)));axis([0 120 1 8]); title('Region of interest');set(gca,'xticklabel',{reco_xvalue((ii-1)*size(reco_unit_yvalue,2)+1):reco_xvalue((ii-1)*size(reco_unit_yvalue,2)+1)+7});
    subplot(5,1,3);rectangle('position',[reco_xvalue((ii-1)*size(reco_unit_yvalue,2)+1),0,6,2],'curvature',[0 0],'Facecolor',scenario_color(sample_real_num(ii)+1));axis([1 10000 0 6]);axis autox;title('Real scenario');hold on;box on;
    text(reco_xvalue(ii*size(reco_unit_yvalue,2)-4),2.5,['S.' num2str(sample_real_num(ii))]);
    for jj = 1:size(reco_unit_yvalue,2)
        subplot(5,1,4);plot(reco_xvalue((ii-1)*size(reco_unit_yvalue,2)+1:(ii-1)*size(reco_unit_yvalue,2)+jj),reco_yvalue((ii-1)*size(reco_unit_yvalue,2)+1:(ii-1)*size(reco_unit_yvalue,2)+jj),'k','linewidth',1);axis([1 10000 0 6]);axis autox;title('Recognized scenario');hold on;
        if animation
           pause(.5);
           drawnow;
        end
    end
    reco_graph_xpart = reco_xvalue((ii-1)*size(reco_unit_yvalue,2)+1:(ii-1)*size(reco_unit_yvalue,2)+size(reco_unit_yvalue,2));
    reco_graph_ypart = reco_yvalue((ii-1)*size(reco_unit_yvalue,2)+1:(ii-1)*size(reco_unit_yvalue,2)+size(reco_unit_yvalue,2));
    fill(reco_graph_xpart,reco_graph_ypart,scenario_color(sample_scenario_num(ii)+1));
    text(reco_xvalue(ii*size(reco_unit_yvalue,2)-5),2.5,['S.' num2str(sample_scenario_num(ii))]);
    for jj = 1:size(reco_unit_yvalue,2)
        subplot(5,1,5);plot(reco_xvalue((ii-1)*size(reco_unit_yvalue,2)+1:(ii-1)*size(reco_unit_yvalue,2)+jj),error((ii-1)*size(reco_unit_yvalue,2)+1:(ii-1)*size(reco_unit_yvalue,2)+jj),'k','linewidth',2);axis([1 10000 0 4]);axis autox;title('Error measurement');hold on;
    end
    if animation
       pause(.5);
       drawnow;
    end
end




