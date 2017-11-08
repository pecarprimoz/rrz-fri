

## Naloga 2
# a)
function vaja1_naloga2()
  #nal2_a
  #nal2_b
  #nal2_c
  #nal2_d
  #nal2_e
  #nal2_f
  #nal2_g
endfunction

function nal2_a
 image_umbrella = imread("umbrellas.jpg");
 figure(1); clf; imagesc(image_umbrella);
 figure(2); clf; imshow(image_umbrella);
endfunction
###

# Izpis velikosti slike
# [h,w,d] = size(image_umbrella);
# h,w,d

# b)
# Sliko je potrebno spremeniti v double, zaradi preliva pri deljenju int8
function nal2_b
 image_umbrella = imread("umbrellas.jpg");
 image_umbrella_d = double(image_umbrella);
 [h, w, d]=size(image_umbrella_d);

## image_umbrella_d(:,:,x) predstavlja matriko za določeno barvo? DA
 image_umbrella_gray = (image_umbrella_d(:,:,1) + image_umbrella_d(:,:,2) + 
  image_umbrella_d(:,:,3)) /3.0; #če množiš rata vse ful brights

# Če ne spremeniš nazaj v int, se slika ne izriše. 

 figure; imshow(uint8(image_umbrella_gray));
endfunction
###

# c) spremeni privzeto barvo sliki
# help colomap
function nal2_c
 image_umbrella = imread("umbrellas.jpg");
 image_umbrella_d = double(image_umbrella);
 [h, w, d]=size(image_umbrella_d);

 image_umbrella_gray = (image_umbrella_d(:,:,1) + image_umbrella_d(:,:,2) + 
  image_umbrella_d(:,:,3)) / 3.0;

# Če ne spremeniš nazaj v int, se slika ne izriše. 
 figure; imshow(uint8(image_umbrella_gray)); colormap(bone);
 figure; imshow(uint8(image_umbrella_gray)); colormap(jet);
 figure; imshow(uint8(image_umbrella_gray)); colormap(gray);

# Colormap kličeš po izrisu figure, neopazno na non-gray sliki
endfunction
###

# d)
function nal2_d
 image_umbrella_1 = imread("umbrellas.jpg");
 image_umbrella_1(130:260,240:450,3) = 0;
 figure;
 subplot(1,2,1);
 imshow(image_umbrella_1);
 image_umbrella_2 = image_umbrella_1(130:260,240:450,2);
 subplot(1,2,2);
 imshow(image_umbrella_2);
endfunction
###

# e)
function nal2_e
 image_umbrella_1 = imread("umbrellas.jpg");
 image_umbrella_1(130:260,240:450,3) = 0;
 image_umbrella_2 = image_umbrella_1(130:260,240:450,2);
 image_umbrella_negated = 255 - image_umbrella_2;
 figure;
 imshow(image_umbrella_negated);
endfunction
###

# f)
function nal2_f
 image_umbrella_1 = imread("umbrellas.jpg");
 image_umbrella_1(130:260,240:450,3) = 0;
 image_umbrella_2 = image_umbrella_1(130:260,240:450,2);
 image_bin = image_umbrella_2 > 150;
 figure;
# imshow(image_umbrella_2);
## imagesc(image_bin);
 imagesc(image_bin);
endfunction


# g) nared z spletno kamero
function nal2_g
for i=2:12
  read_pic = sprintf('my_photo-%d.jpg',i);
  im=double(imread(read_pic));
  im_bw=(im(:,:,1)+im(:,:,2)+im(:,:,3)) / 3.0;
  im_bw=im_bw>150;
  figure(1);
  subplot(2,4,i);
  imshow(uint8(im_bw)*255);
endfor
endfunction


### done