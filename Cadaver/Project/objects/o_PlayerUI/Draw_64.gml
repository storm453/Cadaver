var hp_x = 10;
var hp_y = 10;

var bar_draw = 2

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

//ITEM PICKUP DROP NOTIFICATIONS LOG HJING YEAH
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

if(global.current_gui == gui.INVENTORY)
{
	//SET CRAFING NAME
	craft_cat_name = craft_name_arr[crafting_level]
	selected_tab = craft_cat_name	
}

draw_set_font(ft_Default)

#macro pad 5

#macro switch_button_scale 64

#macro title_button_width 128
#macro title_button_height 32

//ONLY SHOW TAB SELECT IF IS IN LIST
var show_tab = false

for(var i = 0; i < ds_list_size(tab_sel_present_list); i++)
{
	if(global.current_gui = tab_sel_present_list[|i])
	{
		show_tab = true
	}
}

if(show_tab)
{	
	#macro inv_width round(o_PlayerInventory.inv_data.slots_x * o_PlayerInventory.inv_data.draw_scale * o_PlayerInventory.inv_data.slot_size)
	#macro inv_height o_PlayerInventory.player_inventory_height
	
	#macro inv_width_slots_only o_PlayerInventory.player_inventory_height_slots_only
	
	#macro window_width inv_width
	
	window_height = 300
	
	var buttons = 3
	var menu_scale = 0;
	
	repeat(round(buttons))
	{
		menu_scale += pad + switch_button_scale
	}
	
	menu_scale += pad

	var title_height = string_height_font("Title", ft_Title) + pad * 2
	
	var switch_x = display_get_gui_width() / 2 - (menu_scale + menu_scale / 2) / 2
	var switch_y = 0
	
	ui_draw_title(selected_tab, switch_x, switch_y, menu_scale + menu_scale / 2, title_height, tab_color, c_white, false)
	draw_set_font(ft_Default)

	switch_x = display_get_gui_width() / 2 - menu_scale / 2
	switch_y = title_height

	ui_draw_rectangle(switch_x, switch_y, menu_scale, switch_button_scale + pad, menu_color, 1, false)

	switch_x += pad

	var button_array = array_create(buttons);
	
	var button_data_array = ""
	
	button_data_array[0] = "Inv"
	button_data_array[1] = "Chr"
	button_data_array[2] = "Map"

	for(var i = 0; i < buttons; i++)
	{
		//button_array[i] = ui_draw_button_color(button_data_array[i], switch_x, switch_y, switch_button_scale, switch_button_scale, button_color, button_s_color, c_white, false)
		button_array[i] = ui_draw_button_sprite(s_Icons, i, switch_x, switch_y, switch_button_scale, switch_button_scale, button_color, button_s_color, c_white, 0.5, false)
		switch_x += pad + switch_button_scale
	}
	
	if(button_array[0][0])
	{
		global.current_gui = gui.INVENTORY
		selected_tab = craft_cat_name
	}	
	
	if(button_array[1][0])
	{
		global.current_gui = gui.PROFILE
		selected_tab = "PROFILE"
	}
	
	if(button_array[2][0])
	{
		global.current_gui = gui.JOURNAL
		selected_tab = "JOURNAL"
	}	
}

