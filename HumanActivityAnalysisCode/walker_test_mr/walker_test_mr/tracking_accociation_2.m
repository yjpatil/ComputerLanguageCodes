close all;clear all;clc
load step_all-1024-2;

n=length(step_all1);

step_all1=step_all1-0.5;
%step_all2=step_all2-0.5;
aaa=step_all1(1,:);aaa=reshape(aaa,2,length(aaa)/2);
x1=aaa(1,:);y1=aaa(2,:);
aaa=step_all1(2,:);aaa=reshape(aaa,2,length(aaa)/2);
x2=aaa(1,:);y2=aaa(2,:);

human11=[x1(1);y1(1)]; human21=[x1(1);y1(1)];
human12=[x2(1);y2(1)]; human22=[x2(1);y2(1)];
for i=2:length(x1)
    step11=human11(:,size(human11,2));
    step12=human12(:,size(human12,2));
    step21=human21(:,size(human21,2));
    step22=human22(:,size(human22,2));
    
    step_new1=[x1(i);y1(i)]; step_new2=[x2(i);y2(i)];
    if step11(1)>0, distan111=sum((step_new1-step11).^2);
        distan112=sum((step_new2-step11).^2);
    else distan111=50; distan112=50;
    end
    
    if step12(1)>0, distan121=sum((step_new1-step12).^2);
        distan122=sum((step_new2-step12).^2);
    else distan121=50; distan122=50;
    end
    
    if step21(1)>0, distan211=sum((step_new1-step21).^2);
        distan212=sum((step_new2-step21).^2);
    else distan211=50; distan212=50;
    end
    
    if step22(1)>0, distan221=sum((step_new1-step22).^2);
        distan222=sum((step_new2-step22).^2);
    else distan221=50; distan222=50;
    end

    distan=[distan111,distan112,distan121,distan122...
            distan211,distan212,distan221,distan222];
    
    if sum(min(distan)==distan(1:4))>=1
        human11=[human11,step_new1];
        human12=[human12,step_new2];
    else
        human21=[human21,step_new1];
        human22=[human22,step_new2];
    end
    
end

len1=length(human11); len2=length(human21);
len=max(len1,len2);
M=moviein(len);
% ------------------------------------------------------------------
path1X=zeros(1,len1);path1Y=path1X;
path2X=zeros(1,len2);path2Y=path2X;
for i=1:len1
    if human12(1,i)>0
        path1X(i)=(human11(1,i)+human12(1,i))/2;
        path1Y(i)=(human11(2,i)+human12(2,i))/2;
    else
        path1X(i)=human11(1,i);
        path1Y(i)=human11(2,i);
    end
end
for i=1:len2
    if human22(1,i)>0
        path2X(i)=(human21(1,i)+human22(1,i))/2;
        path2Y(i)=(human21(2,i)+human22(2,i))/2;
    else
        path2X(i)=human21(1,i);
        path2Y(i)=human21(2,i);
    end
end
% ------------------------------------------------------------------
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

for i=1:len
    counting=counting+1;
    
    if counting==3
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
    if i<=len1
    plot(path1X(i),path1Y(i),'s',...
        'MarkerSize',32,'MarkerFaceColor','blue')
    else
       plot(path1X(len1),path1Y(len1),'s',...
        'MarkerSize',32,'MarkerFaceColor','blue') 
    end
    if i<=len2
    plot(path2X(i),path2Y(i),'s',...
        'MarkerSize',32,'MarkerFaceColor','red')
    else
        plot(path2X(len2),path2Y(len2),'s',...
        'MarkerSize',32,'MarkerFaceColor','red')
    end
% -------------------------------------------------------------------------
    M(:,i) = getframe;

end
title('Finished')

clear M;

