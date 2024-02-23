function f=sineplot_func(a,b)
%for run this prog. we need to go command window and type sineplot_func(1,2) 
t=0:0.001:1;
f=a*sin(2*pi*b*t);
plot(t,f);
end
%%
%this programme will run only in command window.
%another way to define a function
%f1=@(a)a^2+5;
%the above f1 can be written as  f1=inline('a^2+5','a')
%this @(a) means variable of this f1 is a.

