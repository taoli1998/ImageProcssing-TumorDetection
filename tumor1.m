function [y1,y2] = tumor1(img)
    
[M,N] = size(img);
%figure(1),imshow(img);
% apple gausian lowpass filter
[img_gau] = filter_im(img,30,2);
%figure(2),imshow(img_gau);

[counts,o] = imhist(img_gau,32);
T = otsuthresh(counts);
BW = imbinarize(img_gau,T);
BW1 = ~BW;
%BW1 = imclearborder(BW1);
area = bwarea(BW1);
%figure(3), imshow(BW1);

if area>9398 && area<9400
    BW1 = imclearborder(BW1);
    region1 = bwareafilt(BW1,5);
    %figure(4), imshow(region1);
    region2 = bwareafilt(region1,[20,5000]);
    [labeledImage, numRegions] = bwlabel(region2);
props = regionprops(labeledImage, 'Area');
% Compute all the areas.
allAreas = [props.Area];
% Display each blob in its own %figure.
temp = 0;
for k = 1 : numRegions
    thisRegion = ismember(labeledImage, k);
    if k ~=1
        H1 = uint8(thisRegion).*img;
            
        H2 = H1;
        if mean(H1,'all') < mean(temp,'all')
            OurRegion = thisRegion;
            temp = H2;
        end
        
    else
        OurRegion = thisRegion;
        temp = uint8(thisRegion).*img;
        
    end
    
    %figure;
    %imshow(thisRegion);
    %drawnow;
end
%figure,imshow(OurRegion);
se2 = strel('square',2);
img_dila = imdilate(OurRegion,se2);
%figure,imshow(img_dila);

Final = zeros(M,N);


for i=1:M
    for j=1:N
        if img_dila(i,j) == 1
            Final(i,j) = 255;
        else
            Final(i,j) = img(i,j);
        end
    end
end
%figure, imshow(uint8(Final));
    
else

se1 = strel('square',9);
%se1 = strel('line',20,15);
img_ero = imerode(BW1,se1);
%figure(4), imshow(img_ero);

region1 = bwareafilt(img_ero,5);
%figure(5), imshow(region1);
for i=21:33
    region1(88,i)=0;
end

region1 = imclearborder(region1);

%figure(6), imshow(region1);
region2 = bwareafilt(region1,[0,5000]);
region2 = imfill(region2,'holes');
%figure(7), imshow(region2);



[labeledImage, numRegions] = bwlabel(region2);
props = regionprops(labeledImage, 'Area');
% Compute all the areas.
allAreas = [props.Area];
% Display each blob in its own %figure.
temp = 0;
for k = 1 : numRegions
    thisRegion = ismember(labeledImage, k);
    if k ~=1
        H1 = uint8(thisRegion).*img;
        [p,q] = size(H1);
        D = zeros(p,q);
        D(img<60) = 1;
        H2 = uint8(D).*H1;
        if mean(H1,'all') > mean(temp,'all')
            OurRegion = thisRegion;
            temp = H2;
        end
        
    else
        OurRegion = thisRegion;
        temp = uint8(thisRegion).*img;
        [p,q] = size(temp);
        D = ones(p,q);
        D(img<60) =1;
        temp = uint8(D).*temp;
    end
    
    %%figure;
    %imshow(thisRegion);
    %drawnow;
end
%figure,imshow(OurRegion);

%se2 = strel('square',6);
se2 = strel('square',8);
img_dila = imdilate(OurRegion,se2);
se3 = strel('disk',1);
img_dila = imdilate(img_dila,se3);
%figure,imshow(img_dila);

Final = zeros(M,N);


for i=1:M
    for j=1:N
        if img_dila(i,j) == 1
            Final(i,j) = 255;
        else
            Final(i,j) = img(i,j);
        end
    end
end
%figure, imshow(uint8(Final));

end
y1 = img_dila;
y2 = uint8(Final);
end