function [F2, F3] = getF23(BW)

line_length = 60;
F2 = 0;
B = zeros(size(BW), 'logical');
for i = 1:size(BW, 1)
    for j = 1:size(BW, 2)
        if BW(i, j)
            d=1;
            while 1
                if(BW(i-d, j+d)==0)
                    break
                end
                d = d+1;
            end
            if d >= line_length
                F2 = F2+1;
                for ind =0:d
                    BW(i-ind, j+ind) = 0;
                    B(i-ind, j+ind) = 1;
                end
            end
        end
    end
end
%F3 = sum(sum(B));
F3 = sum(sum(B))/numel(B);

% figure
% imshow(B);
% title('45-angle lines');
end

