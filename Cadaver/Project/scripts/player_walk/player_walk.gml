function player_walk()
{
	input()
	movement()
	player_animation()
	
	if(vec_length(velocity) < walk_speed / 2) 
	{
		state = player_state.idle
	}
	
	if(shift) state = player_state.run
}