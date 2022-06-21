function player_idle()
{
	input()
	movement()
	player_animation()
	
	if(vec_length(velocity) > walk_speed / 2) 
	{
		if(!shift)
		{
			state = player_state.walk
		}
		else
		{
			state = player_state.run	
		}
	}
}