function WorldStep()
{
	if(auto_z) z = -bbox_bottom

	//particles.step()

	if(state_timer_enabled)
	{
		if(state_timer > 0)
		{
			state_timer -= get_delta_time()	
		}
		else
		{
			state_timer = 0	
			state_timer_enabled = false
		
			goto_state(state_timer_next)
		}
	}

	if(damagable)
	{
		if(hp <= 0)
		{
			instance_destroy()	
		}
	}

	if(is_animal)
	{
		var _distance = (o_Camera.x_size * o_Camera.zoom) * 2
		var _player = distance_to_object(o_Player)
	
		if(_player >= _distance)
		{
			instance_destroy()	
		}
	}
	if(is_parasite)
	{
		var _distance = (o_Camera.x_size * o_Camera.zoom) * 4
		var _player = distance_to_object(o_Player)
	
		if(_player >= _distance)
		{
			instance_destroy()	
		}	
	}
	
	if(knockback_target != noone)
	{
		var _knock = move_towards(knockback_target)
	
		knockback_velocity.x += -_knock.x * 80
		knockback_velocity.y += -_knock.y * 80
	
		knockback_target = noone
	}

	x += velocity.x * get_delta_time()
	y += velocity.y * get_delta_time()

	x += knockback_velocity.x * get_delta_time()
	y += knockback_velocity.y * get_delta_time()

	knockback_velocity.x += knockback_velocity.x * -velocity_dampen * get_delta_time()
	knockback_velocity.y += knockback_velocity.y * -velocity_dampen * get_delta_time()
}