function naloga3()
  pkg load image
  %nalogaA();
  %nalogaE();
  %nalogaF();
  %skarice();
  kozarc();
  endfunction


function nalogaA()
  camera = camera_create('roka9.fri1.uni-lj.si'); % Create camera handle
  
  image = camera_image(camera); % Retrieve current image
  figure(6);
  imshow(image);
  H = camera_position(camera); % Retrieve current homoraphy
  %na koncu dodal spet prvotno koordinato ker drugače mi je falila ena črta
  X = [100,100,300,300];
  Y = [-200,200,200,-200];
  figure(1);
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
  %SEr=strel('rectangle',[4 4]);
  %redSeg = I(:,:,1)>=1/360 & I(:,:,1)<=11/360 & I(:,:,2)>=0.65 & I(:,:,2)<=0.95;
  %fix_red = imdilate(redSeg,SEr);
  %imshow(fix_red);
  %REDS END
  
  %HUE 100 - 225
  %SAT 7 - 15
  %VAL 15 - 20
  %BLACKS START, UZAME TI ŠE CELOTNO OKOLICO KOT DA JE BELA
  SEb = strel('rectangle',[6 6]);
  blackSeg = I(:,:,1)>=0/360 & I(:,:,1)<=235/360 & I(:,:,2)>=0.0 & I(:,:,2)<=0.25 & I(:,:,3)>=0.0 & I(:,:,3)<=0.2;
  fix_black = imdilate(bwareaopen(blackSeg,40),SEb);
  figure(3);
  imshow(fix_black);
  
  
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
  manipulator = manipulator_create('roka9.fri1.uni-lj.si');
  manipulator_draw(world, manipulator);
  for i=1:size(pX)
    state = manipulator_solve(manipulator, [pX(i), pY(i), 60]);
    % Transition to the new manipulator state
    manipulator = manipulator_animate(world, manipulator, state, 10);
  endfor
  
  img_centroids = regionprops(fix_black,'centroid');
  img_centroids(1)=[];
  centroids = cat(1, img_centroids.Centroid);
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
    state = manipulator_solve(manipulator, [pX(i), pY(i), 60]);
    state(7)=1;
    % Transition to the new manipulator state
    manipulator = manipulator_animate(world, manipulator, state, 10);
  endfor
endfunction

function nalogaE()
   camera = camera_create('roka9.fri1.uni-lj.si'); % Create camera handle
  
  image = camera_image(camera); % Retrieve current image
  figure(6);
  imshow(image);
  H = camera_position(camera); % Retrieve current homoraphy
  %na koncu dodal spet prvotno koordinato ker drugače mi je falila ena črta
  X = [100,100,300,300];
  Y = [-200,200,200,-200];
  figure(1);
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
  %SEr=strel('rectangle',[4 4]);
  %redSeg = I(:,:,1)>=1/360 & I(:,:,1)<=11/360 & I(:,:,2)>=0.65 & I(:,:,2)<=0.95;
  %fix_red = imdilate(redSeg,SEr);
  %imshow(fix_red);
  %REDS END
  
  %HUE 100 - 225
  %SAT 7 - 15
  %VAL 15 - 20
  %BLACKS START, UZAME TI ŠE CELOTNO OKOLICO KOT DA JE BELA
  SEb = strel('rectangle',[6 6]);
  blackSeg = I(:,:,1)>=0/360 & I(:,:,1)<=235/360 & I(:,:,2)>=0.0 & I(:,:,2)<=0.25 & I(:,:,3)>=0.0 & I(:,:,3)<=0.2;
  fix_black = imdilate(bwareaopen(blackSeg,40),SEb);
  figure(3);
  imshow(fix_black);
  
  
  %BLACKS END
  
  %BLUES FROM BEFORE
  SE =strel('rectangle',[2 3]);
  greenSeg = I(:,:,1)>=200/360 & I(:,:,1)<=240/360 & I(:,:,2)>=0.40 & I(:,:,2)<=0.86 & I(:,:,3)<=0.55;
  fix_green = imdilate(bwareaopen(greenSeg,100),SE);
  figure(2);
  imshow(fix_green);
  %END BLUES
  
  %centroidi za modre, reakcija roke na modre
  img_centroids = regionprops(fix_green,'centroid');
  centroids = cat(1, img_centroids.Centroid)
  hold on;
  plot(centroids(:,1),centroids(:,2), 'rx');
  hold off;
  figure(3)
  pX=centroids(:,1)+15;
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
  manipulator = manipulator_create('roka9.fri1.uni-lj.si');
  manipulator_draw(world, manipulator);
  for i=1:size(pX)
    state = manipulator_solve(manipulator, [pX(i), pY(i), 60]);
    % Transition to the new manipulator state
    manipulator = manipulator_animate(world, manipulator, state, 10);
    state = manipulator_solve(manipulator, [pX(i), pY(i), 28]);
    % Transition to the new manipulator state
    manipulator = manipulator_animate(world, manipulator, state, 10);
    state = manipulator_solve(manipulator, [pX(i), pY(i), 28]);
    manipulator = manipulator_animate(world, manipulator, state, 10);
    
    
    state(7)=0.7;
    manipulator = manipulator_animate(world, manipulator, state, 10);
    state = manipulator_solve(manipulator, [pX(i), pY(i), 170]);
    manipulator = manipulator_animate(world, manipulator, state, 10);
    state = manipulator_solve(manipulator, [pX(i)-80, pY(i), 170]);
    % Transition to the new manipulator state
    manipulator = manipulator_animate(world, manipulator, state, 10);
    
    state = manipulator_solve(manipulator, [pX(i)-80, pY(i), 170]);
    state(7)=0;
    % Transition to the new manipulator state
    manipulator = manipulator_animate(world, manipulator, state, 10);
  endfor
