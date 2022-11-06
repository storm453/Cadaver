render_game()

var cam_x = o_Camera.x
var cam_y = o_Camera.y

var cam_w = o_Camera.x_size * o_Camera.zoom
var cam_h = o_Camera.y_size * o_Camera.zoom

draw_rectangle(cam_x - cam_w / 2, cam_y - cam_h / 2, cam_x + cam_w / 2, cam_y + cam_h / 2, 1)