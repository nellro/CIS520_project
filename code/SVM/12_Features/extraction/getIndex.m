function r = getIndex( BW )

% S = total number of pixels in the image
S = numel(BW);
% P = number of corresponding white pixels (number of 1s)
P = sum(sum(BW));
% index:
r = P/S;
end