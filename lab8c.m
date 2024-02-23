% Initial guess for components in Stream 5R

normDifference = 10000;  % Norm difference tolerance
tolerance = 1;
feedCO2 = 2000;
feedH2 = 4000;
stream5RCO2 = 1000;
stream5RH2 = 1000;
stream5RMethanol =1000;
stream5RWater = 1000;

while normDifference > tolerance
    totalCO2 = feedCO2 + stream5RCO2;
    totalH2 = feedH2 + stream5RH2;

    % Component balance on the Reactor
    reactorCO2 = totalCO2 * 0.7;
    reactorH2 = totalH2 - totalCO2 * 0.9;
    reactorMethanol = totalCO2 * 0.3 + stream5RMethanol;
    reactorWater = totalCO2 * 0.3 + stream5RWater;
    totalReactant = reactorCO2 + reactorMethanol + reactorH2 + reactorWater;

    % Rachford-Rice procedure on Flash
    % Calculating equilibrium constants for different components
    kMethanol = (exp(24.6971 - 4941.2833 / 313)) / 7800000;
    kCO2 = (exp(22.36 - 1992.9 / 313)) / 7800000;
    kWater = (exp(24.6961 - 4941.2833 / 313)) / 7800000;
    kH2 = 1440000000 / 7800000;

    moleFractionMethanol = reactorMethanol / totalReactant;
    moleFractionCO2 = reactorCO2 / totalReactant;
    moleFractionWater = reactorWater / totalReactant;
    moleFractionH2 = reactorH2 / totalReactant;

    guessStream5R = [stream5RCO2, stream5RH2, stream5RMethanol, stream5RWater];
    
    % Solving for equilibrium using fsolve
    equilibriumX = fsolve(@(equilibriumX) (moleFractionMethanol * (1 - kMethanol) / (1 + X * (kMethanol - 1)) + ...
        moleFractionCO2 * (1 - kCO2) / (1 + X * (kCO2 - 1)) + ...
        moleFractionWater * (1 - kWater) / (1 + X * (kWater - 1)) + ...
        moleFractionH2 * (1 - kH2) / (1 + X * (kH2 - 1))), [0.7], ...
        optimoptions('fsolve', 'Display', 'off'));

    stream5RMethanolOutlet = equilibriumX * totalReactant;
    stream5ROther = totalReactant - stream5RMethanolOutlet;
    stream5RCO2Outlet = moleFractionCO2 * stream5ROther / (1 + equilibriumX * (kCO2 - 1));
    stream5RH2Outlet = moleFractionH2 * stream5ROther / (1 + equilibriumX * (kH2 - 1));
    stream5RMethanolOutlet = moleFractionMethanol * stream5ROther / (1 + equilibriumX * (kMethanol - 1));
    stream5RWaterOutlet = moleFractionWater * stream5ROther / (1 + equilibriumX * (kWater - 1));

    % Update Stream 5R components
    stream5RCO2 = 0.95 * stream5RCO2Outlet;
    stream5RMethanol = 0.95 * stream5RMethanolOutlet;
    stream5RWater = 0.95 * stream5RWaterOutlet;
    stream5RH2 = 0.95 * stream5RH2Outlet;

    % Calculate the norm difference
    normDifference = norm(guessStream5R - [stream5RCO2, stream5RH2, stream5RMethanol, stream5RWater]);
end
