player_distance = distance_to_object(o_Player)

if(o_Player.state != player_state.attack)
{
	enemy_data.hit = 0
}

z = -bbox_bottom

if(enemy_data.hp <= 0) 
{
	randomize()
	create_drop(x, y, items.infectedpiece, irandom(3) + 1)
	create_drop(x, y, items.cloth, irandom_range(1,2))
	
	instance_destroy()
}

if(current_state != state.attack)
{
	did_damage = 0
}

script_execute(scripts_array[current_state])