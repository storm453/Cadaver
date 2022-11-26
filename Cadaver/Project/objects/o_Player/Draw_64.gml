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

if(instance_exists(o_Infected))
{
	var nearest_workbench = instance_nearest(x, y, o_Infected)
	
	var wb_angle = point_direction(x, y, nearest_workbench.x, nearest_workbench.y)

	var wb_draw_x = display_get_gui_width() / 2
	var wb_draw_y = display_get_gui_height() / 2
	
	var ax = cos(wb_angle * 2 * pi / 360) * 800 + wb_draw_x
	var ay = -sin(wb_angle * 2 * pi / 360) * 450 + wb_draw_y
	
	if(distance_to_object(nearest_workbench) > 90) draw_sprite_ext(s_RedArrow, 0, ax, ay, 1, 1, 0, c_white, 0.8)
}