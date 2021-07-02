var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

for(var i = 0; i < slots_x; i++)
{
	for(var j = 0; j < slots_y; j++)
	{	
        if(point_in_rectangle(mx, my, start_x + (i * slot_size * draw_scale), start_y + (j * slot_size * draw_scale), start_x + (i * slot_size * draw_scale) + slot_size * draw_scale, start_y + (j * slot_size * draw_scale) + slot_size * draw_scale))
		{
			si = i
            sj = j
			s_slot = inv[i,j]
			
			if(mouse_check_button_pressed(mb_left))
			{
				if(!keyboard_check(vk_shift))
				{
					var old_hand = global.in_hand
			
					global.in_hand = inv[i, j]
		            inv[i, j] = old_hand
				}
			}
        }  
    }
}