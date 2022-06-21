function infected_idle()
{
	infected_animation()
	
	if(player_distance < chase_distance) current_state = state.move
}