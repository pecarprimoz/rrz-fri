#naloga 1
function nal1()
  #a narejen v zvezku
  pkg load image
  #naloga b
  #k = textread('kernel.txt');
  #s = textread('signal.txt');
  #Ig = simple  _convolutionFigured(s,k);
  #odg na vprašanje, uporabljen filter je podoben
  #normaliziran filter za glajenje, sum je 1
  #sum(g)
  
  #naloga c
  #k = textread('kernel.txt');
  #s = textread('signal.txt');
  #nalogaC(s,k);
  
  #naloga d
  #[g1 , x1]=gauss(0.5);
  #[g2 , x2]=gauss(1);
  #[g3 , x3]=gauss(2);
  #[g4 , x4]=gauss(3);
  #[g5 , x5]=gauss(4);
  #figure(3);
  #plot(x1,g1,x2,g2,x3,g3,x4,g4,x5,g5);

  #naloga e narejena v zvezku
  
  #naloga f
  #nalogaF();
  
  #naloga g
  #nalogaG();
  
  #naloga h
  #nalogaH();
  
  #naloga i
  #testing simple median
  #k = textread('kernel.txt');
  #s = textread('signal.txt');
  #Ig = simple_median(s,5);
  
  #naloga j
  #nalogaJ();
  
  #naloga k
  #testing two d median, seems to be working
  #A = rgb2gray(imread('lena.png'));
  #twoD_median(A,3);
  
  #naloga k, dejanska
  #nalogaK();
  
  #naloga l
  #test = gaussdx(0.5);
  #figure;
  #plot([0:1:length(test)-1],test);
  
  #naloga m
  #nalogaM();
  
  #naloga n
  #A = rgb2gray(imread('pier.jpg'));
  #nalogaN(A,3);
endfunction

function Ig = simple_convolution(I, g)
N = (length(g) - 1) / 2;
Ig = zeros(1, length(I));
for i = N+1:length(I)-N
i_left = max([1, i - N]);
i_right = min([length(I), i + N]);
Ig(i) = sum(g .* I(i_left:i_right));
endfor
endfunction

function Ig = simple_convolutionFigured(I, g)
N = (length(g) - 1) / 2;
Ig = zeros(1, length(I));
for i = N+1:length(I)-N
  i_left = max([1, i - N]);
  i_right = min([length(I), i + N]);
  Ig(i) = sum(g .* I(i_left:i_right));
endfor
  figure(1);
  xplot=[0:1:39]
  xplotg=[0:1:12];
  plot(xplot,I,xplot,Ig,xplotg,g);
  #odg na vprašanje, uporabljen filter je podoben
  #normaliziran filter za glajenje, sum je 1
  #sum(g)
endfunction

function nalogaC(I,g) 
  Ig=conv(I,g,'same');
  xplot=[0:1:39]
  xplotg=[0:1:12];
  figure(2);
  plot(xplot,I,xplot,Ig,xplotg,g);
  #odg na vprašanje, zadni argument je regija,
  #ki jo vrne po konvoluciji, moznost je 'same'
  #ki vrne center konvolucije in še 'valid'
  #ki pa vrne konvolucijo brez robnih ničel
endfunction

function [g, x] = gauss(sigma)
x = -round(3.0*sigma):round(3.0*sigma);
[Y,X] = meshgrid(x,x);
g = (1/(sqrt(2*pi)*sigma))*exp(-(x.^2)/(2*sigma^2) );
g = g / sum(g) ; % normalisation
endfunction

function nalogaF()
  s = textread('signal.txt');
  k = transpose([0.1,0.6,0.4]);
  [g1,x1] = gauss(2);
  Ig1=simple_convolution(s,k);
  Ig1Fin=simple_convolution(Ig1,g1);
  Ig2=simple_convolution(s,transpose(g1));
  Ig2Fin=simple_convolution(transpose(Ig2),k);
  multiKernel=simple_convolution(transpose(g1),k);
  Ig3Fin=simple_convolution(s,transpose(multiKernel));
  figure(4);
  subplot(1,4,1);
  plot([0:1:39],s);
  subplot(1,4,2);
  plot([0:1:39],Ig1Fin);
  subplot(1,4,3);
  plot([0:1:39],Ig2Fin);
  subplot(1,4,4);
  plot([0:1:39],Ig3Fin);
