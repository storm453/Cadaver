global.res_fix = display_get_gui_width() / 1920

room_speed = 999

global.time += get_delta_time() * 60

if(keyboard_check_pressed(vk_f1)) 
{
	game_restart()
	rand_seed()
}

if(keyboard_check_pressed(vk_f11))
{
	window_set_fullscreen(!window_get_fullscreen())

	//display_set_gui_maximize(display_get_gui_width() / 1920, display_get_gui_height() / 1080)
	
}

display_set_gui_size(window_get_width(), window_get_height())

day_factor = (cos(global.time / (24 * 60) * 2 * pi) * 0.5 + 0.5)

//graph
history[history_head] = delta_time
history_head++
history_head %= array_length(history)