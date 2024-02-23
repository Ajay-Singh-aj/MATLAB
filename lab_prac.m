% Define the given parameters and initial guess
Ti = 300+273;           % Average temperature of hot gases in the chimney (°C)
To = 20+273;            % Ambient temperature (°C)
Tsky = 260;       % Effective sky temperature (K)
l = 0.2;            % Length of a side of the square chimney (m)
k = 1.4;            % Thermal conductivity of concrete (W/m·K)
hi = 70;            % Convection heat transfer coefficient inside chimney (W/m^2·K)
ho = 21;            % Convection heat transfer coefficient outside chimney (W/m^2·K)
e = 0.9;            % Emissivity of outer surface
sigma = 5.67e-8;
T = ones(9,1)*273;    % Initial guess for the temperatures at the nodes (K)

% Define the functions for the equations at each node
f1 = @(T1,T2,T3) (0+hi*(l/2)*(Ti)+k*(l/2)*(T2-T1)/l+k*(l/2)*(T3-T1)/l)/(hi*(l/2)) - T1;
f2 = @(T1,T2,T4) (k*(l/2)*(T1)/l+hi*(l/2)*(Ti-T2)+0+k*(l)*(T4-T2)/l)*l/(k*(l/2)) - T2;
f3 = @(T1,T3,T4,T6) (T4 + T1 + T4 + T6 )/4 - T3;
f4 = @(T2,T3,T4,T5,T7) (T3 + T2+T5 + T7)/4 - T4;
f5 = @(T4,T5,T8) (T4 + T4+T8 + T8)/4 - T5;
f6 = @(T3,T6,T7) (0+k*(l/2)*(T3-T6)/l+k*(l/2)*(T7)/l+ho*(l/2)*(To-T6)+e*sigma *(l/2)*(Tsky)^4-(T6)^4)*l/(k*(l/2)) - T6;
f7 = @(T4,T6,T7,T8) (k*(l)*(T4-T7)/l+k*(l/2)*(T6)/l+k*(l/2)*(T8-T7)/l+ho*(l)*(To-T7)+e*sigma *(l)*(Tsky)^4-(T7)^4)*l/(k*(l/2)) - T7;
f8 = @(T5,T7,T8,T9) ((k*(Dx)*(T5-T8)/Dy+k*(Dy/2)*(T7)/Dx+k*(Dy/2)*(T9-T8)/Dx+ho*(Dx)*(To-T8)+e*sigma *(Dx)*(Tsky)^4-(T8)^4)*Dx/(k*(Dy/2))) - T8;
f9 = @(T8,T9) (0+k*(l/2)*(T8)/l+ho*(l/2)*(To-T9)+e*sigma *(l/2)*((Tsky)^4-(T9)^4))*l/(k*(l/2)) - T9;

% Define the vector of functions and the vector of variables
F = @(T) [f1(T(1),T(2),T(3)); f2(T(1),T(2),T(4)); f3(T(1),T(3),T(4),T(6)); f4(T(2),T(3),T(4),T(5),T(7)); f5(T(4),T(5),T(8)); f6(T(3),T(6),T(7)); f7(T(4),T(6),T(7),T(8)); f8(T(5),T(7),T(8),T(9)); f9(T(8),T(9))];

% Use fsolve to find the numerical solution
options = optimoptions('fsolve','Display','iter'); % Set options to show iterations
T = fsolve(F,T,options); % Solve the system of equations

% Display the solution
disp('The temperatures at the nodes are:')
disp(T)
