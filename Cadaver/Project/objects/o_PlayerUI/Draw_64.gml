var draw_hud = false

for(var i = 0; i < ds_list_size(draw_hud); i++)
{
	if(global.current_gui == draw_hud[|i]) draw_hud = true	
}

if(draw_hud)
{
	//hp bar
	var hp_x = 10;
	var hp_y = 10;

	var bar_draw = 3

	hp_show = lerp(hp_show, o_Player.hp, 0.2);

	var hp_w = (hp_show / 100) * sprite_get_width(s_HealthBar);
	var hp_h = sprite_get_width(s_HealthBar)

	draw_sprite_ext(s_HealthBar, 1, hp_x, hp_y, bar_draw, bar_draw, 0, c_white, 1)
	draw_sprite_part_ext(s_HealthBar, 0, 0, 0, hp_w, hp_h, hp_x, hp_y, bar_draw, bar_draw, c_white, 1)

	//energy bar
	hp_y += hp_h * bar_draw + pad

	energy_show = lerp(energy_show, o_Player.energy, 0.2);

	var en_w = (energy_show / 100) * sprite_get_height(s_EnergyBar);
	var en_h = sprite_get_width(s_EnergyBar)

	draw_sprite_ext(s_EnergyBar, 1, hp_x, hp_y, bar_draw, bar_draw, 0, c_white, 1)
	draw_sprite_part_ext(s_EnergyBar, 0, 0, 0, en_w, en_h, hp_x, hp_y, bar_draw, bar_draw, c_white, 1)
} 

//item log pikcup notifications
var log_x = 1700
var log_y = 1000
for(var i = 0; i < ds_list_size(item_log); i++)
{
	var log_height = 50
		
	var item_entry = item_log[|i]
		
	var item_spr_index = item_entry.spr_index
	//var item_name = o_iitem_entry.spr_index
	
	var fade_time = 0.5
	var fade_alpha = clamp(item_entry.time / fade_time, 0, 1)
	
	//@TODO Smooth moving
	//@HACK
	draw_set_alpha(fade_alpha)
	ui_draw_title(item_entry.msg, log_x, log_y - (log_height + pad) * i, 200, log_height, tab_color, c_white, false)
	draw_set_alpha(1)	
	
	item_entry.time -= get_delta_time()
		
	if(item_entry.time <= 0)
	{
		ds_list_delete(item_log, i)
	}
}
#macro pad 5

//switch buttons - for switching between inventory and building
var show = false

for(var i = 0; i < ds_list_size(switch_buttons); i++)
{
	if(global.current_gui == switch_buttons[|i].to) show = true
}

if(show)
{
	var sw_width = 175
	var sw_height = 35

	var sw_gap = 30
	
	var sw_x = display_get_gui_width() / 2 - (((ds_list_size(switch_buttons) * sw_width)) + ((ds_list_size(switch_buttons) - 1) * sw_gap)) / 2
	var sw_y = pad

	for(var i = 0; i < ds_list_size(switch_buttons); i++)
	{
		var color = c_gray
		var s_color = c_ltgray
		
		if(global.current_gui == switch_buttons[|i].to) 
		{
			color = c_orange
			s_color = c_orange
		}
		
		var button = ui_draw_button_color(switch_buttons[|i].text, sw_x + (sw_width + sw_gap) * i, sw_y, sw_width, sw_height, color, s_color, c_white, false)
		if(button[0])
		{
			global.current_gui = switch_buttons[|i].to	
			
			if(global.current_gui == gui.BUILDING) selected_bp = noone
		}
	}
}

if(global.current_gui == gui.INVENTORY)
{
	

}

if(global.current_gui == gui.BUILDING)
{
	if(selected_bp == noone)
	{
		var bw = 300
		var bh = 70
	
		var bx = display_get_gui_width() - pad - bw
		var by = pad
	
		for(var i = 0; i < ds_list_size(blueprints); i++)
		{
			by = by + (bh + pad) * i
		
			var color = tab_color
		
			if(point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), bx, by, bx + bw, by + bh + pad - 1))
			{
				color = main_color	
			
				if(mouse_check_button_pressed(mb_left))
				{
					selected_bp = blueprints[|i].obj
				}

				//info about item you hovering
				var iw = 260
				var ih = 230
			
				var ix = bx - iw - pad
				var iy = by
			
				ui_draw_rectangle(ix, iy, iw, ih, main_color, 1, false)
			
				info = make_panel(ix + pad, iy + pad)
			
				draw_set_color(text_color)
				var dh = ui_draw_string(info.at_x, info.at_y, blueprints[|i].text, ft_Default)
			
				pn_row(info, dh + pad)
				
				draw_set_color(tab_color)
				ui_draw_string(info.at_x, info.at_y, blueprints[|i].desc, ft_Description)
			
				pn_row(info, 60)
				for(var j = 0; j < array_length_1d(blueprints[|i].need); j++)
				{
					var need_name = global.items_list[blueprints[|i].need[j].item].name
					var need_amt = blueprints[|i].need[j].amt
				
					var tw = iw - (pad * 2)
					var th = 45
					
					ui_draw_rectangle(info.at_x, info.at_y + (th + pad) * j, tw, th, tab_color, 1, false)
					
					var spr_draw_space = th
					var spr_scale = spr_draw_space / 16
					var spr_offset = th / 2 - (16 * spr_scale) / 2
					var spr_half = (16 * spr_scale) / 2
					
					var col = decline_color
					
					var item_amt = get_item_amount(o_PlayerInventory.inv, o_PlayerInventory.inv_data, blueprints[|i].need[j].item)
					var item_need = blueprints[|i].need[j].amt
					
					if(item_amt >= item_need) col = confirm_color
					
					draw_sprite_ext(s_Items, blueprints[|i].need[j].item, info.at_x + spr_half + spr_offset, info.at_y + (th + pad) * j + spr_half + spr_offset, spr_scale, spr_scale, 0, col, 1)
					
					var text_height = string_height_font("Wdad", ft_Description)
					var text_offset = th / 2 - text_height / 2
					
					draw_set_color(col)
					ui_draw_string(info.at_x + (spr_half * 2) + spr_offset + pad, info.at_y + (th + pad) * j + text_offset, string(need_name) + " (" + string(item_amt) + "/" + string(need_amt) + ")", ft_Description)
					draw_set_color(c_white)
				}
			}
			
			ui_draw_rectangle(bx, by, bw, bh, color, 1, false)	
	
			var sprite_scale = 4
			var sprite_space = 16 * sprite_scale
		
			var text_height = string_height_font(blueprints[|i].text, ft_Default)
		
			var sprite = object_get_sprite(blueprints[|i].obj)
			var swidth = sprite_get_width(sprite)
		
			sprite_scale = (16 / swidth) * 4
		
			draw_sprite_ext(sprite, 0, bx, by, sprite_scale, sprite_scale, 0, c_white, 1)
		
			var tx = bx + sprite_space + pad
			var ty = by + (bh / 2) - (text_height / 2)
		
			ui_draw_string(tx, ty, blueprints[|i].text, ft_Default)
		}
	}
}