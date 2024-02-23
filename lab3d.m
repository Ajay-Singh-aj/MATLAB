% Known Parameters
CO2_price_range = 0.025:0.025:1; % CO2 price range from $0.025 to $1 per kg
H2_price_range = 0.5:0.1:2;     % H2 price range from $0.5 to $2 per kg
CO2_molar_flow_rate = 2000;     % Molar flow rate of CO2 (kmol/hr)
CO2_conversion = 0.3325;        % CO2 conversion fraction
H2O_molar_flow_rate_stream5 = 3.103; % Molar flow rate of H2O in stream 5 (kmol/hr)
hours_per_year = 7884;          % Number of operating hours per year
capital_recovery_factor = 0.1;  % Capital recovery factor

k=1.53*10^7*((F3)/54000)^(0.65);
F3=CO2_molar_flow_rate0*3;
F4nCH3OH=CO2_molar_flow_rate*CO2_conversion;F4nH2O=F4nCH3OH;F4nH2=CO2_molar_flow_rate*2-3*F4nCH3OH;F4nCO2=CO2_molar_flow_rate*F4nCH3OH;
F4ntotal=F4nCH3OH+F4nCO2+F4nH2+F4nH2O;
F4=F4ntotal;
X_CO2=F4nCO2/F4ntotal;
X_CH3OH=F4nCH3OH/F4ntotal;
X_H2=F4nH2/F4ntotal;
X_H2O=F4nH2O/F4ntotal;
F5=H2O_molar_flow_rate_stream5+F4*X_CO2*.972+F4*X_CH3OH*0.0235+F4*X_H2*0.9997;
F6=F4*X_H2O- H2O_molar_flow_rate_stream5+F4*X_CO2*(1-0.972)+F4*X_CH3OH*(1-0.0235)+F4*X_H2*(1-0.9997);
F7=


% Equipment Costs and Energy Consumption (from Table 1)
capital_costs =[14694200;29418000;k;269600;171300;168100;63000;1507900]; % Add other capital costs
electricity_consumption = [9.7; 21.5;0;0;0;0;0;0]; % Add other electricity consumption values
steam_consumption = [0; 0;0.28;0;0;00.8;15.7];           % Add other steam consumption values
cooling_water_consumption = [12; 20.9;0;22.6;0;0;0;15.4]; % Add other cooling water consumption values

% Utility Prices (from Table 2)
electricity_price = 0.072;  % $/kWh
steam_price = 2.5e-6;      % $/kJ
cooling_water_price = 2.12e-7; % $/kJ

% Unknown Flow Rates (to be calculated)
% Define variables for the unknown flow rates
% For example, F3, F4, F5, F7, F8, F9, F10, ...

% Example of a linear equation for a unit operation (adjust as needed)
% For instance, based on the reaction CO2 + 3H2 → CH3OH + H2O
% Use the mole balance equation for CH3OH:
% F3 * X_CO2 - F5 * X_CO2 = -F9 * X_CH3OH
% where X_CO2 is the molar fraction of CO2 in stream 3, X_CH3OH is the molar fraction of CH3OH in stream 9
% and other variables are flow rates.

% Define the coefficient matrix A and the right-hand side vector B for the system of equations
% A * unknown_flow_rates = B

% Example:
% A(1, 1) = X_CO2 - X_CO2; % Coefficient for the first equation
% A(1, 2) = -X_CO2;        % Coefficient for the second equation
% B(1) = -F9 * X_CH3OH;

% Solve the system of linear equations
unknown_flow_rates = A \ B;
% Calculate the total annual cost (TAC)
TAC = capital_recovery_factor * sum(capital_costs) + ...
      (sum(electricity_consumption) * electricity_price + ...
      sum(steam_consumption) * steam_price + ...
      sum(cooling_water_consumption) * cooling_water_price);

% Calculate the annual production of methanol (PMethanol)
PMethanol = unknown_flow_rates(index_of_methanol_stream) * hours_per_year;

% Calculate CMethanol
CMethanol = TAC / PMethanol;
% Create a grid of CO2 and H2 prices
[CO2_prices, H2_prices] = meshgrid(CO2_price_range, H2_price_range);

% Initialize a matrix to store CMethanol values
CMethanol_values = zeros(size(CO2_prices));

% Loop through CO2 and H2 prices and calculate CMethanol for each combination
for i = 1:length(CO2_price_range)
    for j = 1:length(H2_price_range)
        % Set CO2 and H2 prices
        CO2_price = CO2_prices(i, j);
        H2_price = H2_prices(i, j);
        
        % Calculate CMethanol for the given prices (similar to Step 4)
        % Store the result in CMethanol_values(i, j)
    end
end

% Create a contour plot
contour(CO2_prices, H2_prices, CMethanol_values);
colorbar;
xlabel('CO2 Price ($/kg)');
ylabel('H2 Price ($/kg)');
title('Cost of Methanol Production (CMethanol) Contour Plot');
