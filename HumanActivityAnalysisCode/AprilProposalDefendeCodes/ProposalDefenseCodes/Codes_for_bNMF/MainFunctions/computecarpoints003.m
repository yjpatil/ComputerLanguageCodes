function [x_points,y_points,XCoG,YCoG] = computecarpoints003(x0,y0,angle,carL,carW,Plot)
gcf;
angleRadians = angle*pi/180; % angle is in degree (in truckmod function)

% **** CHANGE 7Sep2013 **** %
% carL = 3.5;
% carW = 1.7;

% carL = 1.2;
% carW = 1.3;

x1 = x0 + rotateX(0,carW/2,angleRadians);
y1 = y0 + rotateY(0,carW/2,angleRadians);

x2 = x0 + rotateX(carL,carW/2,angleRadians);
y2 = y0 + rotateY(carL,carW/2,angleRadians);

x3 = x0 + rotateX(carL,-carW/2,angleRadians);
y3 = y0 + rotateY(carL,-carW/2,angleRadians);

x4 = x0 + rotateX(0,-carW/2,angleRadians);
y4 = y0 + rotateY(0,-carW/2,angleRadians);

x_points = [x1 x2 x3 x4];
y_points = [y1 y2 y3 y4];


Xm1m2 = (x1+x2)/2;
Ym1m2 = (y1+y2)/2;

Xm2m3 = (x2+x3)/2;
Ym2m3 = (y2+y3)/2;

Xm3m4 = (x3+x4)/2;
Ym3m4 = (y3+y4)/2;

Xm1m4 = (x1+x4)/2;
Ym1m4 = (y1+y4)/2;

XCoG = (Xm1m2+Xm3m4)/2;
YCoG = (Ym1m2+Ym3m4)/2;


if(Plot)
    plot(XCoG,YCoG,'pk','Linewidth',1.5);
    %plot([Xm1m2 Xm3m4],[Ym1m2 Ym3m4], '-k','Linewidth',1.5);
    %plot([Xm2m3 Xm1m4],[Ym2m3 Ym1m4], Color,'Linewidth',1.5);
    plot([XCoG Xm2m3],[YCoG Ym2m3] ,'-k','Linewidth',1.5); % % **This is the part where you plot the nose/front end of the 
end


%plot([x4 x1],[y4 y1],'-r')

% x_p = [x1 x2 x3 x4 x1];
% y_p = [y1 y2 y3 y4 y1];

%plot(x_p,y_p,'-b')
%xlim([0 25]);ylim([0 25]);
%grid on;  hold on;



end






