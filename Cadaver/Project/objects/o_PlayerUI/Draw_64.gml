var hp_x = 10;
var hp_y = 10;

var bar_draw = 3

hp_show = lerp(hp_show, o_Player.hp, 0.2);

var hp_w = (hp_show/100)* sprite_get_width(s_HealthBar)
var hp_h = sprite_get_height(s_HealthBar);

draw_sprite_ext(s_HealthBar, 0, hp_x, hp_y, bar_draw, bar_draw, 0, c_white, 1)
draw_sprite_part_ext(s_HealthBar, 1, 0, 0, hp_w, hp_h, hp_x, hp_y, bar_draw, bar_draw, c_white, 1)

//energy bar
hp_y += hp_h * bar_draw + pad

energy_show = lerp(energy_show, o_Player.energy, 0.2);

var en_w = (energy_show/100)* sprite_get_width(s_HealthBar)
var en_h = sprite_get_height(s_HealthBar);

draw_sprite_ext(s_EnergyBar, 0, hp_x, hp_y, bar_draw, bar_draw, 0, c_white, 1)
draw_sprite_part_ext(s_EnergyBar, 1, 0, 0, en_w, en_h, hp_x, hp_y, bar_draw, bar_draw, c_white, 1)

draw_set_font(ft_Default)

#macro pad 5

#macro switch_button_scale 64

#macro title_button_width 128
#macro title_button_height 32

if(global.current_gui  != 0)
{	
	var inv_width = round(o_PlayerInventory.slots_x * o_PlayerInventory.draw_scale * o_PlayerInventory.slot_size) - 1
	var inv_width_slots_only = o_PlayerInventory.player_inventory_height_slots_only
	var inv_height = o_PlayerInventory.player_inventory_height
	var window_width = inv_width
	var window_height = 300

	var buttons = 3
	var menu_scale = 0;
	
	repeat(round(buttons))
	{
		menu_scale += pad + switch_button_scale
	}
	
	menu_scale += pad

	draw_set_font(ft_Title)
	var title = "THING";
	var title_height = string_height(title) + pad * 2
	
	var switch_x = display_get_gui_width() / 2 - (menu_scale + menu_scale / 4) / 2
	var switch_y = 0
	
	ui_draw_title(selected_tab, switch_x, switch_y, menu_scale + menu_scale / 4, title_height, tab_color, c_white, false)
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
		selected_tab = "CRAFTING"
	}	
	
	if(button_array[1][0])
	{
		global.current_gui = gui.PROFILE
		selected_tab = "PROFILE"
	}
	
	if(button_array[2][0])
	{
		global.current_gui = gui.CRAFTING
		selected_tab = "MAP"
	}
}

function ui_draw_window(t, sx, sy, w, h)
{
	ui_draw_rectangle(sx, sy, w, h, menu_color, 1, false)
	
	var title_height = string_height_font(t, ft_Title)
	
	sy -= title_height + pad * 2
	
	ui_draw_rectangle(sx, sy, w, pad * 2 + title_height, tab_color, 1, false);
	ui_draw_string(sx + pad, sy + pad, t, ft_Title) 
		
	return title_height + pad * 3
}

