img=imread('morph.png');
figure,imshow(img),title('original');
binaryImage=rgb2gray(img);
imgdouble=im2double(binaryImage);

ratio = WhiteRatio(imgdouble);
disp(ratio);

numberOfObjects = calculateobjects(binaryImage);
disp(numberOfObjects);

holes=calculateHoles(imgdouble);
disp(holes);

numberOfObjectWHole=calculateHoledObjects(imgdouble);
disp(numberOfObjectWHole);

numberofsq=calculateSquares(imgdouble);
disp(numberofsq);

squares = squaresWithHoles(imgdouble);
figure, imshow(squares), title('squares with Holes');

circles = circleWithoutHoles(imgdouble);
figure, imshow(circles), title('circles without holes');


function [numberOfObject]=calculateobjects(binaryImage)
    [labeledImage, numberOfObject] = bwlabel(binaryImage);
    
end

function [ratio]=WhiteRatio(imgdouble)
    numberOfWhitePixels = sum(imgdouble(:)==1);
    [row,col]=size(imgdouble);
    totalsize=row*col;
    ratio= numberOfWhitePixels ./ totalsize;
    
end

function [numberOfHoles]=calculateHoles(imgdouble)
    img=~imgdouble;
    [labeledImage, numberOfObject] = bwlabel(img);
    numberOfHoles=numberOfObject-1;
end

function [numberOfObjectWHole]=calculateHoledObjects(imgdouble)
    filled=imfill(imgdouble,'holes');
    [L,N]= bwlabel(filled);
    holes=filled-imgdouble;
    m=holes.*L;
    numberOfObjectWHole=length(unique(nonzeros(m)));
   
end

function [numberOfSquares]=calculateSquares(imgdouble)
    %{
    se = strel('square',30);
    afterOpening = imopen(imgdouble,se);
    figure
    imshow(afterOpening,[]);
    %}
    count=0;
    I = imfill(imgdouble,'holes');
    [L,N] = bwlabel(I);
    prop = regionprops (L,'Area' , 'BoundingBox');
    for i=1:N
        if prop(i).Area == prop(i).BoundingBox(3) * prop(i).BoundingBox(4)
            count = count +1;
        end
    end
    numberOfSquares = count;
end

function res=squaresWithHoles(imgdouble)
    
    I = imfill(imgdouble,'holes');
    [L,N] = bwlabel(I);
    
    [Ldiff, Ndiff] = bwlabel(imgdouble);
    % the properties of the image with holes in it
    propdiff = regionprops (Ldiff,'EulerNumber' , 'Area' , 'Perimeter' , 'BoundingBox' , 'ConvexArea');
    %the properties of the filled image
    prop = regionprops (L,'EulerNumber' , 'Area' , 'Perimeter' , 'BoundingBox' , 'ConvexArea');
    pic = zeros(size(imgdouble));
    % iterate on all connected objects
    for i=1:N
        left = prop(i).BoundingBox(1);
        top = prop(i).BoundingBox(2);
        width = prop(i).BoundingBox(3);
        height = prop(i).BoundingBox(4);
        right = left+width;
        bottom = top+height;
        
        % check the value of circularity to differentiate between circle and square
        circularity = (prop(i).Perimeter .^ 2) ./ (4 * pi * prop(i).ConvexArea);
        
        if circularity > 1 % if not circle
            % extract the square inside the bounding box in image I
            cropped = imcrop(L, prop(i).BoundingBox); 
            % extract the square inside the bounding box in image imgdouble
            croppedWithHoles = imcrop(Ldiff, propdiff(i).BoundingBox);
            disp(sum(sum(cropped)));
            if sum(sum(cropped)) ~= sum(sum(croppedWithHoles))
                pic(top:bottom,left:right) = croppedWithHoles;
            end
        end
    end
    res = pic;
    

end

function res=circleWithoutHoles(imgdouble)
     I = imfill(imgdouble,'holes');
    [L,N] = bwlabel(I);
    
    [Ldiff, Ndiff] = bwlabel(imgdouble);
    % the properties of the image with holes in it
    propdiff = regionprops (Ldiff,'EulerNumber' , 'Area' , 'Perimeter' , 'BoundingBox' , 'ConvexArea');
    %the properties of the filled image
    prop = regionprops (L,'EulerNumber' , 'Area' , 'Perimeter' , 'BoundingBox' , 'ConvexArea');
    pic = zeros(size(imgdouble));
    % iterate on all connected objects
    for i=1:N
        left = prop(i).BoundingBox(1);
        top = prop(i).BoundingBox(2);
        width = prop(i).BoundingBox(3);
        height = prop(i).BoundingBox(4);
        right = left+width;
        bottom = top+height;
        
        % check the value of circularity to differentiate between circle and square
        circularity = (prop(i).Perimeter .^ 2) ./ (4 * pi * prop(i).ConvexArea);
        
        if circularity <= 1 % if circle
            % extract the square inside the bounding box in image I
            cropped = imcrop(L, prop(i).BoundingBox); 
            % extract the square inside the bounding box in image imgdouble
            croppedWithHoles = imcrop(Ldiff, propdiff(i).BoundingBox);
            if sum(sum(cropped)) == sum(sum(croppedWithHoles))
                pic(top:bottom,left:right) = cropped;
            end
        end
    end
    res = pic;
end
