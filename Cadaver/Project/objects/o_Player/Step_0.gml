z = -bbox_bottom

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
attack = mouse_check_button_pressed(mb_left)
dash = keyboard_check_pressed(vk_space)

sprite_index = sprites_array[state]

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
			dash_speed = 5
			state_timer_next = player_state.idle
			state_timer = 0.3
			state_timer_enabled = true
		}
		break;
		
		case(player_state.attack):
		{
			image_index = 0
			swing_scale = 1.5
		}
		break;

		case(player_state.hit):
		{
			hit_state_was_timer_enabled = state_timer_enabled	
			state_timer_enabled = false

			hit_state_timer = 0.6
			hit_state_next = state
		}
	}

	state = _state
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
	
	if(attack)
	{
		if(attack_cooldown <= 0)
		{
			attack_cooldown = attack_cooldown_set
			
			goto_state(player_state.attack)
			
			if(global.hotbar_data != 0)
			{
				var _hotbar_item_data = global.items_list[global.hotbar_data.item].item_data
				var _hid_type = _hotbar_item_data.item_type
				var _hid_damage = _hotbar_item_data.damage
				
				switch(_hid_type)
				{
					case(item_types.melee):
					{
						damage_circle(attack_circle.x, attack_circle.y, attack_radius, _hid_damage)
					}
					break;
					
					case(item_types.ranged):
					{
						
					}
					break;
				}
			}
		}
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
	
	case(player_state.attack):
	{
		movement(0.5)
	}	
	break;
	
	case(player_state.run):
	{
		check_if_attack()
		movement(2)
	
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
		part_particles_create(part_sys, x, y, pt_epic, 12)
		
		x += dcos(dash_dir) * dash_speed
		y += dsin(dash_dir) * dash_speed
		
		dash_speed -= 0.2
	}
	break;

	case(player_state.hit):
	{
		if(hit_state_timer > 0)
		{
			hit_state_timer -= get_delta_time()	
		}
		else
		{
			hit_state_timer = 0
			state_timer_enabled = hit_state_was_timer_enabled
			
			state = hit_state_next
		}
	}
	break;
}

//get closest interacatable block to us
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