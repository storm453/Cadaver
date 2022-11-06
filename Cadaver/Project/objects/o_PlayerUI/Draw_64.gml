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
	var log_height = 35
		
	var item_entry = item_log[|i]
		
	var item_spr_index = item_entry.spr_index
	//var item_name = o_iitem_entry.spr_index
	
	var fade_time = 0.25
	var fade_alpha = clamp(item_entry.time / fade_time, 0, 1)
	
	var target_y = log_y - (log_height + pad) * i
	
	item_entry.cur_y = lerp(item_entry.cur_y, target_y, 0.1)
	
	//text coloring
	var text_c = decline_color
	
	if(item_entry.type) text_c = confirm_color
	
	//@TODO Smooth moving
	//@HACK
	draw_set_alpha(fade_alpha)
	draw_set_font(ft_Medium)
	draw_sprite_ext(s_PickupTitle, 0, log_x, item_entry.cur_y, inv_scale, inv_scale, 0, c_white, fade_alpha)
	ui_draw_title_text(item_log[|i].msg, log_x, item_entry.cur_y, 200, log_height, text_c, text_c, false)
	draw_set_alpha(1)	
	
	item_entry.time -= get_delta_time()
		
	if(item_entry.time <= 0)
	{
		ds_list_delete(item_log, i)
	}
}
#macro pad 5

//loop through and check if current gui is in tablist
for(var i = 0; i < ds_list_size(tabnav); i++)
{
	if(global.current_gui == tabnav[|i])
	{
		var tn_x = 0
		var tn_y = 0
		
		var tab_h = 70
		
		//draw navtab bc gui is in tabnav list
		draw_set_color(c_yellow)
		draw_rectangle(tn_x, tn_y, display_get_gui_width(), tab_h, false)
		draw_set_color(c_white) 
		
		tn_x += pad
		
		for(var i = 0; i < ds_list_size(tabnav_buttons); i++)
		{
			var tn_bwidth = 300
			
			var cur = tabnav_buttons[|i]
			
			var col = c_orange
			var sel_col = c_red
			
			if(cur.ui == global.current_gui)
			{
				//current button is the gui that is selected
				col = c_lime
				sel_col = c_lime
			}
			
			draw_set_font(ft_24)
			
			var button = ui_draw_button_color(cur.text, tn_x + (i * (tn_bwidth + pad)), tn_y, tn_bwidth, tab_h, col, sel_col, c_white, false)
			if(button[0])
			{
				global.current_gui = cur.ui
			}
		}
	}
}

