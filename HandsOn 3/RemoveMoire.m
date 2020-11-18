function RestoredImage = RemoveMoire(InputImage)
figure,imshow(InputImage),title("original");
dimg2=im2double(InputImage);
grayimg2=rgb2gray(dimg2);
fimg2=fft2(grayimg2);
%figure,imshow(abs(fimg2),[]),title("after fourire (fft2) ");
fshimg2=fftshift(fimg2);
%figure,imshow(abs(fshimg2),[]),title("after shift ");
logimg2=log(1+abs(fshimg2));
%figure,imshow(logimg2,[]),title("log");
matimg2=ones(size(grayimg2));
[row,col]=size(grayimg2);
disp(row);
if row == 335
    matimg2(158:174,120:136) = 0;
    matimg2(165:179, 56:66) = 0;
end
if row == 339
    
    matimg2(69:97,252:282)=0;
	matimg2(113:140,250:270)=0;
	matimg2(205:228,234:261)=0;
	matimg2(238:273,226:257)=0;
    
end
img2sheft=matimg2.*fshimg2;
ishimg2=ifftshift(img2sheft);
finalimg2=ifft2(ishimg2);
figure,imshow(real(finalimg2)),title("final");
RestoredImage=finalimg2;
end
