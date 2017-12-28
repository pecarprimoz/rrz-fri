function [T00, T01, T12, T23] = antro_mod(theta1,theta2,theta3)
  
  T00 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
  T01 = dh_joint([0,pi/2,3,theta1]);
  T12 = T01*dh_joint([3,0,0,theta2]);
  T23 = T12*dh_joint([3,0,0,theta3]);
  
endfunction