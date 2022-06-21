function infected_animation()
{
	sprite = sprites_array[current_state]
	
	sprite_index = sprite
	
	//Face the player
	var sign_mouse = sign(o_Player.x - x)

	if(sign_mouse == 0) 
	{
		sign_mouse = 1
	}

	if(sign_mouse != 0)
	{
		image_xscale = sign_mouse;	
	}
}