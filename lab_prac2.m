Ti = 300+273;           % Average temperature of hot gases in the chimney (°C)
To = 20+273;            % Ambient temperature (°C)
Tsky = 260;       % Effective sky temperature (K)
l = 0.2;            % Length of a side of the square chimney (m)
k = 1.4;            % Thermal conductivity of concrete (W/m·K)
hi = 70;            % Convection heat transfer coefficient inside chimney (W/m^2·K)
ho = 21;            % Convection heat transfer coefficient outside chimney (W/m^2·K)
e = 0.9;            % Emissivity of outer surface
sigma = 5.67e-8;
% at node 1
T1=(0+hi*(Dx/2)*(Ti)+k*(Dy/2)*(T2-T1)/Dx+k*(Dx/2)*(T3-T1)/Dy)/(hi*(Dx/2));
% at node 2
T2=(k*(Dy/2)*(T1)/Dx+hi*(Dx/2)*(Ti-T2)+0+k*(Dx)*(T4-T2)/Dy)*Dx/(k*(Dy/2));
% at node 3
T3=(T4 + T1 + T4 + T6 )/4 ;
%at node 4
T4=(T3 + T2+T5 + T7)/4 ;
%at node 5
T5=(T4 + T4+T8 + T8)/4 ;
% at node 6
T6=(0+k*(Dx/2)*(T3-T6)/Dy+k*(Dy/2)*(T7)/Dx+ho*(Dx/2)*(To-T6)+e*sigma *(Dx/2)*(Tsky)^4-(T6)^4)*Dx/(k*(Dy/2));
% at node 7
T7=(k*(Dx)*(T4-T7)/Dy+k*(Dy/2)*(T6)/Dx+k*(Dy/2)*(T8-T7)/Dx+ho*(Dx)*(To-T7)+e*sigma *(Dx)*(Tsky)^4-(T7)^4)*Dx/(k*(Dy/2));
% at node 8
T8=(k*(Dx)*(T5-T8)/Dy+k*(Dy/2)*(T7)/Dx+k*(Dy/2)*(T9-T8)/Dx+ho*(Dx)*(To-T8)+e*sigma *(Dx)*(Tsky)^4-(T8)^4)*Dx/(k*(Dy/2));
%at node 9
T9=(0+k*(Dy/2)*(T8)/Dx+ho*(Dx/2)*(To-T9)+e*sigma *(Dx/2)*((Tsky)^4-(T9)^4))*Dx/(k*(Dy/2));

