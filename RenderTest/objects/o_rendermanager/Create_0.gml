global.entities = ds_list_create()
render_list = ds_list_create()

function render_game()
{
	ds_list_clear(render_list);
	ds_list_copy(render_list, global.entities);
	
	for(var i = 0; i < ds_list_size(render_list); i++)
	{
		var close = i
		
		for (var j = i + 1; j < ds_list_size(render_list); j++) 
		{	
			var check_z = -1 * render_list[|close].bbox_bottom
			var ahead_z = -1 * render_list[|j].bbox_bottom
			
			if(check_z < ahead_z)
			{
				close = j	
			}
		}
		
		var temp = render_list[|close]
		
		//swap de place
		render_list[|close] = render_list[|i]
		render_list[|i] = temp
	}
	
	//loop through entities & draw
	for(var i = 0; i < ds_list_size(render_list); i++)
	{
		//draw here
		//var uid = render_list[|i]
	
		//var spr = object_get_sprite(uid.object_index)
		//var sw = sprite_get_width(spr)
		//var sh = sprite_get_height(spr)
		//var sx = uid.image_xscale
		//var sy = uid.image_yscale
		//var dx = uid.x
		//var dy = uid.y
	
		//draw_sprite_ext(spr, 0, dx, dy, sx, sy, 0, c_white, 1)	

		//run render
		render_list[|i].render()
	}
}	