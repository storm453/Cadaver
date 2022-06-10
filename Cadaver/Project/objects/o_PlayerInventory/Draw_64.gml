ui_draw_rectangle(0, 0,display_get_gui_width(), display_get_gui_height(), c_black, overlay_alpha, false)
//mouse variables
var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

var hot_width = (inv_data.slots_x * slot_size * inv_scale) + ((inv_data.slots_x - 1) * slot_gap)
var hot_height = slot_size * inv_scale

inv_x = display_get_gui_width() / 2 - hot_width / 2
inv_y = display_get_gui_height() - hot_height - scr_hot_shift

var open = false

for(var i = 0; i < ds_list_size(show_list); i++)
{
	if(global.current_gui == show_list[|i]) open = true
}

if(open)
{
	if(inv_alpha < 1) inv_alpha += 0.1
	if(overlay_alpha < 0.5) overlay_alpha += 0.05
}
else
{
	if(inv_alpha > 0) inv_alpha -= 0.1	
	if(overlay_alpha > 0) overlay_alpha -= 0.05
}

//hotbar
for(var i = 0; i < inv_data.slots_x; i++)
{
	var inv_j = inv_data.slots_y - 1
	var pos_j = 0
	
	if(keyboard_check_pressed(ord(i + 1)))
	{
		global.hotbar_sel_slot = i
	}
	
	var color = c_gray
	
	if(open)
	{
		var rec_x = inv_x + (i * (slot_size * inv_scale + slot_gap))
		var rec_y = inv_y

		if(point_in_rectangle(mx, my, rec_x, rec_y, rec_x + slot_size * inv_scale, rec_y + slot_size * inv_scale))
		{
			color = c_ltgray	
		}
	}
	else
	{
		if(global.hotbar_sel_slot == i) color = c_aqua	
	}
	
	ui_draw_rectangle(inv_x + (i * (slot_size * inv_scale + slot_gap)), inv_y, slot_size * inv_scale, slot_size * inv_scale, color, 0.5, false)
		
	if(inv[i,inv_j] != 0)
	{
		var item = inv[i,inv_j]
		var item_offset = ((slot_size * inv_scale) - (16 * inv_scale)) / 2

		var item_half = (sprite_get_width(s_Items) / 2) * inv_scale

		draw_sprite_ext(s_Items, item.item, inv_x + (i * (slot_size * inv_scale + slot_gap)) + item_offset + item_half, inv_y + item_offset + item_half, inv_scale, inv_scale, 0, c_white, 1)
			
		if(item.amt > 1)
		{
			var amt_width = string_width(string(item.amt))
			draw_set_alpha(1)
			draw_set_color(c_black)
			ui_draw_string(inv_x + (i * (slot_size * inv_scale + slot_gap)) + amt_width / 4, inv_y, string(item.amt), ft_Default)
			draw_set_color(c_white)
			ui_draw_string(inv_x + (i * (slot_size * inv_scale + slot_gap)) + amt_width / 4, inv_y, string(item.amt), ft_Default)
		}
	}
}

global.hotbar_sel_item = inv[global.hotbar_sel_slot, inv_data.slots_y - 1]

var inv_width = (inv_data.slots_x * slot_size * inv_scale) + ((inv_data.slots_x - 1) * slot_gap)
var inv_height = (inv_data.slots_y * slot_size * inv_scale) + ((inv_data.slots_y - 1) * slot_gap)

//remove hotbar
inv_height -= slot_size * inv_scale + slot_gap

//readjust x and y values for drawing inventory
inv_x = display_get_gui_width() / 2 - inv_width / 2
inv_y = display_get_gui_height() - hot_height - scr_hot_shift - inv_hot_shift - inv_height

//inventory
var data_temp = { slots_x: inv_data.slots_x, slots_y: inv_data.slots_y - 1 }
draw_inventory(inv, data_temp, inv_x, inv_y, c_gray, 0.5, 1, 0, open = true)

var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)
	
for(var i = 0; i < inv_data.slots_x; i++)
{
	for(var j = 0; j < inv_data.slots_y; j++)
	{
		var rec_x = inv_x + (i * (slot_size * inv_scale + slot_gap))
		var rec_y = inv_y + (j * (slot_size * inv_scale + slot_gap))
		
		if(j > inv_data.slots_y - 1)
		{
			  rec_y -= inv_hot_shift
		}

		if(open)
		{
			if(point_in_rectangle(mx, my, rec_x, rec_y, rec_x + slot_size * inv_scale, rec_y + slot_size * inv_scale))
			{
				//picking up
				if(mouse_check_button_pressed(mb_left))
				{
					var old_hand = global.in_hand
			
					global.in_hand = inv[i, j]
					array_set(inv[i], j, old_hand)

					if(global.in_hand != 0)
					{
						if(inv[i,j] != 0)
						{
							if(inv[i,j].item == global.in_hand.item)
							{
								inv[i,j].amt += global.in_hand.amt
								global.in_hand = 0 
							}
						}
					}
				}
				
				//splitting 
				if(mouse_check_button_pressed(mb_right))
				{
					if(global.in_hand == 0)
					{
						//hand is empty
						var take_amt = round(inv[i,j].amt / 2)
						var leave_amt = inv[i,j].amt - take_amt
						
						global.in_hand = { item: inv[i,j].item, amt: take_amt }
						
						inv[i,j].amt = leave_amt
					}
				}
			}
		}
	}
}

if(open)
{
	window_text(inv_x, inv_y, "INVENTORY")
}