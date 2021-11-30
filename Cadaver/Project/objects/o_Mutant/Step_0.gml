player_distance = distance_to_object(o_Player)

z = -bbox_bottom

var move_dir = v2(0)

if(player_distance <= 256)
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
	move_dir = move_towards(o_Player)
	
	var near = instance_nearest_notme(all)
	
	if(near != -4)
	{
		var near_dis = distance_to_object(near)
		
		if(near_dis == 0) near_dis = 1
		
		var near_dir = v2_div(move_towards(near), v2(near_dis))
	
		move_dir = v2_sub(move_dir, near_dir)
	}
	
	x += move_dir.x
	y += move_dir.y
}

if(v2_length(move_dir) > 0)
{
	sprite_index = s_MutantRun	
}
else
{
	sprite_index = s_Mutant	
}