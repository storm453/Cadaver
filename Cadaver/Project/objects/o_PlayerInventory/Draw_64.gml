//mouse variables
var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

//set drawing of inventory
inv_data.ix = display_get_gui_width() / 2 - (inv_data.slots_x  * inv_data.draw_scale * 16) / 2
inv_data.iy = display_get_gui_height() - player_inventory_height

var show_inventory = false

//loop gui 
for(var i = 0; i < ds_list_size(o_PlayerUI.inv_present_list); i++)
{
	if(global.current_gui = o_PlayerUI.inv_present_list[|i])
	{
		show_inventory = true
	}
}	

//hotbar drawing when inventory is closed
for(var i = 0; i < inv_data.slots_x; i++)
{
	if(global.current_gui == gui.NONE)
	{
		var key = i + 1
		
		if(i == inv_data.slots_x - 1) key = 0
		
		if(keyboard_check_pressed(ord(key))) global.hotbar_sel = i

		global.hotbar_sel_item = inv[global.hotbar_sel, inv_data.slots_y - 1]
	
		var position_y = inv_data.iy + shift + ((inv_data.slots_y - 1) * inv_data.slot_size * inv_data.draw_scale)	
		var selected = false
		
		if(global.hotbar_sel == i) selected = 2
		
		draw_sprite_ext(s_Slot, selected, inv_data.ix + (i * inv_data.slot_size * inv_data.draw_scale), position_y, inv_data.draw_scale, inv_data.draw_scale, 0, c_white, 1)
	}
}

//TAB above main slots that says INVENTORY
if(show_inventory)
{
	ui_draw_rectangle(inv_data.ix, inv_data.iy - title_height, 480, title_height, tab_color, 1, false)
	ui_draw_string(inv_data.ix + pad, inv_data.iy - title_height + pad, title, ft_Title)
}

//for drawing: loop through inventory : not hotbar
for(var i = 0; i < inv_data.slots_x; i++)
{
	for(var j = 0; j < inv_data.slots_y; j++)
	{	
		var index = inv[i, j]

		var position_y = inv_data.iy + shift + (j * inv_data.slot_size * inv_data.draw_scale)
		var hotbar = true
		var selected = 0
		
		//anmy slots other than hotbar
		if(j != inv_data.slots_y - 1)
		{
			position_y = inv_data.iy + (j * inv_data.slot_size * inv_data.draw_scale)
			hotbar = false
		}
		
		//select slot
		if(point_in_rectangle(mx, my, inv_data.ix + (i * inv_data.slot_size * inv_data.draw_scale), position_y, inv_data.ix + (i * inv_data.slot_size * inv_data.draw_scale) + inv_data.slot_size * inv_data.draw_scale, position_y + inv_data.slot_size * inv_data.draw_scale))
		{
			if(global.current_gui != 0)
			{
				selected = 1
			}
		}

		//dont draw hotbar
		if(j != inv_data.slots_y)
		{
			if(show_inventory)
			{	
				//draw border if right clicked select on slot
				if(global.info_sel_slot[0] != 0)
				{
					if(global.info_sel_slot[1] != 0)
					{
						draw_sprite_ext(s_Slot, 3, inv_data.ix + (global.info_sel_slot[0] * inv_data.slot_size * inv_data.draw_scale), inv_data.iy + (global.info_sel_slot[1] * inv_data.slot_size * inv_data.draw_scale), inv_data.draw_scale, inv_data.draw_scale, 0, c_white, 1)
					}
				}
				
				//actual inventory when open, not hotbar
				draw_sprite_ext(s_Slot, selected, inv_data.ix + (i * inv_data.slot_size * inv_data.draw_scale), position_y, inv_data.draw_scale, inv_data.draw_scale, 0, c_white, 1)
			}
		}
		
		if(index != 0)
		{
			var amount_draw = index.amt

			if(index.amt < 2)
			{
				amount_draw = ""
			}
		
			var hotbar_draw = false

			if(show_inventory)
			{
				if(!hotbar)
				{
					hotbar_draw = true
				}
			}
			
			if(hotbar)
			{
				hotbar_draw = true
			}
			
			if(hotbar_draw)
			{
				draw_sprite_ext(s_Items, global.items_list[index.item].spr_index, inv_data.ix + (i * inv_data.slot_size * inv_data.draw_scale), position_y, inv_data.draw_scale, inv_data.draw_scale, 0, c_white, 1);
				draw_set_color(c_black)
				draw_set_color(text_color)
				ui_draw_string(inv_data.ix + (i * inv_data.slot_size * inv_data.draw_scale) + 3, position_y + 1, amount_draw, ft_Default)
				draw_set_color(text_color)
				draw_text(inv_data.ix + (i * inv_data.slot_size * inv_data.draw_scale) + 3, position_y + 1, amount_draw)
			}
		}
	}
}

//draw the sprite you have in your hand
if(global.in_hand != 0)
{
	draw_sprite_ext(s_Items, global.items_list[global.in_hand.item].spr_index, mx - inv_data.slot_size * inv_data.draw_scale  / 2, my - inv_data.slot_size * inv_data.draw_scale / 2, inv_data.draw_scale, inv_data.draw_scale, 0, c_white, 1);
}

//info boxes they're drawn down here so they're above the slots
if(global.current_gui  == gui.INVENTORY)
{
	for(var i = 0; i < inv_data.slots_x; i++)
	{
		for(var j = 0; j < inv_data.slots_y; j++)
		{	
				var index = inv[i, j]
		
				if(point_in_rectangle(mx, my, inv_data.ix + (i * inv_data.slot_size * inv_data.draw_scale), inv_data.iy + (j * inv_data.slot_size * inv_data.draw_scale), inv_data.ix + (i * inv_data.slot_size * inv_data.draw_scale) + 16 * inv_data.draw_scale, inv_data.iy + (j * inv_data.slot_size * inv_data.draw_scale) + 16 * inv_data.draw_scale))
				{
						if(inv[i, j] != 0)
						{
							//info box drawing
							draw_set_color(c_dkgray)
							draw_rectangle(mx, my, mx + 5 + string_width(global.items_list[index.item].name) + 5, my + 5 + string_height(global.items_list[index.item].name) + 5, false);
							draw_set_color(c_white)
							draw_text(mx + 5, my + 5, global.items_list[index.item].name);
						}
				}
		}	
	}
}

//shift clicking
for(var i = 0; i < inv_data.slots_x; i++)
{
	for(var j = 0; j < inv_data.slots_y; j++)
	{	
        if(point_in_rectangle(mx, my, inv_data.ix + (i * inv_data.slot_size * inv_data.draw_scale), inv_data.iy + (j * inv_data.slot_size * inv_data.draw_scale), inv_data.ix + (i * inv_data.slot_size * inv_data.draw_scale) + inv_data.slot_size * inv_data.draw_scale, inv_data.iy + (j * inv_data.slot_size * inv_data.draw_scale) + inv_data.slot_size * inv_data.draw_scale))
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
						for(var e = 0; e < inv_data.slots_x; e++)
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