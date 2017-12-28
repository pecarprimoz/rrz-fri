function naloga2()
  nalogaA2();
  %nalogaB();
  %nalogaC(3);
  endfunction


function nalogaA1()
  TSPECIAL = [3,3,4,1];
  [T00, T01, T12, T23] = antro_mod(0.2,0.1,0.3);
  T1 = T00(:,4);
  T2 = T01(:,4);
  T3 = T12(:,4);
  T4 = T23(:,4);
  X = [T1(1),T2(1),T3(1),T4(1)];
  Y = [T1(2),T2(2),T3(2),T4(2)];
  Z = [T1(3),T2(3),T3(3),T4(3)];
  plot3(X,Y,Z, 'color', [0,0,0], 'linewidth', 4);
  hold on;
  scatter3(X,Y,Z, 20, [0.5 0.5 0.5]);
  scatter3(3,3,4, 10, [0.5 0.5 0.5]);
  while(1)
    if(T4(1)>3)
      T4(1)=T4(1)-0.01;
    endif
    
    if(T4(2)<3)
    T4(2)=T4(2)+0.01;
    endif
    
    if(T4(3)>4)
    T4(3)=T4(3)-0.01;
    endif
    
    scatter3(T4(1),T4(2),T4(3), 2, [0.5 0.5 0.5]);
    
    if(T4(1)<=3 && T4(2)>=3 && T4(3)<4)
      break;
    endif    
  endwhile 
endfunction

function nalogaA2()
  T1 = [3,3,4,1];
  cur_best_point=-1;
  cur_best_val=99999;
 
  for i=1:360
    [T00, T01, T12, T23] = antro_mod(0.2,0.1,i*180/pi);
    T2 = T23 .* [0,0,0,1];
    T2f = T2(:,4);
    fin = sqrt((T2f(1)-T1(1))^2 + (T2f(2)-T1(2))^2 + (T2f(3)-T1(3))^2);
    if(fin<cur_best_val)
      cur_best_val=fin;
      cur_best_point=i/360;
    endif

  T1 = T00(:,4);
  T2 = T01(:,4);
  T4 = T23(:,4);
  T3 = T12(:,4);
  X = [T1(1),T2(1),T3(1),T4(1)];
  Y = [T1(2),T2(2),T3(2),T4(2)];
  Z = [T1(3),T2(3),T3(3),T4(3)];
  scatter3(X,Y,Z, 2, [0.5 0.5 0.5]);
  endfor
  cur_best_point
  [T00, T01, T12, T23] = antro_mod(0.2,0.1,cur_best_point);
  T1 = T00(:,4);
  T2 = T01(:,4);
  T4 = T23(:,4);
  T3 = T12(:,4);
  X = [T1(1),T2(1),T3(1),T4(1)];
  Y = [T1(2),T2(2),T3(2),T4(2)];
  Z = [T1(3),T2(3),T3(3),T4(3)];
  plot3(X,Y,Z, 'color', [0,0,0], 'linewidth', 4);
  hold all
  scatter3(X,Y,Z, 20, [0.5 0.5 0.5]);
  scatter3(3,3,4, 10, [0.5 0.5 0.5]);
  
endfunction

function nalogaB()

% Setup world: world structure defines the bounds of the world and
% points in the world used for navigation
world = world_setup(1, 200);

% We will use two points in this sample.
world.points = [90,90.5,1;2,2,4]';

% Setup script for antropomorphic manipulator.
setup_antropomorphic;
%setup_stanford;

% Draw world
manipulator_draw(world, manipulator);

% Solve the IK problem for a checkpoint
% state is a vector of joint states that bring the point of
% the manipulator to the desired position
state = manipulator_solve(manipulator, world.points(:, 1)');
% Transition to the new manipulator state
manipulator = manipulator_animate(world, manipulator, state, 10);

state = manipulator_solve(manipulator, world.points(:, 2)');
% Transition to the new manipulator state
manipulator = manipulator_animate(world, manipulator, state, 10);


endfunction

function towerOfHanoi(n,A,C,B,manipulator,world)
  state = manipulator_solve(manipulator, world.points(:, 4)');
  manipulator = manipulator_animate(world, manipulator, state, 10);
  if (n~=0)
    towerOfHanoi(n-1,A,B,C,manipulator,world);
    fprintf('Move plate %d from tower %d to tower %d\n',[n A C]);
    if(A==1 && C==2)
      %PEG A
      state = manipulator_solve(manipulator, world.points(:, 1)');
      manipulator = manipulator_animate(world, manipulator, state, 10);
      %PEG B
      state = manipulator_solve(manipulator, world.points(:, 2)');
      manipulator = manipulator_animate(world, manipulator, state, 10);
      printf("End of move A -> B");
    endif
    
    if(A==1 && C==3)
      %PEG A
      state = manipulator_solve(manipulator, world.points(:, 1)');
      manipulator = manipulator_animate(world, manipulator, state, 10);
      %PEG C
      state = manipulator_solve(manipulator, world.points(:, 3)');
      manipulator = manipulator_animate(world, manipulator, state, 10);
      printf("End of move A -> C");
    endif
    
    if(A==2 && C==3)
      %PEG B
      state = manipulator_solve(manipulator, world.points(:, 2)');
      manipulator = manipulator_animate(world, manipulator, state, 10);
      %PEG C
      state = manipulator_solve(manipulator, world.points(:, 3)');
      manipulator = manipulator_animate(world, manipulator, state, 10);
      printf("End of move B -> C");
    endif
    
    if(A==2 && C==1)
      %PEG B
      state = manipulator_solve(manipulator, world.points(:, 2)');
      manipulator = manipulator_animate(world, manipulator, state, 10);
      %PEG A
      state = manipulator_solve(manipulator, world.points(:, 1)');
      manipulator = manipulator_animate(world, manipulator, state, 10);
      printf("End of move B -> A");
    endif
    
    if(A==3 && C==1)
      %PEG C
      state = manipulator_solve(manipulator, world.points(:, 3)');
      manipulator = manipulator_animate(world, manipulator, state, 10);
      %PEG A
      state = manipulator_solve(manipulator, world.points(:, 1)');
      manipulator = manipulator_animate(world, manipulator, state, 10);
      printf("End of move C -> A");
    endif
    
    if(A==3 && C==2)
      %PEG C
      state = manipulator_solve(manipulator, world.points(:, 3)');
      manipulator = manipulator_animate(world, manipulator, state, 10);
      %PEG B
      state = manipulator_solve(manipulator, world.points(:, 2)');
      manipulator = manipulator_animate(world, manipulator, state, 10);
      printf("End of move C -> B");
    endif
    
    towerOfHanoi(n-1,B,C,A,manipulator,world);
  endif
endfunction


function nalogaC(disc)

world = world_setup(1, 200);
world.points = [-200,1,1;1,1,1;200,1,1; 1, 100, 1]';
setup_antropomorphic;
manipulator_draw(world, manipulator);
towerOfHanoi(3,1,2,3,manipulator,world);
  
endfunction