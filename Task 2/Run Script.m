lines = imread('lines.bmp');
figure,imshow(lines),title('lines');

G2M = Gauss2(1.5);
G2 = LinearFilter(lines,G2M,'none');
figure,imshow(G2),title('Gaussian 2');

G1M = Gauss1(3,1.5);
G1 = LinearFilter(lines,G1M,'none');
figure,imshow(G1),title('Gaussian 1');

MM = MeanMask(20,20);
M = LinearFilter(lines,MM,'none');
figure,imshow(M),title('Mean');

SHM = Sobel('H');
SH = LinearFilter(lines,SHM,'absolute');
figure,imshow(SH),title('Sobel Horizontal');

SVM = Sobel('V');
SV = LinearFilter(lines,SVM,'absolute');
figure,imshow(SV),title('Sobel Vertical');

EM = EdgeMagnit(lines);
figure,imshow(EM),title('Edge Magnitude');

moon = imread('moon.jpg');
figure,imshow(moon),title('moon');

LSM = laplacianSharp();
LS = LinearFilter(moon,LSM,'cutoff');
figure,imshow(LS),title('laplacian Sharp');
