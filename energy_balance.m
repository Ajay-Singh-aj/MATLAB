p1=1*10^(5);
p2=5*10^(5);
T=25+273;
R=8.314;
Cv=(5/2)*R;
Cp=(7/2)*R;
g=Cp/Cv;
%calculating work
work_isothermal=@(p3,p4)(R*T*log(p4/p3));
work_isochoric=0;
work_isobaric=@(p,v1,v2)(p*(v2-v1));
work_adiabatic=@(t1,t2)((R*(t1-t2))/g-1);

%calculating internal energy
u_isothermal=0;
u_rest=@(t1,t2)(Cv*(t2-t1));

%% part 1(a)
%heating a constant volume
t_intermediate=p2*T/p1;
v_intermediate=R*t_intermediate/p2;
w_cv1=work_isochoric;
u_cv1=u_rest(T,t_intermediate);
Q_cv1= u_cv1+w_cv1;

P1=linspace(1,5,100);
V1=linspace(v_intermediate,v_intermediate,100);


%cooling at constant pressure
v2=v_intermediate*T/t_intermediate;
w_cp1=-work_isobaric(p2,v_intermediate,v2);
u_cp1=u_rest(t_intermediate,T);
Q_cp1=w_cp1+u_cp1;

w_total_a=w_cv1+w_cp1;
Q_total_a=Q_cp1+Q_cv1;
u_total_a=u_cp1+u_cv1;
P2=linspace(5,5,100);
V2=linspace(v_intermediate,v2,100);
figure(1)
plot(P1,V1)
hold on
plot(P2,V2)
title('P-V graph of part a')
xlabel('V (in m^3)')
ylabel('P (in 10^5 Pa)')
legend('isochoric','isobaric')

%%part 1(b)
w_isoth=work_isothermal(p1,p2);
u_isoth=u_isothermal;
Q_isoth=u_isoth-w_isoth;
P3=linspace(1,5,100);
for i=1:100
    V3(i)=R*T/P3(i);
end
figure(2)
plot(P3,V3)
title('P-V graph of part b')
xlabel('V (in m^3)')
ylabel('P (in 10^5 Pa')
legend('isothermal')
%%part1(c)
v1=R*T/p1
v2_adi=R*T/p2;
t2_intermediate=T*(v1/v2)^(g-1);
p_adi=R*t2_intermediate/v2;
w_adi=-work_adiabatic(T,t2_intermediate);
u_adi=-w_adi
Q_adi=u_adi+w_adi;
P4=linspace(1,p_adi,100);
for i=1:100
    V4(i)=((p_adi*v2_adi^(g))/P4(i))^(1/g);
end
figure(3)
plot(P4,V4)
title('P-V graph of part c')
xlabel('V (in m^3)')
ylabel('P (in 10^5 Pa')
legend('adiabatic')


w_cv2=work_isochoric;
u_cv2=u_rest(t2_intermediate,T);
Q_cv2=u_cv2+w_cv2;
P5=linspace(p_adi,5,100)
V5=linspace(v2_adi,v2_adi,100)
figure(3)
plot(P4,V4)
hold on
plot(P5,V5)
title('P-V graph of part b')
xlabel('V (in m^3)')
ylabel('P (in 10^5 Pa')
legend('adiabatic','isochoric')


w_total_c=w_adi+w_cv2;
u_total_c=u_adi+u_cv2;
Q_total_c=Q_adi+Q_cv2;


































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































