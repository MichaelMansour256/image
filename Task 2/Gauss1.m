function M = Gauss1(Size,Sig)
x=1;

divsz = Size/2;
M=zeros(Size,Size);
for I = -divsz : divsz
    y=1;
    for J = -divsz : divsz
        eq = 1/(2*pi*(Sig^2) ) * exp( double( (I^2+J^2)*(-1) / 2*Sig^2 )); % 1/(2*pi*Sig^2) * e^(-(X^2+Y^2)/2*Sig^2)
        M(x,y)=eq;
        x=x+1;
        y=y+1;
    end
end
end

