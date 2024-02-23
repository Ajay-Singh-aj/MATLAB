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

% Calculations - Finite Difference Method 
% Note: This is just an example, you need to adapt it according to your specific needs

% Convert temperatures to Kelvin for calculations 
Ti_K = Ti + 273.15;
To_K = To + 273.15;

% Calculate number of nodes based on user-defined Dx and Dy 
numNodesX = round(0.2 / Dx) + 1;
numNodesY= round(0.2 / Dy) +1;

% Initialize matrix for temperatures at nodal points 
Tnodes= zeros(numNodesX,numNodesY);

% Solve the system of equations using fsolve 
options = optimoptions('fsolve','Display','none'); % Suppress output
T0 = ones(numNodesX*numNodesY,1)*Ti_K; % Initial guess
T = fsolve(@energyBalance,T0,options); % Solve for T

% Reshape T into a matrix 
Tnodes = reshape(T,numNodesY,numNodesX);

% Display temperatures at nodal points 
disp('Temperatures at Nodal Points (in K):');
disp(Tnodes);

% Calculate rate of heat loss 
sigma = 5.67e-8; % Stefan-Boltzmann constant in W/m2·K4
A = 0.2*0.2; % Surface area in m2
To = mean(Tnodes(:,1)); % Average outer surface temperature in K
Q_conv = ho*A*(To - To_K); % Heat transfer by convection in W
Q_rad = e*sigma*A*(To^4 - Tsky_K^4); % Heat transfer by radiation in W
Q_total = Q_conv + Q_rad; % Total heat transfer in W

% Display rate of heat loss 
disp('Rate of Heat Loss (in W):');
disp(Q_total);
function F = energyBalance(T)
    % T is a vector of unknown temperatures at nodal points 
    % F is a vector of energy balance equations 
    F = zeros(numNodesX*numNodesY,1); % Initialize F
    % Loop over all nodes 
    for i=1:numNodesX
        for j=1:numNodesY
            % Calculate the index of the node in the vector T 
            index = (i-1)*numNodesY + j;
            % Check the location of the node 
            if i==1 % Left symmetry line 
                F(index) = T(index) - T(index+1); % T1 = T2
            elseif i==numNodesX % Right symmetry line 
                F(index) = T(index) - T(index-1); % T9 = T8
            elseif j==1 % Bottom symmetry line 
                F(index) = T(index) - T(index+numNodesY); % T1 = T4
            elseif j==numNodesY % Top symmetry line 
                F(index) = T(index) - T(index-numNodesY); % T3 = T6
            else % Interior node 
                F(index) = k*(T(index-1) - 2*T(index) + T(index+1))/Dx^2 + ...
                    k*(T(index-numNodesY) - 2*T(index) + T(index+numNodesY))/Dy^2 + ...
                    hi*(T(index) - Ti_K); % Energy balance equation 
            end 
        end 
    end 
end 


