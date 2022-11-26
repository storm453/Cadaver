//day_factor = 1
global.time += get_delta_time()

function brzeczszyszrzkiewicz_curve(time_dr_freeman)
{
	return -cos(pi / 2 + (pi / 2 * min(1, max(-1, cos(pi * time_dr_freeman / 1440) * steepness)))) * 0.5 + 0.5
}

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

day_factor = 1 - brzeczszyszrzkiewicz_curve(global.time * 50)