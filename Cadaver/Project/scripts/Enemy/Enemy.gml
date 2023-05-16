function enemy_movement(_speed = 1)
{
	//Move towards player
	move_dir = move_towards(o_Player)
	
	
	//UNCOMMENT BELOW TO AVOID NEARBY OBSTACLES
	
	//var near = instance_nearest_notme(all)
	
	//if(near != noone)
	//{
	//	var near_dis = distance_to_object(near)
		
	//	if(near_dis == 0) near_dis = 1
		
	//	var near_dir = v2_div(move_towards(near), v2(near_dis))
	
	//	move_dir = v2_sub(move_dir, near_dir)
	//}

	if(!place_meeting(x + move_dir.x * _speed, y, o_Collision))
	{
		x += move_dir.x * _speed
	}
	if(!place_meeting(x, y + move_dir.y * _speed, o_Collision))
	{
		y += move_dir.y	* _speed
	}
}