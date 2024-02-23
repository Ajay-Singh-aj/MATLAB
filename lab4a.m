pco2 = linspace(0.025,1,100);
ph2 = linspace(0.5,2,100);

for i=1:100
for j=1:100
F3 = 2000*44 + 4000*2;
C_cap(i,j) = 14694200 + 29418000 + (1.53*(10^7)*((F3/54000)^0.65)) + 269600 + 171300 + 168100 + 63000 + 1507900;
phi = 0.1;
C_op(i,j) = (9.7+21.5)*72 + (0.28+0.8+15.7)*1000*3600*2.5*(10^-6) + (12+20.9+22.6+15.4)*1000*3600*2.12*(10^-7) + (2000*44)*pco2(i) + (4000*2)*ph2(j)*7884;
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