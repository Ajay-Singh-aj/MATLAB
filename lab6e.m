% Given temperature in Celsius and pressure in bar
T_Celsius = 210;
P = 78;

% Convert temperature to Kelvin
T_Kelvin = T_Celsius + 273.15;

% Antoine equation parameters for CH3OH
A1 = 24.834;
B1 = 4515.897;


% Antoine equation parameters for CO2
A2 = 22.36;
B2 = 1992.9;

% Calculate vapor pressures for CH3OH and CO2
p1_vap = 10^(A1 - (B1 / (T_Kelvin )));
p2_vap = exp(A2 - B2 / T_Kelvin);

% Initialize arrays for storing data points
x1_values = linspace(0, 1, 100); % Mole fraction of CH3OH in liquid phase
P_values = zeros(size(x1_values)); % Total pressure
y1_values = zeros(size(x1_values)); % Mole fraction of CH3OH in vapor phase

% Calculate P-x-y data points (Bubble Point)
for i = 1:length(x1_values)
    x1 = x1_values(i);
    
    % Calculate total pressure using Raoult's law for P-x-y plot
    P = x1 * p1_vap + (1 - x1) * p2_vap;
    P_values(i) = P;
    
    % Calculate mole fraction of CH3OH in vapor phase for P-x-y plot
    y1 = (x1 * p1_vap) / P;
    y1_values(i) = y1;
end

% Convert temperature to Kelvin for T-x-y plot
T_Kelvin = zeros(size(x1_values));

% Calculate T-x-y data points (Bubble Point)
for i = 1:length(y1_values)
    y1 = y1_values(i);
    
    % Solve for temperature (T) using fsolve for T-x-y plot
    equation = @(T) y1 * (10^(A1 - (B1 / (T )))) / P + (1 - y1) * (exp(A2 - B2 / T)) / P - 1;
    T_guess = 100; % Initial guess for temperature (in Celsius)
    T_solution = fsolve(equation, T_guess);
    T_Kelvin(i) = T_solution + 273.15;
end

% Create P-x-y plot
figure;
plot(x1_values, P_values, 'b-', x1_values, P_values, 'ro', y1_values, P_values, 'go');
xlabel('Mole Fraction of CH3OH');
ylabel('Pressure (bar)');
title('P-x-y Plot for CH3OH/CO2 at 210°C');
legend('P-x Curve', 'Bubble Point', 'Dew Point', 'Location', 'Northwest');
grid on;

% Create T-x-y plot
figure;
plot(x1_values, T_Kelvin, 'b-', x1_values, T_Kelvin, 'ro', y1_values, T_Kelvin, 'go');
xlabel('Mole Fraction of CH3OH');
ylabel('Temperature (K)');
title('T-x-y Plot for CH3OH/CO2 at 78 bar');
legend('T-x Curve', 'Bubble Point', 'Dew Point', 'Location', 'Northwest');
grid on;

 