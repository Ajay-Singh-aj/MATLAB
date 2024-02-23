%firstly mass balance
syms m3 m4 m5 m6;
m7=893.263;
%mass balance for CO2
co2=0.176*m3-0.243*m4-0.744*m5-0*m6==0.002*m7;
%mass balance for H2;
h2=0.53*m3-0.752*m4-0.027*m5-0*m6==0*m7;
%mass balance for CH3OH
ch3oh=0.147*m3-0.004*m4-0.188*m5-0*m6==0.987*m7;
%mass balance for H2O
h2o=0.147*m3-0.001*m4-0.041*m5-m6==0.011*m7;
%creating coeffiecient matrix
Q=[0.176 -0.243 -0.744 0; 0.53 -0.752 -0.027 0;0.147 -0.004 -0.188 0;0.147 -0.001 -0.041 -1 ];
disp (Q);
S=[m7*0.002; m7*0;m7*0.987;0.011*m7];
disp(S);
%creating augumented matrix
Aug=[Q S];
%applying gauss elimination method
for j=1:3
%applying partial pivoting
[M,N]=max(abs(Aug(j:4,j)));
C=Aug(j,:);
Aug(j,:)=Aug(N+j-1,:);
Aug(N+j-1,:)=C;
%disp(M);
%disp(N);
 
for i=j+1:4
m=Aug(i,j)/Aug(j,j);
Aug(i,:)=Aug(i,:)-m*Aug(j,:);
end
end
disp(Aug);
X(4,1)=Aug(4,5)/Aug(4,4);
%solving the molar rates in term of molar rates store in X matrix
for k=3:-1:1
X(k,1)=(Aug(k,5)-(Aug(k,k+1:4)*X(k+1:4,1)))/Aug(k,k);
end
%Linsolve methode
[A,B]=equationsToMatrix([co2,h2,ch3oh,h2o],[m3,m4,m5,m6]);
T=A\B;
Y=double(T);