endfunction

function nalogaF()
  camera = camera_create('roka9.fri1.uni-lj.si'); % Create camera handle
  image = camera_image(camera); % Retrieve current image
  figure(6);
  imshow(image);
  H = camera_position(camera); % Retrieve current homoraphy
  %na koncu dodal spet prvotno koordinato ker drugače mi je falila ena črta
  X = [100,100,300,300];
  Y = [-200,200,200,-200];
  figure(1);
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
  %SEr=strel('rectangle',[4 4]);
  %redSeg = I(:,:,1)>=1/360 & I(:,:,1)<=11/360 & I(:,:,2)>=0.65 & I(:,:,2)<=0.95;
  %fix_red = imdilate(redSeg,SEr);
  %imshow(fix_red);
  %REDS END
  
  %HUE 100 - 225
  %SAT 7 - 15
  %VAL 15 - 20
  %BLACKS START, UZAME TI ŠE CELOTNO OKOLICO KOT DA JE BELA
  SEb = strel('rectangle',[6 6]);
  blackSeg = I(:,:,1)>=0/360 & I(:,:,1)<=235/360 & I(:,:,2)>=0.0 & I(:,:,2)<=0.25 & I(:,:,3)>=0.0 & I(:,:,3)<=0.2;
  fix_black = imdilate(bwareaopen(blackSeg,40),SEb);
  figure(3);
  imshow(fix_black);
  
  
  %BLACKS END
  
  %BLUES FROM BEFORE
  SE =strel('rectangle',[2 3]);
  greenSeg = I(:,:,1)>=200/360 & I(:,:,1)<=240/360 & I(:,:,2)>=0.40 & I(:,:,2)<=0.86 & I(:,:,3)<=0.55;
  fix_green = imdilate(bwareaopen(greenSeg,100),SE);
  figure(2);
  imshow(fix_green);
  %END BLUES
  
  %centroidi za modre, reakcija roke na modre
  img_centroids = regionprops(fix_green,'centroid');
  centroids = cat(1, img_centroids.Centroid)
  hold on;
  plot(centroids(:,1),centroids(:,2), 'rx');
  hold off;
  figure(3)
  pX=centroids(:,1)+15;
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
  manipulator = manipulator_create('roka9.fri1.uni-lj.si');
  manipulator_draw(world, manipulator);
  
  for i=1:size(pX)
    if(pX(i)>=300)
      state = manipulator_solve(manipulator, [pX(i), pY(i), 60]);
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state = manipulator_solve(manipulator, [pX(i), pY(i), 28]);
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state(7)=0.7;
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state = manipulator_solve(manipulator, [pX(i), pY(i), 170]);
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state = manipulator_solve(manipulator, [pX(i), pY(i), 170]);
      state(1)=-state(1);
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state = manipulator_solve(manipulator, [pX(i), pY(i), 60]);
      state(1)=-state(1);
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state = manipulator_solve(manipulator, [pX(i), pY(i), 40]);
      state(1)=-state(1);
      state(7)=0;
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state = manipulator_solve(manipulator, [pX(i), pY(i), 170]);
      state(1)=-state(1);
      manipulator = manipulator_animate(world, manipulator, state, 10);
    
      state = manipulator_solve(manipulator, [pX(i), pY(i), 170]);
      manipulator = manipulator_animate(world, manipulator, state, 10);
    endif
    
    if(pX(i)<=300)
      state = manipulator_solve(manipulator, [pX(i), pY(i), 60]);
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state = manipulator_solve(manipulator, [pX(i), pY(i), 28]);
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state(7)=0.7;
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state = manipulator_solve(manipulator, [pX(i), pY(i), 170]);
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state = manipulator_solve(manipulator, [pX(i), pY(i), 170]);
      state(1)=-state(1);
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state = manipulator_solve(manipulator, [pX(i), pY(i), 60]);
      state(1)=-state(1);
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state = manipulator_solve(manipulator, [pX(i), pY(i), 40]);
      state(1)=-state(1);
      state(7)=0;
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state = manipulator_solve(manipulator, [pX(i), pY(i), 170]);
      state(1)=-state(1);
      manipulator = manipulator_animate(world, manipulator, state, 10);
    
      state = manipulator_solve(manipulator, [pX(i), pY(i), 170]);
      manipulator = manipulator_animate(world, manipulator, state, 10);
    endif
    endfor

