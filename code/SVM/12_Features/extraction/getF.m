function F = getF( s, fs )

F = zeros(6, 1);
% PHASE PLOT 1: s_{i} VS s_{i+1}
% PHASE PLOT 2: s_{i} VS s_{i+5}
BW1 = getBW(s, 1);
BW5 = getBW(s, 5);

% It is expected that the self-similarity index value F1 will be smaller for 
% VT than for SVT, as P (the number of 1s in the binary image) 
% will be greater for the latter
r1 = getIndex(BW1);
r2 = getIndex(BW5);
F(1) = r2-r1;
%-----------------------
[F(2), F(3)] = getF23(BW1);
%-----------------------
% F4 is higher for VT
F(4) = getF4(BW1, BW5);

% F5 is greater for the SVT than for VT
F(5) = getF5(s, fs);

%The F6 value should be higher for VT than for SVT
F(6) = wentropy(s,'shannon');

end
