function M = MeanMask(W,H)  % done and tested
M = ones(W,H);
den = W*H;
M = 1/den*M;
disp(M);
end

