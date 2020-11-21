function G = EdgeMagnit(I)
M1 = Sobel('H');
H = LinearFilter(I,M1,'absolute');
M2 = Sobel('V');
V = LinearFilter(I,M2,'absolute');
G = abs(H+V);
end