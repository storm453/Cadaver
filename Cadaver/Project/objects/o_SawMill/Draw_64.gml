if(global.open_instance == id)
{
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)
	
	//draw ui
    ui_draw_rectangle(dx, dy, dw, dh, main_color, 1, false)

    window_text(dx, dy, "Sawing Table")
	
    saw_panel = make_panel(dx, dy)
	
	var total_w = (slot_size * inv_scale) * (saw_data.slots_x) + (((saw_data.slots_x) - 1) * slot_gap) + (slot_gap * 2) + compl_w
	var total_h = (slot_size * inv_scale)
	
	var offset_x = dw / 2 - total_w / 2
	var offset_y = dh / 2 - total_h / 2
	
	//first slot
	var sx = saw_panel.at_x + offset_x
	var sy = saw_panel.at_y + offset_y
	
	var color = c_gray
	
	if(point_in_rectangle(mx, my, sx, sy, sx + slot_size * inv_scale, sy + slot_size * inv_scale))
	{
		color = c_ltgray
	}
	
	ui_draw_rectangle(sx, sy, slot_size * inv_scale, slot_size * inv_scale, color, 1, false)
	window_text(sx, sy, "Log", ft_Description)
	
	inv_move_new(sx, sy, saw, saw_data, slot_gap)
	draw_item(saw, 0, 0, sx, sy, 1)
	//
	
	pn_col(saw_panel, slot_size * inv_scale + slot_gap)
	
	var compl_offset = slot_size * inv_scale / 2 - 10 / 2
	
	var compl_per = (compl_w) * (cut / 180)
	
	ui_draw_rectangle(saw_panel.at_x + offset_x, saw_panel.at_y + offset_y + compl_offset, compl_w, 10, tab_color, 1, false)
	ui_draw_rectangle(saw_panel.at_x + offset_x, saw_panel.at_y + offset_y + compl_offset, compl_per, 10, c_green, 1, false)
	
	pn_col(saw_panel, compl_w + slot_gap)
	
	//second slot
	var sx = saw_panel.at_x + offset_x
	var sy = saw_panel.at_y + offset_y
	
	var color = c_gray
	
	if(point_in_rectangle(mx, my, sx, sy, sx + slot_size * inv_scale, sy + slot_size * inv_scale))
	{
		color = c_ltgray
	}
	
	ui_draw_rectangle(sx, sy, slot_size * inv_scale, slot_size * inv_scale, color, 1, false)
	window_text(sx, sy, "Output", ft_Description)
	
	inv_move_new(sx, sy, saw, saw_data, slot_gap, 1)
	draw_item(saw, 0, 0, sx, sy, 1, 1)
	//
}