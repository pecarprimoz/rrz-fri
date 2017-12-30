function naloga3()
  pkg load image
  nalogaA();

endfunction


function nalogaA()
  camera = camera_create('10.0.0.106:8080'); % Create camera handle
  image = camera_image(camera); % Retrieve current image
  H = camera_position(camera); % Retrieve current homoraphy
  %na koncu dodal spet prvotno koordinato ker drugače mi je falila ena črta
  X = [100,100,300,300];
  Y = [-200,200,200,-200];
  figure(2);
  imshow(image); % Display image
  hold on;
  for i = 1:4
    vector_h= H * [X(i),Y(i),1]';
    X(i)=vector_h(1)/vector_h(3);
    Y(i) = vector_h(2)/vector_h(3);
    plot(X(i),Y(i), '.r');
  endfor
  plot(X',Y','r')
  plot([X(1) X(4)],[Y(1) Y(4)],'r');
  hold off;

  Im=poly2mask(X,Y,480,640);
  R = immask(image,Im);
  I = rgb2hsv(R);
  %imshow(I);
  %hsv upragovanje za 3 razlicne primere, todo
  
  %REDS START
  %HUE 1 - 10
  %SAT 65 - 80
  %VAL x
  %SEr=strel('rectangle',[3 3]);
  %redSeg = I(:,:,1)>=1/360 & I(:,:,1)<=11/360 & I(:,:,2)>=0.65 & I(:,:,2)<=0.86;
  %fix_red = imdilate(redSeg,SEr);
  %imshow(fix_red);
  %REDS END
  
  %HUE 100 - 225
  %SAT 7 - 15
  %VAL 15 - 20
  %BLACKS START
  SEb = strel('rectangle',[4 4]);
  blackSeg = I(:,:,1)>=100/360 & I(:,:,1)<=235/360 & I(:,:,2)>=0.04 & I(:,:,2)<=0.2 & I(:,:,3)>=0.15 & I(:,:,3)<=0.2;
  fix_black = imdilate(bwareaopen(blackSeg,100),SEb);
  %imshow(fix_black);
  
  %BLACKS END
  
  %BLUES FROM BEFORE
  SE =strel('rectangle',[2 3]);
  greenSeg = I(:,:,1)>=200/360 & I(:,:,1)<=240/360 & I(:,:,2)>=0.40 & I(:,:,2)<=0.86 & I(:,:,3)<=0.55;
  fix_green = imdilate(bwareaopen(greenSeg,100),SE);
  %imshow(fix_green);
  %END BLUES
  
  %centroidi za modre, reakcija roke na modre
  img_centroids = regionprops(fix_green,'centroid');
  centroids = cat(1, img_centroids.Centroid)
  hold on;
  plot(centroids(:,1),centroids(:,2), 'rx');
  hold off;
  figure(3)
  pX=centroids(:,1)
  pY=centroids(:,2)
  hold on;
  Hinv = inv(H);
  for i=1:size(centroids(:,1))
    vector_h = Hinv* [pX(i), pY(i),1]';  
    pX(i)=vector_h(1)/vector_h(3);
    pY(i) = vector_h(2)/vector_h(3);
    plot(pX(i),pY(i), 'b');
  endfor
  hold off;
  world = world_setup(1, 400);
  manipulator = manipulator_create('10.0.0.106');
  manipulator_draw(world, manipulator);
  for i=1:size(pX)
    state = manipulator_solve(manipulator, [pX(i), pY(i), 30]);
    % Transition to the new manipulator state
    manipulator = manipulator_animate(world, manipulator, state, 10);
  endfor
  
  %centroidi za modre, reakcija roke na modre
  img_centroids = regionprops(fix_black,'centroid');
  centroids = cat(1, img_centroids.Centroid)
  figure(2);
  hold on;
  plot(centroids(:,1),centroids(:,2), 'rx');
  hold off;
  figure(3);
  pX=centroids(:,1)
  pY=centroids(:,2)
  hold on;
  Hinv = inv(H);
  for i=1:size(centroids(:,1))
    vector_h = Hinv* [pX(i), pY(i),1]';  
    pX(i)=vector_h(1)/vector_h(3);
    pY(i) = vector_h(2)/vector_h(3);
    plot(pX(i),pY(i), 'b');
  endfor
  hold off;
  world = world_setup(1, 400);
  for i=1:size(pX)
    state = manipulator_solve(manipulator, [pX(i), pY(i), 30]);
    state(7)=1;
    % Transition to the new manipulator state
    manipulator = manipulator_animate(world, manipulator, state, 10);
  endfor


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