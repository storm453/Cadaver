z = -bbox_bottom

image_speed = 0

var move = true

for(var i = 0; i < array_length(disable_move); i++)
{
	if(global.current_gui == disable_move[i])
	{
		move = false
	}
}

//part_system_depth(part_sys, -99)

mouse_angle = point_direction(x, y - 20, mouse_x, mouse_y)

attack_circle = circle_point(x, y - 20, attack_distance, mouse_angle)

in_x = keyboard_check(ord("D")) - keyboard_check(ord("A"))
in_y = keyboard_check(ord("S")) - keyboard_check(ord("W"))

shift = keyboard_check(vk_shift);	
attack_light = mouse_check_button(mb_left)
attack_heavy = mouse_check_button(mb_right)
dash = keyboard_check_pressed(vk_space)

step_animation()

var sign_mouse = sign(mouse_x - x)

if(sign_mouse == 0) 
{
	sign_mouse = 1
}

if(sign_mouse != 0)
{
	image_xscale = sign_mouse;	
}

if(!move) exit;

function goto_state(_state)
{
	switch(_state)
	{
		case(player_state.dash):
		{
			dash_dir = point_direction(0, 0, in_x, -in_y)
			dash_speed = dash_speed_set
			state_timer_next = player_state.idle
			state_timer = dash_time
			state_timer_enabled = true
		}
		break;
	}

	state = _state
	set_animation(animation_array[state])
}

if(swing_scale > 1) swing_scale -= 0.05

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

attack_cooldown -= get_delta_time()
if(attack_cooldown <= 0) attack_cooldown = 0

function check_if_attack()
{
	attack_angle = mouse_angle
	
	if(attack_light)
	{
		goto_state(player_state.punch_light)
	}
	if(attack_heavy)
	{
		goto_state(player_state.punch_heavy)
	}
}

if(dash)
{
	goto_state(player_state.dash)
}

switch(state)
{
	case(player_state.idle):
	{
		movement()
		check_if_attack()
		
		if(vec_length(velocity) > walk_speed / 2) 
		{
			if(!shift)
			{
				goto_state(player_state.walk)
			}
			else
			{
				goto_state(player_state.run)	
			}
		}	
	}
	break;
	
	case(player_state.walk):
	{
		movement()
		check_if_attack()
	
		if(vec_length(velocity) < walk_speed / 2) 
		{
			goto_state(player_state.idle)
		}
		if(shift)
		{
			goto_state(player_state.run)
		}	
	}
	break;
	
	case(player_state.run):
	{
		check_if_attack()
		movement(2.3)
	
		if(!shift) 
		{
			goto_state(player_state.walk)	
		}
		if(vec_length(velocity) < walk_speed / 2) 
		{
			goto_state(player_state.idle)	
		}
	}
	break;
	
	case(player_state.dash):
	{
		//part_particles_create(part_sys, x, y, pt_epic, 12)
		
		x += dcos(dash_dir) * dash_speed * get_delta_time()
		y += dsin(dash_dir) * dash_speed * get_delta_time()
		
		dash_speed -= 12 * get_delta_time()
	}
	break;
}

if(hp <= 0)
{
	hp = 10
	goto_state(player_state.death)	
}

if(knockback_target != noone)
{
	var _knock = move_towards(knockback_target)
	
	knockback_velocity.x += -_knock.x * 200
	knockback_velocity.y += -_knock.y * 200
	
	knockback_target = noone
}

x += knockback_velocity.x * get_delta_time()
y += knockback_velocity.y * get_delta_time()

knockback_velocity.x += knockback_velocity.x * -velocity_dampen * get_delta_time()
knockback_velocity.y += knockback_velocity.y * -velocity_dampen * get_delta_time()

//@TEMP quite slow 4 performance
for(var i = 0; i < instance_number(o_WorldParent); i++)
{
	var cur_multiblock = instance_find(o_WorldParent, i)
	
	var distance_check = distance_to_object(cur_multiblock)

	if(cur_multiblock.type == parent_type.interactable)
	{
		if(current_multi == noone)
		{
			current_multi = cur_multiblock
		}
		else
		{
			var current_distance = distance_to_object(current_multi)

			if(distance_check < current_distance)
			{
				current_multi = cur_multiblock
			}
		}
	}
}

var scan = current_multi

if(keyboard_check_pressed(ord("E")))
{
	if(global.current_gui == gui.NONE)
	{
		if(global.open_instance == noone)
		{
			scan_distance = distance_to_object(scan)
			
			if(scan_distance < interact_range)
			{
				global.open_instance = scan
				global.current_gui = global.open_instance.block_data.to
			}
		}
	}
}