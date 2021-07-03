//amount to shift hotbar down from inventory
var shift = draw_scale * slot_size / 4

//some inventory height variables for drawing ui in o_PlayerUI
player_inventory_height_slots_only = ((slots_y - 0.9) * slot_size * draw_scale) - 1
player_inventory_height = (slots_y * slot_size * draw_scale) + shift

//mouse variables
var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

//set drawing of inventory
start_x = display_get_gui_width() / 2 - (slots_x  * draw_scale * slot_size) / 2
start_y = display_get_gui_height() - (draw_scale * slot_size * slots_y) - shift

//for drawing: loop through inventory
for(var i = 0; i < slots_x; i++)
{
	for(var j = 0; j < slots_y; j++)
	{	
		var index = inv[i, j]

		var position_y = start_y + shift + (j * slot_size * draw_scale)
		var selected = 0
		
		if(j != slots_y - 1)
		{
			position_y = start_y + (j * slot_size * draw_scale)
		}
		
		if(point_in_rectangle(mx, my, start_x + (i * slot_size * draw_scale), position_y, start_x + (i * slot_size * draw_scale) + slot_size * draw_scale, position_y + slot_size * draw_scale))
		{
			selected = 1
		}
		
		if(global.current_gui == gui.INVENTORY)
		{
			draw_sprite_ext(s_Slot, selected, start_x + (i * slot_size * draw_scale), position_y, draw_scale, draw_scale, 0, c_white, 1)
		}
		
		if(global.current_gui != 0)
		{
			draw_sprite_ext(s_Slot, selected, start_x + (i * slot_size * draw_scale), position_y, draw_scale, draw_scale, 0, c_white, 1)
		}
		
		if(index != 0)
		{
			var amount_draw = index[1]

			if(index[1] < 2)
			{
				amount_draw = ""
			}


			if(global.current_gui  == gui.INVENTORY)
			{
				//draw_text(start_x + (i * slot_size * draw_scale), start_y + (j * slot_size * draw_scale), inv[i, j].name)
				draw_sprite_ext(s_Items, items_list[index[0]].spr_index, start_x + (i * slot_size * draw_scale), position_y, draw_scale, draw_scale, 0, c_white, 1);
				draw_set_color(c_black)
				draw_text(start_x + (i * slot_size * draw_scale), position_y, amount_draw)
			}
		}
	}
}

//draw the sprite you have in your hand
if(global.in_hand != 0)
{
	draw_sprite_ext(s_Items, items_list[global.in_hand[0]].spr_index, mx - slot_size * draw_scale  / 2, my - slot_size * draw_scale / 2, draw_scale, draw_scale, 0, c_white, 1);
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

//shift clicking
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
			}
        }    
    }
}