if(state == player_state.attack)
{
	goto_state(player_state.idle)
}
if(state == player_state.death)
{
	state = player_state.dead	
}