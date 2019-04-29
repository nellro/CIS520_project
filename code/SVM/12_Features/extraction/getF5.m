function F5 = getF5( s, fs )
% F5 is greater for the SVT than for VT

N = length(s);
NN = 2*floor(N/2); % odd length
y = fft(s, NN);  
Py = y.*conj(y)/NN;
f = fs/NN*(0:NN/2-1);

y_half = Py(1:NN/2);
y_norm = y_half/max(y_half);

% plot(f, y_norm, '-');
% xlabel('Frequency');
% ylabel('Power');

F5 = sum(y_norm > mean(y_norm));
end