if(global.current_gui == gui.INVENTORY)
{
	/// CRAFTING UI !
	
	//ITEM DATA WINDOW
	#macro craft_width window_width
	#macro craft_height 320
	
	var item_window_x = display_get_gui_width() / 2 - inv_width / 2
	var item_window_y = display_get_gui_height() - inv_height - craft_height - title_height - pad
	
	ui_draw_window(item_window_name, item_window_x, item_window_y, craft_width, craft_height)
	
	item_panel = make_panel(item_window_x + pad, item_window_y + pad)

	var turn = -1
	
	if(sel_item != -1)
	{
		turn = 1
	}
	
	if(global.info_sel_slot[0] != -1)
	{
		if(global.info_sel_slot[1] != -1)
		{
			turn = 0	
		}
	}
	
	//turn starts off -1, if a recipe is selected it's 1 (true), if a slot in ur inventory is selected, its 0
	if(turn)
	{
		var station_check = true

		if(sel_craft_list[|sel_item].craft_lvl != crafting_lvls.ALL)
		{
			if(sel_craft_list[|sel_item].craft_lvl != crafting_level) station_check = false
		}

		if(station_check)
		{
			sel_item_id = global.items_list[sel_craft_list[|sel_item].item_id].spr_index
			
			var item_spr_scale = 5
			var item_spr_size = sprite_get_width(s_Items)
			
			ui_draw_rectangle(item_panel.at_x, item_panel.at_y, item_spr_size * item_spr_scale, item_spr_size * item_spr_scale, tab_color, 1, false)
			draw_sprite_ext(s_Items, sel_item_id, item_panel.at_x, item_panel.at_y, item_spr_scale, item_spr_scale, 0, c_white, 1)
			
			pn_col(item_panel, item_spr_scale * item_spr_size + pad)
			
			var text_space = craft_width - (pad * 3) - (item_spr_scale * item_spr_size)
			
			var description = "This is where the description would go. Essential for a crafting system. Well, not really. But it's cool!"
			
			if(variable_struct_exists(global.items_list[sel_craft_list[|sel_item].item_id], "item_data"))
			{
				if(variable_struct_exists(global.items_list[sel_craft_list[|sel_item].item_id].item_data, "description"))
				{
					description = global.items_list[sel_craft_list[|sel_item].item_id].item_data.description
				}
			}
			
			draw_set_color(text_color)
			draw_text_ext(item_panel.at_x, item_panel.at_y, description, 20, text_space)
			draw_set_color(c_white)
			
			pn_row(item_panel, item_spr_scale * item_spr_size - (pad))
			
			var line_x = item_panel.at_x + craft_width - (pad * 2)
				
			draw_set_color(tab_color)
			draw_line_width(item_panel.at_x + (item_spr_scale * item_spr_size), item_panel.at_y, line_x, item_panel.at_y, 3)
			
			pn_row(item_panel, pad * 2)
			
			var arrow_width = (item_spr_scale * item_spr_size) / 2 - (pad / 2)
			var arrow_height = 25
			
			//ui_draw_button_sprite(s_Icons, 5, item_panel.at_x, item_panel.at_y, arrow_width, arrow_height, button_color, button_h_color, c_ltgray, -0.2, false)
			
			pn_col(item_panel, arrow_width + pad)
			
			//ui_draw_button_sprite(s_Icons, 5, item_panel.at_x, item_panel.at_y, arrow_width, arrow_height, button_color, button_h_color, c_ltgray, 0.2, false)
			
			pn_row(item_panel, arrow_height + pad)
			
			var craft_button_width = (item_spr_scale * item_spr_size) * 1.75
			
			for(var i = 0; i < 5; i++)
			{
				ui_draw_rectangle(item_panel.at_x, item_panel.at_y + (40 * i), craft_button_width, 35,	tab_color, 1, 1)
			}
			
			var craft = 1
			
			var requirements_array = sel_craft_list[|sel_item].req_arr
			
			for(var i = 0; i < array_length_1d(requirements_array); i++)
			{
				var arr_item_id = requirements_array[i].iid
				var arr_item_am = requirements_array[i].mat
				
				var check = check_item(o_PlayerInventory, arr_item_id, arr_item_am)
				
				if(!check) craft = 0
			}
			
			if(craft) 
			{
				var craft = ui_draw_button_color("CRAFT", item_panel.at_x, item_panel.at_y, craft_button_width, 35, button_color, button_h_color, text_color, false)
				if(craft[0])
				{
					ds_list_add(queue_list, { uid: sel_item_id , amt: 1 , timer: 5 } )
					
					//remove items needed
					for(var i = 0; i < array_length_1d(requirements_array); i++)
					{
						remove_item(o_PlayerInventory, requirements_array[i].iid,  requirements_array[i].mat)
					}
				}
			}
			else
			{
				ui_draw_title("CRAFT", item_panel.at_x, item_panel.at_y, craft_button_width, 35, button_color, tab_color, false)
			}
			
			pn_col(item_panel, craft_button_width + pad)
			
			var req_width = craft_width - (pad * 3) - craft_button_width
			
			for(var i = 0; i < 5; i++)
			{
				ui_draw_rectangle(item_panel.at_x, item_panel.at_y + (40 * i), req_width, 35, tab_color, 1, false)
			}
			
			for(var i = 0; i < array_length_1d(requirements_array); i++)
			{
				var arr_item_id = requirements_array[i].iid
				var arr_item_am = requirements_array[i].mat
				
				var check = check_item(o_PlayerInventory, arr_item_id, arr_item_am)
				
				var dis_scale = 2.3
				
				var spr_adj = (35 / 2) - ((sprite_get_width(s_Items) * dis_scale) / 2)
				var txt_adj = (35 / 2) - (string_height("ITEM") / 2)
				
				var txt_color = 0x69db91
				var spr_color = c_white
				
				if(!check)
				{
					craft = 0
					
					txt_color = 0x8181f6
					spr_color = 0x8181f6
				}
				
				draw_sprite_ext(s_Items, global.items_list[arr_item_id].spr_index, item_panel.at_x + spr_adj, item_panel.at_y + spr_adj + (40 * i), dis_scale, dis_scale, 0, spr_color, 1)
				
				var amt_string = ""
				
				if(arr_item_am > 1) amt_string = " x" + string(arr_item_am)
				
				draw_set_color(txt_color)
				ui_draw_string(item_panel.at_x + pad + dis_scale * sprite_get_width(s_Items), item_panel.at_y + (40 * i) + txt_adj, string(global.items_list[arr_item_id].name) + amt_string, ft_Default)	
			}
		}
		else
		{
			//draw here if user does not have proper craft lvl
			sel_item_id = global.items_list[sel_craft_list[|sel_item].item_id].spr_index
			
			var item_spr_scale = 5
			var item_spr_size = sprite_get_width(s_Items)
			
			ui_draw_rectangle(item_panel.at_x, item_panel.at_y, item_spr_size * item_spr_scale, item_spr_size * item_spr_scale, tab_color, 1, false)
			draw_sprite_ext(s_Items, sel_item_id, item_panel.at_x, item_panel.at_y, item_spr_scale, item_spr_scale, 0, c_white, 1)

			pn_col(item_panel, item_spr_scale * item_spr_size + pad)
			
			var text_space = craft_width - (pad * 3) - (item_spr_scale * item_spr_size)
			
			var description = "You are not at the correct workstation to create this item. \nCrafted at: WORKBENCH"

			draw_set_color(c_red)
			draw_text_ext(item_panel.at_x, item_panel.at_y, description, 20, text_space)
			draw_set_color(c_white)
		}
	}
	else if(turn == 0)
	{
		//Selected inventory slot data
		if(o_PlayerInventory.inv[global.info_sel_slot[0], global.info_sel_slot[1]] != 0)
		{
			inv_sel = o_PlayerInventory.inv[global.info_sel_slot[0], global.info_sel_slot[1]].item
		
			var item_spr_scale = 5
			var item_spr_size = sprite_get_width(s_Items)
		
			ui_draw_rectangle(item_panel.at_x, item_panel.at_y, item_spr_size * item_spr_scale, item_spr_size * item_spr_scale, tab_color, 1, false)
			draw_sprite_ext(s_Items, inv_sel, item_panel.at_x, item_panel.at_y, item_spr_scale, item_spr_scale, 0, c_white, 1)
		
			pn_col(item_panel, item_spr_scale * item_spr_size + pad)
		
			var text_space = craft_width - (pad * 3) - (item_spr_scale * item_spr_size)
		
			var description = "This is where the description would go. Essential for a crafting system. Well, not really. But it's cool!"
			
			if(variable_struct_exists(global.items_list[inv_sel], "item_data"))
			{
				if(variable_struct_exists(global.items_list[inv_sel].item_data, "description"))
				{
					description = global.items_list[inv_sel].item_data.description
				}
			}
		
			draw_set_color(text_color)
			draw_text_ext(item_panel.at_x, item_panel.at_y, description, 20, text_space)
			draw_set_color(c_white)
		
			pn_row(item_panel, item_spr_scale * item_spr_size - (pad))
		
			var line_x = item_panel.at_x + craft_width - (pad * 2)
			
			draw_set_color(tab_color)
			draw_line_width(item_panel.at_x + (item_spr_scale * item_spr_size), item_panel.at_y, line_x, item_panel.at_y, 3)
		
			pn_row(item_panel, pad * 2)
		
			var arrow_width = (item_spr_scale * item_spr_size) / 2 - (pad / 2)
			var arrow_height = 25
		
			//ui_draw_button_sprite(s_Icons, 5, item_panel.at_x, item_panel.at_y, arrow_width, arrow_height, button_color, button_h_color, c_ltgray, -0.2, false)
		
			pn_col(item_panel, arrow_width + pad)
		
			//ui_draw_button_sprite(s_Icons, 5, item_panel.at_x, item_panel.at_y, arrow_width, arrow_height, button_color, button_h_color, c_ltgray, 0.2, false)
		
			pn_row(item_panel, arrow_height + pad)
		
			var craft_button_width = (item_spr_scale * item_spr_size) * 1.75
		
			for(var i = 0; i < 5; i++)
			{
				ui_draw_rectangle(item_panel.at_x, item_panel.at_y + (40 * i), craft_button_width, 35,	tab_color, 1, 1)
			}
			
			var inspect_list = ds_list_create()
			
			if(variable_struct_exists(global.items_list[inv_sel], "item_data"))
			{
				if(global.items_list[inv_sel].item_data.hp > 0)
				{
					ds_list_add(inspect_list, "Use")	
				}
				
				if(global.items_list[inv_sel].item_data.scrap)
				{
					ds_list_add(inspect_list, "Scrap")	
				}
			}
			
			ds_list_add(inspect_list, "Drop")
			
			for(var i = 0; i < ds_list_size(inspect_list); i++)
			{
				var inspect_button = ui_draw_button_color(inspect_list[|i], item_panel.at_x, item_panel.at_y + (40 * i), craft_button_width, 35, button_color, button_h_color, text_color, false)
				if(inspect_button[0])
				{
					//Clicked use button
					if(inspect_list[|i] == "Use")
					{
						remove_item_slot(o_PlayerInventory, 1, global.info_sel_slot[0], global.info_sel_slot[1])
						
						o_Player.hp += global.items_list[inv_sel].item_data.hp
						o_Player.energy += global.items_list[inv_sel].item_data.energy
					}
					//Clicked scrap button
					if(inspect_list[|i] == "Scrap")
					{
						remove_item_slot(o_PlayerInventory, 1, global.info_sel_slot[0], global.info_sel_slot[1])	
					}
					//Clicked drop button
					if(inspect_list[|i] == "Drop")
					{
						remove_item_slot(o_PlayerInventory, 999, global.info_sel_slot[0], global.info_sel_slot[1])
					}
					
				}
			}
			
			pn_col(item_panel, craft_button_width + pad)
		
			var req_width = craft_width - (pad * 3) - craft_button_width
		
			for(var i = 0; i < 5; i++)
			{
				ui_draw_rectangle(item_panel.at_x, item_panel.at_y + (40 * i), req_width, 35, tab_color, 1, false)
			}
		}	
		else
		{
			item_window_name = "None"	
		}
	}
	
	//if item is moved, or item goes missing, reset info sel slot to nothing
	if(global.info_sel_slot[0] != -1)
	{
		if(global.info_sel_slot[1] != -1)
		{
			if(o_PlayerInventory.inv[global.info_sel_slot[0], global.info_sel_slot[1]] == 0)
			{
				global.info_sel_slot[0] = -1	
				global.info_sel_slot[1] = -1	
				
				item_window_name = "None"
			}
		}
	}
	
	//ITEM CRAFTING QUEUE
	var q_size = 70
	
	var q_window_x = display_get_gui_width() / 2 - inv_width / 2 - pad - q_size
	var q_window_y = display_get_gui_height() - inv_height - craft_height - title_height + spacing_from_top + list_height
	
	for(var i = 0; i < ds_list_size(queue_list); i++)
	{
		var q_window_x_i = q_window_x - (i * (pad + q_size))
		
		//draw blank rectangle
		ui_draw_rectangle(q_window_x_i, q_window_y, q_size, q_size, menu_color, 1, false)
		
		//draw sprite
		var q_spr_scale = q_size / sprite_get_width(s_Items)
		
		draw_sprite_ext(s_Items, queue_list[|i].uid, q_window_x_i, q_window_y, q_spr_scale, q_spr_scale, 0, c_white, 1)
		
		//draw timer texet
		draw_text(q_window_x_i + pad, q_window_y + pad, "0:0" + string(queue_list[|i].timer))
	}
	
	//ITEM LIST WINDOW
	#macro list_width 275
	#macro list_height 450
		
	#macro spacing_from_top 50
	
	var list_window_x = display_get_gui_width() / 2 - inv_width / 2 - pad - list_width
	var list_window_y = display_get_gui_height() - inv_height - craft_height - title_height - pad + spacing_from_top
	
	ui_draw_window(list_window_name, list_window_x, list_window_y, list_width, list_height)
	
	list_panel = make_panel(list_window_x + pad, list_window_y + pad)
	
	var mag_icon = s_MagIcon
	var icon_size = sprite_get_width(mag_icon)
	
	draw_sprite(mag_icon, 0, list_panel.at_x, list_panel.at_y)
	
	pn_col(list_panel, icon_size + pad)
	
	var search_pad = 12
	
	var search_width = list_width - (pad * 3) - icon_size - search_pad
	var search_height = icon_size - search_pad
	
	ui_draw_title("", list_panel.at_x + (search_pad / 2), list_panel.at_y + (search_pad / 2), search_width, search_height, tab_color, text_color, false)
	
	pn_row(list_panel, icon_size + pad)
	
	var cat_back_width = list_width - (pad * 2)
	var cat_back_height = 50
	
	var cat_button_scale = 32
	var cat_button_amt = 7
	
	ui_draw_rectangle(list_panel.at_x, list_panel.at_y, cat_back_width, cat_back_height, tab_color, 1, false)
	
	var cat_center = list_panel.at_x + cat_back_width
	
	for(var i = 0; i < cat_button_amt; i++)
	{
		var cat_button = ui_draw_button_sprite(s_MagIcon, 0, cat_center - ((pad + cat_button_scale) * cat_button_amt) + (i * (cat_button_scale + pad)), list_panel.at_y + (cat_back_height / 2 - cat_button_scale / 2), cat_button_scale, cat_button_scale, button_color, button_h_color, text_color, 0, 1)
		if(cat_button[0])
		{
			current_page = 0
			
			list_window_name = cat_buttons[i].name
			
			if(global.info_sel_slot[0] == -1)
			{
				if(global.info_sel_slot[1] == -1)
				{
					item_window_name = "None"
				}
			}
			
			sel_craft_list = cat_buttons[i].list_var
			sel_item = -1
		}
	}
	
	pn_row(list_panel, cat_back_height + pad)
	
	var item_button_width = list_width - (pad * 2)
	var item_button_height = 35
	
	//page
	if(keyboard_check_pressed(vk_left))
	{
		current_page--
		
		if(current_page <= 0) current_page = 0
	}
	if(keyboard_check_pressed(vk_right))
	{
		if(ds_list_size(sel_craft_list) > ((current_page + 1) * item_per_page))
		{
			current_page++	
		}
	}
	
	var pg_loop_start = 0 + (item_per_page * current_page)
	var pg_loop_end = item_per_page + (item_per_page * current_page)
	
	if(ds_list_size(sel_craft_list) < pg_loop_end) pg_loop_end = ds_list_size(sel_craft_list)
	
	if(ds_list_size(sel_craft_list) > 0)
	{
		for(var i = pg_loop_start; i < pg_loop_end; i++)
		{
			var pos_i = i - (item_per_page * current_page)
			
			var station_check = true

			if(sel_craft_list[|i].craft_lvl != crafting_level)
			{
				station_check = false
			}

			var item_button_t_color = text_color
			var item_button_color = button_color
			var item_button_h_color = button_h_color
			
			if(i == sel_item)
			{
				item_button_color = button_s_color	
				item_button_h_color = button_s_color
			}
			if(!station_check)
			{
				item_button_t_color = c_black
			}
			
			var item_name = global.items_list[sel_craft_list[|i].item_id].name
			
			var item_button = ui_draw_button_color(item_name, list_panel.at_x, list_panel.at_y + (pos_i * (item_button_height + pad)), item_button_width, item_button_height, item_button_color, item_button_h_color, item_button_t_color, false)
			if(item_button[0])
			{
				sel_item = i	
				item_window_name = global.items_list[sel_craft_list[|sel_item].item_id].name
				
				global.info_sel_slot[0] = -1
				global.info_sel_slot[1] = -1
			}
		}
	}
	
	//DEPENDING ON WHAT STATION IS OPEN
	switch(crafting_level)
	{
		//WORKBENCH
		case(1):
			
		break;
	}
}

