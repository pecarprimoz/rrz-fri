## NALOGA 4
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

#rgb določajo 3 barve red green blue in na podlagi teh se mešajo nove barve,
#pri hsv modelu pa ima vsaka barva še intenziteto od bele do črne, oz Hue Saturation
#value


####