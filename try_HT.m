% Given parameters
T1 = 100;  % Outer surface temperature of the pipe (constant) in °C
T_infinity = 25;  % Temperature of the surrounding medium in °C
k = 0.1;  % Thermal conductivity of the insulation material in W/(m·K)
h = 10;  % Convection heat transfer coefficient in W/(m^2·K)
r1 = 0.02;  % Inner radius of the pipe in meters
L = 1;  % Length of the pipe in meters

% Create an array of radii from r1 to r2
r_values = linspace(r1, 0.05, 100);  % Outer radius of the insulation layer

% Calculate the thermal resistances
R_cond = log(r_values / r1) ./ (2 * pi * k * L); % Element-wise division
R_conv = 1 ./ (h * 2 * pi * r_values * L); % Element-wise division

% Calculate the total thermal resistance
R_total = R_cond + R_conv;

% Calculate the heat transfer Q
Q = (T1 - T_infinity) ./ R_total; % Element-wise division

% Plot Q vs. r
plot(r_values, Q);
xlabel('Radius (m)');
ylabel('Heat Transfer (W)');
title('Heat Transfer vs. Radius for cylindrical pipe');
grid on;
