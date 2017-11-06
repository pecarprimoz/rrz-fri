pkg load image
I2 = imread('trucks.jpg');
I1 = rgb2hsv(I2);
first=I1(:,:,1);
blue = first >= 180/360 & first <=215/360;
special = blue & (I1(:,:,2)>0.4);
# & (I1(:,:,3)<1
figure(1);
imshow(special);
###
I1 = rgb2hsv(imread('flum.jpg'));
first=I1(:,:,1);
orange=first >= 14/360 & first <= 54/360;
special = orange & I1(:,:,2)>0.85 | I1(:,:,3)>0.95;
figure(2);
imshow(special);



###

#e) narejen ZGORAJ UPORAGOVAL TUDI PO V IN S, 
# težko je določiti oddtenek zaradi različnih vrednostih v V in S,
# lažje lahko to določimo z uporagovanjem po še teh kanalih

#f)

yimg = rgb2hsv(imread("trucks.jpg"));
prag = (yimg(:,:,1)>=32/360 & yimg(:,:,1)<=55/360) & yimg(:,:,2) >= 0.4  & yimg(:,:,3)>=0.4;
figure(3);
SE = strel('diamond',4);
finished_pic = bwlabel(imdilate(bwareaopen(prag,25),SE));
print_struct_array_contents(true)
test = regionprops(finished_pic,"centroid");
#test
imagesc(finished_pic);

#idk if region is right

#g 
function immask(pic_rgb,pic_bw)
Irgb=pic_rgb;
I1=pic_bw;
first=I1(:,:,1);
orange=first >= 14/360 & first <= 54/360;
special = orange & I1(:,:,2)>0.1 & I1(:,:,3)>=0.95;
figure(4);
imshow(special.*Irgb);
end

Irgb= imread('flum.jpg');
I1 = rgb2hsv(imread('flum.jpg'));

immask(Irgb,I1);