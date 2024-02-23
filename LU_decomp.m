A=[6.99891 7.00908 6.99052];
B=[1474.679 1462.266 1453.430];
C=[213.69 215.11 215.31];
T=[144.4 139.1 138.4];
M=zeros(6,5);
P=zeros(1,3);
L=zeros(6,6);


for i=1:3
    P(1,i)=10^(A(1,i)-(B(1,i)/(C(1,i)+T(1,i))));
end
Q=[P(1,1) 0 0 -760 0 0 ; 0 P(1,2) 0 0 -760 0 ; 0 0 P(1,3) 0 0 -760 ; 0.2 0 0 0.8 0 0 ; 0 0 0 1 1 1 ; 1 1 1 0 0 0];

S=[0;0;0;0.2;1;1];
for k=1:5
    for i=k+1:6
        M(i,k)=Q(i,k)/Q(k,k);
        for j=k:6
            Q(i,j)=Q(i,j)-M(i,k)*Q(k,j);
        end
        S(i,1)=S(i,1)-M(i,k)*S(k,1);
    end
end
for i=1:6
    for j=1:6
        if i>j
            L(i,j)=M(i,j);
        elseif i<j
            L(i,j)=0;
        elseif i==j
            L(i,j)=1;
        end
    end
end
Y(1,1)=S(1,1)/L(1,1);
for i=2:6
    sum=0;
    for j=1:i-1
        sum=sum+L(i,j)*Y(j,1);
    end
    Y(i,1)=(S(i,1)-sum)/L(i,i);
end

