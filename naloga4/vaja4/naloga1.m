function naloga1()
  nalogaAB()
  %nalogaC()
endfunction

function nalogaAB()
  I = imread('camera1.jpg');
  H = load('camera1.txt');
  n = 10;
  X = linspace(0, 200, n);
  Y = linspace(0, 200, n);
  figure(1); imshow(I); % Draw the image
  hold on;
  for i = 1:n
  vector_h= H * [X(i),Y(i),1]';
  X(i)=vector_h(1)/vector_h(3);
  Y(i) = vector_h(2)/vector_h(3);
    plot([X(i), X(i)], [Y(1)], 'b');
    plot([X(1)], [Y(i), Y(i)], 'b');
  end
  hold off;
endfunction

function nalogaC()
  I = imread('camera1.jpg');
  H = load('camera1.txt');
  Hinv = inv(H);
  figure(1); imshow(I);
  [pX,pY]=ginput(5)
  figure(2)
  hold on;
  for i=1:5
    vector_h = Hinv* [pX(i), pY(i),1]';  
    X(i)=vector_h(1)/vector_h(3);
    Y(i) = vector_h(2)/vector_h(3);
    plot(X(i),Y(i), 'b');
  endfor
  hold off;
endfunction