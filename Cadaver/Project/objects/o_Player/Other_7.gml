if(state == player_state.death)
{
	state = player_state.dead	
}
if(state == player_state.raise)
{
	image_index = 0

	if(vec_length(velocity) > walk_speed / 2) 
	{
		if(!shift)
		{
			goto_state(player_state.walk)
		}
		else
		{
			goto_state(player_state.run)	
		}
	}	
	else
	{
		goto_state(player_state.idle)
	}
}