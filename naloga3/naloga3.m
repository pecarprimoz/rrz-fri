#naloga3
function naloga3()
  %nalogaB()
  %nalogaD()
  %nalogaC();
  nalogaF()
  %nalogaNarisiA();
endfunction

function nalogaB()
  % A demonstration program for the sample robot manipulator environment


  % Setup world: world structure defines the bounds of the world and
  % points in the world used for navigation
  world = world_setup(1, 200);

  % We will use two points in this sample.
  world.points = [100, 100, 100; 100, -100, 100; 100, -100, 300; 100,100,300]';

  manipulator = manipulator_create('roka9.local');

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

  manipulator = manipulator_create('roka9.local'); 

  manipulator_draw(world, manipulator);
  state1=[0.20000   0.64000  -1.07000  -0.93000   0.00000 -0.01000   0.01000];
  state12=[0.21000   0.84000  -1.40000  -0.97000   0.00000 -0.00000   0.01000];
  state2=[0.15000   1.12000  -1.77000  -0.93000   0.00000 -0.00000   0.01000]; 
  state3=[-0.03000   1.35000  -2.13000  -0.90000   0.00000 -0.01000   0.02000];
  state4=[-0.28000   0.96000  -1.52000  -0.84000   0.00000 -0.02000   0.02000];
  
  state5=[-0.34000   0.70000  -1.05000  -0.84000   0.00000 -0.02000   0.02000];
  state6=[-0.34000   0.44000  -0.71000  -0.97000   0.00000 -0.01000   0.01000];
  state7=[-0.33000   1.00000  -1.53000  -0.75000   0.00000 0.00000   0.01000];
  state8=[0.23000   1.05000  -1.57000  -0.74000   0.00000 -0.01000   0.00000];
      manipulator = manipulator_animate(world, manipulator, state1, 10);
      %waitforbuttonpress; 
      manipulator = manipulator_animate(world, manipulator, state12, 10);
      manipulator = manipulator_animate(world, manipulator, state2, 10);
      manipulator = manipulator_animate(world, manipulator, state3, 10);
      manipulator = manipulator_animate(world, manipulator, state4, 10);
      manipulator = manipulator_animate(world, manipulator, state5, 10);
      manipulator = manipulator_animate(world, manipulator, state6, 10);
      manipulator = manipulator_animate(world, manipulator, state7, 10);
      manipulator = manipulator_animate(world, manipulator, state8, 10);


endfunction


function nalogaD()
  % A demonstration program for the sample robot manipulator environment


  % Setup world: world structure defines the bounds of the world and
  % points in the world used for navigation
  world = world_setup(1, 200);

  % We will use two points in this sample.
  world.points = [250, 50, 70; 190, 25, 70 ; 140, 0, 70; 250, -50, 70; 250, -50, 80; 190,-25, 70; 190, 25 ,70]';

  manipulator = manipulator_create('roka9.local'); 

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
    manipulator = manipulator_create('192.168.1.118');
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