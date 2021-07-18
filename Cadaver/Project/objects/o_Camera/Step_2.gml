var tx = lerp(target.x, mouse_x, 0.3);
var ty = lerp(target.y, mouse_y, 0.3);

x += ((tx) - x) * scroll_speed;
y += ((ty) - y) * scroll_speed;