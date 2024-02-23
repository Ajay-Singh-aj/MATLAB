% Given pressure in pascal
P = 78*10^(5);  

% Antoine equation coefficients for CH3OH and CO2
A_ch3oh = 24.834;
B_ch3oh = 4504.4;
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
% Given data
z_CO2 = 0.25; % Mole fraction of CO2 in stream 1
z_CH3OH = 0.12; % Mole fraction of CH3OH in stream 1
z_H2O = 0.12; % Mole fraction of H2O in stream 1
z_H2 = 0.51; % Mole fraction of H2 in stream 1

F = 1.0; % Total feed flow rate (you can adjust this value)

%antoinne equations
fun_ch3oh = @(T) exp(24.834 - 4504.4 / (T));
fun_co2 = @(T) exp(22.36 - 1992.9 / (T));
fun_h20 = @(T) exp(24.713 - 4946.6/ (T));
fun_h2 = 1.44*10^(9);

% Initialize arrays to store recovery ratios
R_CO2 = zeros(78, 228); % For CO2 recovery
R_CH3OH = zeros(78, 228); % For CH3OH recovery
R_H2 = zeros(78, 228); % For H2 recovery
R_H2O = zeros(78, 228); % For H2O recovery

% Loop through pressure and temperature ranges OF CO2
for P = 10^(5):10^(5):78*10^(5)
    for T = 273.15:1:500.15
        PB=z_H2*fun_h2+z_H2O*fun_h20(T)+z_CH3OH*fun_ch3oh(T)+z_CO2*fun_co2(T);
        PD=1/(z_H2/fun_h2+z_H2O/fun_h20(T)+z_CH3OH/fun_ch3oh(T)+z_CO2/fun_co2(T));
      
        % Initialize variables
        x = zeros(4, 1); % Liquid phase composition
        y = zeros(4, 1); % Vapor phase composition
        V = 0; % Vapor flow rate
        L = 0; % Liquid flow rate

        if P >  PB % Feed is in liquid phase
            x = [z_CO2; z_H2O; z_CH3OH; z_H2];
            y = [0; 0; 0; 0];
            L = F;
        elseif P < PD % Feed is in vapor phase
            y = [z_CO2; z_H2O; z_CH3OH; z_H2];
            x = [0; 0; 0; 0];
            V= F;
        else % Two-phase equilibrium
            % Calculate K values
            K_CO2 = fun_co2(T)/P;
            K_H2O = fun_h20(T)/P;
            K_CH3OH = fun_ch3oh(T)/P;
            K_H2 = fun_h2/P;
            k=[K_CO2;K_H2O;K_CH3OH;K_H2];
            % Solve for Ψ
            eqn= @(phi)[(z_CO2*(1-K_CO2))/(1+phi*(K_CO2-1))+(z_H2O*(1-K_H2O))/(1+phi*(K_H2O-1))+(z_CH3OH*(1-K_CH3OH))/(1+phi*(K_CH3OH-1))+(z_H2*(1-K_H2))/(1+phi*(K_H2-1))];
            phi_sol= fsolve(eqn,10);
            % Calculate vapor and liquid compositions
            x = [z_CO2/(1+phi_sol*(K_CO2-1)); z_H2O/(1+phi_sol*(K_H2O-1)) ;z_CH3OH/(1+phi_sol*(K_CH3OH-1)) ;z_H2/(1+phi_sol*(K_H2-1))];
            y = x.*k;
            % Calculate vapor and liquid flow rates
            V = F * phi_sol;
            L = F - V;
        % Calculate recovery ratios
        Tk=T-272.15;
        P
        Pk=P/10^(5);
        R_CO2(Pk, Tk) = y(1)*V/z_CO2; % CO2 recovery
        R_CH3OH(Pk, Tk) = x(3)*L/z_CH3OH; % CH3OH recovery
        R_H2(Pk, Tk) = y(4)*V/z_H2; % H2 recovery
        R_H2O(Pk, Tk) = x(2)*L/z_H2O; % H2O recovery
        end
    end
end

% Create a meshgrid for pressure and temperature
[T, P] = meshgrid(273.15:1:500.15, 1:78);

% Create a grid for CO2 recovery
CO2_recovery = R_CO2;
CH3OH_recovery = R_CH3OH;
H2_recovery = R_H2;
H20_recovery = R_H2O;
contourf(P, T, CH3OH_recovery);
xlabel('Pressure (bar)');
ylabel('Temperature (K)');
title('CH3OH Recovery Contour Plot');
colorbar; % Add a colorbar for reference
[maxValue, maxIndex] = max(CH3OH_recovery(:));
[row, col] = ind2sub(size(CH3OH_recovery), maxIndex);

% Display the maximum value and its corresponding pressure and temperature
fprintf('Maximum CH3OH Recovery: %f\n', maxValue);
fprintf('Pressure at Maximum: %f bar\n', P(row, col));
fprintf('Temperature at Maximum: %f K\n', T(row, col));
figure;
% Create a contour plot for CO2 recovery
figure;
contourf(P, T, CO2_recovery);
xlabel('Pressure (bar)');
ylabel('Temperature (K)');
title('CO2 Recovery Contour Plot');
colorbar; % Add a colorbar for reference
[maxValue, maxIndex] = min(CO2_recovery(:));
[row, col] = ind2sub(size(CO2_recovery), maxIndex);

% Display the maximum value and its corresponding pressure and temperature
fprintf('Minimum CO2 Recovery: %f\n', maxValue);
fprintf('Pressure at Min: %f bar\n', P(row, col));
fprintf('Temperature at Min: %f K\n', T(row, col));
figure;
contourf(P, T, H20_recovery);
xlabel('Pressure (bar)');
ylabel('Temperature (K)');
title('H20 Recovery Contour Plot');
colorbar; % Add a colorbar for reference
figure;
[maxValue, maxIndex] = max(H20_recovery(:));
[row, col] = ind2sub(size(H20_recovery), maxIndex);

% Display the maximum value and its corresponding pressure and temperature
fprintf('Maximum h20 Recovery: %f\n', maxValue);
fprintf('Pressure at Maximum: %f bar\n', P(row, col));
fprintf('Temperature at Maximum: %f K\n', T(row, col));

contourf(P, T, H2_recovery);
xlabel('Pressure (bar)');
ylabel('Temperature (K)');
title('H2 Recovery Contour Plot');
colorbar; % Add a colorbar for reference
[maxValue, maxIndex] = min(H2_recovery(:));
[row, col] = ind2sub(size(CO2_recovery), maxIndex);

% Display the maximum value and its corresponding pressure and temperature
fprintf('Maximum h2 Recovery: %f\n', maxValue);
fprintf('Pressure at Maximum: %f bar\n', P(row, col));
fprintf('Temperature at Maximum: %f K\n', T(row, col));