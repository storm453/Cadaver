event_inherited();

bird_state = make_enum()

custom_render = true

add_enum(bird_state, "loiter")
add_enum(bird_state, "flee")
add_enum(bird_state, "land")
add_enum(bird_state, "walk")
add_enum(bird_state, "to_tree")
add_enum(bird_state, "in_tree")
add_enum(bird_state, "guide")
add_enum(bird_state, "to_shrine")

state = bird_state.loiter

bird_sprites = []

bird_sprites[bird_state.loiter] = s_BirdFly
bird_sprites[bird_state.flee] = s_BirdFly
bird_sprites[bird_state.land] = s_Bird
bird_sprites[bird_state.walk] = s_BirdWalk
bird_sprites[bird_state.to_tree] = s_BirdFly
bird_sprites[bird_state.guide] = s_BirdFly
bird_sprites[bird_state.to_shrine] = s_BirdFly

state_timer_enabled = false
state_timer = 0
state_timer_next = bird_state.loiter

is_animal = true

acc = 1
bird_speed = 120
height = 40

loiter_distance = 200
loiter_target = vec2(x, y)
loiter_timer = 0

to_tree_target = vec2(0, 0)
in_tree_timer = 0

function goto_state(_state)
{
	var _sucessful = true
	
	switch(_state)
	{
		case(bird_state.loiter):
		{
			loiter_target = vec2(x, y)
		}
		break;
		
		case(bird_state.to_tree):
		{
			var _trees = instance_number(o_Tree1)
			
			if(_trees == 0)
			{
				_sucessful = false
				break	
			}
			
			var _closest_tree = noone
			
			for(var i = 0; i < _trees; i++)
			{
				var _current_tree = instance_find(o_Tree1, i)
				
				if(_closest_tree == noone) 
				{
					_closest_tree = _current_tree
				}
				if(distance_to_object(_current_tree) < distance_to_object(_closest_tree))
				{
					_closest_tree = _current_tree	
				}
			}
			
			to_tree_target.x = _closest_tree.x
			to_tree_target.y = _closest_tree.y - 60
		}
		break;
		
		case(bird_state.in_tree):
		{
			in_tree_timer = 5	
		}
		break;
	}
	
	if(_sucessful) state = _state
}

function step()
{
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
	
	var _loiter_distance = distance_to_point(loiter_target.x, loiter_target.y)

	switch(state)
	{
		case(bird_state.loiter):
		{
			if(_loiter_distance <= 10)
			{
				loiter_target.x = x + irandom_range(-loiter_distance, loiter_distance)
				loiter_target.y = y + irandom_range(-loiter_distance, loiter_distance)
				
				if(chance(0.1))
				{
					goto_state(bird_state.to_tree)
				}
			}

			var _move = move_towards(loiter_target)

			velocity.x += (_move.x * bird_speed - velocity.x) * acc * get_delta_time()
			velocity.y += (_move.y * bird_speed - velocity.y) * acc * get_delta_time()
		}
		break;
		
		case(bird_state.to_tree):
		{
			if(distance_to_point(to_tree_target.x, to_tree_target.y) < 10)
			{
				goto_state(bird_state.in_tree)
			}
			else
			{
				var _move = move_towards(to_tree_target)
			
				velocity.x += (_move.x * bird_speed - velocity.x) * acc * get_delta_time()
				velocity.y += (_move.y * bird_speed - velocity.y) * acc * get_delta_time()	
			}
		}
		break;
		
		case(bird_state.in_tree):
		{
			in_tree_timer -= get_delta_time()
			
			velocity = vec2(0, 0)
			
			if(in_tree_timer <= 0)
			{
				in_tree_timer = 5
				
				if(chance(0.7))
				{
					goto_state(bird_state.loiter)	
				}
			}
		}
		break;
	}

	image_xscale = sign(-velocity.x)
	
	sprite_index = bird_sprites[state]
}

function my_render()
{
	if(state == bird_state.in_tree) exit;
	
	draw_self()
	
	var _shadow_alpha = 0.2 * max((40 - height) / 40, 0)

	draw_sprite_ext(sprite_index, image_index, x, y + height, image_xscale, 1, 0, c_black, _shadow_alpha)
}