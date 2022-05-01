if !surface_exists(surf)
{
	var _cw = o_Camera.x_size * o_Camera.zoom * 1.1
	var _ch = o_Camera.y_size * o_Camera.zoom * 1.1
	
	surf = surface_create(_cw, _ch)
	
	surface_set_target(surf)
	
	draw_set_colour(c_black)
	draw_set_alpha(0)
	draw_rectangle(0, 0, _cw, _cw, false)
	surface_reset_target()
}
else
{
	if (surface_exists(surf)) 
	{
		var _cw = o_Camera.x_size * o_Camera.zoom * 1.1
		var _ch = o_Camera.y_size * o_Camera.zoom * 1.1
		
		var _cx = o_Camera.x - _cw / 2
		var _cy = o_Camera.y - _ch / 2
		
		surface_set_target(surf);
		
		draw_set_color(c_black);
		draw_set_alpha(0.7 * o_GUI.day_factor);
		draw_rectangle(0, 0, _cw, _ch, 0);
		
		gpu_set_blendmode(bm_subtract);
		
		with (o_Light)
		{	
			draw_sprite_ext(s_light, 0, x - _cx, y - _cy, 1 * range + random(0.01), 0.6 * range + random(0.01), 0, c_white, 1 * o_GUI.day_factor) 
		}
		
		gpu_set_blendmode(bm_normal);
		draw_set_alpha(1);
		surface_reset_target();
		draw_surface(surf, _cx, _cy);
	}
}