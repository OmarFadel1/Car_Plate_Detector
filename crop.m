clc
I1 = imread("image 1 .jpg");
I1 = imresize(I1 , [72 131]);
I2 = imread("image 2.jpg");
I2 = imresize(I2 , [50 131]);
I3 = imread("image 3.jpg");
I3 = imresize(I3 , [50 131]);
I4 = imread("image 5.jpg");
I4 = imresize(I4 , [50 131]);
R = I1(:,:,1); 
G = I1(:,:,2); 
B = I1(:,:,3);

col = 20 ;
row = 60 ;
[R(col,row) G(col,row) B(col,row)]




%  0   87  199 -> Blue 
% 160   13    5 -> Red 
% 189  199  200 -> Grey 
% 76, 144, 224 - blue 


% Blue -> R( 0,35 ) , G(40 , 60) , B(95 , 255) 
% Red -> R(220 , 255) , G(0 , 127) , B()