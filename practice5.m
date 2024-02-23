A=input('matrix:');
B=[2;3;5;8;1;7;4;9;6];
n=length(A);
s=[A B];
for j=1:n-1
    [M,P]=max(abs(s(j:n,j)));
    c=s(j,:);
    s(j,:)=s(P+j-1,:);
    s(P+j-1,:)=c;
    for i=j+1:n
        m=s(i,j)/s(j,j);
        s(i,:)=s(i,:)-m*s(j,:);
    end
end
disp(s);
x(n)=s(n,n+1)/s(n,n);
for i =n-1:-1:1
    sum=0;
    for k=i+1:n
        sum=sum+x(k)*s(i,k);
    end
    
    x(i)=(s(i,n+1)-sum)/s(i,i);
end
disp(x)



