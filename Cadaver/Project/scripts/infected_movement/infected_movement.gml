function infected_movement(spd = 1)
{
	//Move towards player
	move_dir = move_towards(o_Player)
	
	var near = instance_nearest_notme(all)
	
	if(near != noone)
	{
		var near_dis = distance_to_object(near)
		
		if(near_dis == 0) near_dis = 1
		
		var near_dir = v2_div(move_towards(near), v2(near_dis))
	
		move_dir = v2_sub(move_dir, near_dir)
	}
	
	var len = v2_length(v2(enemy_data.arg_knock_x, enemy_data.arg_knock_y));
	
	if (len > 0.1)
		move_dir = v2(0, 0);
	
	x += move_dir.x * spd + enemy_data.arg_knock_x
	y += move_dir.y	* spd + enemy_data.arg_knock_y
	
	enemy_data.arg_knock_x *= 0.9
	enemy_data.arg_knock_y *= 0.9
}