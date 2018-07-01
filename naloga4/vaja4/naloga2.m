function naloga2()
  pkg load image
  %nalogaA();
  %nalogaB();
  nalogaC()
endfunction


function R = nalogaA()
  I = imread('camera2.jpg');
  pW=480;
  pH=640;
  H = load('camera2.txt');
  Hinv = inv(H);
  figure(1)
  subplot(1,3,1);
  imshow(I);
  [pX,pY]=ginput(4)
  hold on;
  for i=1:4
    plot(pX(i),pY(i), 'xr');
  endfor
  hold off;
  
  Im=poly2mask(pX,pY,pW,pH);
  subplot(1,3,2);
  imshow(Im);
  subplot(1,3,3);
  R = immask(I,Im);
  imagesc(R);
endfunction

function R = pickOnScreen(stringJpg, stringTxt,w,h)
  I = imread(stringJpg);
  pW=w; 
  pH=h;
  H = load(stringTxt);
  figure(1)
  imshow(I);
  [pX,pY]=ginput(4);
  hold on;
  for i=1:4
    plot(pX(i),pY(i), 'xr');
  endfor
  hold off;
  Im=poly2mask(pX,pY,pW,pH);
  R = immask(I,Im);
endfunction


 %S = 86, 71
 %V = 47
function nalogaB()
  I = rgb2hsv(pickOnScreen('camera2.jpg','camera2.txt',480,640));
  SE =strel('diamond',2);
  greenSeg = I(:,:,1)>=220/360 & I(:,:,1)<=240/360 & I(:,:,2)>=0.62 & I(:,:,2)<=0.86 & I(:,:,3)<=0.55;
  fix_green = imdilate(bwareaopen(greenSeg,170),SE);
  figure(2);
  imshow(fix_green);
endfunction

function nalogaC()
  Iorg = imread('camera2.jpg');
  I = rgb2hsv(pickOnScreen('camera2.jpg','camera2.txt',480,640));
  SE =strel('rectangle',[2 3]);
  greenSeg = I(:,:,1)>=200/360 & I(:,:,1)<=240/360 & I(:,:,2)>=0.40 & I(:,:,2)<=0.86 & I(:,:,3)<=0.55;
  fix_green = imdilate(bwareaopen(greenSeg,170),SE);
  figure(2);
  subplot(1,2,1);
  imshow(fix_green);
  img_centroids = regionprops(fix_green,'centroid');
  centroids = cat(1, img_centroids.Centroid);
  subplot(1,2,2);
  imshow(Iorg);
  hold on
  plot(centroids(:,1),centroids(:,2), 'rx');
  hold off

endfunction

function R = immask(I, M)
  mask = M == 0;
  
  r = I(:, :, 1);
  g = I(:, :, 2);
  b = I(:, :, 3);
  
  r(mask) = 0;
  g(mask) = 0;
  b(mask) = 0;
  
  R = cat(3, r, g, b);
endfunction