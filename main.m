clear 
clc;
%-------------------------Sample start--------------------------------
img_sample=imread('Breast\Test_Image_5.png');
mask1 = imread('Mask\mask_5.png');
img_sample = uint8(img_sample);
mask1 = uint8(mask1);
[y1,y2] = tumor1(img_sample);
B1 = bwboundaries(y1);

figure,
subplot(2,3,1)
imshow(img_sample)
title('Original image');

subplot(2,3,2)
imshow(y1);
title('My result');

subplot(2,3,3)
imshow(y2);
title('result on image');

subplot(2,3,4)
imshow(mask1);
title('mask');

mask1_b = imbinarize(mask1);
sim1 = dice(y1,mask1_b);
subplot(2,3,5)
imshowpair(mask1_b,y1);
title('result vs mask');
imwrite(y1,'Result/SampleResult.png');
%--------------------------Sample finish----------------------------



%--------------------------program code-------------------------------------
%read image from folder
img = imread('Breast\ImageName');
img = uint8(img);
% Replace 'ImageName' to the filename of the image. See sample code

%-------------------------------------------------------------------
% mask2 = imread('Mask\MaskName');
% mask2 = uint8(mask2);
% If there is a mask to compare my result, uncommenet line 45-46 
% Replace 'MaskName' to the file name of the mask. See sample code
%-------------------------------------------------------------------

[f1,f2] = tumor1(img);
B2 = bwboundaries(f1);

figure,
%plot the original image
subplot(2,3,1)
imshow(img)
title('Original image');

%plot the result
subplot(2,3,2)
imshow(f1);
title('My result');

% result vs image
subplot(2,3,3)
imshow(f2);
title('result on image');

%-----------------------------------------------------------------
%if there is a mask to compare my result, uncomment line 72-83
%{
%plot the mask
subplot(2,3,4)
imshow(mask2);
title('mask');

mask2_b = imbinarize(mask2);
sim2 = dice(f1,mask2_b);
subplot(2,3,5)
imshowpair(mask2_b,f1);
title('result vs mask');
%}
%-----------------------------------------------------------------

%Output the result image
imwrite(f1,'Result/result.png');
%}
