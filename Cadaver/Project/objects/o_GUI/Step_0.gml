//day_factor = 1
day_factor = (-cos(global.time * time_speed) * 0.5 + 0.5)

global.time += (delta_time / 1000000)

if(keyboard_check_pressed(vk_f1))
{
	game_restart()	
}