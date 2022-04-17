if(open)
{
	ui_draw_window("Furnace", work_window_x, work_window_y, furn_width, furn_height)

	furn_panel = make_panel(work_window_x + pad, work_window_y + pad)

	text_gap(furn_panel, "Fuel")

	if(fuel_inv[0, 0] != 0)
	{
		var on_button = ui_draw_button_sprite(s_PowerIcon, 0, furn_panel.at_x, furn_panel.at_y, fuel_inv_data.slot_space, fuel_inv_data.slot_space, button_color, button_h_color, text_color, 0.5, false)
		if(on_button[0])
		{
			if(fuel_inv[0,0] != 0)
			{
				if(global.items_list[fuel_inv[0,0].item].item_data.burn_time > 0)
				{
					on = !on
				}
			}
		}
	}
	else
	{
		ui_draw_button_sprite(s_PowerIcon, 0, furn_panel.at_x, furn_panel.at_y, fuel_inv_data.slot_space, fuel_inv_data.slot_space, tab_color, tab_color, text_color, 0.5, false)
	}

	pn_col(furn_panel, fuel_inv_data.slot_space + pad)
	
	//draw fuel slot
	for(var i = 0; i < fuel_inv_data.slots_x; i++)
	{
		for(var j = 0; j < fuel_inv_data.slots_y; j++)
		{
			var mx = device_mouse_x_to_gui(0)
			var my = device_mouse_y_to_gui(0)
			
			var select = 0

			if(point_in_rectangle(mx, my, furn_panel.at_x, furn_panel.at_y, furn_panel.at_x + fuel_inv_data.slot_space, furn_panel.at_y + fuel_inv_data.slot_space))
			{
				select = 1
			}

			//draw slot
			draw_sprite_ext(s_SlotFurnace, select, furn_panel.at_x + (fuel_inv_data.slot_space * i), furn_panel.at_y, fuel_inv_data.draw_scale, fuel_inv_data.draw_scale, 0, c_white, 1)

			//draw item
			if(fuel_inv[i,j] != 0)
			{
				draw_sprite_ext(s_Items, fuel_inv[i,j].item, furn_panel.at_x, furn_panel.at_y, fuel_inv_data.draw_scale, fuel_inv_data.draw_scale, 0, c_white, 1,)	
				
				draw_set_color(text_color)
				ui_draw_string(furn_panel.at_x + 3, furn_panel.at_y + 1, fuel_inv[i,j].amt, ft_Default)
				draw_set_color(text_color)
				draw_text(furn_panel.at_y + 3, furn_panel.at_y + 1, fuel_inv[i,j].amt)
			}

			//draw fire
			if(on) draw_sprite_ext(s_Fire, 0, furn_panel.at_x, furn_panel.at_y, 3, 3, 0, c_white, 1)
		}
	}
	
	if(fuel_inv[0,0] == 0)
	{
		if(global.in_hand != 0)
		{
			if(global.items_list[global.in_hand.item].item_data.burn_time > 0)
			{
				inv_move(fuel_inv, fuel_inv_data, furn_panel.at_x, furn_panel.at_y)
			}
		}
	}
	else
	{
		if(global.in_hand == 0)
		{
			inv_move(fuel_inv, fuel_inv_data, furn_panel.at_x, furn_panel.at_y)
		}
	}
		
	var gap = 20
	
	pn_row(furn_panel, fuel_inv_data.slot_space + pad + gap)
	
	text_gap(furn_panel, "Smelting")

	//smelting slots
	var smelt_scale = smelt_inv_data.slot_space + pad

	for(var i = 0; i < smelt_inv_data.slots_x; i++)
	{
		for(var j = 0; j < smelt_inv_data.slots_y; j++)
		{
			var select = 0

			if(point_in_rectangle(mx, my, furn_panel.at_x + (smelt_scale * i), furn_panel.at_y, furn_panel.at_x + (smelt_scale * i) + smelt_scale, furn_panel.at_y + smelt_scale))
			{
				select = 1
			}

			draw_sprite_ext(s_SlotFurnace, select, furn_panel.at_x + (smelt_scale * i), furn_panel.at_y, smelt_inv_data.draw_scale, smelt_inv_data.draw_scale, 0, c_white, 1)

			//draw item
			if(smelt_inv[i,j] != 0)
			{
				draw_sprite_ext(s_Items, smelt_inv[i,j].item, furn_panel.at_x + (smelt_scale * i), furn_panel.at_y, smelt_inv_data.draw_scale, smelt_inv_data.draw_scale, 0, c_white, 1,)	
				
				draw_set_color(text_color)
				ui_draw_string(furn_panel.at_x + 3 + (smelt_scale * i), furn_panel.at_y + 1, smelt_inv[i,j].amt, ft_Default)
				draw_set_color(text_color)
				draw_text(furn_panel.at_y + 3 + (smelt_scale * i), furn_panel.at_y + 1, smelt_inv[i,j].amt)
			}
		}
		
		if(smelted[i] > 0)
		{
			var smelt_bar = (smelt_inv_data.slot_space - (pad * 2)) * (smelted[i] / 300)
			
			var rect_height = smelt_inv_data.slot_space / 8

			var rect_x = furn_panel.at_x + (smelt_scale * i) + pad
			var rect_y = furn_panel.at_y + smelt_inv_data.slot_space - rect_height - pad

			ui_draw_rectangle(rect_x - 4, rect_y - 2, smelt_bar + 4, rect_height + 4, tab_color, 1, false)
			ui_draw_rectangle(rect_x, rect_y, smelt_bar, rect_height, c_red, 0.9, false)
		}
	}

	inv_move(smelt_inv, smelt_inv_data, furn_panel.at_x, furn_panel.at_y, smelt_scale)
	
	pn_row(furn_panel, smelt_scale + gap)
	
	text_gap(furn_panel, "Inventory")

	var slots = 3
	
	for(var i = 0; i < slots; i++)
	{
		ui_draw_rectangle(furn_panel.at_x, furn_panel.at_y + (35 * i), furn_width - (pad * 2), 30, tab_color, 1, false)
	}
	
	var center = string_height("H") / 2 - 30 / 2
	
	var metal_count = get_item_amount(stored_inv, stored_inv_data, items.metal)
	var glass_count = get_item_amount(stored_inv, stored_inv_data, items.glass)
	var stone_count = get_item_amount(stored_inv, stored_inv_data, items.stone)
	
	draw_set_color(text_color)
	ui_draw_string(furn_panel.at_x + 3, furn_panel.at_y - center, "Metal: " + string(metal_count), ft_Default)

	pn_row(furn_panel, 35)

	ui_draw_string(furn_panel.at_x + 3, furn_panel.at_y - center, "Glass: " + string(glass_count), ft_Default)

	pn_row(furn_panel, 35)

	ui_draw_string(furn_panel.at_x + 3, furn_panel.at_y - center, "Stone: " + string(stone_count), ft_Default)

	pn_row(furn_panel, 35 + gap)
	
	text_gap(furn_panel, "Output")
	
	for(var i = 0; i < crafted_inv_data.slots_x; i++)
	{
		for(var j = 0; j < crafted_inv_data.slots_y; j++)
		{
			var select = 0

			if(point_in_rectangle(mx, my, furn_panel.at_x + (smelt_scale * i), furn_panel.at_y, furn_panel.at_x + (smelt_scale * i) + smelt_scale, furn_panel.at_y + smelt_scale))
			{
				select = 1
			}

			draw_sprite_ext(s_SlotFurnace, select, furn_panel.at_x + (smelt_scale * i), furn_panel.at_y, crafted_inv_data.draw_scale, crafted_inv_data.draw_scale, 0, c_white, 1)

			//draw item
			if(crafted_inv[i,j] != 0)
			{
				draw_sprite_ext(s_Items, crafted_inv[i,j].item, furn_panel.at_x + (smelt_scale * i), furn_panel.at_y, crafted_inv_data.draw_scale, crafted_inv_data.draw_scale, 0, c_white, 1,)	
				
				draw_set_color(text_color)
				ui_draw_string(furn_panel.at_x + 3 + (smelt_scale * i), furn_panel.at_y + 1, crafted_inv[i,j].amt, ft_Default)
				draw_set_color(text_color)
				draw_text(furn_panel.at_y + 3 + (smelt_scale * i), furn_panel.at_y + 1, crafted_inv[i,j].amt)
			}
		}
	}

	inv_move(crafted_inv, crafted_inv_data, furn_panel.at_x, furn_panel.at_y)
}