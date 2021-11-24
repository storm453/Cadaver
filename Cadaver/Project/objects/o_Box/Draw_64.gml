if(!open) exit;
if(global.current_gui != gui.LOOT) exit;

draw_set_color(c_red);

//amount to shift hotbar down from inventory
var shift = draw_scale * slot_size / 4

//mouse variables
var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

//TAB above main slots that says LOOT
title = "LOOT";
font_height = string_height_font(title, ft_Title)
title_height = font_height + pad * 2

ui_draw_rectangle(start_x, start_y + shift - title_height, 480, title_height, tab_color, 1, false)
ui_draw_string(start_x + pad, start_y + shift - title_height + pad, title, ft_Title)

//for drawing: loop through inventory
for(var i = 0; i < slots_x; i++)
{
	for(var j = 0; j < slots_y; j++)
	{	
		var index = inv[i, j]

		var position_y = start_y + shift + (j * slot_size * draw_scale)
		var selected = 0
		
		if(point_in_rectangle(mx, my, start_x + (i * slot_size * draw_scale), start_y + (j * slot_size * draw_scale), start_x + (i * slot_size * draw_scale) + slot_size * draw_scale, start_y + (j * slot_size * draw_scale) + slot_size * draw_scale))
		{
			selected = 1
		}
		
		draw_sprite_ext(s_Slot, selected, start_x + (i * slot_size * draw_scale), position_y, draw_scale, draw_scale, 0, c_white, 1)
		
		if(index != 0)
		{
			var amount_draw = index[1]

			if(index[1] < 2)
			{
				amount_draw = ""
			}

			//draw_text(start_x + (i * slot_size * draw_scale), start_y + (j * slot_size * draw_scale), inv[i, j].name)
			draw_sprite_ext(s_Items, items_list[index[0]].spr_index, start_x + (i * slot_size * draw_scale), position_y, draw_scale, draw_scale, 0, c_white, 1);
			draw_set_color(c_black)
			draw_text(start_x + (i * slot_size * draw_scale), position_y, amount_draw)
		}
	}
}

//draw the sprite you have in your hand
if(global.in_hand != 0)
{
	draw_sprite_ext(s_Items, items_list[global.in_hand[0]].spr_index, mx - slot_size * draw_scale  / 2, my - slot_size * draw_scale / 2, draw_scale, draw_scale, 0, c_white, 1);
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
						draw_rectangle(mx, my, mx + 5 + string_width(items_list[index[0]].name) + 5, my + 5 + string_height(items_list[index[0]].name) + 5, false);
						draw_set_color(c_white)
						draw_text(mx + 5, my + 5, items_list[index[0]].name);
					}
			}
	}	
}