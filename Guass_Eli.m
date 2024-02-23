A=input('Enter your coefficient matrix: ');
B=[3;2;5;2;5;7;3;7;9];
N=length(A);
Aug=[A B];
for j=1:N-1
    [M,P]=max(abs(Aug(j:N,j)));
    c=Aug(j,:);
    Aug(j,:)=Aug(P+j-1,:);
    Aug(P+j-1,:)=c;
    for i=j+1:N
        m=Aug(i,j)/Aug(j,j);
        Aug(i,:)=Aug(i,:)-m*Aug(j,:);
    end
end
disp(Aug)
X(N)=Aug(N,N+1)/Aug(N,N);
for k=N-1:-1:1
    sum=0;
    for j=k+1:N
        sum=sum+Aug(k,j)*X(j);
    end
    X(k)=(Aug(k,N+1)-sum)/Aug(k,k);
end
disp(X)


