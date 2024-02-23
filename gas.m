clc
A=[6.99891 7.00908 6.99052];
B=[1474.679 1462.266 1453.430];
C=[213.69 215.11 215.31];
T=[144.4 139.1 138.4];

for i=1:3
    P(1,i)=10^(A(1,i)-(B(1,i)/(C(1,i)+T(1,i))));
end
Q=[P(1,1) 0 0 -760 0 0 ; 0 P(1,2) 0 0 -760 0 ; 0 0 P(1,3) 0 0 -760 ; 0.2 0 0 0.8 0 0 ; 0 0 0 1 1 1 ; 1 1 1 0 0 0];
%syms X1 X2 X3 Y1 Y2 Y3
%E=[X1;X2;X3;Y1;Y2;Y3];
S=[0;0;0;0.2;1;1];
%Argumented matrix
I=[Q S];
for k=1:5
    for i=k+1:6
        M(i,k)=Q(i,k)/Q(k,k);
        for j=k:6
            Q(i,j)=Q(i,j)-M(i,k)*Q(k,j);
        end
        S(i,1)=S(i,1)-M(i,k)*S(k,1);
    end
end
E(6,1)=S(6,1)/Q(6,6);
for i=5:-1:1
    sum=0;
    for j=i+1:6
        sum=sum+Q(i,j)*E(j,1);
    end
    disp(sum);
    E(i,1)=(S(i,1)-sum)/Q(i,i);
end





