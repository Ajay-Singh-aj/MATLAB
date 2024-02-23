% Given data from Table 1
molarFlow1 = 2000; % kmol/h
molarFlow2 = 4000; % kmol/h
molarFlow5 = 8787.2; % kmol/h
temperature1 = 210; % °C
temperature5 = 40; % °C
pressure1 = 78; % bar
pressure5 = 78; % bar
 
% Molar flow rates of individual components
molarFlowCO2_1 = 2000; % kmol/h
molarFlowH2_2 = 4000; % kmol/h
molarFlowCO2_3 = 4064; % kmol/h
molarFlowH2_3 = 10266.1; % kmol/h
molarFlowCH3OH_3 = 14.8; % kmol/h
molarFlowH2O_3 = 3.1; % kmol/h
molarFlowCO2_5r=2172.6*0.95;
molarFlowH2O_5r=3.3*0.95;
molarFlowH2_5r=6595.8*0.95;
molarFlowCH3OH_5r=15.5*0.95;
n6CO2=2844.8-2172.6;
n6H2=6608.5-6595.8;
n6H2O=1222.3-3.3;
n6CH3OH=1233.9-15.5;
 
% Constants (heat capacity and enthalpy of vaporization)
h1_CO2=enthalpy_CO2(25,210);
h5r_CO2=enthalpy_CO2(25,40);
h2_H2=enthalpy_H2(25,210);
h5r_H2=enthalpy_H2(25,40);
h5r_CH3OH=enthalpy_CH3OH_liq(25,64.7)+35.27+enthalpy_CH3OH_vap(64.7,40);
h5r_H2O=enthalpy_H2O_liq(25,100)+40.656+enthalpy_H2O_vap(100,40);
%CALCULATING ENERGY INPUT
Energy_in=molarFlowCO2_1*h1_CO2+molarFlowH2_2*h2_H2+molarFlowCO2_5r*h5r_CO2+molarFlowH2_5r*h5r_H2+molarFlowCH3OH_5r*h5r_CH3OH+molarFlowH2O_5r*h5r_H2O;
%Calculating temp 3
Temperature3=fsolve(@(T) Energy_in-molarFlowCO2_3*enthalpy_CO2(25,T)-molarFlowH2_3*enthalpy_H2(25,T)-molarFlowH2O_3*(enthalpy_H2O_liq(25,100)+40.656+enthalpy_H2O_vap(100,T))-molarFlowCH3OH_3*(enthalpy_CH3OH_liq(25,64.7)+35.27+enthalpy_CH3OH_vap(64.7,T)),0);
%calculating molar enthalpy of stream 4,5,6
H_5=h5r_H2O*3.3+h5r_CH3OH*15.5+h5r_H2*6595.8+h5r_CO2*2172.6;
H_4=2844.8*enthalpy_CO2(25,210)+6608.5*enthalpy_H2(25,210)+1233.9*(enthalpy_CH3OH_liq(25,64.7)+35.27+enthalpy_CH3OH_vap(64.7,210))+1222.3*(enthalpy_H2O_liq(25,100)+40.656+enthalpy_H2O_vap(100,210));
H_6=n6CO2*(enthalpy_CO2(25,40)-304.2)+n6H2*(enthalpy_H2(25,40)-0.904)+n6H2O*enthalpy_H2O_liq(25,40)+n6CH3OH*enthalpy_CH3OH_liq(25,40);
%calculating heat duty
Q=H_5+H_6-H_4;
HEAT_DUTY=Q/3600;
fprintf('Estimated Temperature of Stream 3: %f °C\n', Temperature3);
fprintf('Cooling Requirement of Cooler C1: %f J/S\n', HEAT_DUTY);
function dh_CO2 =enthalpy_CO2(Tmin , Tmax)
fun=@(T) 36.11*10^(-3)+4.23*10^(-5)*T-2.88*10^(-8)*T.^2+7.46*10^(-12)*T.^3;
dh_CO2=integral(fun,Tmin,Tmax);
end
function dh_H2 =enthalpy_H2(Tmin , Tmax)
fun=@(T) 28.84*10^(-3)+0.00765*10^(-5)*T+0.3288*10^(-8)*T.^2-0.8698*10^(-12)*T.^3;
dh_H2=integral(fun,Tmin,Tmax);
end
function dh_H2O =enthalpy_H2O_liq(Tmin , Tmax)
dh_H2O=75.4*10^(-3)*(Tmax-Tmin);
end
function dh_CH3OH =enthalpy_CH3OH_liq(Tmin , Tmax)
fun=@(T) 75.86*10^(-3)+16.83*10^(-5)*T;
dh_CH3OH=integral(fun,Tmin,Tmax);
end
function dh_H2O =enthalpy_H2O_vap(Tmin , Tmax)
fun=@(T) 33.46*10^(-3)+0.688*10^(-5)*T+0.7604*10^(-8)*T.^2-3.593*10^(-12)*T.^3;
dh_H2O=integral(fun,Tmin,Tmax);
end
function dh_CH3OH =enthalpy_CH3OH_vap(Tmin , Tmax)
fun=@(T) 42.93*10^(-3)+8.301*10^(-5)*T-1.87*10^(-8)*T.^2-8.03*10^(-12)*T.^3;
dh_CH3OH=integral(fun,Tmin,Tmax);
end