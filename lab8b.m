norm_diff=10000;
%Component balance on mixer
C1=2000;
H2=4000;
C5R=1000;
H5R=1000;
M5R=1000;
W5R=1000;
while norm_diff > 1
    C3=C1+C5R;
    H3=H2+H5R;
    %Component balance on Reactor
    C4=C3*0.7;
    H4=H3-C3*0.9;
    M4=C3*0.3+M5R;
    W4=C3*0.3+W5R;
    F4=C4+M4+H4+W4;
    %Rachford Rice procedure on Flash
    %calculating k for different values
    km=(exp(24.6971-4941.2833/313))/7800000;
    kc=(exp(22.36-1992.9/313))/7800000;
    kw=(exp(24.6961-4941.2833/313))/7800000;
    kh=1440000000/7800000;
    zm=M4/F4;
    zc=C4/F4;
    zw=W4/F4;
    zh=H4/F4;
    mi5r_guess=[C5R;H5R;M5R;W5R];
    X=fsolve(@(X) (zm*(1-km)/(1+X*(km-1)))+(zc*(1-kc)/(1+X*(kc-1))+(zw*(1-kw)/(1+X*(kw-1))+(zh*(1-kh)/(1+X*(kh-1))))),[0.7],optimoptions('fsolve','Display','off'));
    F5=X*F4;
    F6=F4-F5;
    C6=zc*F6/(1+X*(kc-1));
    H6=zh*F6/(1+X*(kh-1));
    M6=zm*F6/(1+X*(km-1));
    W6=zw*F6/(1+X*(kw-1));
    C5=C4-C6;
    M5=M4-M6;
    W5=W4-W6;
    H5=H4-H6;
    C5R=0.95*C5;
    C5P=C5-C5R;
    M5R=0.95*M5;
    M5P=M5-M5R;
    W5R=0.95*W5;
    W5P=W5-W5R;
    H5R=0.95*H5;
    H5P=H5-H5R;
    mi5r_actual=[C5R;H5R;M5R;W5R];
    norm_diff=norm(mi5r_guess-mi5r_actual);
end