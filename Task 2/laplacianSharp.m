function M = laplacianSharp()  % done and tested
    buf=ones(3,3); %3*3 matrix
    M = buf*-1; %multiply all elements by -1
    M(2,2) = 9; % assign value 9 to the middle element
end