endfunction

function nalogaG()
A = rgb2gray(imread('lena.png'));
Icg = imnoise(A,'gaussian', 0, 0.01); % Gaussian noise
figure;
subplot(2,2,1); imshow(Icg); colormap gray;
axis equal; axis tight; title('Gaussian noise');
Ics = imnoise(A,'salt & pepper', 0.1); % Salt & pepper noise
subplot(2,2,2) ; imshow(uint8(Ics)); colormap gray;
axis equal; axis tight; title('Salt and pepper');
[filter_u, x1] = gauss(1);
filter_d = transpose(filter_u);
Icg_b = conv2(Icg,filter_u,'same');
Icg_b = conv2(Icg,filter_d,'same');
Ics_b = conv2(Ics,filter_u,'same');
Ics_b = conv2(Ics,filter_d,'same');
subplot(2,2,3) ; imshow(uint8(Icg_b)); colormap gray;
axis equal; axis tight; title('Filtered') ;
subplot(2,2,4) ; imshow(uint8(Ics_b)); colormap gray;
axis equal; axis tight; title('Filtered');
#bolje odstrani gausovega
endfunction

function nalogaH()
  finm=[0 0 0; 0 2 0; 0 0 0]-(1/9)*[1 1 1; 1 1 1; 1 1 1];
  A = rgb2gray(imread('museum.jpg'));
  figure(5);
  subplot(1,2,1);
  imshow(A);
  filtered_image=imfilter(A,finm);
  #3 iteracije
  for i =(1:2)
    filtered_image=imfilter(filtered_image,finm);
  endfor
  subplot(1,2,2);
  imshow(filtered_image);
endfunction
function Ig = simple_median(I, W)
  #I je naša slika ki jo filtriramo
  #W pa je velikost filtra
  N = ceil((W-1)/2);
  Ig = zeros(1, length(I));
  for i = N+1 : length(I)-N
    #zacetek
    i_left = max([1, i-N]);
    #konec
    i_right = min([length(I), i+N]);
    currentWindow = I(i_left:i_right);
    currentWindowSorted = sort(currentWindow);
    currentWindowMedian = currentWindowSorted(round(W/2));
    Ig(i)=currentWindowMedian;
  endfor
endfunction
function nalogaJ()
  x = [zeros(1, 14), ones(1, 11), zeros(1, 15)]; % Input signal
  xc = x; xc(11) = 5; xc(18) = 5; % Corrupted signal
  figure;
  subplot(1, 4, 1); plot(x); axis([1, 40, 0, 7]); title('Input');
  subplot(1, 4, 2); plot(xc); axis([1, 40, 0, 7]); title('Corrupted');
  g = gauss(1);
  x_g = conv(xc, g, 'same');
  x_m = simple_median(xc, 5);
  subplot(1, 4, 3); plot(x_g); axis([1, 40, 0, 7]); title('Gauss');
  subplot(1, 4, 4); plot(x_m); axis([1, 40, 0, 7]); title('Median');
  #bolje se obnese medianin filter
endfunction
function Ig = twoD_median(I,W)
  im_pad = padarray(I, [floor(W/2) floor(W/2)]);
  im_col = im2col(im_pad, [W W], 'sliding');
  sorted_cols = sort(im_col, 1, 'ascend');
  med_vector = sorted_cols(floor(W*W/2) + 1, :);
  Ig = col2im(med_vector, [W W], size(im_pad), 'sliding');
  #I je naša slika
  #W je velikost w*w filtra
  #POČASNA IMPLEMENTACIJA, IZ SLAJDOV
  #[w, h] = size(I);
  #Ig = zeros(w,h);
  #slidingWindow = zeros(2*W+1);
  #for v = 1:h
  #  for u = 1:w
  #    k = 1;
  #    for j = -1:1
  #      for i = -1:1
  #        slidingWindow(k)=I(u+i,v+j);
  #        k++
  #      endfor
  #    endfor
  #    sortedWindows=sort(slidingWindow);
  #    I(u,v)=sortedWindows(length(sortedWindows)/2);  
  #  endfor  
  #endfor
