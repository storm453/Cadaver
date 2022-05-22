//mouse variables
var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

var hot_width = (hot_data.slots_x * slot_size * inv_scale) + ((hot_data.slots_x - 1) * slot_gap)
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
	ui_draw_rectangle(0, 0,display_get_gui_width(), display_get_gui_height(), c_black, 0.5, false)
	
	if(inv_alpha < 1) inv_alpha += 0.1
}
else
{
	if(inv_alpha > 0) inv_alpha -= 0.1	
}

//hotbar
if(open)
{
	draw_inventory(hot, hot_data, inv_x, inv_y, c_gray, 0.75, 1, open = true)
}
else
{
	for(var i = 0; i < hot_data.slots_x; i++)
	{
		var key = i + 1
		
		if(keyboard_check_pressed(ord(key)))
		{
			global.hotbar_sel_slot = i
		}

		for(var j = 0; j < hot_data.slots_y; j++)
		{
			color = c_gray

			if(global.hotbar_sel_slot == i) color = c_aqua

			ui_draw_rectangle(inv_x + (i * (slot_size * inv_scale + slot_gap)), inv_y + (j * (slot_size * inv_scale + slot_gap)), slot_size * inv_scale, slot_size * inv_scale, color, 0.5, false)
		
			if(hot[i,j] != 0)
			{
				var item = hot[i,j]
				var item_offset = ((slot_size * inv_scale) - (16 * inv_scale)) / 2

				draw_sprite_ext(s_Items, item.item, inv_x + (i * (slot_size * inv_scale + slot_gap)) + item_offset, inv_y + (j * (slot_size * inv_scale + slot_gap)) + item_offset, inv_scale, inv_scale, 0, c_white, 1)
			
				var amt_width = string_width(string(item.amt))
				draw_set_alpha(1)
				draw_set_color(c_black)
				ui_draw_string(inv_x + (i * (slot_size * inv_scale + slot_gap)) + amt_width / 4, inv_y + (j * (slot_size * inv_scale + slot_gap)), string(item.amt), ft_Default)
				draw_set_color(c_white)
				ui_draw_string(inv_x + (i * (slot_size * inv_scale + slot_gap)) + amt_width / 4, inv_y + (j * (slot_size * inv_scale + slot_gap)), string(item.amt), ft_Default)
			}
		}
	}
}

global.hotbar_sel_item = hot[global.hotbar_sel_slot, 0]

var inv_width = (inv_data.slots_x * slot_size * inv_scale) + ((inv_data.slots_x - 1) * slot_gap)
var inv_height = (inv_data.slots_y * slot_size * inv_scale) + ((inv_data.slots_y - 1) * slot_gap)

//readjust x and y values for drawing inventory
inv_x = display_get_gui_width() / 2 - inv_width / 2
inv_y = display_get_gui_height() - hot_height - scr_hot_shift - inv_hot_shift - inv_height

//inventory
draw_inventory(inv, inv_data, inv_x, inv_y, c_gray, 0.5, 1, open = true, open = true)

if(open)
{
	var inv_text = "INVENTORY"
	var inv_text_height = string_height_font(inv_text, ft_Default)

	inv_y -= pad + inv_text_height

	draw_set_color(text_color)
	ui_draw_string(inv_x, inv_y, inv_text, ft_Default)
	draw_set_color(c_white)
	draw_set_alpha(1)
}

//if(!open)
//{
//	if(global.in_hand != 0)
//	{
//		array_set(inv[global.last_slot.xx], global.last_slot.yy, global.in_hand)
		
//		global.in_hand = 0	
//	}
//}