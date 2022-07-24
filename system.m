clc
pkg load image
I = imread("image 1 .jpg");
Igrey = rgb2gray(I);
Iedge = edge(Igrey);
bn = im2bw(Igrey)
%figure , imshow(bn)
bw = Igrey < 60;
%figure , imshow(bw)

% Find the Region of Interest 
whiteCountPerRow = sum(bw , 2);
regions = whiteCountPerRow > 100
start = [1 ; find(diff(regions) == 1)] 
endidx = [find(diff(regions) == -1) ; length(regions)]
[~ , widestRegion] = max(endidx - start)
upper = start(widestRegion)
lower = endidx(widestRegion)
Roi = bw(upper: lower , :);
figure , imshow(Roi);

% find Each Char 
col = sum (Roi , 1);
regions = col > 3;
startidx = [1 find(diff(regions) == 1)];
endidx = [find(diff(regions) == -1 ) length(regions)];
regions = endidx - startidx;
widththreeshold = mean(regions);
letter = Roi(: , startidx(2):endidx(2)+1);
figure , imshow(letter)




%location = regionprops(I , 'BoundingBox' , 'Area' , 'Image');
%area = location.Area;
%count = numel(location);
%boundingbox =location.BoundingBox;