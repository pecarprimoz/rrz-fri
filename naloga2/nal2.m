#naloga2
function nal2()
  pkg load image
  #naloga a PRAVILNA
  #A = rgb2gray(imread('museum.jpg'));
  #imgder(A,2.5);
  #[Imag, Idir] = gradient_magnitude(A,2);
  #figure(1);
  #subplot(1,3,1);
  #imagesc(A); colormap gray;
  #subplot(1,3,2);
  #imagesc(Imag); colormap gray;
  #subplot(1,3,3);
  #imagesc(Idir); colormap gray;

  #naloga b pravilna
  #A = rgb2gray(imread('museum.jpg'));
  #figure(2);
  #x=1
  #for i = 0:5:25
  #  subplot(2,3,x)
  #  bin_im = edges_simple(A,2.5,i+0.1);
  #  imagesc(bin_im); colormap gray;
  #  x++;
  #endfor
  
  #naloga c pravilna
  #nalogaC();
  
  #dodaten haris delujeta oba 
  #dela z rectangle, haris z sigmo 3 ?
  #A = rgb2gray(imread('rectangle.png')*255);
  B = rgb2gray(imread('pier.jpg'));
  #harris_edge_kvadrat(A,1);
  harris_edge_pier(B,3);
  endfunction  
function derfunc=gaussdx(sigma)
  x = -round(3.0*sigma):round(3.0*sigma);
  #TO JE PRAV
  g = -(x./exp(x.^2/(2*sigma^2)))/(sigma^3*sqrt(2*pi));
  #IDK KAKO NORMALIZIRAT A DELA PRAVILNO TKO DA IDK
  [Y,X] = meshgrid(x,x);
  derfunc = g;
endfunction

function [g, x] = gauss(sigma)
x = -round(3.0*sigma):round(3.0*sigma);
[Y,X] = meshgrid(x,x);
g = (1/(sqrt(2*pi*sigma)))*exp(-(X.^2+Y.^2)/(2*sigma^2) );
g = g / sum(g) ; % normalisation
endfunction

function [Ix, Iy] = imgder(I,sigma)
  [G,x1] = gauss(sigma);
  D = gaussdx(sigma);
  Ix = conv2(conv2(I,G','same'),D','same');
  Iy = conv2(conv2(I,G,'same'),D,'same');
  #figure(2);
  #subplot(1,2,1);
  #imshow(Ix); colormap gray;
  #subplot(1,2,2);
  #imshow(Iy); colormap gray;
  
endfunction

function [Imag, Idir] = gradient_magnitude(I, sigma)
  [Ix, Iy]=imgder(I,sigma);
  size(Ix);
  #size(Iy)
  #imshow(Iy); colormap gray;
  Imag = sqrt(Ix.^2 + Iy.^2);
  Idir = atan2(Iy,Ix);
endfunction
  
function Ie = edges_simple(I,sigma,prag)
  [Imag, Idir]=gradient_magnitude(I,sigma);
  Ie=Imag>prag;
endfunction

function nalogaC()
  A = rgb2gray(imread('pier.jpg'));
  figure(3);
  subplot(2,3,1);
  imshow(A);
  subplot(2,3,2);
  imagesc(edge(A,'Sobel')); colormap gray; title('Sobel');
  subplot(2,3,3);
  imagesc(edge(A,'Prewitt')); colormap gray; title('Prewitt');
  subplot(2,3,4);
  imagesc(edge(A,'Roberts')); colormap gray; title('Roberts');
  subplot(2,3,5);
  imagesc(edge(A,'Canny')); colormap gray; title('Canny');
  subplot(2,3,6);
  imagesc(edge(A,'Canny',0.1)); colormap gray; title('Simple, tresh. .1');
endfunction

function A = nonmaxima_suppression(A, n)

    valid = ((ordfilt2(A, (n * 2 + 1) ^ 2, true(n * 2 + 1))) == A);
    A(~valid) = 0;
  
endfunction
function harris_edge_kvadrat(im,sigma)
  g = gauss(sigma);
  [dx,dy] = imgder(im,sigma);
  #Ix = conv2(im,dx,'same');
  #Iy = conv2(im,dy,'same');
  Ix2 = conv2(dx.^2,g,'same');
  Iy2 = conv2(dy.^2,g,'same');
  Ixy = conv2(dx.*dy,g,'same');
  #imshow(corenrs_from_gradient);  
  hrs = (Ix2 .* Iy2 - Ixy .^2) - 0.05* (Ix2 + Iy2).^2;
  #[Igrad, Imag] = gradient_magnitude(hrs,sigma);
  #z 3 narlepsi rezultat
  hrs_fin = nonmaxima_suppression(hrs,1);
  hrs_fin = (hrs_fin == hrs) & (hrs_fin > 1);
  [h_x,h_y] = find(hrs_fin);
  size(h_y)
  figure(6);
  hold on;
  imagesc(im);
  plot(h_y,h_x,'og',15);

  hold off;
 endfunction

function harris_edge_pier(im,sigma)
  g = gauss(sigma);
  [dx,dy] = imgder(im,sigma);
  #Ix = conv2(im,dx,'same');
  #Iy = conv2(im,dy,'same');
  Ix2 = conv2(dx.^2,g,'same');
  Iy2 = conv2(dy.^2,g,'same');
  Ixy = conv2(dx.*dy,g,'same');
  #imshow(corenrs_from_gradient);  
  hrs = (Ix2 .* Iy2 - Ixy .^2) - 0.05* (Ix2 + Iy2).^2;
  #[Igrad, Imag] = gradient_magnitude(hrs,sigma);
  #z 3 narlepsi rezultat
  hrs_fin = nonmaxima_suppression(hrs,1);
  hold on;
  hrs_fin = (hrs_fin == hrs) & (hrs_fin > 7);
  [h_x,h_y] = find(hrs_fin);
  size(h_x)
  size(h_y)
  hold on;
  imshow(im);
    plot(h_y,h_x,'+r',15);
  hold off;
endfunction
