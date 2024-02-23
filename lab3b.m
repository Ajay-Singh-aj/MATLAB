


% Define equations for material and component balances

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

 
