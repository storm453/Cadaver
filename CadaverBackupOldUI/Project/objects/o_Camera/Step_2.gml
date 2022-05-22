var tx = lerp(target.x, mouse_x, 0.2);
var ty = lerp(target.y, mouse_y, 0.2);

if(global.current_gui != gui.NONE)
{
	var tx = target.x
	var ty = target.y
	
	scroll_speed = 0.1
}
else
{
	scroll_speed = 0.2	
}

x += ((tx) - x) * scroll_speed;
y += ((ty) - y) * scroll_speed;