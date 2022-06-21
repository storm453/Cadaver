function infected_move()
{
	infected_animation()
	infected_movement()
	
	if(player_distance > chase_distance) current_state = state.idle
	
	if(player_distance <= attack_distance) 
	{
		current_state = state.charging
	}
}