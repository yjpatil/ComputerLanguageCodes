% deformation of a sphere to a superquadric surface
% This technique also works with a cylinder or torus to make
% a 'squared off' version of the shape.

clear all
clf

s1=UnitSphere(5);
s1.facelighting='flat';
s1.facecolor='red';

%n less than one tends to a cube
%n greater than one tends to a 6-point star
n=.1; 

%deform the vertices by 'raising them to a power'
V=s1.vertices;
V=abs(V).^n .* sign(V);
s1.vertices=V;

count=renderpatch(s1);


   axis off;
   grid on
   daspect([1 1 1])
   
   light('position',[10,-10,10])
   %light('position',[10, 10, 10])
   
   %Do a persptective transform
   set(gca,'projection','perspective')
   set(gca,'CameraViewAngle',8)
   
   %The frame background color
   set(gcf,'color', [.6,.8,.8])
   xlabel('x');ylabel('y');zlabel('z'); 
   view(-40,20)
   drawnow  

rotate3d on
