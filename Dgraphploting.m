%%3D graph plot

x=0:0.1:10;
y=2:0.2:5;
[X,Y]=meshgrid(x,y);
z=sin(X).*cos(Y);
surf(x,y,z);
xlabel('x');
ylabel('y');
zlabel('z');
