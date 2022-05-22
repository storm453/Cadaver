if(o_PlayerUI.open_instance == id)
{
	#macro work_width 325
	#macro work_height 200
	
	var work_window_x = display_get_gui_width() / 2 + inv_width / 2 + pad
	var work_window_y = display_get_gui_height() - inv_height - craft_height - pad
	
	ui_draw_window("WORKBENCH", work_window_x, work_window_y, work_width, work_height)
	
	work_panel = make_panel(work_window_x + pad, work_window_y + pad)
	
	ui_draw_string(work_panel.at_x, work_panel.at_y, "Output", ft_Default)
	pn_row(work_panel, string_height_font("Output", ft_Default) + pad)

	var slot_scale = inv_data.slot_space
	
	for(var i = 0; i < inv_data.slots_y; i++)
	{
		for(var j = 0; j < inv_data.slots_x; j++)
		{
			var mx = device_mouse_x_to_gui(0)
			var my = device_mouse_y_to_gui(0)

			var pad_slot = inv_data.slot_space + pad
			var select = 0

			if(point_in_rectangle(mx, my, work_panel.at_x + (pad_slot * j), work_panel.at_y, work_panel.at_x + (pad_slot * j) + pad_slot, work_panel.at_y + pad_slot))
			{
				select = 1
			}

			draw_sprite_ext(s_SlotFurnace, select, work_panel.at_x + (j * pad_slot), work_panel.at_y, inv_data.draw_scale, inv_data.draw_scale, 0, c_white, 1)
			
			if(inv[j,i] != 0)
			{
				draw_sprite_ext(s_Items, inv[j,i].item, work_panel.at_x + (pad_slot * j), work_panel.at_y, inv_data.draw_scale, inv_data.draw_scale, 0, c_white, 1,)	
				
				draw_set_color(text_color)
				ui_draw_string(work_panel.at_x + 3 + (pad_slot * j), work_panel.at_y + 1, inv[j,i].amt, ft_Default)
				draw_set_color(text_color)
				draw_text(work_panel.at_x + 3 + (pad_slot * j), work_panel.at_y + 1, inv[j,i].amt)
			}
		}
	}

	if(global.in_hand == 0) inv_move(inv, inv_data, work_panel.at_x, work_panel.at_y, inv_data.slot_space)
}