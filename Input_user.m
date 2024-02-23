r=input('radius(cm)=');
h=input('height(cm)=');
%for input string we use 's'
z=input('what do you want to do? ','s');
D=2*r;
C=2*pi*r;
A=pi*r^2;
Vc=pi*(r^2)*h;
disp('Calculation of Circle');
disp('-----------------------');
%here we are changing all variable parameter with there name
disp(['radius(cm) =',num2str(r)]);

disp(['height(cm) =',num2str(h)]);
disp(['diameter(cm) =',num2str(D)]);
disp(['circumference(cm) =',num2str(C)]);
disp(['area(cm^2) =',num2str(A)]);
disp(['volume(cm^3) =',num2str(Vc)]);
