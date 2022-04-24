z = 0

enemy_data = enemy_create(50, 2, 10)

attack_cooldown = 0

current_state = state.idle

sprites_array = array_create()

sprites_array[state.idle] = s_Walker
sprites_array[state.move] = s_Walker
sprites_array[state.attack] = s_Walker

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
	
	var len = v2_length(v2(enemy_data.arg_knock_x, enemy_data.arg_knock_y));
	
	if (len > 0.1)
		move_dir = v2(0, 0);
	
	x += move_dir.x * (spd * 0.5) + enemy_data.arg_knock_x
	y += move_dir.y	* (spd * 0.5) + enemy_data.arg_knock_y
	
	enemy_data.arg_knock_x *= 0.9
	enemy_data.arg_knock_y *= 0.9
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
	
	var hp_width = 16 / 50 * enemy_data.hp
	var hp_height = 1.5
	
	var h_x = x - (hp_width / 2)
	var h_y = y - sprite_height - pad - hp_height
	
	//balck bar
	ui_draw_rectangle(x - (16 / 2), h_y, 16, hp_height, c_black, 0.3, false)
	
	//red bar
	ui_draw_rectangle(h_x, h_y, hp_width, hp_height, c_red, 0.5, false)

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