close all;clear all;clc
load step_all-1024-2;

n=length(step_all1);

step_all1=step_all1-0.5;
step_all2=step_all2-0.5;
i=1:4:n-2;
M=moviein(length(i));

counting=0;

plot([0,8],[0,0],'k','LineWidth',2)
    hold on
    plot([0,8],[1,1]); plot([0,8],[2,2]); 
    plot([0,8],[3,3]);plot([0,8],[4,4],'k','LineWidth',2); 
    plot([0,8],[5,5]);plot([0,8],[6,6]); 
    plot([0,8],[7,7]);plot([0,8],[8,8],'k','LineWidth',2); 
    
    plot([0,0],[0,8],'k','LineWidth',2); plot([1,1],[0,8]); 
    plot([2,2],[0,8]); plot([3,3],[0,8]); 
    plot([4,4],[0,8],'k','LineWidth',2);
    plot([5,5],[0,8]); plot([6,6],[0,8]);
    plot([7,7],[0,8]); plot([8,8],[0,8],'k','LineWidth',2);
    axis square; axis([0 8 0 8]);

for i=1:4:n-2
    counting=counting+1;
    
    if counting==35
        counting=0;
    hold off
% -------------------------------------------------------------------------    
    plot([0,8],[0,0],'k','LineWidth',2)
    hold on
    plot([0,8],[1,1]); plot([0,8],[2,2]); 
    plot([0,8],[3,3]);plot([0,8],[4,4],'k','LineWidth',2); 
    plot([0,8],[5,5]);plot([0,8],[6,6]); 
    plot([0,8],[7,7]);plot([0,8],[8,8],'k','LineWidth',2); 
    
    plot([0,0],[0,8],'k','LineWidth',2); plot([1,1],[0,8]); 
    plot([2,2],[0,8]); plot([3,3],[0,8]); 
    plot([4,4],[0,8],'k','LineWidth',2);
    plot([5,5],[0,8]); plot([6,6],[0,8]);
    plot([7,7],[0,8]); plot([8,8],[0,8],'k','LineWidth',2);
    axis square; axis([0 8 0 8]);
    end
% -------------------------------------------------------------------------
    plot(step_all1(1,i),step_all1(1,i+1),'s',...
        'MarkerSize',32,'MarkerFaceColor','blue')
    plot(step_all1(1,i+2),step_all1(1,i+3),'s',...
        'MarkerSize',32,'MarkerFaceColor','blue')
    
    plot(step_all1(2,i),step_all1(2,i+1),'s',...
        'MarkerSize',32,'MarkerFaceColor','blue')
    plot(step_all1(2,i+2),step_all1(2,i+3),'s',...
        'MarkerSize',32,'MarkerFaceColor','blue')
% -------------------------------------------------------------------------   
%     plot((step_all2(1,i)+step_all2(2,i))/2,(step_all2(1,i+1)+step_all2(2,i+1)),'s',...
%         'MarkerSize',32,'MarkerFaceColor','red');
%     
%     plot((step_all2(1,i+2)+step_all2(2,i+2))/2,(step_all2(1,i+3)+step_all2(2,i+3)),'s',...
%         'MarkerSize',32,'MarkerFaceColor','red')
% -------------------------------------------------------------------------
%     plot(step_all2(1,i),step_all2(1,i+1),'s',...
%         'MarkerSize',32,'MarkerFaceColor','red')
%     plot(step_all2(1,i+2),step_all2(1,i+3),'s',...
%         'MarkerSize',32,'MarkerFaceColor','red')
%     plot(step_all2(2,i),step_all2(2,i+1),'s',...
%         'MarkerSize',32,'MarkerFaceColor','red')
%     plot(step_all2(2,i+2),step_all2(2,i+3),'s',...
%         'MarkerSize',32,'MarkerFaceColor','red')
% -------------------------------------------------------------------------
    j=(i-1)/4+1;
    M(:,j) = getframe;

end
title('Finished')
% aaa=step_all1(1,:);aaa=reshape(aaa,2,length(aaa)/2);
% x1=aaa(1,:);y1=aaa(2,:);
% aaa=step_all1(2,:);aaa=reshape(aaa,2,length(aaa)/2);
% x2=aaa(1,:);y2=aaa(2,:);
% aaa=step_all2(1,:);aaa=reshape(aaa,2,length(aaa)/2);
% x3=aaa(1,:);y3=aaa(2,:);
% aaa=step_all2(2,:);aaa=reshape(aaa,2,length(aaa)/2);
% x4=aaa(1,:);y4=aaa(2,:);
% plot(x1,y1,'b');plot(x2,y2,'r');plot(x3,y3,'r');plot(x4,y4,'r');
%movie2avi(M,'fiber32s_64g_movie.avi', 'compression', 'None','fps',30);
clear M;

