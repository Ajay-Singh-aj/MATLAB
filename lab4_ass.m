data=readmatrix("P-T-data.xlsx");
T_data=data(:,1);
P_data=data(:,2).*10^5;
R=8.314;
lnP_data=log(P_data);
x_data=1./T_data;
y_data=lnP_data;
p=polyfit(x_data,y_data,1);
%hold on
%plot(x_data,polyval(p,x_data),'-');
delta_H=p(1)*R;
disp(['Enthaply of vapourisation(CCE):',num2str(delta_H)]);
%%
fun_ant=@(z,T_data) z(1)-z(2)./(T_data+z(3));
z0_ant=[0,0,0];
options=optimset('Display','off');
z_ant=lsqcurvefit(fun_ant,z0_ant,T_data,log10(P_data),[],[],options);
A_ant=z_ant(1);
B_ant=z_ant(2);
C_ant=z_ant(3);
%%
data1=readmatrix("T-V (1).xlsx");
T=data1(:,1);
Vm=data1(:,2);
Tc=369.9;
Pc=42.5*10^5;
Vc=0.2;
br=0.07780*R*Tc/Pc;
ar=0.45724*R^2*Tc^2/Pc;
w=0.153;

Tr=T./Tc;
alpha=(1+((0.37464+1.54226*w-0.26992*(w^2)).*(1-sqrt(Tr)))).^2;
c1=R.*(T)./(Vm-br);
P_pr=c1-alpha.*ar./(Vm.*Vm+2*br.*Vm-(br*br));
lnPr_data=log(P_pr);
x1_data=1./T;
y2_data=lnPr_data;
p_poly=polyfit(x1_data,y2_data,1);
delta_H_Pr=p_poly(1)*R;
disp(['Enthaply of vapourisation(Antoine Eq):',num2str(delta_H_Pr)]);
%%
%c
fun_ant_pr=@(y,T) y(1)-y(2)./(T+y(3));
y0_ant_pr=[0,0,0];
options=optimset('Display','off');
y_ant=lsqcurvefit(fun_ant,y0_ant_pr,T,log10(P_pr),[],[],options);
A_ant_pr=y_ant(1);
B_ant_pr=y_ant(2);
C_ant_pr=y_ant(3);

%%
%FOR CCE
figure(1)
plot(1./T_data,log10(P_data));
hold on
plot(x1_data,log10(P_pr));
xlabel('Temperature(K)');
hold on
plot(x1_data,log10(P_pr));
xlabel('Temperature(K)')
ylabel('log10P')
title('Clasius claperoyn equation')
legend('actual','PR')
ylabel('log10P')
hold off
title('Clasius claperoyn equation')
legend('actual','PR')
%%
figure(2)
plot(T_data,log(P_data));
hold on
plot(T,log(P_pr));
xlabel('Temperature(K)')
ylabel('logP')
title('Antoine equation')
legend('actual','PR')
hold off
%%
%for ideal gas
P_ig=R*T./Vm*10^-3;
%c
fun_ant_ig=@(y,T) y(1)-y(2)./(T+y(3));
y0_ant_ig=[0,0,0];
options=optimset('Display','off');
y_ant_ig=lsqcurvefit(fun_ant_ig,y0_ant_ig,T,log10(P_ig),[],[],options);
A_ant_ig=y_ant_ig(1);
B_ant_ig=y_ant_ig(2);
C_ant_ig=y_ant_ig(3);
figure(3)
plot(1./T_data,log10(P_data));
hold on
plot(x1_data,log10(P_pr));
xlabel('Temperature(K)');
hold on
plot(x1_data,log10(P_ig));
xlabel('Temperature(K)')
ylabel('log10P')
hold off
title('Clasius claperoyn equation')
legend('actual','PR','ideal gas')

figure(4)
plot(T_data,log(P_data));
hold on
plot(T,log(P_pr));
hold on
plot(T,log(P_ig))
hold off
xlabel('Temperature(K)')
ylabel('logP')
title('Antoine equation')
legend('actual','PR','ideal')
hold off