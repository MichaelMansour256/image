function [out] = AddMan(man ,bigima )
out=imread(bigima);
figure,imshow(out);
%[h2, w2, c2] = size(Ima);
[h, w, c] = size(man);
for i=1:h
    for j = 1:w
        if man(i,j,:)==0
            out(i,j,:) =out(i,j,:);
        else 
            out(i,j,:)=man(i,j,:);
        end
    end
end
%figure,imshow(out);
end