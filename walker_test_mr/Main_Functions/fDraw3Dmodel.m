function[out1] = fDraw3Dmodel(walker,x,y,angle_direct)
% This function is to draw the 3D model

walker = scale(walker,0.5,0.5,0.5);
walker  = rotateZ(walker,angle_direct);
walker  = translate(walker,x,y,0);


cla
renderpatch(walker); % Takes the structure
camlight   % Create or move light object in camera coordinates    
view(120,20)    
grid on
drawnow    
set(gca,'xlim',[-1 19],'ylim',[-1 22],'zlim',[-2.718 9]);

out1 = 1;

end