endfunction

function skarice()
  camera = camera_create('roka9.fri1.uni-lj.si'); % Create camera handle
  image = camera_image(camera); % Retrieve current image
  figure(6);
  imshow(image);
  H = camera_position(camera); % Retrieve current homoraphy
  %na koncu dodal spet prvotno koordinato ker drugače mi je falila ena črta
  X = [100,100,300,300];
  Y = [-200,200,200,-200];
  figure(1);
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
  imshow(I);
  SE =strel('rectangle',[7 4]);
  greenSeg = I(:,:,1)>=200/360 & I(:,:,1)<=320/360 & I(:,:,2)>=0.40 & I(:,:,2)<=0.86 & I(:,:,3)<=0.55;
  fix_green = imdilate(bwareaopen(greenSeg,100),SE);
  figure(2);
  imshow(fix_green);
  img_centroids = regionprops(fix_green,'centroid');
  centroids = cat(1, img_centroids.Centroid)
  hold on;
  plot(centroids(:,1),centroids(:,2), 'rx');
  hold off;
  figure(3)
  pX=centroids(:,1)+15;
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
  world = world_setup(1, 200);
  manipulator = manipulator_create('roka9.fri1.uni-lj.si');
  manipulator_draw(world, manipulator);
  
  state = manipulator_solve(manipulator, [pX(i), pY(i), 120]);
  state(6) = 0;
  manipulator = manipulator_animate(world, manipulator, state, 10);
  
  state = manipulator_solve(manipulator, [pX(i), pY(i), 80]);
  state(6) = 0;
  manipulator = manipulator_animate(world, manipulator, state, 10);
  
  state = manipulator_solve(manipulator, [pX(i)-10, pY(i), 50]);
  state(6) = 0;
  manipulator = manipulator_animate(world, manipulator, state, 10);
  
  state = manipulator_solve(manipulator, [pX(i)-10, pY(i), 45]);
  state(6) = 0;
  manipulator = manipulator_animate(world, manipulator, state, 10);
  
  state = manipulator_solve(manipulator, [pX(i)-10, pY(i), 45]);
  state(6) = 0;
  state(7)=0.8;
  manipulator = manipulator_animate(world, manipulator, state, 10);
  
  state = manipulator_solve(manipulator, [pX(i), pY(i), 150]);
  state(6) = 0;
  state(7)=0.8;
  manipulator = manipulator_animate(world, manipulator, state, 10);
  
  state = manipulator_solve(manipulator, [pX(i)+50, pY(i), 150]);
  state(6) = 0;
  state(7)=0.8;
  manipulator = manipulator_animate(world, manipulator, state, 10);
  
  state = manipulator_solve(manipulator, [pX(i)-50, pY(i), 150]);
  state(6) = 0;
  state(7)=0.8;
  manipulator = manipulator_animate(world, manipulator, state, 10);
  
  
  
endfunction

function kozarc()
    camera = camera_create('roka9.fri1.uni-lj.si'); % Create camera handle
  image = camera_image(camera); % Retrieve current image
  figure(6);
  imshow(image);
  H = camera_position(camera); % Retrieve current homoraphy
  %na koncu dodal spet prvotno koordinato ker drugače mi je falila ena črta
  X = [100,100,300,300];
  Y = [-200,200,200,-200];
  figure(1);
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
  imshow(I);
  SEb = strel('diamond',3);
  blackSeg = I(:,:,1)>=0/360 & I(:,:,1)<=235/360 & I(:,:,2)>=0.0 & I(:,:,2)<=0.25 & I(:,:,3)>=0.0 & I(:,:,3)<=0.2;
  fix_black = imdilate(bwareaopen(blackSeg,40),SEb);
  figure(5);
  imshow(fix_black);

  
  img_centroids = regionprops(fix_black,'centroid');
  img_centroids(1)=[];
  centroids = cat(1, img_centroids.Centroid);
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
  
  
  world = world_setup(1, 200);
  manipulator = manipulator_create('roka9.fri1.uni-lj.si');
  manipulator_draw(world, manipulator);
  
  state = manipulator_solve(manipulator, [pX(1), pY(1), 120]);
  state(6) = 0;
  manipulator = manipulator_animate(world, manipulator, state, 10);
  
  state = manipulator_solve(manipulator, [pX(1), pY(1), 80]);
  state(6) = 0;
  manipulator = manipulator_animate(world, manipulator, state, 10);
  
  state = manipulator_solve(manipulator, [pX(1)+30, pY(1), 50]);
  state(6) = 0;
  manipulator = manipulator_animate(world, manipulator, state, 10);
  
  
  

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