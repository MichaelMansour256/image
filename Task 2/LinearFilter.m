function out = LinearFilter(Inp,Filter,PostProccess)  % done and tested
maskrows = size(Filter,1);
maskcolumns = size(Filter,2);

orr = int16(maskrows/2) + 1; % center row of the mask
orc = int16(maskcolumns/2) + 1; % center column of the mask

I = im2double(Inp);
[rows, columns, rgb] = size(I);

newI = zeros(rows,columns);

for r = 1:rows    
    for c = 1:columns
        sum=0;
        for mr = 1:maskrows
            for mc = 1:maskcolumns
                cellr = r-abs(orr-mr);
                cellc = c-abs(orc-mc);
                if cellr <= 0
                    continue;
                end
                if cellc <= 0
                    continue;
                end
                if cellr > rows
                    continue;
                end
                if cellc > columns
                    continue;
                end
               
                val = I(cellr,cellc) * Filter(mr,mc);
                sum = sum + val;                               
            end
        end
        if PostProccess == "cutoff"
            if sum > 255
                sum = 255;
            elseif sum < 0
                sum = 0;
            end
        elseif PostProccess == "absolute"
            if sum < 0
                sum = abs(sum);
            end
        else 
            sum = sum;
        end
            
        newI(r,c) = sum;
    end
end
out = newI;
end

