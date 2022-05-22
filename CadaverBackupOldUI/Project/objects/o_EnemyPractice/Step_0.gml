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
	var diff_x = o_Player.x - x
	var diff_y = o_Player.y - y
	
	var length = sqrt(diff_x * diff_x + diff_y * diff_y)
	
	var dir_x = diff_x / length
	var dir_y = diff_y / length
	
	x += dir_x * -1
	y += dir_y * -1
}

if(v2_length(move_dir) > 0)
{
	sprite_index = s_MutantRun	
}
else
{
	sprite_index = s_Mutant	
}