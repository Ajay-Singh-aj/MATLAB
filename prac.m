syms F3_CO2 F4_CO2 F2_H2 F3_H2 F4_H2 F3_H2O F4_H2O F3_CH3OH F4_CH3OH;
syms F5_CO2 F5_H2 F5_CH3OH F5_H2O;
syms F5P_CO2 F5P_H2 F5P_CH3OH F5P_H2O F5R_CO2 F5R_H2 F5R_CH3OH F5R_H2O;
syms F8_CO2  F8_CH3OH F8_H2O F7_CO2 F7_H2 F7_CH3OH F7_H2O;
syms F9_CO2 F9_CH3OH F9_H2O F10_H2O extent;

overall_conv = 0.6356;
F1_CO2 = 2000;
R = 2; 
b = 0.05;

% with recycle 
F6_CO2 = 145.338; F6_H2 = 0.789; F6_CH3OH = 1265.53; F6_H2O = 1269.99;
ratio_h2o_10_8 = 0.9909;
F8_H2 = 0; F9_H2 = 0; F10_CO2 = 0; F10_H2 = 0; F10_CH3OH = 0;

mol_wt_H2 = 2; 
mol_wt_CO2 = 44; 
mol_wt_CH3OH = 32; 
mol_wt_H2O = 18;

eqns1 = [
     
    F1_CO2 + F5R_CO2 == F3_CO2;
    F2_H2 == R*F1_CO2;
    F2_H2 + F5R_H2 == F3_H2;
    F5R_CH3OH == F3_CH3OH;
    F5R_H2O == F3_H2O;
    %overall conversion is given
    (F1_CO2 - F6_CO2 - b*F5_CO2)/F1_CO2 == overall_conv; 
    %component mass balance around R1 
    F3_CO2 - extent == F4_CO2;
    F3_H2 - 3*extent == F4_H2; 
    F3_CH3OH + extent == F4_CH3OH;
    F3_H2O + extent == F4_H2O;

    
    F4_CO2 == F5_CO2 + F6_CO2;
    F4_H2 == F5_H2 + F6_H2;
    F4_CH3OH == F5_CH3OH + F6_CH3OH;
    F4_H2O == F5_H2O + F6_H2O;

     
    (1-b)*F5_CO2 == F5R_CO2;
    (1-b)*F5_H2 == F5R_H2;
    (1-b)*F5_CH3OH == F5R_CH3OH;
    (1-b)*F5_H2O == F5R_H2O;
    
    F6_CO2 == F7_CO2 + F8_CO2; 
    F6_H2 == F7_H2;
    F6_CH3OH == F7_CH3OH + F8_CH3OH;
    F6_H2O == F7_H2O + F8_H2O;
     
    F7_CO2 == 57.74*F8_CO2; 
    F7_H2O == 0.0043*F8_H2O;
    F7_CH3OH == 0.0212*F8_CH3OH;
  
    F8_CO2 == F9_CO2; 
    F8_H2O == F9_H2O + F10_H2O;
    F8_CH3OH == F9_CH3OH;
    F10_H2O == ratio_h2o_10_8*F8_H2O,
    ];



sol = solve(eqns1, [extent,  F2_H2, F3_CO2, F3_H2, F3_CH3OH, F3_H2O, F4_CO2, F4_H2, F4_CH3OH, F4_H2O, ...
    F5_CO2, F5_H2, F5_CH3OH, F5_H2O, F5R_CO2, F5R_H2, F5R_CH3OH, F5R_H2O, F7_CO2, F7_H2, F7_CH3OH, F7_H2O, ...
    F8_CO2, F8_CH3OH, F8_H2O, F9_CO2, F9_H2O, F9_CH3OH, F10_H2O]);


F3 = double(sol.F3_H2 + sol.F3_CO2 + sol.F3_CH3OH + sol.F3_H2O);
F4 = double(sol.F4_H2 + sol.F4_CO2 + sol.F4_CH3OH + sol.F4_H2O);
F5 = double(sol.F5_H2 + sol.F5_CO2 + sol.F5_CH3OH + sol.F5_H2O);
F5R = double(sol.F5R_H2 + sol.F5R_CO2 + sol.F5R_CH3OH + sol.F5R_H2O);
F6 = double(F6_H2 + F6_CO2 + F6_CH3OH + F6_H2O);
F7 = double(sol.F7_H2 + sol.F7_CO2 + sol.F7_CH3OH + sol.F7_H2O); 
F8 = double(F8_H2 + sol.F8_CO2 + sol.F8_CH3OH + sol.F8_H2O);
F9 = double(F9_H2 + sol.F9_CO2 + sol.F9_CH3OH + sol.F9_H2O);
F10 = double(F10_H2 + F10_CO2 + F10_CH3OH + sol.F10_H2O);

disp(['The molar flow rate of stream 3 is: ', num2str(F3)]); 
disp(['The molar flow rate of stream 4 is: ', num2str(F4)]);
disp(['The molar flow rate of stream 5 is: ', num2str(F5)]); 
disp(['The molar flow rate of stream 5R is: ', num2str(F5R)]);
disp(['The molar flow rate of stream 6 is: ', num2str(F6)]); 
disp(['The molar flow rate of stream 7 is: ', num2str(F7)]); 
disp(['The molar flow rate of stream 8 is: ', num2str(F8)]); 
disp(['The molar flow rate of stream 9 is: ', num2str(F9)]); 
disp(['The molar flow rate of stream 10 is: ', num2str(F10)]); 