if(global.current_gui == gui.INVENTORY)
{
	//MAIN UI
	var start_x = display_get_gui_width() / 2 - inv_width / 2
	var start_y = display_get_gui_height() - inv_height - window_height - pad

	var title = "INVENTORY";
	var font_height = string_height_font(title, ft_Title)
	var title_height = font_height + pad * 2
		
	window_height -= title_height

	start_y = display_get_gui_height() - inv_height - title_height
	
	ui_draw_rectangle(start_x, start_y, window_width, title_height, tab_color, 1, false)
	ui_draw_string(start_x + pad, start_y + pad, title, ft_Title)

	var craft_height = 400

	start_y = display_get_gui_height() - inv_height - craft_height - title_height - pad
	
	ui_draw_window("CRAFTING", start_x, start_y, window_width, craft_height)
	
	#macro list_button_scale 50
	
	#macro item_button_width 160
	#macro item_button_height 35
	
	var buttons_x = display_get_gui_width() / 2 - inv_width / 2
	var buttons_y = display_get_gui_height() - inv_height - craft_height - title_height - pad
	
	var list_x = display_get_gui_width() / 2 - inv_width / 2 
	var list_y = display_get_gui_height() - inv_height - craft_height - title_height - pad
	
	buttons_x += pad
	list_x += pad
	
	buttons_x += inv_width / 2 - ds_list_size(buttons_list) * (list_button_scale + pad) / 2 - pad
	buttons_y += pad
	
	for(i = 0; i < ds_list_size(buttons_list); i++)
	{
		var index = buttons_list[|i]
		
		var button = ui_draw_button_sprite(sTab, index[0], buttons_x + (list_button_scale + pad) * i, buttons_y, list_button_scale, list_button_scale, button_color, button_s_color, c_white, 0.07, false)
		if(button[0])
		{
			crafting_tab = index[1]
			selected_list = index[2]
			selected_item = 0
		}
	}
	
	list_y += list_button_scale + pad * 2
	
	ui_draw_title(crafting_tab, list_x, list_y, inv_width - (pad * 2), item_button_height, menu_color, c_white, false)
	
	list_y += item_button_height + pad

	if(ds_list_size(selected_list) > 0)
	{
		for(var i = 0; i < ds_list_size(selected_list); i++)
		{
			if(selected_item == i)
			{
				var button = ui_draw_button_color(o_InventoryBase.items_list[selected_list[|i][0]].name, list_x, list_y + (i * (item_button_height + pad)), item_button_width, item_button_height, button_s_color, button_s_color, c_white, false)
			}
			else
			{
				var button = ui_draw_button_color(o_InventoryBase.items_list[selected_list[|i][0]].name, list_x, list_y + (i * (item_button_height + pad)), item_button_width, item_button_height, button_color, button_s_color, c_white, false)	
			}
			
			if(button[0])
			{
				selected_item = i	
				//var check = check_item(1,2)
				//show_debug_message(check)
			}
		}
	}
	
	list_x += item_button_width + pad
	
	var sprite_scale = 5
	
	//THIS IS INCREDIBLY JANK PLEAASE CHANGE THIS SOON ADAM GODAMN
	if(ds_list_size(selected_list) > 0)
	{
		ui_draw_rectangle(list_x, list_y, sprite_get_width(s_Items) * sprite_scale, sprite_get_height(s_Items) * sprite_scale, button_color, 1, false)
	
		draw_sprite_ext(s_Items, o_InventoryBase.items_list[selected_list[|selected_item][0]].spr_index, list_x, list_y, sprite_scale, sprite_scale, 0, c_white, 1)
	
		list_x += sprite_get_width(s_Items) * sprite_scale + pad
	
		ui_draw_string(list_x, list_y, "CRAFTABLE: " + string(o_InventoryBase.items_list[selected_list[|selected_item][0]].name), ft_Default)
	
		list_y += string_height("Z") + pad
	
		for(var i = 0; i < array_length_1d(selected_list[|selected_item][1]); i++)
		{
			ui_draw_string(list_x, list_y, string(selected_list[|selected_item][1][i].mat) + "x " + string(o_InventoryBase.items_list[selected_list[|selected_item][1][i].iid].name), ft_Default)
			
			list_y += string_height("Z") + pad
		}
	}
	
}


if(global.current_gui == gui.PROFILE)
{
	var prof_width = inv_width * 2
	var prof_height = window_height + inv_width_slots_only
	
	//MAIN UI
	var start_x = display_get_gui_width() / 2 - prof_width / 2
	var start_y = display_get_gui_height() - inv_height - window_height - pad

	ui_draw_window("PROFILE", start_x, start_y, prof_width, prof_height)
}

if(global.current_gui == gui.CRAFTING)
{
	draw_set_font(ft_Title)
	
	//MAIN UI
	var map_height = window_height + inv_width_slots_only
	
	var start_x = display_get_gui_width() / 2 - inv_width / 2
	var start_y = display_get_gui_height() - inv_height - window_height - pad

	var window = ui_draw_window("MAP", start_x, start_y, window_width, map_height)
	
	start_x += pad
	start_y += pad
	
	world_draw = 384
	
	ui_draw_rectangle(start_x, start_y, world_draw, world_draw, grass_color, 1, true)
	
	for(var i = 0; i < world; i++)
	{
		for(var j = 0; j < world; j++)
		{	
			if(!position_empty(i * tiles, j * tiles))
			{
				map[i,j] = 1	
			}
		}
	}
	
	for(var i = 0; i < world; i++)
	{
		for(var j = 0; j < world; j++)
		{
			if(map[i,j] == 1)
			{
				ui_draw_rectangle(start_x + (i * world_draw / world), start_y + (j * world_draw / world), world_draw / world, world_draw / world, object_color, 1, true)
			}
		}
	}
}