z = 0

enemy_data = enemy_create(10, 2, 0)

enum state
{
	idle,
	move,
	charging,
	attack
}

chase_distance = 128
attack_distance = 12

current_state = state.idle

scripts_array[state.idle] = infected_idle
scripts_array[state.move] = infected_move
scripts_array[state.charging] = infected_charge
scripts_array[state.attack] = infected_attack

sprites_array[state.idle] = s_Mutant
sprites_array[state.move] = s_MutantRun
sprites_array[state.charging] = s_MutantCharge
sprites_array[state.attack] = s_MutantAttack

charged = 0
charge_time = 30

attacked = 0
attack_time = 75

did_damage = 0

attack_range = 25

function render()
{
	draw_self();
	
	var hp_width = 16 / 10 * enemy_data.hp
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

ds_list_add(o_RenderManager.entities, self)