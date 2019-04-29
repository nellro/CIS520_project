function F4 = getF4( BW1, BW5 )
% Because of the disorganized behavior of a VT phase plot, 
% the area of white zone in the related binary image is higher than
% the area of white zone in a SVT phase plot¡¯s binary image
% F4 is higher for VT

BW_DIF = imsubtract(BW1, BW5);
BW_FILL = imfill(BW_DIF,8,'holes'); % 4 | 8 | 6 | 18 | 26
%F4 = sum(sum(BW_FILL));
F4 = sum(sum(BW_FILL))/numel(BW_FILL);

% figure
% imshow(BW_FILL);
% title('Filled BW1-BW5');
end