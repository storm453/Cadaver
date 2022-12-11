hurt_alpha -= 0.01

draw_sprite_ext(hurt_overlay, 0, 0, 0, 1, 1, 0, c_white, hurt_alpha)

//we draw block bar
var block_bar_width = 100
var block_bar_height = 20

var block_x = display_get_gui_width() / 2 - block_bar_width / 2
var block_y = display_get_gui_height() * 0.87

if(block_time > 0)
{
	ui_draw_rectangle(block_x, block_y, block_bar_width, block_bar_height, c_black, 0.3, false)
	
	var block_show = abs(sin(7.854 * block_time)) * block_end
	
	ui_draw_rectangle(block_x, block_y, block_bar_width * (block_show * (1 / block_end)), block_bar_height, c_aqua, 1, false)
}

display_time -= get_delta_time

if(distance_to_object(current_multi) <= interact_range)
{
	var multi_line_width = 600
	
	var multi_line_draw_x = display_get_gui_width() / 2 - multi_line_width / 2
	var multi_line_draw_y = display_get_gui_height() * 0.8
	
	draw_set_color(c_white)
	draw_set_alpha(1)
	draw_line(multi_line_draw_x, multi_line_draw_y, multi_line_draw_x + multi_line_width, multi_line_draw_y)
	
	draw_set_halign(fa_middle)
	window_text(multi_line_draw_x + multi_line_width / 2, multi_line_draw_y, current_multi.block_data.name, ft_24Bold, c_white)
	draw_set_halign(fa_left)
	
	if(keyboard_check_pressed(ord("R")))
		{
			add_item(o_PlayerInventory.inv, current_multi.block_data.block_item, 1)
			instance_destroy(current_multi)
		}
	
	multi_line_draw_y += 25
	
	var multi_button_width = 200
	var multi_button_height = 75

	var multi_button_pad = 15

	var mutli_button_total_width = (multi_button_width * ds_list_size(multi_buttons_list) + (multi_button_pad * (ds_list_size(multi_buttons_list) - 1)))

	multi_line_draw_x = display_get_gui_width() / 2

	multi_line_draw_x -= mutli_button_total_width / 2

	for(var i = 0; i < ds_list_size(multi_buttons_list); i++)
	{
		//ui_draw_rectangle(multi_line_draw_x + (i * (multi_button_width + multi_button_pad)), multi_line_draw_y, multi_button_width, multi_button_height, c_white, 1, 1)
		
		var multi_button_text = multi_buttons_list[|i].text
		
		draw_set_font(ft_20)
		
		var multi_button_text_width = string_width(multi_button_text)
		var multi_sprite_scale = sprite_get_width(multi_buttons_list[|i].button_spr)
		
		var multi_button_total = multi_button_text_width + multi_sprite_scale
		
		var multi_button_x = multi_line_draw_x + (i * (multi_button_width + multi_button_pad)) + (multi_button_width / 2 - (multi_button_total / 2))
		var multi_button_y = multi_line_draw_y + multi_button_height / 2 - (multi_sprite_scale) / 2
		
		draw_sprite_ext(multi_buttons_list[|i].button_spr, 0, multi_button_x, multi_button_y, 1, 1, 0, c_white, 1)
		
		multi_button_x += multi_sprite_scale + pad

		var multi_button_y_text = multi_line_draw_y + multi_button_height / 2 - (string_height_font(multi_button_text, ft_20) / 2)

		draw_text(multi_button_x, multi_button_y_text, multi_buttons_list[|i].text)

		if(keyboard_check_pressed(ord("X")))
		{
			instance_destroy(current_multi)
		}
	}
}

//@TEMP
if(instance_exists(o_Workbench))
{
	var nearest_workbench = instance_nearest(x, y, o_Workbench)
	
	var wb_angle = point_direction(x, y, nearest_workbench.x, nearest_workbench.y)

	var wb_draw_x = display_get_gui_width() / 2
	var wb_draw_y = display_get_gui_height() / 2
	
	var ax = cos(wb_angle * 2 * pi / 360) * 800 + wb_draw_x
	var ay = -sin(wb_angle * 2 * pi / 360) * 450 + wb_draw_y
	
	if(distance_to_object(nearest_workbench) > 90) draw_sprite_ext(s_Arrow, 0, ax, ay, 1, 1, wb_angle, c_white, 0.2)
}