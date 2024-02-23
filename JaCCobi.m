A=[4,1,2;2,5,1;3,5,9];
B=[2;6;4];
P=[0;0;0];%initial guess vector
n=20;
esp=10^(-4);
N=length(A);
X=zeros(N,1);
for j=1:n
    for i=1:N
        sum=0;
        for k=1:N
            if k==i
                continue;
            else
            sum = sum+A(i,k)*P(k);
            end
        end
        
        X(i)=(B(i)-sum)/A(i,i);
    end
    fprintf('iteration no. is %d\n',j);
    disp(X);
    if abs(X-P)<esp
        break;
    end
    
    P=X;
end