//Counter for crafting
counter++

if(counter > 60)
{
	counter = 0
		
	if(ds_list_size(queue_list) > 0)
	{
		queue_list[|0].timer--
		
		if(queue_list[|0].timer <= 0)
		{
			add_item(o_PlayerInventory, queue_list[|0].uid, queue_list[|0].amt)
			ds_list_delete(queue_list, 0)
		}
	}
}

if(global.current_gui == gui.PROFILE)
{
	var prof_width = inv_width * 2
	var prof_height = window_height + inv_width_slots_only
	
	//MAIN UI
	var hp_info_start_x = display_get_gui_width() / 2 - prof_width / 2
	var hp_info_start_y = display_get_gui_height() - inv_height - window_height - pad
	
	var hp_info_x = hp_info_start_x
	var hp_info_y = hp_info_start_y

	ui_draw_window("PROFILE", hp_info_x, hp_info_y, prof_width, prof_height)
	
	hp_info_x += pad
	hp_info_y += pad
	
	var hp_info_width = 250
	var hp_info_height = 100
	
	ui_draw_rectangle(hp_info_x, hp_info_y, hp_info_width, hp_info_height, button_color, 1, false)
	
	var status_x = hp_info_start_x
	var status_y = hp_info_start_y
	
	status_x += (pad * 2) + hp_info_width
	status_y += pad
	
	var status_width = 200
	var status_height = 50
	
	for(var i = 0; i < ds_list_size(status_list); i++)
	{
		if(ds_list_size(status_list) > 0)
		{
			var index = status_list[|i]
			var selected_col = button_color
		
			if(status_selected = i)
			{
				selected_col = button_s_color	
			}
		
			var button = ui_draw_button_color(index.status_id.name + " (" + string(index.time) + "s)", status_x, status_y + (pad + status_height) * i, status_width, status_height, selected_col, button_s_color, c_white, false)
			if(button[0])
			{
				status_selected = i	
			}
		}
	}
	
	status_x += status_width + pad
	
	draw_text(status_x, status_y, status_list[|status_selected].status_id.description)
}

