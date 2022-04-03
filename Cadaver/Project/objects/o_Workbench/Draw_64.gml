if(open)
{
	#macro work_width 325
	#macro work_height 200
	
	var work_window_x = display_get_gui_width() / 2 + inv_width / 2 + pad
	var work_window_y = display_get_gui_height() - inv_height - craft_height - pad
	
	ui_draw_window("WORKBENCH", work_window_x, work_window_y, work_width, work_height)
	
	work_panel = make_panel(work_window_x + pad, work_window_y + pad)
	
	var slot_scale = inv_data.slot_space
	
	for(var i = 0; i < inv_data.slots_y; i++)
	{
		for(var j = 0; j < inv_data.slots_x; j++)
		{
			draw_sprite(s_Slot, 0, work_panel.at_x + (j * slot_scale), work_panel.at_y)
		}
	}
}