%for loop syntax
%for i=a:b:c
    %code
 %end
 %here a is intial ,b is gap ,c is limit value.
 for i=0:2:10
     m=(2*i)+1
 end

 %%
 %nested for loop
 m=1:5
 n=1:3
 for i=1:length(m)
     for j=1:length(n)
         a(i,j)=m(i)+n(j)
     end
 end