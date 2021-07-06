hp = 50;
energy = 50;

walk_speed = 100
acceleration = 50

velocity = vec2(0, 0);

state = player_state.idle

enum player_state
{
	idle,
	run,
	attack
}

function input()
{
	in_x = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	in_y = keyboard_check(ord("S")) - keyboard_check(ord("W"))
	
	shift = keyboard_check(vk_shift);	
	attack = mouse_check_button_pressed(mb_left)
}

sprites_array[player_state.idle] = s_Player
sprites_array[player_state.run] = s_PlayerRun
//sprites_array[player_state.attack] = s_Player_Attack

function movement() 
{
	var move_speed = walk_speed
	var target_velocity = vec_mul(vec_normalized(vec2(in_x, in_y)), vec2(move_speed))

	var velocity_change = vec_sub(target_velocity, velocity)
	var velocity_increase = vec_mul(velocity_change, vec2(acceleration * get_delta_time()))

    if (vec_length(velocity_increase) > vec_length(velocity_change)) velocity_increase = velocity_change
	
	velocity = vec_add(velocity, velocity_increase)

	//if(Collision(x + velocity.x * get_delta_time(), y))
	//{
    //    velocity.x = 0
	//}

	//if(Collision(x, y + velocity.y * get_delta_time())) 
	//{
    //    velocity.y = 0
	//}

	// move the player
	x += velocity.x * get_delta_time()
	y += velocity.y * get_delta_time()
}

function player_animation() 
{
	sprite = sprites_array[state]

	sprite_index = sprite

	var sign_mouse = sign(mouse_x - x)

	if(sign_mouse == 0) 
	{
		sign_mouse = 1
	}

    if(in_x != 0 && sign(in_x) != sign_mouse) 
	{
		image_speed = -1
	}
	else {
		image_speed = 1
	}
	
	if(sign_mouse != 0)
	{
		image_xscale = sign_mouse;	
	}
}

attack_cooldown_set = 60
attack_cooldown = 0
attack_duration = 20

attack_range = 25
gave_item = false

resource_drops[0] =
{
  object: o_Tree01,
  drops: array
  (
	{ uid : 17, amt : 1 },
	{ uid : 2, amt : 1 }
  )
}

anim = 0