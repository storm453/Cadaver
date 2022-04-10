//day_factor = 1
day_factor = -sin(timer)

timer += (delta_time / 9000000) * global.time_speed

if(keyboard_check_pressed(vk_f1))
{
	game_restart()	
}
if(keyboard_check_pressed(vk_f11))
{
	window_set_fullscreen(!window_get_fullscreen())	
}