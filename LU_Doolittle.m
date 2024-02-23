A=input('Enter the value of matrix');
B=[2;4;3;6;5;9;1;7;8];
N=length(A);
L=zeros(N,N);
U=zeros(N,N);
for a=1:N
    L(a,a)=1;
end
U(1,:)=A(1,:);
L(:,1)=A(:,1)/U(1,1);
for i=2:N
    for j=i:N
        U(i,j)=A(i,j)-L(i,1:i-1)*U(1:i-1,j);
    end
    for k=i+1:N
        L(k,i)=(A(k,i)-L(k,1:i-1)*U(1:i-1,i))/U(i,i);
    end
end
disp(L);
disp(U);
Y=zeros(N,1);
Y(1)=B(1)/L(1,1);
for i=2:N
    sum=0;
    for k=1:i-1
        sum=sum+Y(k)*L(i,k);
    end
    Y(i)=(B(i)-sum)/L(i,i);
end
X=zeros(N,1);
X(N)=Y(N)/U(N,N);
for i=N-1:-1:1
    sum=0;
    for k=i+1:N
        sum=sum+X(k)*U(i,k);
    end
    X(i)=(Y(i)-sum)/U(i,i);
end
disp(X)

