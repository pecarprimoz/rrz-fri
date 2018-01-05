#naloga3
function naloga3()
  %nalogaB()
  nalogaD()
  %nalogaC();
  %nalogaF()
  %nalogaNarisiA();
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

  manipulator = manipulator_create('roka9.fri1.uni-lj.si'); 

  manipulator_draw(world, manipulator);
  state1=[ 0.19405   0.62937  -0.84935  -0.64510   0   0   0.00000];
  state12=[ 0.19405   0.62937  -0.84935  -0.64510   0   0   0.78];
  state2=[0.13112   0.87063  -1.08653  -1.21153   0.00000   0   0.78]; 
  state3=[-0.00524   0.98601  -1.29807  -1.55768   0.00000   0   0.780000];
  state4=[-0.19405   0.63986  -0.76602  -0.76049   0.00000   0   0.780000];
  state5=[-0.19405   0.63986  -0.76602  -0.76049   0.00000   0   0.780000];
  state6=[-0.13112   0.80769  -0.97115  -1.33741   0.00000   0   0.780000];
  state7=[0.13112   0.81293  -0.97756  -1.32692   0.00000   0   0.780000];
  state1=[ 0.19405   0.62937  -0.84935  -0.64510   0   0   0.00000];
      manipulator = manipulator_animate(world, manipulator, state1, 10);
      waitforbuttonpress; 
      manipulator = manipulator_animate(world, manipulator, state12, 10);
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

  manipulator = manipulator_create('roka3.fri1.uni-lj.si'); 

  manipulator_draw(world, manipulator);
  for i=[1:7]
    state = manipulator_solve(manipulator, world.points(:, i)')
    manipulator = manipulator_animate(world, manipulator, state, 10);
  endfor
endfunction

function nalogaF()
    world = world_setup(1, 200);
    snowflake=[145, 140,35];
    world.points = [145, 140, 35; 145, 140, 150]';
    manipulator = manipulator_create('roka9.fri1.uni-lj.si');
    manipulator_draw(world, manipulator);

    for i=1:5
      %PRVOTNO STANJE, GREMO DO KOCKE
      state = manipulator_solve(manipulator, world.points(:, 1)',10)
      manipulator = manipulator_animate(world, manipulator, state, 10);
      waitforbuttonpress;
      state(7)=0.7; 
      manipulator = manipulator_animate(world, manipulator, state, 10);
      %SE DVIGNEMO PO ZJU
      state = manipulator_solve(manipulator, world.points(:, 2)',10);
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      %SE SAM OBRNEMO ZA -1 PRVEGA SKLEPA
      state = manipulator_solve(manipulator, world.points(:, 2)',10);
      state(1)=-(state(1)); 
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      %ODLOŽIMO KOCKO 
      state = manipulator_solve(manipulator, snowflake,1);
      state(1)=-(state(1));
      manipulator = manipulator_animate(world, manipulator, state, 10);
      state(7)=0;
      manipulator = manipulator_animate(world, manipulator, state, 10);
      snowflake(3)=snowflake(3)+21 ;
      
      
      state = manipulator_solve(manipulator, world.points(:, 2)',10);
      state(1)=-(state(1));
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
      state = manipulator_solve(manipulator, world.points(:, 2)',10);
      manipulator = manipulator_animate(world, manipulator, state, 10);
      
    endfor
  
endfunction

function nalogaNarisiA()
  myPos = [
   0.26000   1.40000  -2.43000   0.51000   0.00000   0.01000   0.91000,
   0.24000   1.37000  -2.44000   0.51000   0.00000   0.02000   0.91000,
   0.18000   1.37000  -2.44000   0.52000   0.00000   0.02000   0.91000,
   0.06000   1.37000  -2.44000   0.51000   0.00000   0.03000   0.91000,
   0.01000   1.36000  -2.44000   0.52000   0.00000   0.02000   0.91000,
   0.01000   1.32000  -2.41000   0.53000   0.00000   0.05000   0.91000,
   0.08000   1.29000  -2.38000   0.55000   0.00000   0.03000   0.91000,
   0.11000   1.23000  -2.32000   0.55000   0.00000   0.03000   0.91000,
   0.12000   1.23000  -2.32000   0.54000   0.00000   0.06000   0.91000,
   0.17000   1.13000  -2.20000   0.55000   0.00000   0.05000   0.91000,
   0.16000   1.12000  -2.20000   0.55000   0.00000   0.06000   0.90000,
   ]
  world = world_setup(1, 200);
  manipulator = manipulator_create('roka3.fri1.uni-lj.si');
  manipulator_draw(world, manipulator);
  for i=1:15
    state = manipulator_solve(manipulator, myPos(:, 2)',10)
    manipulator = manipulator_animate(world, manipulator, state, 10);
  endfor


endfunction