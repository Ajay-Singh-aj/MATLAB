% Define the coefficients matrix (A) and the right-hand side vector (B)
F_CO2_outlet_from_D1=1.1288;
A = [1 0 0 0; 
     0 1 0 0; 
     1 -2 0 0; 
     0 0 1 0; 
     1 0 0 0; 
     0 0 0 1; 
     0 0 -1 0];
B = [2000; 4000; 0; 3.103; 0; 0; -30.89 * F_CO2_outlet_from_D1];

% Solve the linear system
X = linsolve(A, B);

% Extract the flow rates from the solution
F_CO2 = X(1);
F_H2 = X(2);
F_CH3OH = X(3);
F_H2O = X(4);

% Display the results
disp(['Total Molar Flow Rate of CO2: ' num2str(F_CO2) ' kmol/hr']);
disp(['Total Molar Flow Rate of H2: ' num2str(F_H2) ' kmol/hr']);
disp(['Total Molar Flow Rate of CH3OH: ' num2str(F_CH3OH) ' kmol/hr']);
disp(['Total Molar Flow Rate of H2O: ' num2str(F_H2O) ' kmol/hr']);
