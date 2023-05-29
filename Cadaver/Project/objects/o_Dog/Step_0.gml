event_inherited()

if !instance_exists(angry) && angry != noone
{
	move_target = vec2(x, y)
	angry = noone
	fof_chosen = false
	state = dog_state.idle
}

var _move_distance = distance_to_point(move_target.x, move_target.y)

switch(state)
{
	case(dog_state.idle):
	{
		move_target = vec2(x, y)
		
		if(chance(0.005))
		{
			state = dog_state.move
		}
		
		if(angry != noone)
		{
			state = dog_state.fof		
		}
	}
	break;
		
	case(dog_state.move):
	{
		if(_move_distance <= 10)
		{
			 //move_target.x = x + irandom_range(-move_distance, move_distance)
			 //move_target.y = y + irandom_range(-move_distance, move_distance)
			
			var _facing_x = velocity.x
			var _facing_y = velocity.y

			var _facing_l = sqrt(_facing_x * _facing_x + _facing_y * _facing_y)
			
			if _facing_l != 0
			{
				_facing_x /= _facing_l
				_facing_y /= _facing_l
			}
			else 
			{
				_facing_x = 1;
				_facing_y = 0;	
			}
			
			var _right_x = _facing_y				
			var _right_y = -_facing_x
			
			
			var _amt_r = irandom_range(-move_distance, move_distance)
			var _amt_f = irandom_range(0, move_distance)
			
			move_target.x = x + _right_x * _amt_r + _facing_x * _amt_f
			move_target.y = y + _right_y * _amt_r + _facing_y * _amt_f  
		}
		
		if(chance(0.001))
		{
			state = dog_state.idle
		}
		
		if(angry != noone)
		{
			state = dog_state.fof	
		}
	}
	break;
	
	case(dog_state.fof):
	{
		if(fight)
		{
			//fight the player
			move_target = angry
			
			if(distance_to_object(move_target) <= pounce_distance)
			{
				state = dog_state.charge	
			}
		}
		else
		{
			//flee
			var _flee = move_towards(angry)
			
			velocity.x = -_flee.x * 240
			velocity.y = -_flee.y * 240
		}
	}
	break;
	
	case(dog_state.pounce):
	{
		velocity.x += velocity.x * 4 * get_delta_time()
        velocity.y += velocity.y * 4 * get_delta_time()
		
		var _circle_hit = damage_circle(x, y, 30, 1)
		
		if(_circle_hit)
		{
			state = dog_state.fof	
		}
		
		if !instance_exists(angry) 
		{
			move_target = vec2(x, y)
			angry = noone
		}

		pounce_timer += get_delta_time()
		
		if(pounce_timer > 1)
		{
			state = dog_state.fof	
		}
	}
	break;

	case(dog_state.charge):
	{
		velocity.x *= 1 - 0.1 * 60 * get_delta_time()	
		velocity.y *= 1 - 0.1 * 60 * get_delta_time()
	}
	break;
}	

sprite_index = dog_sprites[state]

if(state != dog_state.pounce)
{
	if(move_target != noone)
	{
		var _move = move_towards(move_target)

		velocity.x += (_move.x * dog_speed - velocity.x) * acc * get_delta_time()
		velocity.y += (_move.y * dog_speed - velocity.y) * acc * get_delta_time()
	}
}

if (velocity.x != 0) image_xscale = sign(-velocity.x)