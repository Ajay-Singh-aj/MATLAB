% User-defined values
Dx = input('Enter Dx value: ');
Dy = input('Enter Dy value: ');

% Given values
k = 1.4; % Thermal conductivity in W/m·K
Ti = 300; % Inner temperature in °C
To = 20; % Outer temperature in °C
hi = 70; % Inner convection heat transfer coefficient in W/m2·K
ho = 21; % Outer convection heat transfer coefficient in W/m2·K
e = 0.9; % Emissivity 
Tsky_K = 260; % Sky temperature in K

% Calculate the thickness of the wall
thickness = 0.2; % Thickness of the wall in meters

% Calculations - Finite Difference Method 
% Convert temperatures to Kelvin for calculations 
Ti_K = Ti + 273.15;

% Calculate number of nodes based on user-defined Dx and Dy 
numNodesX = round(0.2 / Dx) + 1;
numNodesY = round(0.2 / Dy) + 1;

% Initialize matrix for temperatures at nodal points 
Tnodes = zeros(numNodesX, numNodesY);

% Solve the system of equations using fsolve 
options = optimoptions('fsolve', 'Display', 'none'); % Suppress output
T0 = ones(numNodesX * numNodesY, 1) * Ti_K; % Initial guess

% Call the energyBalance function
T = fsolve(@(T) energyBalance3(T, numNodesX, numNodesY, Dx, Dy, k, hi, Ti_K, thickness), T0, options);

% Reshape T into a matrix 
Tnodes = reshape(T, numNodesY, numNodesX);

% Display temperatures at nodal points 
disp('Temperatures at Nodal Points (in K):');
disp(Tnodes);

% Calculate rate of heat loss 
sigma = 5.67e-8; % Stefan-Boltzmann constant in W/m2·K4
A = 0.2 * 0.2; % Surface area in m2
To = mean(Tnodes(:, 1)); % Average outer surface temperature in K
Q_conv = ho * A * (To - Ti); % Heat transfer by convection in W
Q_rad = e * sigma * A * (To^4 - Tsky_K^4); % Heat transfer by radiation in W
Q_total = Q_conv + Q_rad; % Total heat transfer in W

% Display rate of heat loss 
disp('Rate of Heat Loss (in W):');
disp(Q_total);