endfunction


function nalogaK()
  A = rgb2gray(imread('lena.png'));
  Icg = imnoise(A,'gaussian', 0, 0.01); % Gaussian noise
  figure;
  subplot(2,3,1); imshow(Icg); colormap gray;
  axis equal; axis tight; title('Gaussian noise');
  Ics = imnoise(A,'salt & pepper', 0.1); % Salt & pepper noise
  subplot(2,3,4) ; imshow(uint8(Ics)); colormap gray;
  axis equal; axis tight; title('Salt and pepper');
  [filter_u, x1] = gauss(1);
  filter_d = transpose(filter_u);
  Icg_b = conv2(Icg,filter_u,'same');
  Icg_b = conv2(Icg,filter_d,'same');
  Ics_b = conv2(Ics,filter_u,'same');
  Ics_b = conv2(Ics,filter_d,'same');
  subplot(2,3,2) ; imshow(uint8(Icg_b)); colormap gray;
  axis equal; axis tight; title('Filtered') ;
  subplot(2,3,5) ; imshow(uint8(Ics_b)); colormap gray;
  axis equal; axis tight; title('Filtered');
  median_test = twoD_median(Icg,5);  
  subplot(2,3,3) ; imshow(uint8(median_test)); colormap gray;
  axis equal; axis tight; title('Filtered');
  median_test_s = twoD_median(Ics,5);  
  subplot(2,3,6) ; imshow(uint8(median_test_s)); colormap gray;
  axis equal; axis tight; title('Filtered');
endfunction

function derfunc=gaussdx(sigma)
  x = -round(3.0*sigma):round(3.0*sigma)
  #TO JE PRAV
  g = -(x./exp(x.^2/(2*sigma^2)))/(sigma^3*sqrt(2*pi));
  #IDK KAKO NORMALIZIRAT A DELA PRAVILNO TKO DA IDK
  [Y,X] = meshgrid(x,x);
  derfunc = g;
endfunction

function nalogaM()
  I = zeros(25,25); 
  I(13,13)=255;
  sigma = 10.0;
  [G, x1] = gauss(sigma);
  D = gaussdx(sigma);
  figure(1);
  subplot(2,3,1);
  imagesc(I); colormap gray; title('Impulse');
  subplot(2,3,4);
  imagesc(conv2(conv2(I,G,'same'),G','same')); colormap gray; title('G Gt');
  subplot(2,3,2);
  imagesc(conv2(conv2(I,G,'same'),D','same')); colormap gray; title('G Dt');
  subplot(2,3,3);
  imagesc(conv2(conv2(I,D,'same'),G','same')); colormap gray; title('D Gt');
  subplot(2,3,5);
  imagesc(conv2(conv2(I,G','same'),D,'same')); colormap gray; title('Gt D');
  subplot(2,3,6);
  imagesc(conv2(conv2(I,D','same'),G,'same')); colormap gray; title('Gt D'); 
 #plot([0:1:length(G)-1],G,[0:1:length(D)-1],D)
endfunction

function nalogaN(I, sigma)
  [G,x1] = gauss(sigma);
  D = gaussdx(sigma)';
  gradi=conv2(I,G,'same');
  dif=conv2(I,D,'same');
  figure(6);
  subplot(1,3,1);
  imagesc(I); colormap gray;
  subplot(1,3,2);
  imagesc(conv2(conv2(I,G','same'),D','same')); colormap gray;
  subplot(1,3,3);
  imagesc(conv2(conv2(I,G,'same'),D,'same')); colormap gray;

endfunction

function [Ix, Iy] = imgder(I,sigma)
  [G, x1] = gauss(sigma);
  D = gaussdx(sigma)';
  Ix = conv2(conv2(I,G','same'),D','same');
  Iy = conv2(conv2(I,G,'same'),D,'same');
endfunction