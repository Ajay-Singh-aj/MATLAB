n_guess=[1000,1000,1000,1000];% guessed molar flow rates of components in stream 5R
norm_diff=10000;%norm_diff is the norm of the difference between calculated and guessed values of component flow rates
tol=1;
n1=[2000,0,0,0];
n2=[0,4000,0,0];
n4=zeros(1,4);
T=40+273.15;
while norm_diff > tol %iterate until norm_diff become less then tolerance
    n3=n1+n2+n_guess;
    extent=n3(1)*0.3;
    n4(1)=n3(1)-extent;
    n4(2)=n3(2)-3*extent;
    n4(3)=n3(3)+extent;
    n4(4)=n4(4)+extent;
    nt4=n4(1)+n4(2)+n4(3)+n4(4);
    k(1)=exp(22.36-1.9929*1e3/T)/7800000;
    k(2)=1.44*10^4/78;
    k(3)=(exp(24.6971-4941.2833/313))/7800000;
    k(4)=(exp(24.6961-4941.2833/313))/7800000;
    z=n4/nt4;

    psi=fsolve(@(psi) (z(1)*(1-k(1))/(1+psi*(k(1)-1)))+(z(2)*(1-k(2))/(1+psi*(k(2)-1)))+(z(3)*(1-k(3))/(1+psi*(k(3)-1)))+(z(4)*(1-k(4))/(1+psi*(k(4)-1))),0.7,optimoptions('fsolve','Display','off'));
    F5=psi*nt4;
    F6=nt4-psi*nt4;
    n6(1)=z(1)*F6/(1+psi*(k(1)-1));
    n6(2)=z(2)*F6/(1+psi*(k(2)-1));
    n6(3)=z(3)*F6/(1+psi*(k(3)-1));
    n6(4)=z(4)*F6/(1+psi*(k(4)-1));
    n5=n4-n6;
    n5r=0.95*n5;
    n5p=n5-n5r;
    norm_diff=norm(n_guess-n5r);
    n_guess=n5r;

end