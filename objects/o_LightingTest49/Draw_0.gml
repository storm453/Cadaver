if !surface_exists(surf)
{
	var _cw = o_Camera.x_size * 10
	var _ch = o_Camera.y_size * 10
	
	surf = surface_create(_cw, _ch)
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
		
		gpu_set_blendmode(bm_add);
		
		with (o_Player)
		{
			draw_circle_colour(x - _cx, y - _cx, 50, c_white, c_black, false)
		}
		
		gpu_set_blendmode(bm_normal)

		surface_reset_target()

		shader_set(sh_Light);

		var tex = surface_get_texture(surf);
		var handle = shader_get_sampler_index(sh_Light,"lighting");
		texture_set_stage(handle,tex);
		
		draw_set_alpha(1);
		draw_surface(surf, _cx, _cy);
	}
}