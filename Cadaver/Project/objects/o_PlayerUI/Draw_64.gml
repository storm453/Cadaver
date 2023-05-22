if(global.current_gui != gui.NONE)
{
	ui_draw_rectangle(0, 0, make_rectangle(display_get_gui_width(), display_get_gui_height(), c_black, 0.5, false))
}

var do_hud = false

for(var i = 0; i < ds_list_size(draw_hud); i++)
{
	if(global.current_gui == draw_hud[|i]) do_hud = true	
}

if(do_hud)
{
	//draw hud elements in here	
	
	//temperature
	var _therm_scale = 3 * global.res_fix
	var _therm_size = sprite_get_width(s_Thermometer) * _therm_scale
	
	var _therm_x = display_get_gui_width() - edge_pad - (_therm_size / 2)
	var _therm_y = display_get_gui_height() - edge_pad - (_therm_size / 2)
	
	draw_sprite_ext(s_Thermometer, 0, _therm_x, _therm_y, _therm_scale, _therm_scale, 0, c_white, 1)
	
	var _therm_needle_dir = (global.temperature / 100) * 360
	
	draw_sprite_ext(S_ThermometerNeedle, 0, _therm_x, _therm_y, _therm_scale, _therm_scale, _therm_needle_dir, c_white, 1)
	
	//backpack and crafting icons
	var _icon_scale = 3 * global.res_fix
	var _icon_size = sprite_get_width(s_Backpack) * _icon_scale
	var _icon_y_margin = 80 * global.res_fix
	
	var _icon_x = edge_pad + _icon_size / 2
	var _icon_y = display_get_gui_height() - _icon_y_margin
	
	var _icon_label_w = 100
	var _icon_label_h = 25
	
	for(var i = 0; i < array_length_1d(icons); i++)
	{
		_icon_x += (edge_pad + _icon_size) * i
		
		draw_sprite_ext(icons[i].icon, 0, _icon_x, _icon_y, _icon_scale, _icon_scale, 0, c_white, 1)
		
		var _label_x = _icon_x - _icon_label_w / 2
		var _label_y = _icon_y - _icon_size / 2 - _icon_label_h / 2
		
		var _icon_label = make_rectangle(_icon_label_w, _icon_label_h, c_white, 1, false, s_PanelGray)
		ui_draw_title(_label_x, _label_y, _icon_label, make_text(icons[i].label, c_white, ft_IconLabel))
		
		var _key_x = _icon_x
		var _key_y = _icon_y + _icon_size / 2
		
		draw_sprite_ext(icons[i].key, 0, _key_x, _key_y, 3, 3, 0, c_white, 1)
	}
	
	//now we draw health bar
	var _bar_width = 600 * global.res_fix
	var _bar_height = 45 * global.res_fix
	
	var _bar_x = display_get_gui_width() / 2 - (_bar_width / 2)
	var _bar_y = edge_pad
	
	var _hp_width = (o_Player.hp / 10) * _bar_width
	
	ui_draw_rectangle(_bar_x, _bar_y, make_rectangle(_bar_width, _bar_height, c_white, 1, false, s_BarBack))
	ui_draw_rectangle(_bar_x, _bar_y, make_rectangle(_hp_width, _bar_height, c_white, 1, false, s_HPBar))
	
	//draw clock
	var _time_x = edge_pad
	var _time_y = edge_pad

	draw_set_alpha(1)
	draw_set_font(ft_Time)
	
	var _day = floor(global.time / 60 / 24)
	
	draw_text_outline(_time_x, _time_y, color_hex(0x696f80), c_white, "Day " + string(_day + 1), ft_Time)
	
	_time_y += string_height_font("Day", ft_Time) + 4
	
	var _hours = floor(global.time / 60) % 24
	var _minutes = floor(global.time % 60)
	
	function pad_left(_string, _length, _fill)
	{
		for(var i = string_length(_string); i < _length; i++)
		{
			_string = _fill + _string
		}
		
		return _string
	}
	
	draw_text_outline(_time_x, _time_y, color_hex(0x696f80), color_hex(0xeecb90), pad_left(string(_hours), 2, "0") + ":" + pad_left(string(_minutes), 2, "0"), ft_Time)
}

function current_ui(_string)
{
	var _x = display_get_gui_width() / 2 - string_width_font(_string, ft_CurrentUI) / 2
	var _y = string_height_font(_string, ft_CurrentUI) / 2
	
	draw_set_color(c_white)
	draw_set_alpha(1)
	draw_set_font(ft_CurrentUI)
	draw_text(_x, _y, _string)
}

if(global.current_gui == gui.INVENTORY)
{
	current_ui("Inventory")		
}
if(global.current_gui == gui.CRAFT)
{
	current_ui("Crafting")
}
if(global.current_gui == gui.CONTAINER)
{
	current_ui(global.open_instance.block_data.name)
}