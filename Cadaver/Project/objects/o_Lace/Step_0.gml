event_inherited()

image_xscale = -sign(velocity.x)

var _player_distance = distance_to_object(o_Player)

function goto_state(_state)
{
	state = _state
	set_animation(animation_array[state])
	
	switch(_state)
	{
		case(lace_state.charge):
		{
			state_timer_next = lace_state.attack
			state_timer = charge_time
			state_timer_enabled = true
		}
		break;
		
		case(lace_state.attack):
		{
			state_timer_next = lace_state.rest
			state_timer = attack_time
			state_timer_enabled = true
		}
		break;

		case(lace_state.rest):
		{
			state_timer_next = lace_state.roam
			state_timer = 1
			state_timer_enabled = true
		}
		break;
	}
}

step_animation()

switch(state)
{
	case(lace_state.idle):
	{
		delta_dampen(target_velocity, 0.4)
		
		if(chance(idle_chance))
		{
			goto_state(lace_state.roam)
		}
		if(_player_distance <= chase_distance)
		{
			goto_state(lace_state.chase)
		}
	}
	break;

	case(lace_state.roam):
	{
		if(distance_to_point(roam_target.x, roam_target.y) <= 15)
		{
			new_roam()	
		}

		target_velocity = move_towards(roam_target)

		target_velocity.x *= lace_speed
		target_velocity.y *= lace_speed
		
		if(_player_distance <= chase_distance)
		{
			goto_state(lace_state.chase)
		}
		if(chance(idle_chance))
		{
			goto_state(lace_state.idle)
		}
	}
	break;

	case(lace_state.chase):
	{
		target_velocity = move_towards(o_Player)
		
		target_velocity.x *= lace_speed
		target_velocity.y *= lace_speed

		if(_player_distance <= charge_distance)
		{
			goto_state(lace_state.charge)
		}
		if(_player_distance > chase_distance)
		{
			goto_state(lace_state.roam)
		}
	}
	break;

	case(lace_state.charge):
	{
		delta_dampen(target_velocity, 0.4)

		player_angle = point_direction(x, y, o_Player.x, o_Player.y)
	}
	break;

	case(lace_state.rest):
	{
		delta_dampen(target_velocity, 0.1)
	}
	break;

	case(lace_state.attack):
	{
		target_velocity.x = dcos(player_angle) * 200
		target_velocity.y = -dsin(player_angle) * 200

		var _attack_circle = circle_point(x, y, 10, player_angle)

		var _attack = damage_circle(_attack_circle.x, _attack_circle.y, 15, 4)

		if(_attack)
		{
			goto_state(lace_state.rest)
		}
	}
	break;
}

velocity.x += (target_velocity.x - velocity.x) * acc * get_delta_time()
velocity.y += (target_velocity.y - velocity.y) * acc * get_delta_time()