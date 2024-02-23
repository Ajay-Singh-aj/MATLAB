% Given parameters
k = 1.4; % W/m-K
e = 0.9;
Ti = 300; % °C
hi = 70; % W/m2-K
ho = 21; % W/m2-K
To = 20; % °C
sigma = 5.67e-8; % W/m2-K4
Tsky = 260; % K
L = 1; % m
Dx = 0.1; % m
Dy = 0.1;
% Finite difference equations for each node
f1 = @(T1, T2, T3) -(2+(hi*Dx/k)*T1+T2+T3) + hi*Dx*Ti/k;
f2 = @(T1, T2, T4) T1-(3+hi*Dx/k)*T2+2*T4 + hi*Dx*Ti/k;
f3 = @(T1, T2, T4, T6) T1 + T1 + T1 + T6 - 4*T4;
f4 = @(T2, T3, T4, T5, T7) T3 + T2 + T3 + T7 - 4*T1;
f5 = @(T4, T5, T7, T8) T4 + T5 + T7 + T8 - 4*T5;
f6 = @(T2, T3, T4) T2 + T3 - (2+ho*Dx/k)*T6 - e*sigma*Dx/2*(T4^4-Tsky^4)/k;
f7 = @(T4, T6, T8) 2*T4 + T6 + T8 - (4+2*ho*Dx/k)*T7 - e*sigma*Dx*(T4^4-Tsky^4)/k;
f8 = @(T5, T7, T9) 2*T5 + T7 + T9 - (4+2*ho*Dx/k)*T8 - e*sigma*Dx*(T5^4-Tsky^4)/k;
f9 = @(T8) T8 - (1+ho*Dx/k)*T9 - e*sigma*Dx/2*(T8^4-Tsky^4)/k;

% Initial guess for nodal temperatures
T1 = Ti +273; % K
 T2 =  Ti +273;
 T3 = Ti + 273;
 T4 =  Ti +273;
 T5 = Ti + 273;
 T6 = Ti + 273;
 T7 = Ti + 273;
 T8 =  Ti +273;
 T9 = Ti + 273;
 



% Solve the system of nonlinear equations using fsolve
F = @(T) [f1(T(1), T(2), T(3));
          f2(T(1), T(2), T(4));
          f3(T(1), T(2), T(4), T6);
          f4(T(2), T(3), T(4), T5, T7);
          f5(T(4), T(5), T7, T8);
          f6(T(2), T(3), T(4));
          f7(T(4), T6, T8);
          f8(T(5), T7, T9);
          f9(T(8))];
T = fsolve(F, [T1; T2; T3; T4; T5; T6; T7; T8; T9]);

% Extract nodal temperatures
T1 = T(1); T2 = T(2); T3 = T(3); T4 = T(4); T5 = T(5);
T6 = T(6); T7 = T(7); T8 = T(8); T9 = T(9);

% Calculate the rate of heat loss through the chimney
Ao = 4*(0.2*L); % m2
Twall_out = (0.5*T6 + T7 + T8 + 0.5*T9)/(0.5+1+1+0.5); % K
Twall_in = (T1 + T2)/2; % K
Q = ho*Ao*(Twall_out - To + 273) + e*sigma*Ao*(Twall_out^4 - Tsky^4)/k; % W

% Display nodal temperatures and heat loss
disp(['T1 = ' num2str(T1-273) ' °C']);
disp(['T2 = ' num2str(T2-273) ' °C']);
disp(['T3 = ' num2str(T3-273) ' °C']);
disp(['T4 = ' num2str(T4-273) ' °C']);
disp(['T5 = ' num2str(T5-273) ' °C']);
disp(['T6 = ' num2str(T6-273) ' °C']);
disp(['T7 = ' num2str(T7-273) ' °C']);
disp(['T8 = ' num2str(T8-273) ' °C']);
disp(['T9 = ' num2str(T9-273) ' °C']);
disp(['Heat loss = ' num2str(Q) ' W']);