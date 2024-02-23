clc
syms x y
eq1=2*x+8*y==15;
eq2=9*x-6*y==21;
sol=solve([eq1,eq2],0000[x,y]);
disp(sol.x);
disp(sol.y);

%%
clc
syms x y z
eq1=2*x+8*y+2*z==15;
eq2=9*x-6*y-3*z==21;
sol=solve([eq1,eq2],[x,y,z]);
disp(sol.x);
disp(sol.y);
disp(sol.z);