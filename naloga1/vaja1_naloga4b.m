# Naloga b
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

###

# c) posebno uporagovanje

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

###