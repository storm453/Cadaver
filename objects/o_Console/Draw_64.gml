if(keyboard_check_pressed(vk_f9))
{
	open = !open	
	keyboard_string = ""
	typing = ""
}

if(open)
{
	var _console_box_height = 400 * global.res_fix
	var _type_box_height = 60 * global.res_fix
	
	var _console_box = make_rectangle(display_get_gui_width(), _console_box_height, c_dkgray, 0.7, false, s_PanelGray)
	
	ui_draw_rectangle(0, 0, _console_box)
	
	var _type_box_y = _console_box_height - _type_box_height
	
	var _type_box = make_rectangle(display_get_gui_width(), _type_box_height, c_black, 1, false, s_BarBack)
	
	ui_draw_rectangle(0, _type_box_y, _type_box)

	draw_text(0, _type_box_y, typing)

	var _cursor_x = string_width(string_copy(typing, 0, typing_cursor))
	var _cursor_h = string_height(typing)
	
	draw_set_color(c_orange)
	draw_set_alpha(1)
	draw_line(_cursor_x, _type_box_y, _cursor_x, _type_box_y + _cursor_h)
	
	var  _output_y = _type_box_y - _type_box_height
	
	for(var i = ds_list_size(output) - 1; i >= 0; i--)
	{
		draw_text(0, _output_y, output[|i])
		
		_output_y -= _type_box_height
	}
	
	if(keyboard_string != "")
	{
		typing = string_insert(keyboard_string, typing, typing_cursor + 1)
		typing_cursor += string_length(keyboard_string)
		keyboard_string = ""
	}
	if(keyboard_check_pressed(vk_backspace))
	{
		typing = string_delete(typing, typing_cursor, 1)
		typing_cursor--
	}
	
	if(keyboard_check_pressed(vk_left)) typing_cursor--
	if(keyboard_check_pressed(vk_right)) typing_cursor++
	
	typing_cursor = clamp(typing_cursor, 0, string_length(typing))
	
	if(keyboard_check_pressed(vk_enter))
	{
		parse_command(typing)
		
		typing = ""
		typing_cursor = 0
	}
}