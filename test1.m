x=1;
y=2;
x/y;
disp(x/y)
x=linspace(0,2,10);
c=0;
m=1;
y=zeros(size(x));
for i=1:size(x,2)
    xi=x(i);
    if(xi<1)
        
    y(i)=mystaightline(xi,c,m);
    end
end

plot(x,y)

function y = mystaightline(x,c,m)
    y=m*x+c;
end
size(x,2);
       