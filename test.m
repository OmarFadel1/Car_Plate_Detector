clc
% ----------------------------- Load Image -------------------------
imagen =imread('image 6.jpg');  
figure(1)
imshow(imagen);

ColoredImage = imagen ;
title('INPUT IMAGE WITH NOISE')

  
%---------------------------- Pre-Processing -------------------------------

imagen=rgb2gray(imagen);
threshold = graythresh(imagen);
imagen =~im2bw(imagen,threshold);
%imagen = imagen < 80 ;
figure 
imshow(imagen)


%%Remove Noise containing fewer than 24 pixels
imagen = bwareaopen(imagen,12);
pause(1)
figure(2)
imshow(~imagen);
title('INPUT IMAGE WITHOUT NOISE')

%=============================  Object Detection ===========================================

[L Ne]=bwlabel(imagen);
propied=regionprops(L,'BoundingBox' , 'Area' );
hold on

for n=1:size(propied,1)
    %propied(n)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off
pause (1)
% ------------------------------  Load Dataset ----------------------------------
% s at 18
% garb1 -> 29
alpha = {"0" ,"000"  "1" ,"111" , "2"  "4"  "5" ,"05"  "6" , "66", "3" , "9"  ,"99", "55" ,  "6" ,  "7" , "00" ,"s"  ,"k" , "md" ,"mm", "y" , "taah", "m" , "g" , "r" , "daal" , "laaam", "garb1" , "garb2"  , "garb4","garb5","garb6","garb7","garb8" ,"garb9","garb10","garb11" , "garb12" , "garb14"};
location = "BestMatches/";
extension = ".jpg";
% Loop To Detect Plate 
for j =1 : size(propied , 1)
   %propied(j)
		if (propied(j).Area < 200)
			continue;
		endif
    ind = 0 ;
		Lcount = 0 ; Ncount = 0;
    
    %-----------------------Extracting The Best Pixel For Color Detection ---------------------------------------
    
    R1 = ColoredImage(:,:,1); 
    G1 = ColoredImage(:,:,2); 
    B1 = ColoredImage(:,:,3);
    left = propied(j).BoundingBox(1) + (propied(j).BoundingBox(3) / 2 );
    top = propied(j).BoundingBox(2) ;
    
% ------------------------------  Handelling White Pixels ----------------------------
for k =1:20
  
       top =  top + 3 ;
      if(R1(round(top) ,round(left)) >=  240 && G1(round(top) , round(left)) >= 222 & B1(round(top) , round(left)) >= 173)
       top = top + 3;
     else
        break;
    endif
    endfor
    
   %[R1(round(top),round(left)) G1(round(top),round(left)) B1(round(top),round(left))] 
   
   % ----------------------------------------  Color Detection -------------------------------------- 
     if(R1(round(top) ,round(left)) >=  128 && G1(round(top) , round(left)) >= 0 && G1(round(top) , round(left)) <= 160 &&  B1(round(top) , round(left)) >= 0 && B1(round(top) , round(left)) <= 147)   
    color = "Transport [Red Plate]";
    elseif (R1(round(top) ,round(left)) >= 122 && R1(round(top) ,round(left)) <= 220 && G1(round(top) , round(left)) >= 127 && G1(round(top) ,round(left)) <= 220 && B1(round(top) , round(left)) >= 130 && R1(round(top) ,round(left)) <= 220)
     color = "Governorate Car [Grey Plate ]";
   elseif (R1(round(top) ,round(left)) <= 135 && G1(round(top) , round(left)) <= 206 && B1(round(top) , round(left)) >= 118)
     color = "Owners Car [Light Blue Plate]";
   endif
   figure 
   hold on
   % -------------------------------------------- Feature Extarction ----------------------------
		for n=1:Ne
		
			[r, c] = find(L == n);
			if (c(5) > propied(j).BoundingBox(1) && c(5) < propied(j).BoundingBox(1) + propied(j).BoundingBox(3) && r(5) > propied(j).BoundingBox(2) && r(5) < propied(j).BoundingBox(2) + propied(j).BoundingBox(4))
			
				n1 = imagen(min(r) :max(r), min(c) : max(c));
        n1Area = bwarea(n1);
        
				n1 = imresize(n1, [42 24]);
        if(n1Area > 200)
            %disp("Frame Detected ");
            continue;
        endif
        
				 %figure, imshow(n1);
         % ---------------------------------------- Match Features --------------------------------------
				rec = [];
				for i=1:40
					letter = strcat(location, alpha{ i }, extension);
					dataset = imread(letter);
					dataset = imresize(dataset, [42 24]);
					cor = corr2(n1, dataset);
					rec = [rec cor];
				endfor
				ind = find(rec == max(rec));
        %alpha{ind}
        %---------------------------------- Handelling Letter Counter And Numbers Counter ----------------------
				if (ind < 18)
					Ncount = Ncount + 1;
          imshow(~n1) 
          pause(0.1)
          hold off
				elseif(ind > 17 && ind < 29)
       imshow(~n1)
       pause (0.1)
       hold off
					Lcount = Lcount + 1;
				endif
        hold off
			endif
		endfor
       
if(Lcount + Ncount == 6)
   if(Ncount == 3)
   Gover = "Cairo";
   elseif(Ncount == 4)
   Gover = "Giza";
 endif
else
   Gover = "Other governorate ";
endif  

    output1 = ["Number Of Characters: " , num2str(Lcount+Ncount) , " Numbers = " , num2str(Ncount)];
    output2 = ["Governorate: " , Gover];
    output3 = ["Vehicle: " , color];
    disp(output1); disp(output2); disp(output3);
    disp("================================================================")
    
endfor



















