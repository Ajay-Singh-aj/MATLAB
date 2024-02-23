x3co2=0.176;
x4co2=0.243;
x5co2=0.744;
x6co2=0;
x3h2=0.53;
x4h2=0.752;
x5h2=0.027;
x6h2=0;
x3ch3oh=0.147;
x4ch3oh=0.004;
x5ch3oh=0.188;
x6ch3oh=0;
x3h2o=0.147; x4h2o=0.001; x5h2o=0.041; x6h2o=1;
x7co2=0.002; x7h2=0; x7ch3oh=0.987; x7h2o=0.011;
n7=893.263;
syms n3 n4 n5 n6;
%Declare the system of equations symbols n3,n4,n5,n6 respectively
eqn1=n3*x3co2-n4*(x4co2)-n5*(x5co2)-n6*(x6co2)== n7*(x7co2);
eqn2=n3*(x3h2)-n4*(x4h2)-n5*(x5h2)-n6*(x6h2)== n7*(x7h2);
eqn3=n3*(x3ch3oh)-n4*(x4ch3oh)-n5*(x5ch3oh)-n6*(x6ch3oh)== n7*(x7ch3oh);
eqn4=n3*(x3h2o)-n4*(x4h2o)-n5*(x5h2o)-n6*(x6h2o)== n7*(x7h2o);
%Use equations To Matrix to convert the equations into the form AX=B
[A,B]= equationsToMatrix([eqn1,eqn2, eqn3,eqn4], [n3,n4,n5,n6]);
%Use linsolve to solve AX =B for the vector of unknowns X
X=linsolve(A,B);
n3=double(X(1));
n4=double(X(2));
n5=double(X(3));
n6=double(X(4));
n4a=n3-n4;
n5a=n6+n7;
n5aCO2 = 0*n6 + 0.002*n7;
n5aH2 = 0*n6 + 0*n7;
n5aCH3OH = 0*n6 + 0.987*n7;
n5aH2O = 1*n6 + 0.011*n7;
total_5a = n5aCO2 + n5aH2 + n5aCH3OH + n5aH2O;
X5aCO2 = n5aCO2/total_5a;
X5aH2 = n5aH2/total_5a;
X5aCH3OH = n5aCH3OH/total_5a;
X5aH2O = n5aH2O/total_5a;
n4aCO2 = 0.744*n5 + X5aCO2*n5a;
n4aH2 = 0.027*n5 + X5aH2*n5a;
n4aCH3OH = 0.188*n5 + X5aCH3OH*n5a;
n4aH2O = 0.041*n5 + X5aH2O*n5a;
total_4a = n4aCO2 + n4aH2 + n4aCH3OH + n4aH2O;
X4aCO2 = n4aCO2/total_4a;
X4aH2 = n4aH2/total_4a;
X4aCH3OH = n4aCH3OH/total_4a;
X4aH2O = n4aH2O/total_4a;
F7 = zeros(1,151);
F3 = zeros(1,151);
F4A = zeros(1,151);
F5A = zeros(1,151);
for i=0:150
F7(i+1) = 500+i*6;
f7 = F7(i+1);
syms f3 f4 f5 f6;
eq1 = 0.176*f3 == 0.002*f7+ 0*f6 +0.744*f5 + 0.243*f4; % co2 balance
eq2 = 0.53*f3 == 0*f7+ 0*f6+ 0.027*f5+ 0.752*f4; % h2 balance
eq3 = 0.147*f3 == 0.987*f7+ 0*f6+ 0.188*f5 +0.004*f4; % ch3oh balance
eq4 = 0.147*f3 == 0.011*f7 + 1*f6 + 0.041*f5 + 0.001*f4; % h2o balance
[P,d]= equationsToMatrix(eq1,eq2,eq3,eq4);
S = double(P\d);
f3=S(1); f4=S(2); f5=S(3);f6=S(4);
f5a =f6+f7; % calculating molar flow rate of 5a
f4a =f5+f5a; % calculating molar flow rate of 4a
F3(i+1)=f3;
F4A(i+1)=f4a;
F5A(i+1)=f5a;
end
x = linspace(500,1500,151);
y = 182100*(F3/n3).^(6/10)+ 171200*(F4A/n4a).^(6/10) + 1725400*(F5A/n5a).^(6/10);
plot(x,y);
fprintf('Molar flow rate of stream 3 is %0.2f kmol/hr.\n',n3);
fprintf('Molar flow rate of stream 4 is %0.2f kmol/hr.\n',n4);
fprintf('Molar flow rate of stream 5 is %0.2f kmol/hr.\n',n5);
fprintf('Molar flow rate of stream 6 is %0.2f kmol/hr.\n',n6);
fprintf('\n');
fprintf('Molar flow rate of stream 4a is %0.2f kmol/hr.\n',total_4a);
fprintf('Molar flow rate of CO2 of stream 4a is %0.2f kmol/hr.\n',n4aCO2);
fprintf('Molar flow rate of H2 of stream 4a is %0.2f kmol/hr.\n',n4aH2);
fprintf('Molar flow rate of CH3OH of stream 4a is %0.2f kmol/hr.\n',n4aCH3OH);
fprintf('Molar flow rate of H2O of stream 4a is %0.2f kmol/hr.\n',n4aH2O);
fprintf('\n');
fprintf('Molar flow rate of stream 5a is %0.2f kmol/hr.\n',total_5a);
fprintf('Molar flow rate of CO2 of stream 5a is %0.2f kmol/hr.\n',n5aCO2);
fprintf('Molar flow rate of H2 of stream 5a is %0.2f kmol/hr.\n',n5aH2);
fprintf('Molar flow rate of CH3OH of stream 5a is %0.2f kmol/hr.\n',n5aCH3OH);
fprintf('Molar flow rate of H2O of stream 4a is %0.2f kmol/hr.\n',n5aH2O);