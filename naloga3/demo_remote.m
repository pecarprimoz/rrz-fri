% A demonstration program for the sample robot manipulator environment

disp('This is a demo of stohastic IK solver for a remote manipulator.');

% Setup world: world structure defines the bounds of the world and
% points in the world used for navigation
world = world_setup(1, 200);

% We will use two points in this sample.
world.points = [100, 100, 100; 100, -100, 100; 100, -100, 300; 100,100,300]';

manipulator = manipulator_create('roka7.local');

manipulator_draw(world, manipulator);

for i=[1:4]
  state = manipulator_solve(manipulator, world.points(:, i)');
  manipulator = manipulator_animate(world, manipulator, state, 10);
endfor 