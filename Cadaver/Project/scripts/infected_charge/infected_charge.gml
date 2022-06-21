function infected_charge()
{
	infected_animation()
	infected_movement(0)

	charged++

	if(charged >= 60)
	{
		current_state = state.attack

		charged = 0
	}
}