var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

if(global.open_instance != id) exit;

window_text(fur_x, fur_y, "Furnace", ft_Large, color_hex(0xb3b9d1))
	
draw_sprite_ext(s_FurnaceInventory, 0, fur_x, fur_y, inv_scale, inv_scale, 0, c_white, 1)
	
//clicking and moving items
for(var i = 0; i < array_length(inv); i++)
{
	for(var j = 0; j < array_height(inv); j++)
	{
		var slots_dx = fur_x + slot_from_top + (i * (slot_size + slot_spacing))
		var slots_dy = fur_y + slot_from_top + (j * (slot_size + slot_spacing))
			
		if(point_in_rectangle(mx, my, slots_dx, slots_dy, slots_dx + slot_size, slots_dy + slot_size))
		{
			inv_click_logic(i, j)
				
			draw_sprite_ext(s_GeneralSelected, 0, slots_dx, slots_dy, inv_scale, inv_scale, 0, c_white, 0.2)
		}
			
		draw_item(inv, i, j, slots_dx, slots_dy)
	}
}

//draw progress bars
for(var i = 0; i < array_length(smelted); i++)
{
	for(var j = 0; j < array_height(smelted); j++)
	{
		if(smelted[i,j] > 0)
		{
			var bar_dx = fur_x + slot_from_top + (i * (slot_size + slot_spacing))
			var bar_dy = fur_y + slot_from_top + (j * (slot_size + slot_spacing))
			
			ui_draw_rectangle(bar_dx, bar_dy + 64, slot_size * (smelted[i,j] / 1200), 8, c_lime, 0.5, false)	
		}
	}
}

//draw fire
for(var i = 0; i < array_length(inv); i++)
{
	var slots_dx = fur_x + slot_from_top + (i * (slot_size + slot_spacing))
	var slots_dy = fur_y + slot_from_top + ((array_height(inv) - 1) * (slot_size + slot_spacing))
	
	var slot = inv[i, array_height(inv) - 1]
	
	if(slot != 0)
	{
		if(global.items_list[slot.item].item_data.burn_time > 0)
		{
			draw_sprite_ext(s_Fire, 0, slots_dx, slots_dy, inv_scale, inv_scale, 0, c_white, 1)
			
			exit;
		}
	}
}
