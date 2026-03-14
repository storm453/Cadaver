event_inherited()

path_timer -= get_delta_time()

var _player_distance = distance_to_object(o_Player)
var _player_ray = collision_line(x, y - sprite_height / 2, o_Player.x, o_Player.y, o_Collision, 0, false)
var _player_direction = point_direction(x, y, o_Player.x, o_Player.y)

if(_player_ray == noone)
{
	player_last_seen.x = o_Player.x
	player_last_seen.y = o_Player.y	
}

attack_circle_points = circle_point(x, y - sprite_height / 2, attack_radius, _player_direction)

function goto_state(_state)
{
	state = _state
	
	switch(_state)
	{
		case(grunt_state.charge):
		{
			state_timer_next = grunt_state.attack
			state_timer = 1
			state_timer_enabled = true
		}
		break;
		
		case(grunt_state.attack):
		{
			dash_timer = 0
			state_timer_next = grunt_state.rest
			state_timer = 0.4
			state_timer_enabled = true
		}
		break;
		
		case(grunt_state.rest):
		{
			state_timer_next = grunt_state.idle
			state_timer = 3
			state_timer_enabled = true
		}
		break;
	}
}

switch(state)
{
	case(grunt_state.idle):
	{
		if(_player_distance <= follow_distance)
		{
			goto_state(grunt_state.move)
		}
	}
	break;
	
	case(grunt_state.move):
	{
		target_velocity = move_towards(o_Player)
		
		target_velocity.x *= grunt_speed
		target_velocity.y *= grunt_speed
		
		if(_player_distance > follow_distance)
		{
			goto_state(grunt_state.idle)	
		}
		if(_player_ray != noone)
		{
			goto_state(grunt_state.path)	
		}
		
		if(_player_ray == noone)
		{
			if(_player_distance <= attack_distance)
			{
				goto_state(grunt_state.charge)
			}
		}
	}
	break;
	
	case(grunt_state.path):
	{
		enemy_path()	
		
		if(_player_distance > follow_distance)
		{
			goto_state(grunt_state.idle)
		}
		if(_player_ray == noone)
		{
			goto_state(grunt_state.move)
		}
	}
	break;
	
	case(grunt_state.attack):
	{
		dash_timer += get_delta_time()
		
		var _diff_x = player_last_seen.x - x
		var _diff_y = player_last_seen.y - y
		
		var _norm = sqrt(_diff_x * _diff_x + _diff_y * _diff_y)
		
		var _add_x = _diff_x / _norm * attack_speed 
		var _add_y = _diff_y / _norm * attack_speed
		
		if(!place_meeting(x + _add_x, y, o_Collision))
		{
			target_velocity.x = _add_x
		}
		if(!place_meeting(x, y + _add_y, o_Collision))
		{
			target_velocity.y = _add_y
		}
		
		var _did_damage = damage_circle(attack_circle_points.x, attack_circle_points.y, attack_radius, 1)
		
		if(_did_damage)
		{
			goto_state(grunt_state.rest)
		}
	}
	break;
	
	case(grunt_state.rest):
	{
		delta_dampen(target_velocity, 0.7)
	}
	break;
	
	case(grunt_state.charge):
	{
		delta_dampen(target_velocity, 0.9)
	}	
	break;
}

var _acc = acc

if(state == grunt_state.attack)
{
	if(dash_timer > 0.05)
	{
		_acc = 1
	}
}

velocity.x += (target_velocity.x - velocity.x) * _acc * get_delta_time()
velocity.y += (target_velocity.y - velocity.y) * _acc * get_delta_time()