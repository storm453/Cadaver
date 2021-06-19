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
	
	repeat(buttons)
	{
		menu_scale += pad + switch_button_scale
	}
	
	menu_scale += pad

	var switch_x = display_get_gui_width() / 2 - menu_scale / 2
	var switch_y = 0

	ui_draw_rectangle(switch_x, switch_y, menu_scale, 50, c_red, 1, false)

	ui_draw_button_color("H", switch_x, switch_y, switch_button_scale, switch_button_scale, button_color, button_s_color, c_white, false)

	switch_x -= pad + switch_button_scale
	
	ui_draw_button_color("H", switch_x, switch_y, switch_button_scale, switch_button_scale, button_color, button_s_color, c_white, false)
}

if(global.current_gui == gui.CRAFTING)
{
	draw_set_font(ft_Title)
	
	//MAIN UI
	var start_x = display_get_gui_width() / 2 - inv_width / 2
	var start_y = display_get_gui_height() - inv_height - window_height - pad

	var title = "INVENTORY";
	var title_height = string_height(title) + pad * 2
	
	window_height -= title_height

	start_y = display_get_gui_height() - inv_height - title_height
	
	ui_draw_rectangle(start_x, start_y, window_width, title_height, 0x171717, 1, false)

	draw_text(start_x + pad, start_y + pad, title)

	start_y = display_get_gui_height() - inv_height - window_height - title_height - pad

	ui_draw_rectangle(start_x, start_y, window_width, window_height, menu_color, 1, false)
}

if(global.current_gui == gui.PROFILE)
{
	var prof_width = inv_width * 2
	var prof_height = window_height + inv_width_slots_only
	
	//MAIN UI
	var start_x = display_get_gui_width() / 2 - prof_width / 2
	var start_y = display_get_gui_height() - inv_height - window_height - pad

	ui_draw_rectangle(start_x, start_y, prof_width, prof_height, menu_color, 1, false)

	draw_set_font(ft_Title)

	var title = "PROFILE";
	var title_height = string_height(title)
	
	ui_draw_rectangle(start_x, start_y, prof_width, pad * 2 + title_height, 0x171717, 1, false);

	draw_text(start_x + pad, start_y + pad, title)
}

draw_set_font(ft_Default)