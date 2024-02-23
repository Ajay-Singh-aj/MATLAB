% Constants
A_CH3OH = 24.8679;
B_CH3OH = 4515.897;


% Given temperature
T = 210+273; % Temperature in K

% Pressure range
P_range = linspace(1, 78, 100); % Pressure from 1 to 78 bar

% Calculate vapor pressure of CH3OH
P_CH3OH = exp(A_CH3OH - (B_CH3OH/ T));

% Mole fraction range
x_CH3OH_range = linspace(0, 1, 100); % Mole fraction of CH3OH

% Initialize arrays for y_CH3OH
y_CH3OH = zeros(size(x_CH3OH_range));

% Loop to perform flash calculations
for i = 1:length(x_CH3OH_range)
    x_CH3OH = x_CH3OH_range(i);
    % Perform flash calculations here to find y_CH3OH
    % Fill in the code to calculate y_CH3OH for each x_CH3OH
end

% Create P-x-y plot
figure;
plot(x_CH3OH_range, P_CH3OH, 'b-', x_CH3OH_range, P_range, 'r--', x_CH3OH_range, y_CH3OH, 'g-');
xlabel('Mole Fraction CH3OH');
ylabel('Pressure (bar)');
legend('P_CH3OH', 'P', 'y_CH3OH');
title('P-x-y Plot at 210°C');
