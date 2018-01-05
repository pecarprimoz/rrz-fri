function naloga1()
  %lahko se igraš z drugim theta parametrom za obrat okoli osi
  %nalogaA1();
  %nalogaA2();
  %nalogaB()
  nalogaC()
endfunction

function [A] = dh_joint(parameters)
% INPUT: DH parameters for joint (a, alpha, d, theta)
% OUTPUT: 4x4 homogeneous transformation matrix
A = zeros(4, 4);
A(1, 1) = cos(parameters(4));
A(2, 1) = sin(parameters(4));
A(1, 2) = -sin(parameters(4)) * cos(parameters(2));
A(2, 2) = cos(parameters(4)) * cos(parameters(2));
A(3, 2) = sin(parameters(2));
A(1, 3) = sin(parameters(4)) * sin(parameters(2));
A(2, 3) = -cos(parameters(4)) * sin(parameters(2));
A(3, 3) = cos(parameters(2));
A(1, 4) = parameters(1) * cos(parameters(4));
A(2, 4) = parameters(1) * sin(parameters(4));
A(3, 4) = parameters(3);
A(4, 4) = 1;
endfunction

function [T00, T01, T12, T23] = stan_mod(theta1,theta2,d3)
  %predpostavimo da imamo enak primer kot na vajah torej bo theta pi/2 za oba sklepa
  T00 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
  T01 = dh_joint([0,  pi/2,  5,  theta1]);
  T12 = T01*dh_joint([0,  pi/2,  5,  theta2]);
  T23 = T12*dh_joint([0, 0, d3,  0]);
  
endfunction

function [T00, T01, T12, T23] = antro_mod(theta1,theta2,theta3)
  
  T00 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
  T01 = dh_joint([0,pi/2,3,theta1]);
  T12 = T01*dh_joint([3,0,0,theta2]);
  T23 = T12*dh_joint([3,0,0,theta3]);
  
endfunction

function nalogaA1()
  [T00, T01, T12, T23] = stan_mod(0,0,2);
  T1 = T00(:,4)
  T2 = T01(:,4) 
  T3 = T12(:,4) 
  T4 = T23(:,4) 
  X = [T1(1),T2(1),T3(1),T4(1)];
  Y = [T1(2),T2(2),T3(2),T4(2)];
  Z = [T1(3),T2(3),T3(3),T4(3)];
  plot3(X,Y,Z, 'color', [0,0,0], 'linewidth', 4);
  hold on;
  scatter3(X,Y,Z, 20, [0.5 0.5 0.5]);
  show_system(T01);
  show_system(T12);
  show_system(T23);

endfunction

function nalogaA2()
  %20,-5,-25
  [T00, T01, T12, T23] = antro_mod(0,0,0);
  T1 = T00(:,4)
  T2 = T01(:,4) 
  T3 = T12(:,4)   
  T4 = T23(:,4) 
  X = [T1(1),T2(1),T3(1),T4(1)];
  Y = [T1(2),T2(2),T3(2),T4(2)];
  Z = [T1(3),T2(3),T3(3),T4(3)];
  plot3(X,Y,Z, 'color', [0,0,0], 'linewidth', 4);
  hold on;
  scatter3(X,Y,Z, 20, [0.5 0.5 0.5]);
  show_system(T01);
  show_system(T12);
  show_system(T23);
endfunction

function nalogaB()
  %3.257
  [T00, T01, T12, T23] = antro_mod(0.2,0.1,0.3)
  T1 = [3,3,4,1];
  T2 = T23 .* [0,0,0,1];
  T2f = T2(:,4)
  fin = sqrt((T2f(1)-T1(1))^2 + (T2f(2)-T1(2))^2 + (T2f(3)-T1(3))^2)
endfunction

function nalogaC()
  T1 = [3,3,4,1];
  I = zeros(360,360);
  for x = 1:360
    for y = 1:360
      [T00, T01, T12, T23] = antro_mod((y*pi)/180,0.1,(x*pi)/180);
      T2 = T23 .* [0,0,0,1];
      T2f = T2(:,4);
      fin = sqrt((T2f(1)-T1(1))^2 + (T2f(2)-T1(2))^2 + (T2f(3)-T1(3))^2);
      I(x,y)=fin;
    endfor
  endfor

  figure(1);
  imagesc(I);
  
  %plot3(X,Y,Z, 'color', [0,0,0], 'linewidth', 4);
  %hold on;
  %scatter3(X,Y,Z, 20, [0.5 0.5 0.5]);
  %scatter3(3,3,4, 10, [0.5 0.5 0.5]);
endfunction
