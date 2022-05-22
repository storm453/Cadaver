//@Declare(o_Camera)
//@Global(1)
target      = o_Player;
scroll_speed = 0.1;

x_size = 256;
y_size = 128;

x = target.x;
y = target.y;

last_x = x
last_y = y

zoom       = 2;
target_zoom = 1;
min_zoom = 0.5;
max_zoom = 100;

shake = 0;
shake_damp = 0.9;