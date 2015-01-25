clf;
clear all;

mustard=[.7 .7 .2];
orange=[1,.7,.3];

tetra=Polyhedra('tetrahedron');
tetra.facelighting='flat';
tetra.edgecolor='black';

cube1=Polyhedra('cube');
cube1.facecolor='green';
cube1.facelighting='flat';
cube1.edgecolor='black';
cube1=translate(cube1,1.5,0,0);

octa1=Polyhedra('octahedron');
octa1.facecolor=mustard;
octa1.facelighting='flat';
octa1.edgecolor='black';
octa1=translate(octa1,3,0,0);

dodeca1=Polyhedra('dodecahedron');
dodeca1.facecolor=orange;
dodeca1.facelighting='flat';
dodeca1.edgecolor='none';
dodeca1=translate(dodeca1,5,0,0);

icosa1=Polyhedra('icosahedron');
icosa1.facecolor='red';
icosa1.facelighting='flat';
icosa1.edgecolor='black';
icosa1=translate(icosa1,7,0,0);


scene=combine(tetra, cube1, octa1, dodeca1,icosa1);

count=renderpatch(scene);

axis off;
grid on
daspect([1 1 1])
light('position',[10,-10,10])
%light('position',[10, 10, 10])
set(gca,'projection','perspective')
set(gca,'CameraViewAngle',6)
set(gcf,'color', [.6,.8,.8])
xlabel('x');ylabel('y');zlabel('z'); 
%view(-40,20)
rotate3d on
