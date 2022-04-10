z = 0

enemy_data = enemy_create(10, 2, 0)

enum state
{
	idle,
	move,
	attack
}

current_state = state.idle

sprites_array = array_create()

sprites_array[state.idle] = s_Mutant
sprites_array[state.move] = s_MutantRun
sprites_array[state.attack] = s_MutantAttack

attack_frame = 0
attack_range = 25

function movement(spd = 1)
{
	//Move towards player
	move_dir = move_towards(o_Player)
	
	var near = instance_nearest_notme(all)
	
	if(near != -4)
	{
		var near_dis = distance_to_object(near)
		
		if(near_dis == 0) near_dis = 1
		
		var near_dir = v2_div(move_towards(near), v2(near_dis))
	
		move_dir = v2_sub(move_dir, near_dir)
	}
	
	x += move_dir.x * spd
	y += move_dir.y	* spd
}

function animation()
{
	sprite = sprites_array[current_state]
	
	sprite_index = sprite
	
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
}

function render()
{
	draw_self();
	
	ui_draw_string(x, y, "HP: " + string(enemy_data.hp), ft_Small)

	//TEMP
	var rec_x = x + 10 * image_xscale
	var rec_y = y - sprite_height

	if(current_state == state.attack) ui_draw_rectangle(rec_x, rec_y, attack_range * image_xscale, attack_range, c_red, 1, true)
}

function render_shadow()
{
	draw_sprite_ext(sprite_index, 0, x, y, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
}

ds_list_add(o_RenderManager.entities, self)