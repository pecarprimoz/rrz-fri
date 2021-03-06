function vaja1_naloga_5
  pkg load image
  #nal5_c
  #nal5_e
  #### DRUGI DEL
  #nal5_bsecond
  #nal5_csecond
  # init za moment
  #I1 = imread("regions.png");
  #I1 = I1(:,:,1)>1;
  #[I2 , n]=bwlabel(I1); #nova slika stevilo regij
  #[r,c]=find(I2==1);
  #rc = [r c];
  #moment(rc,0,0)
  #central_moment(rc,0,0)
  ###konec momenta
  
  #nal5_dsecond
  #nal5_tic
  f
endfunction



# c)
function nal5_c
rgs = imread("regions.png");
# [h,w]=size(rgs);
test = im2bw(rgs,0.5);
finished = bwlabel(test);
figure;
imagesc(finished);
endfunction
###

# d) 
function [moment] = moment(R, p, q)
  moment = sum(R(:,1).^p.* R(:,2).^q)
endfunction
function [central_moment] = central_moment(R, p, q)
  [x , ~] =size(R);
  avgx = sum(R(:,1))/x;
  avgy = sum(R(:,2))/x;
  central_moment= sum((R(:,1)-avgx).^p.* (R(:,2)-avgy).^q);

endfunction
#e)

function nal5_e
I = imread("regions_noise.png");
SE=strel('diamond',1);
testing = bwlabel(imdilate(bwareaopen(I,3),SE));
print_struct_array_contents(true)
cents = regionprops(testing,"centroid");
boxes = regionprops(testing,"BoundingBox");
figure;
imagesc(testing);
hold on;
#vpras kako se direkt not da box
rectangle('Position',[12.5,10.5,25.0,25.0],'EdgeColor','g','LineWidth',3);
rectangle('Position',[20.500,49.500,24.000,20.000],'EdgeColor','g','LineWidth',3);
rectangle('Position',[57.500,22.500,53.000,34.000],'EdgeColor','g','LineWidth',3);
plot(25.269,23.287,'bo','MarkerSize',10);
plot(32.500,59.500,'bo','MarkerSize',10);
plot(84.212,38.599,'bo','MarkerSize',10);
endfunction

###

## spet a) u zvezku

##b)
function nal5_bsecond
I = imread("regions_noise.png");
bw=bwlabel(im2bw(I,0.5));
#num_regs=regionprops(bw,'Area')
#77
 figure;
 imagesc(bw);
# opazimo šum, te regije so velike po 1 ali 2 piksla, pogosti pojav v rač. vidu
# saj ko zajemamo sliko lahko nastane šum zaradi pomankanja svetlobe, premika kamere
endfunction
#c )
function nal5_csecond
I = imread("regions_noise.png");
bw=bwlabel(im2bw(I,0.5));
se = ones(3,3);
A1 = imdilate(bw,se);
A2 = imerode(A1,se);
B1 = imerode(bw,se);
B2 = imdilate(B1,se);

figure;
subplot(2,3,1);
imshow(bw);
subplot(2,3,2);
imshow(A1);
subplot(2,3,3);
imshow(A2);

subplot(2,3,4);
imshow(B1);
subplot(2,3,5);
imshow(B2);
endfunction
###
#d)
function nal5_dsecond
serode = strel('diamond',2);
sedil = ones(2,2);
img = imread("regions_noise.png");
figure(1);
subplot(1,2,1);
imshow(imerode(imdilate(img,sedil),serode));
subplot(1,2,2);
imshow(imopen(imclose(img,serode),sedil));
endfunction
###




###

#tic
function nal5_tic
yimg = rgb2hsv(imread("bird.jpg"));
prag = ( yimg(:,:,2) >= 0.06  & yimg(:,:,3)>=0.2);
SE = strel('diamond',4);
finished_pic = bwlabel(imdilate(bwareaopen(prag,55),SE));
figure(3);
subplot(1,2,1);
imshow(prag);
subplot(1,2,2);
imshow(finished_pic);
endfunction
function f()
yimg = rgb2hsv(imread("candy_new.jpg"));
SE =strel('diamond',2);
SEblue =strel('diamond',4);
rgbimg =imread("candy_new.jpg");
bimg = rgb2hsv(imread("candy_new.jpg"));
pragRED = (imdilate(bwareaopen((yimg(:,:,1) >= 3/360  & yimg(:,:,1)<=10/360),5),SEblue));
centRED = regionprops(pragRED,"centroid");
pragBLUE = imdilate(bwareaopen(( yimg(:,:,1) >= 67/360  & yimg(:,:,1)<=210/360 & yimg(:,:,2)<=0.2 &yimg(:,:,2)>=0.03),90),SEblue);
centBLUE = regionprops(pragBLUE,"centroid");
pragBRWN =  imdilate(bwareaopen((yimg(:,:,1)>=15/360 & yimg(:,:,1)<=30/360 ),360),SE);
centBRWN = regionprops(pragBRWN,"centroid");
pragGREEN = imdilate(bwareaopen((yimg(:,:,1)>=40/360 & yimg(:,:,1)<=65/360 & yimg(:,:,2)>=0.48 & yimg(:,:,2)<=0.85 & yimg(:,:,3)>=0.5),990),SE);
centGREEN = regionprops(pragGREEN,"centroid");
pragYELL = imdilate(bwareaopen((yimg(:,:,1)>=45/360 & yimg(:,:,1)<=63 & yimg(:,:,2)>=0.61 & yimg(:,:,3)>=0.85),350),SE);
centYELL = regionprops(pragYELL,"centroid");

