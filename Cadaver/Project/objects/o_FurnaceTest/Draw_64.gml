if(!open) exit;
if(global.current_gui != gui.LOOT) exit;

draw_set_color(c_red);

//mouse variables
var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

orig_start_x = display_get_gui_width() / 2 - furnace_width / 2
orig_start_y = display_get_gui_height() - o_PlayerInventory.player_inventory_height - o_PlayerInventory.shift - pad - furnace_height - o_PlayerInventory.title_height

start_x = orig_start_x
start_y = orig_start_y

ui_draw_window("FURNACE", start_x, start_y, furnace_width, furnace_height)

//rectangle
var rect_width = furnace_height - (pad * 2)

ui_draw_rectangle(start_x + pad, start_y + pad, rect_width, rect_width, button_color, 1, false)

var spr_display_width = rect_width / sprite_get_width(s_Furnace)

draw_sprite_ext(s_Furnace, 0, start_x + pad * 2, start_y + pad * 2, spr_display_width, spr_display_width , 0, c_white, 1)

//move so slots draw to right of sprite
start_x = start_x + pad + rect_width + pad
start_y += pad

//for drawing: loop through inventory
for(var i = 0; i < slots_x; i++)
{
	for(var j = 0; j < slots_y; j++)
	{	
		var index = inv[i, j]

		var position_y = start_y + (j * slot_size * draw_scale)
		var selected = 0
		
		slot_px[0] = start_x
		slot_px[1] = start_x
		slot_px[2] = start_x + rect_width
		
		slot_py[0] = orig_start_y + furnace_height / 3 - (slot_size * draw_scale) / 2
		slot_py[1] = orig_start_y + (furnace_height / 3) * 2 - (slot_size * draw_scale) / 2
		slot_py[2] = orig_start_y + furnace_height / 3 - (slot_size * draw_scale) / 2

		//needs to be seperated because slots drawn weird
	    if(point_in_rectangle(mx, my, slot_px[j], slot_py[j],  slot_px[j] + slot_size * draw_scale, slot_py[j] + slot_size * draw_scale))
		{
			selected = 1
			
			si = i
            sj = j
			s_slot = inv[i,j]
			
			if(mouse_check_button_pressed(mb_left))
			{
				if(!keyboard_check(vk_shift))
				{
					if(global.current_gui != 0)
					{
						var old_hand = global.in_hand
			
						global.in_hand = inv[i, j]
				        inv[i, j] = old_hand

						if(global.in_hand != 0)
						{
							if(inv[i,j] != 0)
							{
								if(inv[i,j].item == global.in_hand.item)
								{
									inv[i,j].amt += 	global.in_hand.amt
									global.in_hand = 0 
								}
							}
						}
					}
				}
			}
        } 

		draw_sprite_ext(s_Slot, selected, slot_px[j], slot_py[j], draw_scale, draw_scale, 0, c_white, 1)

		if(index != 0)
		{
			var amount_draw = index.amt

			if(index.amt < 2)
			{
				amount_draw = ""
			}

			draw_sprite_ext(s_Items, items_list[index.item].spr_index, slot_px[j], slot_py[j], draw_scale, draw_scale, 0, c_white, 1);
			draw_set_color(c_black)
			draw_text(slot_px[j], slot_py[j], amount_draw)
		}
	}
}

//draw the sprite you have in your hand
if(global.in_hand != 0)
{
	draw_sprite_ext(s_Items, items_list[global.in_hand.item].spr_index, mx - slot_size * draw_scale  / 2, my - slot_size * draw_scale / 2, draw_scale, draw_scale, 0, c_white, 1);
}

//info boxes they're drawn down here so they're above the slots
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
						draw_rectangle(mx, my, mx + 5 + string_width(items_list[index.item].name) + 5, my + 5 + string_height(items_list[index.item].name) + 5, false);
						draw_set_color(c_white)
						draw_text(mx + 5, my + 5, items_list[index.item].name);
					}
			}
	}	
}