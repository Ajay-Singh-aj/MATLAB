%there are 2 types for solving algebric equation
%1st is by use of matrix
%2nd one is by use os syms
%BY MATRIX
%we can represent 4x+7 in the below form
f=[4,7];
roots(f)
%we can represent 3*x^2-4*x+7 as below
x=[3 -4 7];
roots(x)


%2nd is syms
syms x
solve(4*x+7==0);
syms y
solve(2*y^4-5*y^3-4*y+7==0)