if(global.current_gui == gui.CRAFT)
{
	var craft_width = sprite_get_width(s_CraftUI) * inv_scale
	var craft_height = sprite_get_height(s_CraftUI) * inv_scale
	
	var cra_x = display_get_gui_width() / 2 - craft_width / 2
	var cra_y = display_get_gui_height() / 2 - craft_height / 2
	
	//change some variables based on your station
	var station_name = "Crafting"
	var craft_level = stations.hands
	
	if(global.open_instance != noone)
	{
		//an instance is open
		if(global.open_instance.block_data.misc.station == stations.workbench)
		{
			station_name = "Workbench"
			craft_level = stations.workbench
		}
	}
	
	window_text(cra_x, cra_y, station_name, ft_Large, color_hex(0xe4d2aa))
	
	draw_sprite_ext(s_CraftUI, 0, cra_x, cra_y, inv_scale, inv_scale, 0, c_white, 1)
	
	cra_pan = make_panel(cra_x + slot_from_top, cra_y + slot_from_top)

	for(var i = 0; i < ds_list_size(craft_categories); i++)
	{
		//ui_craft_list_button(craft_categories[|i], cra_pan.at_x,)
		
		//list button
		var mx = device_mouse_x_to_gui(0)
		var my = device_mouse_y_to_gui(0)

		//var spr_index = 0
		var spr_index = 0
		
		var inc_y = cra_pan.at_y + (i * ((sprite_get_height(s_CraftListButton) * inv_scale) + slot_spacing))
		
		if(point_in_rectangle(mx, my, cra_pan.at_x, inc_y, cra_pan.at_x + (sprite_get_width(s_CraftListButton) * inv_scale), inc_y + sprite_get_height(s_CraftListButton) * inv_scale))
		{
			spr_index = 1

			if(mouse_check_button_pressed(mb_left))
			{
				craft_selcat = i	
				
				craft_selrec = 0
			}
		}
		
		if(craft_selcat == i) spr_index = 2
		
		draw_sprite_ext(s_CraftListButton, spr_index, cra_pan.at_x, inc_y, inv_scale, inv_scale, 0, c_white, 1)
		
		var text_x = cra_pan.at_x + (sprite_get_width(s_CraftListButton) * inv_scale) / 2 - string_width(craft_categories[|i]) / 2
		var text_y = inc_y + (sprite_get_height(s_CraftListButton) * inv_scale) / 2 - string_height(craft_categories[|i]) / 2
		
		draw_set_color(c_black)
		draw_text(text_x, text_y, craft_categories[|i])
		draw_set_color(c_white)
	}
	
	pn_col(cra_pan, sprite_get_width(s_CraftListButton) * inv_scale + slot_spacing)
	
	//draw all recipes of current category
	for(var i = 0; i < ds_list_size(craft_recipes[craft_selcat]); i++)
	{
		var sel_recipe = craft_recipes[craft_selcat][|i]
		
		var tx_draw = cra_pan.at_x + slot_spacing
		var ty_draw = cra_pan.at_y + slot_spacing
		
		draw_set_color(c_black)
		
		var gap = 40
		
		if(point_in_rectangle(mx, my, tx_draw, ty_draw + (i * gap), tx_draw + 100, ty_draw + gap + (i * gap)))
		{
			draw_set_color(0xcbefff)
			
			if(mouse_check_button_pressed(mb_left))
			{
				craft_selrec = i	
			}
		}	
		
		if(i == craft_selrec) draw_set_color(c_white)
		
		draw_set_font(ft_24)
		draw_text(tx_draw, ty_draw + (i * gap), global.items_list[sel_recipe.item].name)
		
		draw_set_color(c_black)
	}
	
	pn_col(cra_pan, 71 * inv_scale + slot_spacing)
	
	//selected item data
	if(ds_list_size(craft_recipes[craft_selcat]) > 0)
	{
		//there is atleast one item in list
		var sel_item = craft_recipes[craft_selcat][|craft_selrec].item
		var sel_name = global.items_list[sel_item].name
		var sel_desc = global.items_list[sel_item].item_data.description
		var sel_stat = craft_recipes[craft_selcat][|craft_selrec].station_needed
	
		draw_sprite_ext(s_CraftTitle, 0, cra_pan.at_x, cra_pan.at_y, inv_scale, inv_scale, 0, c_white, 1)
		
		draw_set_font(ft_Large)
		
		var title_w = sprite_get_width(s_CraftTitle) * inv_scale
		var title_h = sprite_get_height(s_CraftTitle) * inv_scale
		
		var title_tx = cra_pan.at_x + title_w / 2 - string_width(sel_name) / 2
		var title_ty = cra_pan.at_y + title_h / 2 - string_height(sel_name) / 2
		
		draw_text(title_tx, title_ty, sel_name)
		
		//description
		cra_pan.at_y += title_h + slot_spacing

		draw_set_font(ft_17)
		draw_set_color(color_hex(0x71413b))
		draw_text_ext(cra_pan.at_x, cra_pan.at_y, sel_desc, 30, title_w)
		
		cra_pan.at_y += 200

		draw_line(cra_pan.at_x, cra_pan.at_y, cra_pan.at_x + title_w, cra_pan.at_y)
		
		//draw text if a workbench is required
		if(sel_stat == stations.workbench) window_text(cra_pan.at_x, cra_pan.at_y, "Workbench required to craft!", ft_17, c_maroon)
		
		
		cra_pan.at_y += slot_spacing
			
		var requirements_array = craft_recipes[craft_selcat][|craft_selrec].req_arr
		
		var craft = true
		
		//draw requirements
		for(var i = 0; i < array_length_1d(requirements_array); i++)
		{
			var req_item = requirements_array[i].item
			var req_amt = requirements_array[i].amt
			var req_name = global.items_list[req_item].name
			
			draw_set_color(color_hex(0xb4202a))
			
			var check = check_item(o_PlayerInventory.inv, req_item, req_amt)
			if(check)
			{
				draw_set_color(color_hex(0x71413b))	
			}
			else
			{
				craft = false	
			}
			
			ui_draw_string(cra_pan.at_x, cra_pan.at_y + (i * 30), req_name + " x" + string(req_amt), ft_17)
			
			//draw (Have:)
			var have_offset = 230
			
			draw_set_color(color_hex(0xa08e73))
			
			if(get_item_amount(o_PlayerInventory.inv, req_item) >= req_amt) draw_set_color(color_hex(0x756854))
			
			ui_draw_string(cra_pan.at_x + have_offset, cra_pan.at_y + (i * 30), "(Have: " + string(get_item_amount(o_PlayerInventory.inv, req_item)) + ")", ft_17)
		}
		
		//disallow crafting if station requirement not met
		if(sel_stat != stations.hands)
		{
			if(craft_level != sel_stat) craft = false	
		}
		
		var craft_button_w = sprite_get_width(s_CraftListButton) * inv_scale
		var craft_button_h = sprite_get_height(s_CraftListButton) * inv_scale
		
		//draw craft button
		cra_pan.at_y = display_get_gui_height() / 2 + ((sprite_get_height(s_CraftUI) * inv_scale) / 2) - slot_from_top - sprite_get_height(s_CraftListButton) * inv_scale
		
		var craft_index = 0
		
		draw_set_color(c_black)
		
		if(!craft) 
		{
			craft_index = 2
			draw_set_color(color_hex(0xa08e73))
		}
		else
		{
			if(point_in_rectangle(mx, my, cra_pan.at_x, cra_pan.at_y, cra_pan.at_x + craft_button_w, cra_pan.at_y + craft_button_h))
			{
				craft_index = 1	
				
				if(mouse_check_button_pressed(mb_left))
				{
					//remove requimrents
					for(var i = 0; i < array_length_1d(requirements_array); i++)
					{	
						remove_item(o_PlayerInventory.inv, requirements_array[i].item, requirements_array[i].amt)
					}
					
					add_item(o_PlayerInventory.inv, sel_item, 1)
				}
			}
		}
		
		draw_sprite_ext(s_CraftListButton, craft_index, cra_pan.at_x, cra_pan.at_y, inv_scale, inv_scale, 0, c_white, 1)
		
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		ui_draw_string(cra_pan.at_x + craft_button_w / 2, cra_pan.at_y + craft_button_h / 2, "Craft", ft_Large)
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
	}
}