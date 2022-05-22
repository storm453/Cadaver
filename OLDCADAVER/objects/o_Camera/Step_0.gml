var divider = window_get_height()/128;

x_size = window_get_width()/divider;
y_size = window_get_height()/divider;

last_x = x;
last_y = y;

var camera = view_camera[0];


zoom += (target_zoom - zoom);

var shake_offset_x = random_range(-1, 1) * shake;
var shake_offset_y = random_range(-1, 1) * shake;

//camera_set_view_pos(camera, x + shake_offset_x - 100, y + shake_offset_y - 100);
shake *= shake_damp;

var scroll = mouse_wheel_down() - mouse_wheel_up();
target_zoom += scroll / 4;

target_zoom = clamp(target_zoom, min_zoom, max_zoom);

camera_set_view_mat(camera, matrix_build(-x, -y, 10, 0, 0, 0, 1, 1, 1));
camera_set_proj_mat(camera, matrix_build_projection_ortho(x_size * zoom ,y_size * zoom, -100, 100));