#vsi pragi skupaj
together_all = pragRED | pragBLUE | pragBRWN | pragGREEN | pragYELL;
figure(1);
imagesc(rgbimg);
#imshow(pragBLUE);
#imagesc(rgbimg);
#tko dobis vn tocn dolocn centroid
#all_red=cat(1,centRED);
#sample_user=[400,500];
#evk=norm(sample_user-all_red(14).Centroid)
#GET USER INPUT
[x,y]=ginput(1);
x,y
min_distance=99999;
closest_to='none';
coord_min=[];

red_vec=[centRED.Centroid];
counter=1;
while(counter<length(red_vec))
  euclidian_dist=norm([x,y]-[[centRED.Centroid](counter),[centRED.Centroid](counter+1)]);
  if(min_distance>euclidian_dist);
    min_distance=euclidian_dist;
    closest_to='red';
    coord_min=[[centRED.Centroid](counter),[centRED.Centroid](counter+1)];
  endif
  counter=counter+2;
endwhile

blue_vec=[centBLUE.Centroid];
counter=1;
while(counter<length(blue_vec))
  euclidian_dist=norm([x,y]-[[centBLUE.Centroid](counter),[centBLUE.Centroid](counter+1)]);
  if(min_distance>euclidian_dist);
    min_distance=euclidian_dist;
    closest_to='blue';
    coord_min=[[centBLUE.Centroid](counter),[centBLUE.Centroid](counter+1)];
  endif
  counter=counter+2;
endwhile
green_vec=[centGREEN.Centroid];
counter=1;
while(counter<length(green_vec))
  euclidian_dist=norm([x,y]-[[centGREEN.Centroid](counter),[centGREEN.Centroid](counter+1)]);
  if(min_distance>euclidian_dist);
    min_distance=euclidian_dist;
    closest_to='green';
    coord_min=[[centGREEN.Centroid](counter),[centGREEN.Centroid](counter+1)];
  endif
  counter=counter+2;
endwhile

brwn_vec=[centBRWN.Centroid];
counter=1;
while(counter<length(brwn_vec))
  euclidian_dist=norm([x,y]-[[centBRWN.Centroid](counter),[centBRWN.Centroid](counter+1)]);
  if(min_distance>euclidian_dist);
    min_distance=euclidian_dist;
      coord_min=[[centBRWN.Centroid](counter),[centBRWN.Centroid](counter+1)];
    closest_to='brwn';
  endif
  counter=counter+2;
endwhile


yell_vec=[centYELL.Centroid];
counter=1;
while(counter<length(yell_vec))
  euclidian_dist=norm([x,y]-[[centYELL.Centroid](counter),[centYELL.Centroid](counter+1)]);
  if(min_distance>euclidian_dist);
    min_distance=euclidian_dist;
      coord_min=[[centYELL.Centroid](counter),[centYELL.Centroid](counter+1)]; 
    closest_to='yellow';
  endif
  counter=counter+2;
endwhile

min_distance
closest_to
coord_min
coord_min(1)
coord_min(2)
#figure(2);
hold on;
#if you want correct
#imshow(together_all);

#if you want preatty
imagesc(rgbimg);
#where user clicked
plot(x,y,'or','MarkerSize',40);
#where closest is
plot(coord_min(1),coord_min(2),'oy','MarkerSize',40);

counter=1;
if(strcmp(closest_to,'red'))
  text(10,10,"Number of red: ",'Color','red');
  text(10,30,int2str(length(red_vec)/2),'Color','red');
  while(counter<length(red_vec))
    plot([centRED.Centroid](counter),[centRED.Centroid](counter+1),'+b','MarkerSize',10);
  counter+=2;
  endwhile

counter=1;
elseif(strcmp(closest_to,'blue'))
text(10,10,"Number of blue: ",'Color','red');
  text(10,30,int2str(length(blue_vec)/2),'Color','red');
  while(counter<length(blue_vec))
    plot([centBLUE.Centroid](counter),[centBLUE.Centroid](counter+1),'+b','MarkerSize',10);
  counter+=2;
  endwhile

elseif(strcmp(closest_to,'green'))
  text(10,10,"Number of green: ",'Color','red');
  text(10,30,int2str(length(green_vec)/2),'Color','red');
  while(counter<length(green_vec))
    plot([centGREEN.Centroid](counter),[centGREEN.Centroid](counter+1),'+b','MarkerSize',10);
  counter+=2;
  endwhile
elseif(strcmp(closest_to,'brwn'))
  text(10,10,"Number of brown: ",'Color','red');
  text(10,30,int2str(length(brwn_vec)/2),'Color','red');
  while(counter<length(brwn_vec))
    plot([centBRWN.Centroid](counter),[centBRWN.Centroid](counter+1),'+b','MarkerSize',10);
  counter+=2;
  endwhile
elseif(strcmp(closest_to,'yellow'))
  text(10,10,"Number of yellow: ",'Color','red');
  text(10,30,int2str(length(yell_vec)/2),'Color','red');
  while(counter<length(yell_vec))
    plot([centYELL.Centroid](counter),[centYELL.Centroid](counter+1),'+b','MarkerSize',10);
  counter+=2;
  endwhile
end
endfunction
