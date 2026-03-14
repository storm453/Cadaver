event_inherited()

var _to_infect = noone

for(var i = 0; i < instance_number(o_WorldParent); i++)
{
	var _parent = instance_find(o_WorldParent, i)

	var _parent_distance = distance_to_object(_parent)

	var _flags = true

	if(_parent.infectable == false)
	{
		_flags = false
	}
	if(_parent.infected == true)
	{
		_flags = false
	}

	if(_flags)
	{
		if(_to_infect == noone)
		{
			_to_infect = _parent
		}
		else
		{
			var _nearest_distance = distance_to_object(_to_infect)

			if(_parent_distance < _nearest_distance)
			{
				_to_infect = _parent
			}
		}
	}
}

var _infectant_distance = distance_to_object(_to_infect)
var _roam_distance = distance_to_point(roam_position.x, roam_position.y)
var _player_distance = distance_to_object(o_Player)
var _roam_point = point_in_circle(roam_position.x, roam_position.y, o_Player.x, o_Player.y, flee_distance + 10)

if(choice == thread_choice.lace)
{
	if(_infectant_distance <= pounce_distance)
	{
		//player is rlly close so they just go for the infect
		if(!charge) 
		{
			charge = true
			state = thread_state.charge
		}
	}

	if(infects >= 3)
	{
		instance_destroy()
		instance_create_layer(x, y, "World", o_Lace)
	}
}

switch(state)
{
	case(thread_state.roam):
	{
		if(_roam_distance <= 20)
		{
			new_roam()
		}
		if(_roam_point)
		{
			new_roam()	
		}
		
		target_velocity = move_towards(roam_position)
		
		target_velocity.x *= thread_speed
		target_velocity.y *= thread_speed
		
		switch(choice)
		{
			case(thread_choice.coil):
			{
				state = thread_state.coil
			}
			break;
			
			case(thread_choice.lace):
			{
				if(_player_distance <= flee_distance)
				{
					state = thread_state.flee
				}
			}
			break;
		}
	}
	break;
	
	case(thread_state.flee):
	{
		var _player = move_towards(o_Player)
		
		target_velocity.x = -_player.x * thread_speed
		target_velocity.y = -_player.y * thread_speed
		
		if(_player_distance >= flee_distance)
		{
			state = thread_state.roam
		}
	}
	break;
	
	case(thread_state.coil):
	{
		evolve_timer += get_delta_time()
		
		//art_particles_create(part, x, y - 2, pt_grow, 3)
		
		target_velocity.x *= 0.4
		target_velocity.y *= 0.4
		
		if(evolve_timer >= 50)
		{
			instance_create_layer(x, y, "World", o_Coil)
			instance_destroy()
		}
	}
	break;

	case(thread_state.charge):
	{
		pounce_timer += get_delta_time()

		target_velocity.x *= 0.2
		target_velocity.y *= 0.2

		if(pounce_timer > 1)
		{
			pounce_timer = 0
			state = thread_state.attack
		}
	}
	break;

	case(thread_state.attack):
	{
		charge = false

		var _player = move_towards(_to_infect)

		target_velocity.x = _player.x * pounce_speed
		target_velocity.y = _player.y * pounce_speed

		attack_timer += get_delta_time()

		if(attack_timer > 0.5)
		{
			attack_timer = 0

			state = thread_state.flee
		}

		if(_infectant_distance <= 20)
		{
			infects++

			if(_to_infect.object_index == o_Player)
			{
				o_Player.infect_alpha = 1.4
				o_Player.hp -= 1
			}

			_to_infect.infected = true

			state = thread_state.flee
		}
	}
	break;
}

part_system_depth(part, -50)

image_xscale = 1 - evolve_timer / 100
image_yscale = 1 + evolve_timer / 50

velocity.x += (target_velocity.x - velocity.x) * acc * get_delta_time()
velocity.y += (target_velocity.y - velocity.y) * acc * get_delta_time()