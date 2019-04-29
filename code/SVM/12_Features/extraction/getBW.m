    
function BW = getBW( signal, step )

figure;
plot(signal(1:end-step), signal(1+step:end), 'k');
axis off

F = getframe(gcf);
[X, Map] = frame2im(F);
BINARY = im2bw(X,Map,0.01);
BW = imcomplement(BINARY); % inverse
% imshow(BW);
% title(sprintf('BW-%i', step));

close
end
