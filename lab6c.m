% Given pressure in pascal
P = 78*10^(5);  

% Antoine equation coefficients for CH3OH and CO2
A_ch3oh = 24.834;
B_ch3oh = 4515.897;
A_co2 = 22.36;
B_co2 = 1992.9;

% Initialize arrays for x1 (liquid phase mole fraction of CH3OH) and T (temperature)
x1 = linspace(0, 1, 201);  % Mole fraction of CH3OH in liquid phase
T_values = linspace(0, 1, 201);
y1 = linspace(0, 1, 201);  % Mole fraction of CH3OH in vapor phase

for j = 1:length(x1)
    % Initialize an initial guess for T
    T_guess = 100;  % Initial guess for temperature 

    % Define a function to find T that satisfies Raoult's law
    fun = @(T) (x1(j) * exp(A_ch3oh - B_ch3oh / (T + 273.15)) + (1 - x1(j)) * exp(A_co2 - B_co2 / (T + 273.15))-P);

    % Use fsolve to find the root
    T_values(j) = fsolve(fun, T_guess);

    % Calculate y1 using Raoult's law
    pvap_ch3oh = exp(A_ch3oh - B_ch3oh / (T_values(j) + 273.15));
    y1(j) = x1(j)*(pvap_ch3oh / P);
end

% Create a figure
figure('Position', [100, 100, 1000, 600]);

% Plot y1 vs. T
plot(y1, T_values, '-r', 'LineWidth', 3, 'DisplayName', 'Y_{CH_3OH}');
hold on
plot(x1, T_values, '-b', 'LineWidth', 3, 'DisplayName', 'X_{CH_3OH}');

% Add labels and title
xlabel('Liquid/Vapor Phase Mole Fraction of CH_3OH');
ylabel('Temperature (°C)');
title(['Vapor-Liquid Equilibrium of CH_3OH-CO_2 at P =78 bar ']);

% Adjust the legend size
legend('Location', 'best', 'FontSize', 12);

% Grid on for better visualization
grid on;