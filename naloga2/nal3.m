#a b narejena v zvezku
function nal3()
  #nalogaC pravilno
  #nalogaC();

  #nalogaD pravilno
  #A = edge(rgb2gray(imread('oneline.png')),'Canny');
  #B = edge(uint8(rgb2gray(imread('rectangle.png')*255)),'Canny');
  #nalogaD(A);
  #nalogaD(B);
  
  #nalogaE pravilno
  #nalogaE();
  
  #f in g v zvezku
  
  #nalogaH pravilno
  #nalogaH()
  
endfunction


function nalogaC()
  
  figure(1);
  subplot(2,2,1);
  imagesc(drawHuf(10,10)); title('X=10, Y=10');% Display status of the accumulator
  subplot(2,2,2);
  imagesc(drawHuf(30,60)); title('X=30, Y=60');
  subplot(2,2,3);
  imagesc(drawHuf(50,20)); title('X=50, Y=20');
  subplot(2,2,4);
  imagesc(drawHuf(80,90)); title('X=80, Y=90');
endfunction

function A = drawHuf(X,Y)
  bins_theta = 300; bins_rho = 300; % Resolution of the accumulator array
  max_rho = 100; % Usually the diagonal of the image
  val_theta = (linspace(-90, 90, bins_theta) / 180) * pi; % Values of theta are known
  val_rho = linspace(-max_rho, max_rho, bins_rho);
  A = zeros(bins_rho, bins_theta);
  % for point at (50, 90)
  x = X;
  y = Y;
  rho = x * cos(val_theta) + y * sin(val_theta); % compute rho for all thetas
  bin_rho = round(((rho + max_rho) / (2 * max_rho)) * length(val_rho)); % Compute bins for rho
  for i = 1:bins_theta % Go over all the points
    if bin_rho(i) > 0 && bin_rho(i) <= bins_rho % Mandatory out-of-bounds check
      A(bin_rho(i), i) = A(bin_rho(i), i) + 1; % Increment the accumulator cells
    end;
  end;
endfunction

function nalogaD(A)
  [w,h] = size(A)
  [X,Y]=find(A);
  bins_theta = w; bins_rho = h; % Resolution of the accumulator array
  max_rho = round(sqrt(w^2+h^2)); % Usually the diagonal of the image
  val_theta = (linspace(-90, 90, bins_theta) / 180) * pi; % Values of theta are known
  val_rho = linspace(-max_rho, max_rho, bins_rho);
  A = zeros(bins_rho, bins_theta);
  for j=1:size(X)
    rho = X(j) * cos(val_theta) + Y(j) * sin(val_theta); % compute rho for all thetas
    bin_rho = round(((rho + max_rho) / (2 * max_rho)) * length(val_rho)); % Compute bins for rho
    for i = 1:bins_theta % Go over all the points
      if bin_rho(i) > 0 && bin_rho(i) <= bins_rho % Mandatory out-of-bounds check
        A(bin_rho(i), i) = A(bin_rho(i), i) + 1; % Increment the accumulator cells
      endif
    endfor
  endfor
  figure(3);
  imagesc(A);
endfunction

function nalogaE()
  A = edge(rgb2gray(imread('pier.jpg')),'Canny');
  B = edge(rgb2gray(imread('bricks.jpg')),'Canny');
  [a_rho, a_theta] = hough_find_lines(A,'threshold',100,'count',50);
  hough_draw_lines(A,a_rho,a_theta);  

  [b_rho, b_theta] = hough_find_lines(B,'threshold',100,'count',25);
  hough_draw_lines(B,b_rho,b_theta); 

endfunction

function nalogaH()
  A = edge(rgb2gray(imread('eclipse.jpg')),'Canny');
  B = edge(rgb2gray(imread('coins.jpg')),'Canny');
  [a_x, a_y, a_r] = hough_find_circles(A,47,'count',32);
  hough_draw_circles(A,a_x,a_y,a_r);
  [b_x, b_y, b_r] = hough_find_circles(B,87,'count',5);
  hough_draw_circles(B,b_x,b_y,b_r);
  
endfunction
