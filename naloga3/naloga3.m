#naloga3
function naloga3()
  %nalogaB()
  %nalogaD()
  nalogaC();
  %nalogaF()
endfunction

function nalogaB()
  % A demonstration program for the sample robot manipulator environment


  % Setup world: world structure defines the bounds of the world and
  % points in the world used for navigation
  world = world_setup(1, 200);

  % We will use two points in this sample.
  world.points = [100, 100, 100; 100, -100, 100; 100, -100, 300; 100,100,300]';

  manipulator = manipulator_create('10.0.0.106');

  manipulator_draw(world, manipulator);
while(1)
  for i=[1:4]
    state = manipulator_solve(manipulator, world.points(:, i)');
    manipulator = manipulator_animate(world, manipulator, state, 10);
  endfor
endwhile 
endfunction
function nalogaC()
  world = world_setup(1, 200);

  manipulator = manipulator_create('10.0.0.106'); 

  manipulator_draw(world, manipulator);
  state1=[ 0.19405   0.62937  -0.84935  -0.64510   0.00000   -1.57080   0.00000];
  state2=[0.13112   0.87063  -1.08653  -1.21153   0.00000   -1.57080   0.00000];
  state3=[-0.00524   0.98601  -1.29807  -1.55768   0.00000   -1.57080   0.00000];
  state4=[-0.19405   0.63986  -0.76602  -0.76049   0.00000   -1.57080   0.00000];
  state5=[-0.19405   0.63986  -0.76602  -0.76049   0.00000   -1.57080   0.00000];
  state6=[-0.13112   0.80769  -0.97115  -1.33741   0.00000   -1.57080   0.00000];
  state7=[0.13112   0.81293  -0.97756  -1.32692   0.00000   -1.57080   0.00000];
      manipulator = manipulator_animate(world, manipulator, state1, 10);
      manipulator = manipulator_animate(world, manipulator, state2, 10);
      manipulator = manipulator_animate(world, manipulator, state3, 10);
      manipulator = manipulator_animate(world, manipulator, state4, 10);
      manipulator = manipulator_animate(world, manipulator, state5, 10);
      manipulator = manipulator_animate(world, manipulator, state6, 10);
      manipulator = manipulator_animate(world, manipulator, state7, 10);


endfunction


function nalogaD()
  % A demonstration program for the sample robot manipulator environment


  % Setup world: world structure defines the bounds of the world and
  % points in the world used for navigation
  world = world_setup(1, 200);

  % We will use two points in this sample.
  world.points = [250, 50, 70; 190, 25, 70 ; 140, 0, 70; 250, -50, 70; 250, -50, 80; 190,-25, 70; 190, 25 ,70]';

  manipulator = manipulator_create('10.0.0.106'); 

  manipulator_draw(world, manipulator);
  for i=[1:7]
    state = manipulator_solve(manipulator, world.points(:, i)')
    manipulator = manipulator_animate(world, manipulator, state, 10);
  endfor
endfunction

function nalogaF()
    world = world_setup(1, 200);
    snowflake=[150,150,30];
    world.points = [150, 150, 30; 150,150,200]';
    manipulator = manipulator_create('10.0.0.106');
    manipulator_draw(world, manipulator);

    for i=1:5
      %PRVOTNO STANJE, GREMO DO KOCKE
      state = manipulator_solve(manipulator, world.points(:, 1)',1)
      state(7)=1;
      manipulator = manipulator_animate(world, manipulator, state, 10);

      %SE DVIGNEMO PO ZJU
      state = manipulator_solve(manipulator, world.points(:, 2)',2);
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      %SE SAM OBRNEMO ZA -1 PRVEGA SKLEPA
      state = manipulator_solve(manipulator, world.points(:, 2)',3);
      state(1)=-(state(1));
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      %ODLOŽIMO KOCKO 
      state = manipulator_solve(manipulator, snowflake,1);
      state(1)=-(state(1));
      state(7)=0;
      manipulator = manipulator_animate(world, manipulator, state, 10);
      snowflake(3)=snowflake(3)+30;
      
      
      state = manipulator_solve(manipulator, world.points(:, 2)',1);
      state(1)=-(state(1));
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state = manipulator_solve(manipulator, world.points(:, 2)',1);
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
    endfor
  
endfunction