Comp1 = 14694200;
Comp2 = 29418000; 
Rcomp = 1434700;
F1 = 171300*(F4/4669.7)^0.6; 
H1 = 63000*(F8/1302.96)^0.6; 
C1 = 269600*(F4/4669.7)^0.6;
F2 = 168100*(F6/1349.53)^0.6;
D1 = 1507900*(F8/1302.96)^0.6;

Mass = double(sol.F3_H2*mol_wt_H2 + sol.F3_CO2*mol_wt_CO2 + ...
    sol.F3_CH3OH*mol_wt_CH3OH + sol.F3_H2O*mol_wt_H2O); % kg/hr
C_reactor = 0.14*10.9*(10^7)*((Mass)/54000)^0.65;


% power consumption by equipment
P_comp1 = 9.7; 
P_comp2 = 21.5;
P_rcomp = 0.97;
H_R1 = 19.76; 
H_H1 = 1.763; 
H_D1 = 30.22; 
C_comp1 = 12.03; 
C_comp2 = 20.97;
C_C1 = 65.65; 
C_D1 = 29.6; 
price_power = 0.072; 
price_cooling_water = 2.12e-7;
price_steam = 2.5e-6;

% capital recovery factor 
crf = 0.1;

price_co2 = linspace(0.025, 1);  
price_H2 = linspace(0.5, 2); 

 
t = 7884; 
annual_capital_cost = crf*(Comp1 + Comp2 + Rcomp + F1 + H1 + C1 + F2 + D1 + C_reactor);
annual_power_cost = (P_comp1 + P_comp2)*price_power*1000*t;
annual_heat_cost = (H_R1 + H_H1 + H_D1)*price_steam*t*3600;
annual_cooling_cost = (C_comp1 + C_comp2 + C_C1 + C_D1)*price_cooling_water*1000*t*3600;
annual_methanol_produced = double(sol.F9_CH3OH)*mol_wt_CH3OH*t/1000; % tonne

cost_methanol = zeros(100, 100);

for i = 1:100
    for j = 1:100
        annual_H2_cost = price_H2(i)*double(sol.F2_H2)*mol_wt_H2*t; 
        annual_CO2_cost = price_co2(j)*double(F1_CO2)*mol_wt_CO2*t;
        annual_operating_cost = annual_power_cost + annual_heat_cost + annual_cooling_cost + annual_H2_cost + annual_CO2_cost;
        total_annual_cost = annual_operating_cost + annual_capital_cost;
        cost_methanol(i,j) = total_annual_cost/ annual_methanol_produced; 
    end
end

figure;
pco2 = linspace(0.025,1,100);
ph2 = linspace(0.5,2,100);

for i=1:100
for j=1:100
F3 = 2000*44 + 4000*2;
C_cap(i,j) = 14694200 + 29418000 + (1.53*(10^7)*((F3/54000)^0.65)) + 269600 + 171300 + 168100 + 63000 + 1507900;
phi = 0.1;
C_op(i,j) = (9.7+21.5 )*72 + (0.28+0.8+15.7)*1000*3600*2.5*(10^-6) + (12+20.9+22.6+15.4)*1000*3600*2.12*(10^-7) + (2000*44)*pco2(i) + (4000*2)*ph2(j)*7884;
TAC(i,j) = phi*C_cap(i,j) + C_op(i,j);
C_methanol(i,j) = TAC(i,j)/(7884*(641.3556*32/1000));
end
end

%Let's plot the contour plot now
contour(ph2,pco2,C_methanol,1000);
colorbar;
xlabel('CO2 Prices');
ylabel('H2 Prices');
title('Total Annual Cost of Methanol Production');
cost_methanol_wr =C_methanol ;
cost_methanol_diff = cost_methanol_wr - cost_methanol; 
contourf(price_H2, price_co2, cost_methanol_diff, 100, 'LineColor', 'none');
colorbar
xlabel('Hydrogen price ($/kg)');
ylabel('CO_2 price ($/kg)');
fontname('Times');
fontsize(18, 'points');
ylim([0.025, 1]);
xlim([0.5, 2]);

fix_H2_price = 1; %% $/kg
fix_CO2_price = 0.1; %% $/kg
raw_material_cost = (fix_H2_price*double(sol.F2_H2)*mol_wt_H2 + fix_CO2_price*double(F1_CO2)*mol_wt_CO2)*t;

xcat = categorical({'With recycle', 'Without recycle'});

costs = [annual_capital_cost/annual_methanol_produced annual_power_cost/annual_methanol_produced annual_heat_cost/annual_methanol_produced annual_cooling_cost/annual_methanol_produced raw_material_cost/annual_methanol_produced;
    42.31 109.43 7.36 2.63 818.39];
figure;
b = bar(xcat, costs, 'stacked');
b(1).BarWidth = 0.25;
ylabel('Methanol price ($/tonne)');
legend('Capital cost', 'Electricity', 'Steam', 'Cooling water', 'Raw material');
fontname('Times');
fontsize(18, 'points');


