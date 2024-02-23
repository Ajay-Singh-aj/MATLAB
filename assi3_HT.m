% Given parameters
Ti = 300;           % Average temperature of hot gases in the chimney (°C)
To = 20;            % Ambient temperature (°C)
T4_sky = 260;       % Effective sky temperature (K)
l = 0.2;            % Length of a side of the square chimney (m)
k = 1.4;            % Thermal conductivity of concrete (W/m·K)
hi = 70;            % Convection heat transfer coefficient inside chimney (W/m^2·K)
ho = 21;            % Convection heat transfer coefficient outside chimney (W/m^2·K)
e = 0.9;            % Emissivity of outer surface
sigma = 5.67e-8;    % Stefan-Boltzmann constant (W/m^2·K^4)

% Finite difference method with Dx = Dy = 10 cm
Dx = 0.1;Dy = 0.1;      % Grid spacing (m)

% Initialize nodal temperatures
T1 = 300; T2 = 300; T3 = 300; T4 = 300; T5 = 300;
T6 = 300; T7 = 300; T8 = 300; T9 = 300;

% Iterate to find nodal temperatures using Gauss-Seidel method
tolerance = 1e-6;   % Tolerance for convergence
max_iterations = 10000;

for iter = 1:max_iterations
    T1_old = T1;
    T2_old = T2;
    T3_old = T3;
    T4_old = T4;
    T5_old = T5;
    T6_old = T6;
    T7_old = T7;
    T8_old = T8;
    T9_old = T9;

    % Node 1
    T1 = -(2 + hi*l/k)*T1 + hi*l*Ti/k;

    % Node 2
    T2 = (T1_old + 2*T4 + hi*l*Ti/k)/(3 + hi*l/k);

    % Node 3
    T3 = (T1_old + 2*T4 + T6)/4;

    % Node 4
    T4 = (T2_old + T3_old + T5_old + T7_old)/4;

    % Node 5
    T5 = (2*T4_old + 2*T8)/4;

    % Node 6
    T6 = (T2_old + T3_old + 456.2 - 0.3645e-9*T4_old/3.5)/(2 + ho*l/k);

    % Node 7
    T7 = (2*T4_old + T6_old + T8_old + 912.4 - 0.729e-9*T4_old/7)/(4 + 2*ho*l/k);

    % Node 8
    T8 = (2*T5_old + T7_old + T9_old + 912.4 - 0.729e-9*T4_old/7)/(4 + 2*ho*l/k);

    % Node 9
    T9 = (T8_old + 456.2 - 0.3645e-9*T4_old/2.5)/(1 + ho*l/k);

    % Check for convergence
    if max(abs([T1 - T1_old, T2 - T2_old, T3 - T3_old, T4 - T4_old, ...
                T5 - T5_old, T6 - T6_old, T7 - T7_old, T8 - T8_old, T9 - T9_old])) < tolerance
        break;
    end
end

% Calculate rate of heat loss through the 1-meter-long section of the chimney
A_outer = 4 * l * l; % Outer surface area of the chimney (m^2)
Q_conv = ho * A_outer * (mean([T6, T7, T8]) - To); % Heat loss through convection (W)
Q_rad = e * sigma * A_outer * ((mean([T4_sky, T4_sky, T4_sky, T4_sky]).^4) - mean([T4, T4, T4, T4].^4)); % Heat loss through radiation (W)
Q_total = Q_conv + Q_rad; % Total heat loss (W)

% Display results
disp(['Rate of heat loss through the 1-meter-long section of the chimney: ', num2str(Q_total), ' W']);
