if(global.current_gui == gui.NONE)
{
	var tx = lerp(target.x, mouse_x, 0.2);
	var ty = lerp(target.y, mouse_y, 0.2);
}
else
{
	var tx = target.x
	var ty = target.y
}

x += ((tx) - x) * scroll_speed * get_delta_time();
y += ((ty) - y) * scroll_speed * get_delta_time();