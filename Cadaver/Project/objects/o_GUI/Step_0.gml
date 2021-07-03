day_factor = -sin(timer)

timer += delta_time / 1000000

if(keyboard_check_pressed(vk_f1))
{
	game_restart()	
}