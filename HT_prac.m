% Given data
Ti = 300 + 273;      % Average temperature of hot gases in the chimney (K)
To = 20 + 273;       % Ambient temperature (K)
Tsky = 260;          % Effective sky temperature (K)
Dx = 0.1;
Dy = 0.1;
k = 1.4;             % Thermal conductivity of concrete (W/m·K)
hi = 70;             % Convection heat transfer coefficient inside chimney (W/m^2·K)
ho = 21;             % Convection heat transfer coefficient outside chimney (W/m^2·K)
e = 0.9;             % Emissivity of outer surface
sigma = 5.67e-8;
% enter the value for Dx
%Dx= input('Enter the value for Dx: ');

% enter the value for Dy
%Dy= input('Enter the value for Dy: ');


% Initial guess for the temperatures
initial_guess = 273 * ones(1, 9);  % All temperatures start at 273 K

% Define the system of equations
fun = @(T) [
    (hi * (Dx/2) * (Ti) + k * (Dy/2) * (T(2) - T(1))/Dx + k * (Dx/2) * (T(3) - T(1))/Dy)/(hi * (Dx/2)) - T(1);
    (k * (Dy/2) * (T(1))/Dx + hi * (Dx/2) * (Ti - T(2)) + 0 + k * (Dx) * (T(4) - T(2))/Dy) * Dx/(k * (Dy/2)) - T(2);
    (T(4) + T(1) + T(4) + T(6)) / 4 - T(3);
    (T(3) + T(2) + T(5) + T(7)) / 4 - T(4);
    (T(4) + T(4) + T(8) + T(8)) / 4 - T(5);
    (0 + k * (Dx/2) * (T(3) - T(6))/Dy + k * (Dy/2) * (T(7))/Dx + ho * (Dx/2) * (To - T(6)) + e * sigma * (Dx/2) * ((Tsky)^4 - (T(6))^4)) * Dx/(k * (Dy/2)) - T(6);
    (k * (Dx) * (T(4) - T(7))/Dy + k * (Dy/2) * (T(6))/Dx + k * (Dy/2) * (T(8) - T(7))/Dx + ho * (Dx) * (To - T(7)) + e * sigma * (Dx) * ((Tsky)^4 - (T(7))^4)) * Dx/(k * (Dy/2)) - T(7);
    (k * (Dx) * (T(5) - T(8))/Dy + k * (Dy/2) * (T(7))/Dx + k * (Dy/2) * (T(9) - T(8))/Dx + ho * (Dx) * (To - T(8)) + e * sigma * (Dx) * ((Tsky)^4 - (T(8))^4)) * Dx/(k * (Dy/2)) - T(8);
    (0 + k * (Dy/2) * (T(8))/Dx + ho * (Dx/2) * (To - T(9)) + e * sigma * (Dx/2) * ((Tsky)^4 - (T(9))^4)) * Dx/(k * (Dy/2)) - T(9);
];

% Solve the system of equations
options = optimoptions('fsolve', 'Display', 'iter');
temperatures = fsolve(fun, initial_guess, options);
disp('Temperatures at each node:');
disp(temperatures);
T=temperatures;
Twall_out=(0.5*T(6)+T(7)+T(8)+0.5*T(9))/(0.5+1+1+0.5);
Twall_in=(T(1)+T(2))/2;
Ao=4*0.6;
Ai=4*0.2;
Qchimney1=ho*Ao*(Twall_out-To)+e*sigma*Ao*((Twall_out)^4-(Tsky)^4);
Qchimney2=hi*Ai*(Ti-Twall_in);

for i = 1:numel(T)
    fprintf('Temperature at node %d is %.4f K\n', i, temperatures(i));
end
fprintf('heat transfer rate of chimney through method 1 is:  %f W\n', Qchimney1);
fprintf('heat transfer rate of chimney through method 2 is:  %f W\n', Qchimney2);