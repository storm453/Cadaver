//@Declare(o_RenderManager)
//@Global(0)

#macro aa_factor 1.5

function render_game()
{
	view_wport[0] = display_get_width() * aa_factor
	view_hport[0] = display_get_height() * aa_factor

	if (view_wport[0] != surface_get_width(application_surface)) || (view_hport[0] != surface_get_height(application_surface)) 
	{
   		surface_resize(application_surface, view_wport[0],view_hport[0]);
	}

	gpu_set_zwriteenable(true)
	gpu_set_ztestenable(true)
	gpu_set_alphatestenable(true)
	
	for(var i = 0; i < ds_list_size(terrain); i++)
	{	
		terrain[|i].render()
	}
	
	gpu_set_zwriteenable(false)
	gpu_set_ztestenable(false)
	gpu_set_alphatestenable(false)
	
	// sort depths
	ds_list_clear(render_list);
	ds_list_copy(render_list, entities);

	for (var i = 0; i < ds_list_size(render_list); i++) 
	{
		var closest = i;
		
		for (var j = i + 1; j < ds_list_size(render_list); j++) 
		{
			if (render_list[|closest].z < render_list[|j].z) 
			{
				closest = j;
		    }
		 }

		 var a = render_list[|closest];
		 render_list[|closest] = render_list[|i];
		 render_list[|i] = a;
	}

	for(var i = 0; i < ds_list_size(render_list); i++)
	{
		render_list[|i].render()
	}
}

terrain = ds_list_create()
entities = ds_list_create()
render_list = ds_list_create()