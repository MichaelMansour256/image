i=imread('Filters.png');
i=rgb2gray(i);
i=medfilt2(i,[30,30]);
i=imbinarize(i,0.5);
i=edge(i);
imshow(i);