% Given parameters
T1 = 100;  % Outer surface temperature of the sphere (constant) in °C
T_infinity = 25;  % Temperature of the surrounding medium in °C
k = 0.1;  % Thermal conductivity of the insulation material in W/(m·K)
h = 10;  % Convection heat transfer coefficient in W/(m^2·K)
r1 = 0.02;  % Inner radius of the sphere in meters

% Create an array of radii from r1 to r2
r_values = linspace(r1, 0.05, 100);  % Outer radius of the insulation layer

% Calculate the thermal resistances
R_cond = (r_values-r1) ./ (4 * pi *r1.*r_values* k); % Element-wise division
R_conv = 1 ./ (h * 4 * pi * r_values.^2 ); % Element-wise division

% Calculate the total thermal resistance
R_total = R_cond + R_conv;

% Calculate the heat transfer Q
Q = (T1 - T_infinity) ./ R_total; % Element-wise division

% Plot Q vs. r
plot(r_values, Q);
xlabel('Radius (m)');
ylabel('Heat Transfer (W)');
title('Heat Transfer vs. Radius for sphere');
grid on;
