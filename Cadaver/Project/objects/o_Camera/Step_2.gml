//var tx = lerp(target.x, mouse_x, 0.2);
//var ty = lerp(target.y, mouse_y, 0.2);

var tx = target.x
var ty = target.y

x += ((tx) - x) * scroll_speed;
y += ((ty) - y) * scroll_speed;