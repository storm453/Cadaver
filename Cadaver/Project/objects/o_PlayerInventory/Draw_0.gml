draw_set_alpha(1)
draw_set_color(c_white)

var _corners = 4

var _player_x = o_Player.x
var _player_y = o_Player.y - sprite_get_height(s_Player) / 2

var _angle = point_direction(_player_x, _player_y, mouse_x, mouse_y)

var _open_wheel = keyboard_check(ord("G"))

if(_open_wheel)
{
	if(wheel_scale < 1) wheel_scale += 0.1
}
else
{	
	if(wheel_scale > 0) wheel_scale -= 0.2
}

for(var i = 0; i < _corners; i++)
{
	if(_angle > 0 + (90 * i)) 
	{
		if(_angle < 90 + (90 * i))
		{
			if(_open_wheel) global.selected = i	
		}
	}
	
	var color = c_white
	
	if(global.selected == i)
	{
		color = c_gray	
	}
	
	draw_sprite_ext(s_SelectWheelCorner, 0, _player_x, _player_y, wheel_scale, wheel_scale, 0 + (90 * i), color, 1)
		
	if(inv[i, inv_sy - 1] != 0)
	{
		draw_sprite_ext(s_Items, inv[i, inv_sy - 1].item, _player_x, _player_y, wheel_scale, wheel_scale, 90 + (90 * i), c_white, 1)	
	}
}

global.hotbar_data = inv[global.selected, inv_sy - 1]