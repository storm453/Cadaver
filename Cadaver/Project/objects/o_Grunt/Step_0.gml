event_inherited()

path_timer -= get_delta_time()

function grunt_movement(_speed)
{
	//mp_potential_step_object(o_Player.x, o_Player.y, 1, o_Collision)
	
	if(collision_line(x, y - sprite_height / 2, o_Player.x, o_Player.y, o_Collision, 0, false) != noone)
	{
		mp_potential_step_object(o_Player.x, o_Player.y, 1, o_Collision)
		
		//path = mp_potential_path_object(path, o_Player.x, o_Player.y, 1, 5, o_Collision)
		
		following = true
	}
	else
	{
		enemy_movement()
		
		following = false
	}
	
	//show_debug_message(place_meeting(x, y, o_Collision))
}

var _player_distance = distance_to_object(o_Player)

switch(state)
{
	case(grunt_state.idle):
	{
		if(_player_distance <= follow_distance)
		{
			state = grunt_state.move	
		}
	}
	break;
	
	case(grunt_state.move):
	{
		grunt_movement(1)
		
		if(_player_distance > follow_distance)
		{
			state = grunt_state.idle	
		}
	}
	break;
}