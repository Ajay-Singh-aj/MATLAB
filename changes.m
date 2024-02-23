%here we'll compare the two methods

f=@(T) 0.05625*(400-T);%function for rate of temperature change


%here we have calculated the stability point form previous euler file 
h=15;%step size
n=60/h;%for t=1 minutes we have to calculate
t0=0;%initial time
F=zeros(n,1);%coloumn matrix that stores rate of temperature decrease at t(i)
time=zeros(n,1);
T=zeros(n,1);
time(1)=t0;T(1)=300;F(1)=-5.625;%initial value stored in coloumn matrix
%code for explicit euler
for i=1:n+1
    time(i+1)=t0+i*h;
    T(i+1)=T(i)+h*f(T(i));
    F(i+1)=-f(T(i+1));%function for rate of temperature decrease
end
disp(T) %Temperature matrix for respective value of time matrix using euler explicit
figure(1)%plot for rate of temperatue decrease v/s time when temperature calculated by euler explicit
plot(time,F)
figure(2)%plot of temperature of ball v/s time when temperature calculated by euler explicit
plot(time,T)

hc=15;%point upto which euler explicit method is stable.
m=60/hc;
t0=0;%initial time
F=zeros(m,1);%coloumn matrix that stores rate of temperature decrease at t(i)
time=zeros(m,1);
T=zeros(m,1);
time(1)=t0;T(1)=300;F(1)=-5.625;%initial value stored in coloumn matrix
%code for RK-4
for i=1:m+1
    time(i+1)=time(1)+i*hc;

    k1=h*f(T(i));
    k2=h*f(T(i)+k1/2);
    k3=h*f(T(i)+k2/2);
    k4=h*f(T(i)+k3);
    T(i+1)=T(i)+1/6*(k1+2*k2 +2*k3 +k4);
    F(i+1)=-f(T(i+1));
end
disp(T) %Temperature matrix for respective value of time matrix using RK_-4
figure(2)
hold on
plot(time,T)%plot of temperature of ball v/s time when temperature calculated by RK-4
figure(1)
hold on 
plot(time,F)%plot for rate of temperatue decrease v/s time when temperature calculated by RK-4
legend('T','F')



