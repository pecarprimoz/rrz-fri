#naloga3
function naloga3()
  %nalogaB()
  %nalogaD()
  nalogaF()
endfunction

function nalogaB()
  % A demonstration program for the sample robot manipulator environment


  % Setup world: world structure defines the bounds of the world and
  % points in the world used for navigation
  world = world_setup(1, 200);

  % We will use two points in this sample.
  world.points = [100, 100, 100; 100, -100, 100; 100, -100, 300; 100,100,300]';

  manipulator = manipulator_create('10.0.0.105');

  manipulator_draw(world, manipulator);
while(1)
  for i=[1:4]
    state = manipulator_solve(manipulator, world.points(:, i)');
    manipulator = manipulator_animate(world, manipulator, state, 10);
  endfor
endwhile 
endfunction

function nalogaD()
  % A demonstration program for the sample robot manipulator environment


  % Setup world: world structure defines the bounds of the world and
  % points in the world used for navigation
  world = world_setup(1, 200);

  % We will use two points in this sample.
  world.points = [250, 50, 70; 190, 25, 70 ; 140, 0, 70; 250, -50, 70; 250, -50, 80; 190,-25, 70; 190, 25 ,70]';

  manipulator = manipulator_create('10.0.0.105'); 

  manipulator_draw(world, manipulator);
  for i=[1:7]
    state = manipulator_solve(manipulator, world.points(:, i)');
    manipulator = manipulator_animate(world, manipulator, state, 10);
  endfor
endfunction

function nalogaF()
  world = world_setup(1, 200);
  manipulator = manipulator_create('10.0.0.105'); 
  world.points = [250, 50, 50]';
  
  state = manipulator_solve(manipulator, world.points(:, 1)');
  manipulator = manipulator_animate(world, manipulator, state, 10);
  
  

endfunction