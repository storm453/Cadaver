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
	
	//draw clock
	var _time_x = edge_pad
	var _time_y = edge_pad

	draw_set_alpha(1)
	
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
	
	//crafting
	var _craft_cell_size = 80
	var _craft_cells_x = 8
	var _craft_cells_y = 5
	var _craft_cell_pad = 20
	
	var _middle_margin = 300
	
	var _craft_x = display_get_gui_width() / 2 - ((_craft_cells_x * _craft_cell_size) + (i - 1 * _craft_cell_pad)) - _middle_margin
	var _craft_y = 300
	
	for(var i = 0; i < _craft_cells_x; i++)
	{
		for(var j = 0; j < _craft_cells_y; j++)
		{
			var _craft_ix = _craft_x + ((_craft_cell_size + _craft_cell_pad) * i)
			var _craft_iy = _craft_y + ((_craft_cell_size + _craft_cell_pad) * j)
			
			ui_draw_rectangle(_craft_ix, _craft_iy, make_rectangle(_craft_cell_size, _craft_cell_size, c_black, 0.5, false))
		}
	}
	
}
if(global.current_gui == gui.CONTAINER)
{
	current_ui(global.open_instance.block_data.name)
}