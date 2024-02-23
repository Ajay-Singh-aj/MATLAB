% if else loop
x=input('Enter current year = ')
y=input('Enter birth year = ')
d=x-y
if d>=18
    disp('you are adult')
elseif  d>=13&&d<18  
    disp('you are teenager')
else
    disp('you are child')
end