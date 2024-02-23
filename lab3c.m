% Given data
CO2_price_range = 0.025:0.0625:1;  % CO2 price from $0.025 to $1 per kg
H2_price_range = 0.5:0.1:2; % H2 price from $0.5 to $2 per kg
F3=56000;

% Initialize arrays to store results
CMethanol = zeros(length(CO2_price_range), length(H2_price_range));
Creactant = zeros(length(CO2_price_range), length(H2_price_range));
Cop = zeros(length(CO2_price_range), length(H2_price_range));

% Constants
phi = 0.1;  % Capital recovery factor


        % Calculate annual operating costs
        Celec =(9.7+21.5)*7884*0.072*1000;  % Calculate electricity cost
        Cstream=(0.28+0.8+15.7)*1000*2.5*10^(-6)*7884*60*60; % Calculate steam cost
        Ccool=(12+20.9+22.6+15.4)*1000*7884*0.212*10^(-7); % Calculate cooling water cost
for i = 1:length(CO2_price_range)
    for j = 1:length(H2_price_range)
        Creactant(i,j) = 2000*44*7884*(CO2_price_range(i) + 4000*2*7884*3* H2_price_range(j));% Calculate reactant (CO2 and H2) cost    
    end
end
for i = 1:length(CO2_price_range)
    for j = 1:length(H2_price_range)
        Cop(i,j)=Celec+Cstream+Ccool+Creactant(i,j);
    end
end
for i = 1:length(CO2_price_range)
    for j = 1:length(H2_price_range)
        % Calculate total annual cost (TAC)
        TAC(i,j) = phi * (sum([14694200, 29418000, 1.53*10^(7) * (F3 / 54000)^0.65, 269600, 171300, 168100, 63000, 1507900])) + Cop(i,j);
    end
end
        
        % Calculate annual production of methanol (PMethanol)
        PMethanol = 7884 * 0.3325 * 679.93 / 1000;  % Assuming plant operates for 7884 hours
for i = 1:length(CO2_price_range)
    for j = 1:length(H2_price_range)
        % Calculate methanol production cost (CMethanol)
        CMethanol(i, j) = TAC(i,j) / PMethanol;
    end
end
    
% Create contour plot
contourf(CO2_price_range, H2_price_range, CMethanol);
colorbar;
xlabel('CO2 Price ($/kg)');
ylabel('H2 Price ($/kg)');
title('Methanol Production Cost Contour Plot');
