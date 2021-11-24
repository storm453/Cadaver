//day_factor = 1
day_factor = -sin(timer)

timer += (delta_time / 9000000) * global.time_speed

//day
if(day_factor <= 0.2)
{
	audio_sound_gain(msc_night, 0, 600)
	
	if(time_music == 0)
	{
		time_music = 1
		
		audio_play_sound(msc_day, 1, 1)
		audio_sound_gain(msc_day, 1, 600)
	}
	
	if(audio_sound_get_gain(msc_night) == 0) audio_stop_sound(msc_night)
}

//night
if(day_factor >= 0.4)
{
	audio_sound_gain(msc_day, 0, 600)	
	
	if(time_music == 1)
	{
		time_music = 0
		
		audio_stop_sound(msc_day)
		audio_play_sound(msc_night, 1, 1)
		audio_sound_gain(msc_night, 1, 600)
	}
	
	if(audio_sound_get_gain(msc_day) == 0) audio_stop_sound(msc_day)
}

//show_debug_message(timer)
//show_debug_message(day_factor)

if(keyboard_check_pressed(vk_f1))
{
	game_restart()	
}