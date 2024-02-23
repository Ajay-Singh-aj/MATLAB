clc
A=[1 2 3;3 4 5 ;6 6 9];
%we want to take value of 2nd row and 2nd col element then
B=A(2,2);
%if we wanted to take all element of one row then
c=A(2,:);
D=A(:,2);
%here 2:3 represent which row we want,and 1:2 represent which column we
%want
E=A(2:3,1:2);
