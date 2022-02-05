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

//move so slots draw to right of sprite
start_x = start_x + pad
start_y += pad

//draw after third slot
var rect_x = start_x + (pad + slot_scale) * 3
var rect_y = start_y

fuel_rect_height = furnace_height - pad * 2

ui_draw_rectangle(rect_x, rect_y, fuel_rect_width, fuel_rect_height, tab_color, 1, false)
ui_draw_rectangle(rect_x, rect_y, fuel_rect_width, fuel_rect_height * (fuel / fuel_rect_height), c_orange, 1, false)

if(point_in_rectangle(mx, my, rect_x, rect_y, rect_x + fuel_rect_width, rect_y + fuel_rect_height))
{
	ui_draw_string(mx, my, string(fuel) + "/100", ft_Default)
}

fuel_timer++

//for drawing: loop through inventory
for(var i = 0; i < slots_x; i++)
{
	for(var j = 0; j < slots_y; j++)
	{	
		//TESTING @TODO -------- CREATE REMOVE SLOT FUNCTION FOR THIS CODE

		var index = inv[i, j]

		var position_y = orig_start_y + furnace_height / 2 - slot_scale / 2
		var selected = 3

		slot_px[0] = start_x + (pad + slot_scale) * i
		slot_px[1] = start_x + (pad + slot_scale) * i
		slot_px[2] = start_x + (pad + slot_scale) * i
		slot_px[3] = start_x + (pad + slot_scale) * i + fuel_rect_width + pad
		slot_px[4] = start_x + (pad + slot_scale) * (i + 1) + fuel_rect_width
		
		slot_py[0] = position_y
		slot_py[1] = position_y
		slot_py[2] = position_y
		slot_py[3] = position_y
		slot_py[4] = position_y
	
		//needs to be seperated because slots drawn weird
	    if(point_in_rectangle(mx, my, slot_px[i], slot_py[j],  slot_px[i] + slot_size * draw_scale, slot_py[j] + slot_size * draw_scale))
		{
			selected = 4
			
			si = i
            sj = j
			s_slot = inv[i,j]
			
			if(mouse_check_button_pressed(mb_left))
			{
				if(!keyboard_check(vk_shift))
				{	
					//all code for moving or picking up
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

		draw_sprite_ext(s_Slot, selected, slot_px[i], slot_py[j], draw_scale, draw_scale, 0, c_white, 1)

		if(index != 0)
		{
			var amount_draw = index.amt

			if(index.amt < 2)
			{
				amount_draw = ""
			}

			draw_sprite_ext(s_Items, items_list[index.item].spr_index, slot_px[i], slot_py[j], draw_scale, draw_scale, 0, c_white, 1);
			draw_set_color(c_black)
			draw_text(slot_px[i], slot_py[j], amount_draw)
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