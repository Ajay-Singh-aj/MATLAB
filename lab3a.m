% Given data
CO2_molar_flow_rate = 2000;  % kmol/hr
H2_molar_flow_rate = 4000;  % kmol/hr
CO2_conversion = 0.3325;
H2O_molar_flow_rate = 3.103;  % kmol/hr
F3 = 54000;  % kg/hr

% Define unknown flow rates
%Stream3=CO2_molar_flow_rate+H2_molar_flow_rate;
%Stream4=Stream3;
%Stream4=Stream5+Stream6;
%Stream6=Stream7+Stream8;
%Stream8=Stream9+Stream10;
% Define unknown flow rates
F1 = sym('F1');
F2 = sym('F2');
F4 = sym('F4');
F5 = sym('F5');
F7 = sym('F7');
F8 = sym('F8');

% Mass balance equations
%eq1 = F4 == CO2_molar_flow_rate - F1;
%eq2 = F5 == CO2_conversion * CO2_molar_flow_rate - F7;
%eq3 = F5 == 0.972 * CO2_molar_flow_rate;
%eq4 = F5 == 0.9997 * (F3 - F8);
%eq5 = F8 == F1 - F2;
%eq6 = F7 == 0.3089 * F8;
%eq7 = F8 == 0.00265 * H2O_molar_flow_rate + 0.0125 * F7;
% Mass balance equations
eq1 =  CO2_molar_flow_rate - F1;
eq2 =  CO2_conversion * CO2_molar_flow_rate - F7;
eq3 =  0.972 * CO2_molar_flow_rate;
eq4 =  0.9997 * (F3 - F8);
eq5 =  F1 - F2;
eq6 =  0.3089 * F8;
eq7 =  0.00265 * H2O_molar_flow_rate + 0.0125 * F7;
% Solve the system of linear equations
sol = solve([eq1, eq2, eq3, eq4, eq5, eq6, eq7], [F1, F2, F4, F5, F7, F8]);
