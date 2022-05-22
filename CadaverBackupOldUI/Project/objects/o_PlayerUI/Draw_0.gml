gpu_set_blendmode(bm_add)

if(global.current_gui == gui.BLUEPRINT)
{
	if(blueprint_obj != noone)
	{
		//var blueprint_width = sprite_get_width(object_get_sprite(blueprint_obj))
		//var blueprint_height = sprite_get_height(object_get_sprite(blueprint_obj))

		var mx = floor(mouse_x / 16) * 16
		var my = floor(mouse_y / 16) * 16

		draw_sprite_ext(object_get_sprite(blueprint_obj), 0, mx, my, 1, 1, 0, c_aqua, 1)

		if(mouse_check_button_pressed(mb_left))
		{
			var obj = instance_create_layer(mx, my, "World", blueprint_obj)
			
			//with(o_PullPipe)
			//{
				//check_adjacent(id)
			//}
			//with(o_Pipe)
			//{
				//event_user(0)
			//}	
		}
	}
}

gpu_set_blendmode(bm_normal)