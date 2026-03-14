var _fly_distance = distance_to_point(fly_target.x, fly_target.y)

switch(state)
{
	case(volant_state.fly):
	{
		if(_fly_distance <= 10)
		{
			var _point = circle_point(o_Player.x, o_Player.y, choose(100, 115), random(360))
			
			fly_target.x = _point.x
			fly_target.y = _point.y
			
			if(chance(0.5))
			{
				state = volant_state.attack
				//goto_state(volant_state.attack)
			}
		}
		
		var _move = move_towards(fly_target)
		
		velocity.x += (_move.x * fly_speed - velocity.x) * acc * get_delta_time()
		velocity.y += (_move.y * fly_speed - velocity.y) * acc * get_delta_time()
	}
	break;
}