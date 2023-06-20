if !surface_exists(surf)
{
	var _cw = o_Camera.x_size * 10
	var _ch = o_Camera.y_size * 10
	
	surf = surface_create(_cw, _ch)
	
	surface_set_target(surf)
	
	draw_set_colour(c_blue)
	draw_set_alpha(0)
	draw_rectangle(0, 0, _cw, _cw, false)
	surface_reset_target()
}
else
{
	if (surface_exists(surf)) 
	{
		var _cw = o_Camera.x_size * 10
		var _ch = o_Camera.y_size * 10
		
		surface_resize(surf, _cw, _ch)
		
		var _cx = o_Camera.x - _cw / 2
		var _cy = o_Camera.y - _ch / 2
		
		surface_set_target(surf);
		
		draw_set_color(c_black);
		draw_set_alpha(o_GUI.day_factor);
		draw_rectangle(0, 0, _cw, _ch, 0);
		
		gpu_set_blendmode(bm_subtract);
		
		with (o_Player)
		{	
			//draw_set_alpha(1)
			//draw_set_color(c_white)
			//draw_circle(x - _cx, y - _cy, 100, false)
			draw_sprite_ext(s_light, 0, x - _cx, y - _cy, 1, 0.6, 0, c_white, o_GUI.day_factor - 0.3) 
		}
		
		gpu_set_blendmode(bm_normal);
		draw_set_alpha(1);
		surface_reset_target();
		draw_surface(surf, _cx, _cy);
	}
}