function M = Gauss2(Sig)
N = int32((3.7 * Sig)-0.5);
s=0;
sz = (2*N)+1;
divsz = int32(sz/2 -1);
x=1;

M=zeros(sz,sz);
for I = -divsz : divsz
    y=1;
    for J = -divsz : divsz
        eq = 1/(2*pi*(Sig^2) ) * exp( double( (I^2+J^2)*(-1) / 2*Sig^2 )); % 1/(2*pi*Sig^2) * e^(-(X^2+Y^2)/2*Sig^2)
        M(x,y)=eq; 
        s=s+eq;
        y=y+1;
    end
    x=x+1;
end
M = (1/s) * M;
end

