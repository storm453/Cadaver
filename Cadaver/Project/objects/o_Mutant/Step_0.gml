player_distance = distance_to_object(o_Player)

if(player_distance <= detection_range)
{
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

	//Move towards player
	move_towards_point(o_Player.x, o_Player.y, 1)
}
else
{
	speed = 0	
}

if(speed > 0)
{
	sprite_index = s_MutantRun	
}
else
{
	sprite_index = s_Mutant	
}