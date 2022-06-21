function movement(spd = 1) 
{
	var move_speed = 50
	var target_velocity = vec_mul(vec_normalized(vec2(in_x, in_y)), vec2(move_speed))

	var velocity_change = vec_sub(target_velocity, velocity)
	var velocity_increase = vec_mul(velocity_change, vec2(acceleration * get_delta_time()))

    if (vec_length(velocity_increase) > vec_length(velocity_change)) velocity_increase = velocity_change
	
	velocity = vec_add(velocity, velocity_increase)

	// move the player
	if(!place_meeting(x + velocity.x * get_delta_time(), y, o_Collision))
	{
		x += velocity.x * get_delta_time() * spd
	}
	
	if(!place_meeting(x, y + velocity.y * get_delta_time(), o_Collision))
	{
		y += velocity.y * get_delta_time() * spd	
	}
}