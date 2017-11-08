## NALOGA 4
function vaja1_naloga4()
  #nal4_a
  #nal4_b
  #nal4_c
  #nal4_d
  #nal4_f #kle rabs se regije
  
  #Irgb= imread('flum.jpg');
  #I1 = rgb2hsv(imread('flum.jpg'));
  #immask(Irgb,I1);
endfunction

function nal4_a
I1 = imread('trucks.jpg');
figure(1);
hold on;
colormap gray;
subplot(2, 4,1);
imshow(I1);
% Draw RGB channels as separate subplots

subplot(2, 4,2);
imshow(I1(:,:,1));

subplot(2, 4,3);
imshow(I1(:,:,2));

subplot(2, 4,4);
imshow(I1(:,:,3));
% Draw HSV channels as separate subplots
I2 = rgb2hsv(I1);
subplot(2,4,6);
imshow(I2(:,:,1));
subplot(2,4,7);
imshow(I2(:,:,2));
subplot(2,4,8);
imshow(I2(:,:,3));
hold off;
endfunction
#rgb določajo 3 barve red green blue in na podlagi teh se mešajo nove barve,
#pri hsv modelu pa ima vsaka barva še intenziteto od bele do črne, oz Hue Saturation
#value


####



# Naloga b
function nal4_b
 I1 = imread('trucks.jpg');
 figure(1);
 subplot(1, 2,1);
 imshow(I1);
## Poberem samo moder kanal
 blue = I1(:,:,3);
## Če je vrednost v blue manjša od 200 jo postavimo na 0
 blue=blue>200;
 subplot(1,2,2);
 imshow(blue);
endfunction
###

# c) posebno uporagovanje
function nal4_c
I1 = double(imread("trucks.jpg"));
figure(2);
subplot(1,2,1);
imshow(uint8(I1));
[w,h,r] = size(I1);
sum_channels = (double(I1(:,:,1)) + double(I1(:,:,2)) + double(I1(:,:,3)));
cur_blue=I1(:,:,3);
cur_blue = cur_blue ./sum_channels;
cur_blue=cur_blue>0.5;
subplot(1,2,2);
imshow(cur_blue);
endfunction
###

function nal4_d
I2 = imread('trucks.jpg');
I1 = rgb2hsv(I2);
first=I1(:,:,1);
blue = first >= 180/360 & first <=215/360;
special = blue & (I1(:,:,2)>0.4);
# & (I1(:,:,3)<1
figure(1);
imshow(special);
###, kle je se za moj e
I1 = rgb2hsv(imread('flum.jpg'));
first=I1(:,:,1);
orange=first >= 14/360 & first <= 54/360;
special = orange & I1(:,:,2)>0.85 | I1(:,:,3)>0.95;
figure(2);
imshow(special);
endfunction


###

#e) narejen ZGORAJ UPORAGOVAL TUDI PO V IN S, 
# težko je določiti oddtenek zaradi različnih vrednostih v V in S,
# lažje lahko to določimo z uporagovanjem po še teh kanalih

#f)
function nal4_f
yimg = rgb2hsv(imread("trucks.jpg"));
prag = (yimg(:,:,1)>=32/360 & yimg(:,:,1)<=55/360) & yimg(:,:,2) >= 0.4  & yimg(:,:,3)>=0.4;
figure(3);
SE = strel('diamond',4);
finished_pic = bwlabel(imdilate(bwareaopen(prag,25),SE));
print_struct_array_contents(true)
test = regionprops(finished_pic,"centroid");
#test
imagesc(finished_pic);
endfunction
#idk if region is right

#g 
function immask(pic_rgb,pic_bw)

Irgb=pic_rgb;
I1=pic_bw;
figure(4);
subplot(1,3,1);
imshow(Irgb);
first=I1(:,:,1);
orange=first >= 14/360 & first <= 54/360;
special = orange & I1(:,:,2)>0.1 & I1(:,:,3)>=0.95;
subplot(1,3,2);
imshow(special);
subplot(1,3,3);
imshow(special.*Irgb);
end