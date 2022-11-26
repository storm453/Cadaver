z = 0

enemy_data = enemy_create(10, 2, 0)

enum state
{
	idle,
	move,
	charging,
	attack,
	backup
}

chase_distance = 128
attack_distance = 30

current_state = state.idle

sprites_array[state.idle] = s_Mutant
sprites_array[state.move] = s_MutantRun
sprites_array[state.charging] = s_MutantCharge
sprites_array[state.attack] = s_MutantAttack
sprites_array[state.backup] = s_Mutant

backup_length = 0
backup_strength = 2

charged = 0
charge_time = 30

dash_time = 0
dash_time_amount = 0.6
dash_strength = 2

player_angle = 0

cx = 0
cy = 0

attacked = 0
attack_time = 75

did_damage = 0

attack_range = 25

function render()
{
	draw_self();
	
	player_angle = point_direction(x, y, o_Player.x, o_Player.y - 16)
	
	cx = cos(player_angle * 2 * pi / 360) * 25 + x
	cy = -sin(player_angle * 2 * pi / 360) * 25 + y

	if(current_state == state.attack)
	{
		if(dash_time < dash_time_amount) draw_sprite_ext(s_Swing, 0, cx, cy, 1, 1, player_angle, c_white, 1)
	}
	
	var hp_width = 16 / 10 * enemy_data.hp
	var hp_height = 1.5
	
	var h_x = x - (hp_width / 2)
	var h_y = y - sprite_height - pad - hp_height
	
	//balck bar
	ui_draw_rectangle(x - (16 / 2), h_y, 16, hp_height, c_black, 0.3, false)
	
	//red bar
	ui_draw_rectangle(h_x, h_y, hp_width, hp_height, c_red, 0.5, false)
}

ds_list_add(o_RenderManager.entities, self)