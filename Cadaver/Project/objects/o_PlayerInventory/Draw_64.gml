var shift = draw_scale * slot_size / 4

player_inventory_height_slots_only = ((slots_y - 0.9) * slot_size * draw_scale) - 1
player_inventory_height = (slots_y * slot_size * draw_scale) + shift

draw_set_color(c_red);

var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

for(var i = 0; i < slots_x; i++)
{
	for(var j = 0; j < slots_y; j++)
	{	
		var index = inv[i, j]

		if(j != slots_y - 1)
		{
			start_x = display_get_gui_width() / 2 - (slots_x  * draw_scale * slot_size) / 2
			start_y = display_get_gui_height() - (draw_scale * slot_size * slots_y) - shift
			
			if(global.current_gui == gui.INVENTORY)
			{
				if(point_in_rectangle(mx, my, start_x + (i * slot_size * draw_scale), start_y + (j * slot_size * draw_scale), start_x + (i * slot_size * draw_scale) + slot_size * draw_scale, start_y + (j * slot_size * draw_scale) + slot_size * draw_scale))
				{
					draw_sprite_ext(s_Slot, 1, start_x + (i * slot_size * draw_scale), start_y + (j * slot_size * draw_scale), draw_scale, draw_scale, 0, c_white, 1);			
				}
				else
				{
					draw_sprite_ext(s_Slot, 0, start_x + (i * slot_size * draw_scale), start_y + (j * slot_size * draw_scale), draw_scale, draw_scale, 0, c_white, 1);	
				}
			}
		}
		else
		{
			
			
	
			if(point_in_rectangle(mx, my, start_x + (i * slot_size * draw_scale), start_y + shift + (j * slot_size * draw_scale), start_x + (i * slot_size * draw_scale) + slot_size * draw_scale, start_y + shift + (j * slot_size * draw_scale) + slot_size * draw_scale))
			{
				draw_sprite_ext(s_Slot, 1, start_x + (i * slot_size * draw_scale), start_y + shift + (j * slot_size * draw_scale), draw_scale, draw_scale, 0, c_white, 1);			
			}
			else
			{
				draw_sprite_ext(s_Slot, 0, start_x + (i * slot_size * draw_scale), start_y + shift + (j * slot_size * draw_scale), draw_scale, draw_scale, 0, c_white, 1);	
			}
		}
		
		if(index != 0)
		{
			var amount_draw = index[1]

			if(index[1] < 2)
			{
				amount_draw = ""
			}

			if(j != slots_y - 1)
			{
				if(global.current_gui  == gui.INVENTORY)
				{
					//draw_text(start_x + (i * slot_size * draw_scale), start_y + (j * slot_size * draw_scale), inv[i, j].name)
					draw_sprite_ext(s_Items, items_list[index[0]].spr_index, start_x + (i * slot_size * draw_scale), start_y + (j * slot_size * draw_scale), draw_scale, draw_scale, 0, c_white, 1);
					draw_set_color(c_black)
					draw_text(start_x + (i * slot_size * draw_scale) + 10, start_y + (j * slot_size * draw_scale) + 10, amount_draw)
				}
			}
			else
			{
				draw_sprite_ext(s_Items, items_list[index[0]].spr_index, start_x + (i * slot_size * draw_scale), start_y + shift + (j * slot_size * draw_scale), draw_scale, draw_scale, 0, c_white, 1);
				draw_set_color(c_black)
				draw_text(start_x + (i * slot_size * draw_scale) + 10, start_y + shift + (j * slot_size * draw_scale) + 10, amount_draw)
			}
		}
	}
}

//draw the sprite you have in your hand
if(in_hand != 0)
{
	draw_sprite_ext(s_Items, items_list[in_hand[0]].spr_index, mx - slot_size * draw_scale  / 2, my - slot_size * draw_scale / 2, draw_scale, draw_scale, 0, c_white, 1);
}

//info boxes they're drawn down here so they're above the slots
if(global.current_gui  == gui.INVENTORY)
{
	for(var i = 0; i < slots_x; i++)
	{
		for(var j = 0; j < slots_y; j++)
		{	
				var index = inv[i, j]
		
				if(point_in_rectangle(mx, my, start_x + (i * slot_size * draw_scale), start_y + (j * slot_size * draw_scale), start_x + (i * slot_size * draw_scale) + 16 * draw_scale, start_y + (j * slot_size * draw_scale) + 16 * draw_scale))
				{
						if(inv[i, j] != 0)
						{
							//info box drawing
							draw_set_color(c_dkgray)
							draw_rectangle(mx, my, mx + 5 + string_width(items_list[index[0]].name) + 5, my + 5 + string_height(items_list[index[0]].name) + 5, false);
							draw_set_color(c_white)
							draw_text(mx + 5, my + 5, items_list[index[0]].name);
						}
				}
		}	
	}
}
