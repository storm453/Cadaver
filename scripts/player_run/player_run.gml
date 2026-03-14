function player_run()
{
	input()
	movement(2)
	player_animation()
	
	if(vec_length(velocity) < walk_speed / 2) 
	{
		state = player_state.idle
	}
	
	if(!shift) state = player_state.walk
}