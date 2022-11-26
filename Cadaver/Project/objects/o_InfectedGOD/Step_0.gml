z = -bbox_bottom

player_distance = distance_to_object(o_Player)

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

if(current_state == state.attack)
{
	attacked++
	
	var player_vec = move_towards(o_Player)
	
	dash_time += get_delta_time()
	
	if(dash_time < dash_time_amount)
	{
		x += player_vec.x * dash_strength
		y += player_vec.y * dash_strength
		
		dash_strength *= 0.98
		
		var attack_circle = collision_circle(cx, cy, 10, o_Player, 0, 0)
		
		if(attack_circle != noone)
		{
			if(o_Player.state == player_state.block)
			{
				//finish dash
				dash_time = dash_time_amount
				
				o_Camera.shake = 2
			}
			else
			{
				if(!did_damage)
				{
					did_damage = 1
				
					o_Player.hurt_alpha = 1
					o_Player.hp -= 20
					
					current_state = state.idle
				
					o_Camera.shake = 2
				}	
			}
		}
	}
	else
	{
		infected_movement()	
	}
	
	if(attacked >= attack_time) 
	{
		attacked = 0

		current_state = state.idle
	}
}
if(current_state == state.move)
{
	infected_movement()
	
	if(player_distance > chase_distance) current_state = state.idle
	
	if(player_distance <= attack_distance) 
	{
		current_state = choose(state.charging, state.backup)
		
		circle_direction = choose(-1, 1)
		circle_distance = choose(50, 100)
		backup_strength = 2
	}	
}
if(current_state == state.idle)
{
	if(player_distance < chase_distance) current_state = state.move	
}
if(current_state == state.charging)
{
	charged += get_delta_time()
	
	var player = move_towards(o_Player)
	
	if(distance_to_object(o_Player) > circle_distance)
	{
		x += player.x
		y += player.y
	}
	
	var new_cool = tangent_vector(player)
	
	x += new_cool.x * circle_direction
	y += new_cool.y * circle_direction
	
	if(charged >= 1 + random(1))
	{
		current_state = state.attack
		
		dash_time = 0
		dash_strength = irandom_range(2, 4)
		charged = 0
	}	
}
if(current_state == state.backup)
{
	var player = move_towards(o_Player)

	x += -player.x * backup_strength
	y += -player.y * backup_strength
	
	backup_strength *= 0.97
	
	backup_length += get_delta_time()
	
	if(backup_length > 0.6) 
	{
		current_state = state.attack
		dash_strength = 3.5
		dash_time = 0
		did_damage = 0
	}
}

//ANIMATIUNO
sprite_index = sprites_array[current_state]

//Face the player
var sign_mouse = sign(o_Player.x - x)

if(sign_mouse == 0) 
{
	sign_mouse = 1
}

if(sign_mouse != 0)
{
	image_xscale = sign_mouse;	
}

if(enemy_data.hp <= 0) 
{
	randomize()
	create_drop(x, y, items.infectedpiece, irandom(3) + 1)
	create_drop(x, y, items.cloth, irandom_range(1,2))
	
	instance_destroy()
}

if(o_Player.state != player_state.attack)
{
	enemy_data.hit = 0
}
if(current_state != state.attack)
{
	did_damage = 0
}
