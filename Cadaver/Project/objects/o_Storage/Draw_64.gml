if(open)
{
	var title = "Loot"
	var title_height = string_height_font(title, ft_Title)
	
	var t_y = inv_y - title_height - pad
	
	ui_draw_rectangle(inv_x, t_y, loot_width, pad + title_height, tab_color, 1, false);
	ui_draw_string(inv_x + pad, t_y + pad, title, ft_Title) 

	for(var i = 0; i < inv_data.slots_x; i++)
	{
		for(var j = 0; j < inv_data.slots_y; j++)
		{
			var mx = device_mouse_x_to_gui(0)
			var my = device_mouse_y_to_gui(0)
				
			var select = 0

			if(point_in_rectangle(mx, my, inv_x + (inv_data.slot_space * i), inv_y + (inv_data.slot_space * j), inv_x + (inv_data.slot_space * i) + inv_data.slot_space, inv_y + (inv_data.slot_space * j) + inv_data.slot_space))
			{
				select = 1
			}

			//draw slot
			draw_sprite_ext(s_Slot, select, inv_x + (inv_data.slot_space * i), inv_y + (inv_data.slot_space * j), inv_data.draw_scale, inv_data.draw_scale, 0, c_white, 1)

			//draw item
			if(inv[i,j] != 0)
			{
				draw_sprite_ext(s_Items, inv[i,j].item, inv_x + (inv_data.slot_space * i), inv_y + (inv_data.slot_space * j), inv_data.draw_scale, inv_data.draw_scale, 0, c_white, 1,)	
					
				draw_set_color(text_color)
				ui_draw_string(inv_x + 3 + (inv_data.slot_space * i), inv_y + 1 + (inv_data.slot_space * j), inv[i,j].amt, ft_Default)
				draw_set_color(text_color)
			}
		}
	}

	inv_move(inv, inv_data, inv_x, inv_y, inv_data.slot_space)
}