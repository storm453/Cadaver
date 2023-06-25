//@Declare(o_RenderManager)
//@Global(0)
light_surface = surface_create(1, 1)

#macro aa_factor 1.5

function render_game()
{
	if(!surface_exists(light_surface))
	{	
		light_surface = surface_create(1, 1)
	}
	
	view_wport[0] = display_get_width() * aa_factor
	view_hport[0] = display_get_height() * aa_factor

	if (view_wport[0] != surface_get_width(application_surface)) || (view_hport[0] != surface_get_height(application_surface)) 
	{
   		surface_resize(application_surface, view_wport[0],view_hport[0]);
	}
	
	if (view_wport[0] != surface_get_width(light_surface)) || (view_hport[0] != surface_get_height(light_surface)) 
	{
   		surface_resize(light_surface, view_wport[0],view_hport[0]);
	}
	
	//main pass
	{
		var _cx = o_Camera.x
		var _cy = o_Camera.y
			
		var _cx_dist = (o_Camera.x_size * o_Camera.zoom)
		var _cy_dist = (o_Camera.y_size * o_Camera.zoom)
		
		//terrain
		{
			//gpu_set_zwriteenable(true)
			//gpu_set_ztestenable(true)
			//gpu_set_alphatestenable(true)
	
			for(var i = render_first_terrain; i != noone; i = i.render_next)
			{	
				if(point_in_rectangle(i.x, i.y, _cx - _cx_dist, _cy - _cy_dist, _cx + _cx_dist, _cy + _cy_dist))
				{
					i.render()
				}
			}
		}
		
		//for (var i = 0; i < ds_list_size(render_list); i++) 
		//{
		//	var closest = i;
		
		//	for (var j = i + 1; j < ds_list_size(render_list); j++) 
		//	{
		//		if (render_list[|closest].z < render_list[|j].z) 
		//		{
		//			closest = j;
		//	    }
		//	 }

		//	 var a = render_list[|closest];
		//	 render_list[|closest] = render_list[|i];
		//	 render_list[|i] = a;
		//}

		for(var i = render_first; i != noone; i = i.render_next)
		{
			if(point_in_rectangle(i.x, i.y, _cx - _cx_dist, _cy - _cy_dist, _cx + _cx_dist, _cy + _cy_dist))
			{
				i.render()
			}
		}
	}
	
	//lights
	{
		surface_set_target(light_surface)
		
		matrix_set(matrix_projection, camera_get_proj_mat(view_camera[0]))
		matrix_set(matrix_view, camera_get_view_mat(view_camera[0]))
		
		gpu_set_blendmode(bm_add)
		
		var _sky_color = 255
		
		draw_clear(make_color_rgb(_sky_color, _sky_color, _sky_color))
		
		draw_set_alpha(1)
		
		for(var i = 0; i < ds_list_size(lights); i++)
		{
			var _light = lights[|i]
			
			with(_light)
			{	
				draw_circle_color(x, y, radius, color, c_black, false)
			}
		}
		
		with(o_Player)
		{
			draw_circle_color(x, y, 200, c_white, c_black, false)	
		}
		
		surface_reset_target()
	}
	
	gpu_set_blendmode_ext(bm_dest_color, bm_zero)
	
	var _cache_matrix = matrix_get(matrix_view)
	var _proj_matrix = matrix_get(matrix_projection)
	
	matrix_set(matrix_view, matrix_build_identity())
	matrix_set(matrix_projection, matrix_build_projection_ortho(surface_get_width(application_surface), -surface_get_height(application_surface), -1000, 1000))
	
	draw_surface(light_surface, -surface_get_width(application_surface) / 2, -surface_get_height(application_surface) / 2)
	
	matrix_set(matrix_view, _cache_matrix)
	matrix_set(matrix_projection, _proj_matrix)
	
	gpu_set_blendmode(bm_normal)
}

render_first = noone
render_last = noone
render_first_terrain = noone
render_last_terrain = noone

function add(_entity)
{
	assert(_entity.render_prev == noone)
	assert(_entity.render_next == noone)
	
	if(render_first == noone)
	{
		render_first = _entity
		render_last  = _entity
	}	
	else
	{
		render_last.render_next = _entity
		_entity.render_prev = render_last
		render_last = _entity
	}
}

function remove(_entity)
{
	if(_entity.render_prev != noone)
	{
		_entity.render_prev.render_next = _entity.render_next
	}
	if(_entity.render_next != noone)
	{
		_entity.render_next.render_prev = _entity.render_prev
	}
	
	if(render_first == _entity)
	{
		render_first = _entity.render_next
	}
	if(render_last == _entity)
	{	
		render_last = _entity.render_prev
	}
}

function terrain_add(_entity)
{
	assert(_entity.render_prev == noone)
	assert(_entity.render_next == noone)
	
	if(render_first_terrain == noone)
	{
		render_first_terrain = _entity
		render_last_terrain  = _entity
	}	
	else
	{
		render_last_terrain.render_next = _entity
		_entity.render_prev = render_last_terrain
		render_last_terrain = _entity
	}
}

function terrain_remove(_entity)
{
	if(_entity.render_prev != noone)
	{
		_entity.render_prev.render_next = _entity.render_next
	}
	if(_entity.render_next != noone)
	{
		_entity.render_next.render_prev = _entity.render_prev
	}
	
	if(render_first_terrain == _entity)
	{
		render_first_terrain = _entity.render_next
	}
	if(render_last_terrain == _entity)
	{	
		render_last_terrain = _entity.render_prev
	}
}

lights = ds_list_create()