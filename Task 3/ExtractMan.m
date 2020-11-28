function [man] = ExtractMan(Image1)

%show image
Ima=imread(Image1);
figure,imshow(Ima);

[h, w, c] = size(Ima);
s = zeros(h,w,c);
for i=1:h
    for j = 1:w
        if Ima(i,j,1) > 10 && (Ima(i,j,1)+10) > (Ima(i,j,2)) && (Ima(i,j,2)+15) > (Ima(i,j,3))
            s(i,j,:) =0;
        else 
            s(i,j,:)=Ima(i,j,:);
        end
    end
end
 %figure, imshow(uint8(s));
for i=1:h
    for j = 1:w
        if s(i,j,:)==0
            s(i,j,:) =255;
        else 
            s(i,j,:)=0;
        end
    end
end

 figure, imshow((s));
 s=rgb2gray(s); 
 
    s=imgaussfilt(s,2);
%s=medfilt2(s);

 figure, imshow(im2uint8(s));

% ima2= im2bw(s,graythresh(s));
% figure, imshow(ima2);
%egge dei
 ima3=edge(s,'canny',0.92);
 ima3=imdilate(ima3,ones(5,5));
 ima3=~ima3;
 figure,imshow(ima3,[]);
 
 
[L, num] = bwlabel(ima3);
RGB = label2rgb(L);
figure,imshow(RGB);

[h, w, ~] = size(s);
smallRatio = h*w*0.002;
for i=1:num
     %i=2;
    x = uint8(L==i);
    f = sum(sum(x==1));
    if(f < smallRatio)
        continue;
    end
    d = zeros(size(Ima));
    d(:,:,1) = uint8(x).*Ima(:,:,1);
    d(:,:,2) = uint8(x).*Ima(:,:,2);
    d(:,:,3) = uint8(x).*Ima(:,:,3);
%disp(i);
    if(i==3)
        man=uint8(d);
        %figure,imshow(uint8(d));
    end
end
figure,imshow(man);


end