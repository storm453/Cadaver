gpu_set_blendmode(bm_add)

if(global.current_gui == gui.BLUEPRINT)
{
	var mx = floor(mouse_x / 16) * 16
	var my = floor(mouse_y / 16) * 16

	draw_sprite_ext(s_Pipe, 0, mx, my, 1, 1, 0, c_aqua, 1)

	if(mouse_check_button_pressed(mb_left))
	{
		var pipe = instance_create_layer(mx, my, "World", o_Pipe)
		
		with(o_PullPipe)
		{
			check_adjacent(id)
		}
		with(o_Pipe)
		{
			event_user(0)
		}	
	}
	if(mouse_check_button_released(mb_left))
	{
		global.current_gui = gui.NONE
	}
	
}

gpu_set_blendmode(bm_normal)