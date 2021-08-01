day_factor = -sin(timer)

timer += (delta_time / 100000000) * global.time_speed

//show_debug_message(day_factor)

if(keyboard_check_pressed(vk_f1))
{
	game_restart()	
}