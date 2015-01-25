function ds = truckmod(s,u)

L = 2.5;
v = -1;

f = s(3) * (pi/180);

q = u * (pi/180);

dx = (-v) * cos(f);
%dx = (-v) * (cos(f)+0.001 *sin(f)); 

dy = (-v) * sin(f);
%dy = (-v) * (-0.001*cos(f)+sin(f));

df = ((-v)/L) * sin(u);

df = df * (180/pi);

ds = [dx;dy;df];

end