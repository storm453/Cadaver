//day_factor = 1
day_factor = -cos(timer) * 0.5 + 0.5

show_debug_message(day_factor)

timer += (delta_time / 10000000) * time_speed

if(keyboard_check_pressed(vk_f1))
{
	game_restart()	
}
if(keyboard_check_pressed(vk_f11))
{
	window_set_fullscreen(!window_get_fullscreen())	
}