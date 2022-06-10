if(global.open_instance == id)
{
	//draw ui
    ui_draw_rectangle(dx, dy, dw, dh, main_color, 1, false)

    window_text(dx, dy, "FURNACE")

    furn_panel = make_panel(dx, dy)

    var prod_slot = 2
    var reac_slot = 1

    var total_w = (slot_size * inv_scale) * (prod_slot + reac_slot) + (((prod_slot + reac_slot) - 1) * slot_gap) + (pad * 2) + compl_w

    var offset_x = (dw / 2) - (total_w / 2)
    var offset_y = (dh / 2) - ((slot_size * inv_scale - (string_height_font("H", ft_Description))) / 2)

	draw_inventory_custom(furn, 2, 1, furn_panel.at_x + offset_x, furn_panel.at_y + offset_y, c_gray, 0.5, 1, 1)
	
	window_text(furn_panel.at_x + offset_x, furn_panel.at_y + offset_y, "Fuel", ft_Description)
	
	pn_col(furn_panel, slot_size * inv_scale + slot_gap)
	
	window_text(furn_panel.at_x + offset_x, furn_panel.at_y + offset_y, "Ore", ft_Description)
	
    pn_col(furn_panel, slot_size * inv_scale + slot_gap)

    //smelting bar
    var compl_offset = (slot_size * inv_scale) / 2 - (10) / 2
    ui_draw_rectangle(furn_panel.at_x + offset_x, furn_panel.at_y + offset_y + compl_offset, compl_w, 10, tab_color, 1, false)
	
	var percent_bar = compl_w * (burn_time / 120)
	
	ui_draw_rectangle(furn_panel.at_x + offset_x, furn_panel.at_y + offset_y + compl_offset, percent_bar, 10, c_orange, 1, false)
	
	pn_col(furn_panel, (pad * 2) + compl_w)
	
	//final slot
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)

	for(var i = 0; i < 1; i++)
	{
		var inv_i = 2

        var rec_x = furn_panel.at_x + offset_x + (i * (slot_size * inv_scale + slot_gap))
        var rec_y = furn_panel.at_y + offset_y + (slot_size * inv_scale + slot_gap)

        var color = c_gray

        if(point_in_rectangle(mx, my, rec_x, furn_panel.at_y + offset_y, rec_x + slot_size * inv_scale, furn_panel.at_y + offset_y + slot_size * inv_scale))
        {
            color = c_ltgray
        }

        ui_draw_rectangle(furn_panel.at_x + offset_x  + (i * (slot_size * inv_scale + slot_gap)), furn_panel.at_y + offset_y, slot_size * inv_scale, slot_size * inv_scale, color, 0.5, false)

		var _data = { slots_x: 1, slots_y: 1 }

		//moving items to the slot
        inv_move_new(furn_panel.at_x + offset_x, furn_panel.at_y + offset_y, furn, _data, slot_gap, 2)
		
		if(furn[inv_i, 0] != 0)
		{
			draw_item(furn, 0, 0, furn_panel.at_x + offset_x, furn_panel.at_y + offset_y, 1, inv_i)
		}
	}

    window_text(furn_panel.at_x + offset_x, furn_panel.at_y + offset_y, "Output", ft_Description)
}