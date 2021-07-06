if(state = player_state.idle)
{
	input()
	movement()
	player_animation()
	
	if(vec_length(velocity) > walk_speed / 2) 
	{
		state = player_state.run
	}
}

if(state == player_state.run)
{
	input()
	movement()
	player_animation()
	
	if(vec_length(velocity) < walk_speed / 2) 
	{
		state = player_state.idle
	}
}

attack_cooldown--