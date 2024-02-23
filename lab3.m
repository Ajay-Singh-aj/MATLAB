% Define equations for material and component balances
% here molar flow rate is shown br nx,y=Mx,Y 
% where x is no. of stream and y is name of compound
%in stream 4
Mco2=2000 ;
Mh2=4000;
M4co2=Mco2*0.6675;
M4ch3oh=Mco2*0.3325;% Given parameters and data
% Define equations for material and component balances
%in stream 3
M3 = Mco2+Mh2;
M4h2o=M4ch3oh;
M4h2=4000-(3*M4ch3oh);
%in stream 5%Crea=2000*44*7884*CO2_prices(i)+4000*2*7884*H2_prices(i);
M5co2=M4co2*0.972;
M5ch3oh=M4ch3oh*0.0235;
M5h2o=3.103;
M5h2=M4h2*0.9997;
%in stream 6
M6co2=M4co2*0.028;
M6ch3oh=M4ch3oh*0.9765;
M6h2o=M4h2o-3.103;
M6h2=M4h2*0.0003;
%in stream 8
M8co2=M6co2/(30.89+1);
M8ch3oh=M6ch3oh/(0.0125+1);
M8h2o=M6h2o/(0.00265+1);
M8h2=0;
%in stream 7
M7co2=M8co2*30.89;
M7ch3oh=M8ch3oh*0.0125;
M7h2o=M8h2o*0.00265;
M7h2=M6h2;

%in stream 9
M9co2=M8co2;
M9ch3oh=M8ch3oh;
M9h2o=0;
M9h2=0;
%in stream 10
M10co2=0;
M10ch3oh=0;
M10h2o=M8h2o;
M10h2=0;
M4=M4co2+M4ch3oh+M4h2o+M4h2;
M5=M5co2+M5ch3oh+M5h2o+M5h2;
M6=M6co2+M6ch3oh+M6h2o+M6h2;
M7=M7co2+M7ch3oh+M7h2o+M7h2;
M8=M8co2+M8ch3oh+M8h2o+M8h2;
M9=M9co2+M9ch3oh+M9h2o+M9h2;
M10=M10co2+M10ch3oh+M10h2o+M10h2;
fprintf("The molar flow rate of stream 3 is");
disp(M3);
fprintf("The molar flow rate of stream 4 is");
disp(M4);
fprintf("The molar flow rate of stream 5 is");
disp(M5);
fprintf("The molar flow rate of stream 6 is");
disp(M6);
fprintf("The molar flow rate of stream 7 is");
disp(M7);
fprintf("The molar flow rate of stream 8 is");
disp(M8);
fprintf("The molar flow rate of stream 9 is");
disp(M9);
fprintf("The molar flow rate of stream 10 is");
disp(M10);

% Given data
CO2_price_range = 0.025:0.025:1;  % CO2 price from $0.025 to $1 per kg
H2_price_range = 0.5:0.1:2; % H2 price from $0.5 to $2 per kg
F3=M3;

% Initialize arrays to store results
CMethanol = zeros(length(CO2_price_range), length(H2_price_range));
Creactant = zeros(length(CO2_price_range), length(H2_price_range));
Cop = zeros(length(CO2_price_range), length(H2_price_range));

% Constants
phi = 0.1;  % Capital recovery factor


        % Calculate annual operating costs
        Celec =(9.7+21.5)*7884*0.072/3.6;  % Calculate electricity cost
        Cstream=(0.28+0.8+15.7)*2.5*7884; % Calculate steam cost
        Ccool=(12+20.9+22.6+15.4)*7884*0.212; % Calculate cooling water cost
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
        TAC(i,j) = phi * (sum([14694200, 29418000, 1.53e7 * (F3 / 54000)^0.65, 269600, 171300, 168100, 63000, 1507900])) + Cop(i,j);
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
contourf( H2_price_range,CO2_price_range, CMethanol);
colorbar;
xlabel('H2 Price ($/kg)');
ylabel('CO2 Price ($/kg)');
title('Methanol Production Cost Contour Plot');
