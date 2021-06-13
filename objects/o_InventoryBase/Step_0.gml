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
				if(keyboard_check(vk_shift))
				{
					//if slot player is hovering is not empty
					if(inv[i, j] != 0)
					{
						//if item is not in hotbar
						for(var e = 0; e < slots_x; e++)
						{
							if(sj !=  4)
							{
								if(inv[e, 4] = 0)
								{
									//move item to bottom
									inv[e, 4] = inv[i,j]
									inv[i,j] = 0
								}
							}
							else
							{
								if(inv[e, 0] = 0)
								{
									//move item to top
									inv[e, 0] = inv[i,j]
									inv[i,j] = 0	
								}
							}
						}
					}
				}
				else
				{
					var old_hand = in_hand
			
					in_hand = inv[i, j]
		            inv[i, j] = old_hand
				}
			}
        }

       
    }
}