var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

global.hotbar_sel_item = inv[global.hotbar_sel_slot, array_height(inv) - 1]
		
//draw hotbar
var hot_spr_w = sprite_get_width(s_Hotbar) * inv_scale
var hot_spr_h = sprite_get_height(s_Hotbar) * inv_scale

hot_x = display_get_gui_width() / 2 - hot_spr_w / 2
hot_y = display_get_gui_height() - hot_spr_h

draw_sprite_ext(s_Hotbar, 0, hot_x, hot_y, inv_scale, inv_scale, 0, c_white, 1)

//draw items
for(var i = 0; i < array_length(inv); i++)
{
	var hot_dx = hot_x + slot_from_top + (i * (slot_size + slot_spacing))
	var hot_dy = hot_y + slot_from_top
	
	if(keyboard_check_pressed(ord(string(i + 1)))) global.hotbar_sel_slot = i
	
	if(global.hotbar_sel_slot == i) draw_sprite_ext(s_HotbarSelect, 0, hot_dx, hot_dy, inv_scale, inv_scale, 0, c_white, 1)

	draw_item(inv, i, array_height(inv) - 1, hot_dx, hot_dy)
}

//transparent black over hotbar
if(global.current_gui != gui.NONE)
{
	if(overlay_alpha < 0.7) overlay_alpha += 0.05	
}
else
{
	if(overlay_alpha > 0) overlay_alpha -= 0.05	
}

ui_draw_rectangle(0, 0,display_get_gui_width(), display_get_gui_height(), c_black, overlay_alpha, false)

var inv_spr_w = sprite_get_width(s_Inventory) * inv_scale
var inv_spr_h = sprite_get_height(s_Inventory) * inv_scale

inv_x = display_get_gui_width() / 2 - inv_spr_w / 2
inv_y = display_get_gui_height() / 2 - inv_spr_h / 2 + inv_offset

var ok_gui = false

for(var i = 0; i < ds_list_size(show_list); i++)
{
	if(global.current_gui = show_list[|i]) ok_gui = true
}

if(ok_gui)
{
	window_text(inv_x, inv_y, "Inventory", ft_Large, color_hex(0xe4d2aa))
	
	//draw inventory
	draw_sprite_ext(s_Inventory, 0, inv_x, inv_y, inv_scale, inv_scale, 0, c_white, 1)
	
	//inv logic
	for(var i = 0; i < array_length(inv); i++)
	{
		for(var j = 0; j < array_height(inv); j++)
		{
			var position_y = 2 * inv_scale
			
			if(j < array_height(inv) - 1)
			{
				position_y = 0
			}
			
			var slots_dx = inv_x + slot_from_top + (i * (slot_size + slot_spacing))
			var slots_dy = inv_y + slot_from_top + (j * (slot_size + slot_spacing)) + position_y
			
			draw_item(inv, i, j, slots_dx, slots_dy)
			
			//main inv, no hotbar
			if(point_in_rectangle(mx, my, slots_dx, slots_dy, slots_dx + slot_size, slots_dy + slot_size))
			{
				inv_click_logic(i, j)
				
				draw_sprite_ext(s_GeneralSelected, 0, slots_dx, slots_dy, inv_scale, inv_scale, 0, c_white, 0.2)
				
				//draw item info above
				if(inv[i,j] != 0)
				{
					draw_text(inv_x, inv_y - 200, string(inv[i,j].item))
				}
			}
		}
	}
}