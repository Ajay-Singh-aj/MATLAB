%Let's write the equations first
n3_CO2=2000;
n3_H2=2*n3_CO2;
n3=n3_H2+n3_CO2;

n4_CO2=n3_CO2-0.3325*n3_CO2;
n4_CH3OH=0.3325*n3_CO2;
n4_H20=0.3325*n3_CO2;
n4_H2=3*0.3325*n3_CO2;
n4=n4_CO2+n4_CH3OH+n4_H2+n4_H20;

n5_CO2=0.972*n4_CO2;
n5_H2=0.9997*n4_H2;
n5_CH3OH=0.0235*n4_CH3OH;
n5_H20=3.103;
n5=n5_CO2+n5_H20+n5_CH3OH+n5_H2;

n6_CO2=n4_CO2-n5_CO2;
n6_H2O=n4_H20-n5_H20;
n6_H2=n4_H2-n5_H2;
n6_CH3OH=n4_CH3OH-n5_CH3OH;
n6 =n6_CH3OH+n6_H2+n6_H2O+n6_CO2;

n8_H2=0;
n8_CO2=n6_CO2/31.89;
n8_CH3OH=n6_CH3OH/1.0125;
n8_H2O=n6_H2O/1.00265;
n8=n8_H2O+n8_CH3OH+n8_CO2+n8_H2;

n7_H2=n6_H2;
n7_H2O=0.00265*n8_H2O;
n7_CO2=30.89*n8_CO2;
n7_CH3OH=0.0125*n8_CH3OH;
n7=n7_CH3OH+n7_CO2+n7_H2O+n7_H2;

n10_H2O=n8_H2O;
n10_H2=0;
n10_CO2=0;
n10_CH3OH=0;
n10=n10_CH3OH+n10_CO2+n10_H2+n10_H2O;

n9_H2O=0;
n9_CO2=n8_CO2;
n9_CH3OH=n8_CH3OH;
n9_H2=n8_H2;
n9=n9_H2+n9_CH3OH+n9_CO2+n9_H2O;

pco2 = linspace(0.025,1,100);
ph2 = linspace(0.5,2,100);

for i=1:100
for j=1:100
F3 = 2000*44 + 4000*2;
C_cap(i,j) = 14694200 + 29418000 + (1.53*(10^7)*((F3/54000)^0.65)) + 269600 + 171300 + 168100 + 63000 + 1507900;
phi = 0.1;
C_op(i,j) = (9.7+21.5)*72 + (0.28+0.8+15.7)*1000*3600*2.5*(10^-6) + (12+20.9+22.6+15.4)*1000*3600*2.12*(10^-7) + (2000*44)*pco2(i) + (4000*2)*ph2(j)*7884;
TAC(i,j) = phi*C_cap(i,j) + C_op(i,j);
C_methanol(i,j) = TAC(i,j)/(7884*(n9_CH3OH*32/1000));
end
end

%Let's plot the contour plot now
contour(ph2,pco2,C_methanol,1000);
colorbar;
xlabel('CO2 Prices');
ylabel('H2 Prices');
title('Total Annual Cost of Methanol Production');