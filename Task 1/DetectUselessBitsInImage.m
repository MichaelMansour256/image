function [B] = DetectUselessBitsInImage(I)
I=rgb2gray(I);
doubleimage=double(I);
B=[];
for i = 1:8
    bit=mod(doubleimage,2);
    [rows , colms]=size(bit);
    total=rows*colms;
    number=sum(bit(:) == 1);
    
    if number/total < 0.1
        B(end+1)=i;   
    end
    doubleimage=floor(doubleimage/2);
end

end