counter++

if(counter > 60)
{
	counter = 0
		
	if(ds_list_size(status_list) > 0)
	{
		for(var i = 0; i < ds_list_size(status_list); i++)
		{
			status_list[|i].time--
		
			if(status_list[|i].time <= 0)
			{
				ds_list_delete(status_list, i)
			}
		}
	}
}

if(global.current_gui == gui.JOURNAL)
{
	var journal_width = 600

	draw_set_font(ft_Title)
	
	//MAIN UI
	var map_height = window_height + inv_width_slots_only
	
	var start_x = display_get_gui_width() / 2 - journal_width / 2
	var start_y = display_get_gui_height() - inv_height - window_height - pad

	var window = ui_draw_window("JOURNAL", start_x, start_y, journal_width, map_height)
	
	start_x += pad
	start_y += pad

	var info_width = 250
	var info_height = 35

	for(var i = 0; i < ds_list_size(info_list); i++)
	{
		var color = button_color
		
		if(info_selected = i) color = button_s_color
		
		var button = ui_draw_button_color(info_list[|i].name, start_x, start_y + (info_height + pad) * i, info_width, info_height, color, button_s_color, c_white, false)
		if(button[0])
		{
			info_selected = i	
		}
	}
	
	start_x += pad + info_width
	
	var title_width = journal_width - (pad * 3) - info_width
	
	ui_draw_title(info_list[|info_selected].name, start_x, start_y, title_width, info_height, menu_color, c_white, false)
	
	start_y += pad + info_height
	
	text = info_list[|info_selected].description

	box_width = title_width
	box_height = string_height(text)
	
	start_x += pad
	
	draw_text_ext(start_x, start_y, text, box_height, box_width - pad)

	//draw_text_

	//world_draw = 384
	
	//ui_draw_rectangle(start_x, start_y, world_draw, world_draw, grass_color, 1, true)
	
	//for(var i = 0; i < world; i++)
	//{
		//for(var j = 0; j < world; j++)
		//{	
			//if(!position_empty(i * tiles, j * tiles))
			//{
				//map[i,j] = 1	
			//}
		//}
	//}
	
	//for(var i = 0; i < world; i++)
	//{
		//for(var j = 0; j < world; j++)
		//{
			//if(map[i,j] == 1)
			//{
				//ui_draw_rectangle(start_x + (i * world_draw / world), start_y + (j * world_draw / world), world_draw / world, world_draw / world, object_color, 1, true)
			//}
		//}
	//}
}

if(global.current_gui == gui.LOOT)
{

}