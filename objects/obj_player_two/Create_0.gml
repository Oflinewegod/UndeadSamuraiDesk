//variables for speed x and y and max.
x_speed = 0;
y_speed = 0;
move_speedx = 2.75;
move_speedy = -5;
grav = 0.18;

//shuriken variables
throw_cooldown = 0;
global.dir = 1;
released = true;

//sound effects
step_cooldown = 0;

//jump stuff
double_jump = true;

//grapple stuff
grappling = false;

gamepad_set_axis_deadzone(0, 0.8)