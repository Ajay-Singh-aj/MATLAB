clc 

%define earthquake magnitude and energy data
magnitude=[1,2,3,4,5,6,7,8,9];
energy=[6.3e5,2e7,6.3e8,2e10,6.3e11,2e13,6.3e14,2e16,6.3e17];

%create linear graph
plot(magnitude,energy,'o-','LineWidth',2);
grid on;
title('Linear Scale');
xlable('Magnitude');
ylable('Energy(joules)');

%%
clc 

%define earthquake magnitude and energy data
magnitude=[1,2,3,4,5,6,7,8,9];
energy=[6.3e5,2e7,6.3e8,2e10,6.3e11,2e13,6.3e14,2e16,6.3e17];

%create logarithmic graph
semilogy(magnitude,energy,'o-','LineWidth',2);
grid on;
title('Logarrithmic Scale');
xlable('Magnitude');
ylable('Energy(joules)');

