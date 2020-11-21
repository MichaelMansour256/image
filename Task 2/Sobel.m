function M = Sobel(Mask)   %not implemented yet
    if Mask=='H'
        M = zeros(3,3);
        M(1,1) = -1;
        M(1,2) = -2;
        M(1,3) = -1;
    
        M(3,1) = 1;
        M(3,2) = 2;
        M(3,3) = 1;
    elseif Mask == 'V'
        M = zeros(3,3);
        M(1,1) = -1;
        M(2,1) = -2;
        M(3,1) = -1;
    
        M(1,3) = 1;
        M(2,3) = 2;
        M(3,3) = 1;
    end
end

