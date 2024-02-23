
% Data
xCH3OH = [0.06, 0.10, 0.18, 0.26, 0.34, 0.42, 0.50, 0.56, 0.64, 0.78, 0.90];
Temp_MATLAB = [36.8499, 38.9520, 43.5444, 48.7577, 54.7574, 61.7783, 70.1678, 77.6698, 89.9370, 121.897, 170.146];
Temp_ASPEN = [36.3599, 38.3763, 42.7777, 47.7682, 53.5038, 60.2065, 68.2041, 75.3481, 87.0251, 117.625, 166.199];

% Calculate the Mean Squared Error (MSE)
MSE = mean((Temp_MATLAB - Temp_ASPEN).^2);

% Display the MSE
disp(['Mean Squared Error (MSE): ', num2str(MSE)]);
