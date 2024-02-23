A=[4,1,2;2,5,1;3,5,9];
%for checking diagnol dominant A
R=sum(abs(A),2);
D=abs(diag(A));
W=R-D;
check=D>=W;
DD all(check)
if DD==1
B=[2;6;4];
P=[0;0;0];%initial guess vector
%this is same as jaccobi but in this we put P=X in loop
n=20;
esp=10^(-4);
N=length(A);
X=zeros(N,1);
Y=zeros(N,1);%for stopping criterial
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
        P(i)=X(i);
    end
    fprintf('iteration no. is %d\n',j);
    disp(X);
    if abs(Y-X)<esp
        break;
    end
    
    Y=X;
end
end



    
   
