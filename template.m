clc ;
%Numbers 
zero = imread("BestMatches/0.jpg");
zero = imresize(zero , [42 24]);
one = imread("BestMatches/1.jpg");
one = imresize(one , [42 24]);
two = imread("BestMatches/2.jpg");
two = imresize(two , [42 24]);
four = imread("BestMatches/4.jpg");
four = imresize(four , [42 24]);
fife = imread("BestMatches/5.jpg");
fife = imresize(fife , [42 24]);
six = imread("BestMatches/6.jpg");
six = imresize(six , [42 24]);
seven = imread("BestMatches/7.jpg");
seven = imresize(seven , [42 24]);






%alpha = [zero , one ,two ,four ,fife , six , seven , gaaf  ,kaaf  ,meem ,r, seen] ; 
%two four fife six seven gaaf kaaf meem r seen
alpha = {"00" , "1fefw" , "2de" , "3"};
location = "BestMatches/";

extension = ".jpg";
for i =1:4
  letter =  strcat(location , alpha{i} , extension)
end
