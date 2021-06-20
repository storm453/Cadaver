//health bar
draw_set_font(ft_Title)

var hp_x = 10;
var hp_y = 10;

hp_show = lerp(hp_show, o_Player.hp, 0.2);

var hp_w = sprite_get_width(s_HealthBar);
var hp_h = (hp_show/100)*sprite_get_height(s_HealthBar);

draw_sprite(s_HealthBar, 1, hp_x, hp_y);
draw_sprite_part(s_HealthBar, 0, 0, 0, hp_w, hp_h, hp_x, hp_y);

draw_set_color(c_white)
draw_text(hp_x + string_width(o_Player.hp) / 2 - 1, hp_y + string_height(o_Player.hp) / 3, o_Player.hp)

//energy bar
var energy_x = hp_x + pad + sprite_get_width(s_HealthBar)

energy_show = lerp(energy_show, o_Player.energy, 0.2);

var energy_w = sprite_get_width(s_HealthBar)
var energy_h = (energy_show / 100) * sprite_get_height(s_HealthBar);

draw_sprite(s_EnergyBar, 1, energy_x, hp_y);
draw_sprite_part(s_EnergyBar, 0, 0, 0, energy_w, energy_h, energy_x, hp_y)

draw_text(energy_x + string_width(o_Player.energy) / 2 - 1, hp_y + string_height(o_Player.energy) / 3, o_Player.energy)

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
	
	draw_set_font(ft_Title)

	var title_height = string_height(t)
	
	ui_draw_rectangle(sx, sy, w, pad * 2 + title_height, tab_color, 1, false);

	draw_text(sx + pad, sy + pad, t)
	
	return title_height + pad * 3
}

if(global.current_gui == gui.INVENTORY)
{
	draw_set_font(ft_Title)
	
	//MAIN UI
	var start_x = display_get_gui_width() / 2 - inv_width / 2
	var start_y = display_get_gui_height() - inv_height - window_height - pad

	var title = "INVENTORY";
	var title_height = string_height(title) + pad * 2
	
	window_height -= title_height

	start_y = display_get_gui_height() - inv_height - title_height
	
	ui_draw_rectangle(start_x, start_y, window_width, title_height, tab_color, 1, false)

	draw_text(start_x + pad, start_y + pad, title)

	start_y = display_get_gui_height() - inv_height - window_height - title_height - pad

	//Draw stuff here..
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
	start_y += window
	
	world_draw = map_height - string_height("M") - pad  * 4
	
	ui_draw_rectangle(start_x + window_width / 2 - world_draw / 2, start_y, world_draw, world_draw, grass_color, 1, true)
	
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

draw_set_font(ft_Default)