//day_factor = 1
day_factor = (-cos(global.time * time_speed) * 0.5 + 0.5)


global.time += (delta_time / 1000000)

if(keyboard_check_pressed(vk_f1))
{
	game_restart()	
	rand_seed()
}

if(keyboard_check_pressed(vk_f11))
{
	if(window_get_fullscreen()) display_set_gui_size(window_get_width(), window_get_height())
	
	window_set_fullscreen(!window_get_fullscreen())
}