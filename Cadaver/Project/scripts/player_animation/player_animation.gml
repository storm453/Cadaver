function player_animation() 
{
	sprite_index = sprites_array[state]

	//exceptions go here!
	if(global.hotbar_sel_item != 0) sprite_index = s_PlayerAttack

	//in water
	var near_x = floor(o_Player.x / chunk_size) * chunk_size
	var near_y = floor(o_Player.y / chunk_size) * chunk_size

	var chunk = instance_nearest(near_x, near_y, o_Chunk)
	
	var block = chunk.grid[# floor((x - chunk.x) / tile_size), floor((y - chunk.y) / tile_size)]
	
	//music manager	
	if(block == tile.water)
	{
		sprite_index = s_PlayerSwim
	}
	
	function volume(arg_x)
	{
		if(arg_x < 3)
		{
			return arg_x / 3;	
		}
		else
		{
			return 1;	
		}
	}

	if(songs[block] == current_song)
	{
		audio_state += (delta_time / 1000000) * 2
		
		if(audio_state > 10) audio_state = 10
	}
	else
	{
		audio_state -= (delta_time / 1000000) * 2
		
		if(audio_state <= 0) 
		{
			audio_state = 0
			
			audio_stop_sound(current_song)
		}
	}
	
	if(audio_state == 0)
	{
		current_song = songs[block]	
		
		audio_play_sound(current_song, 0, 1)
	}
	
	audio_sound_gain(current_song, volume(audio_state), 0)
	
	//image_xscale and sacaling
	var sign_mouse = sign(mouse_x - x)

	if(sign_mouse == 0) 
	{
		sign_mouse = 1
	}

    if(in_x != 0 && sign(in_x) != sign_mouse) 
	{
		image_speed = -1
	}
	else {
		image_speed = 1
	}
	
	if(sign_mouse != 0)
	{
		image_xscale = sign_mouse;	
	}
}