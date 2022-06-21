function player_attack()
{
	input()
	movement()
	player_animation()

	if(image_index >= image_number - sprite_get_speed(sprite_index) / room_speed)
	{
		state = player_state.idle
	}
	var attack_list = ds_list_create()

	var attack_rec = collision_circle_list(ex, ey, 25, o_WorldParent, false, true, attack_list, true)

	var sweep = 0

	if(global.hotbar_sel_item != 0)
	{
		if(global.items_list[global.hotbar_sel_item.item].item_data.sweep) sweep = 1
	}

	if(global.hotbar_sel_item == 0) sweep = 1

	var loop_size = ds_list_size(attack_list)
	var check_dealt = 0

	if(!sweep) 
	{
		loop_size = 1
		check_dealt = 1
	}

	//enemies
	for(var p = 0; p < ds_list_size(enemies_list); p++)
	{
		if(ds_list_size(attack_list) > 0)
		{
			for(var i = 0; i < loop_size; i++)
			{
				if(attack_list[|i].object_index == enemies_list[|p])
				{
					if(attack_list[|i].enemy_data.hit <= 0)
					{
						if(!dealt_damage)
						{
							if(check_dealt) dealt_damage = 1
							
							attack_list[|i].enemy_data.hit = 1

							var damage = global.items_list[items.air].item_data.damage
							var kb = global.items_list[items.air].item_data.kb

							if(global.hotbar_sel_item != 0)
							{
								damage = global.items_list[global.hotbar_sel_item.item].item_data.damage
							}
							if(global.hotbar_sel_item != 0)
							{
								kb = global.items_list[global.hotbar_sel_item.item].item_data.kb
							}

							attack_list[|i].enemy_data.hp -= damage * attack_list[|i].enemy_data.protection
							
							part_particles_create(part_sys, attack_list[|i].x, attack_list[|i].y - 10, global.pt_blood, 5)	
						
							var dir = move_towards(attack_list[|i]);

							attack_list[|i].enemy_data.arg_knock_x += dir.x * kb * attack_list[|i].enemy_data.knock_resistance
							attack_list[|i].enemy_data.arg_knock_y += dir.y * kb * attack_list[|i].enemy_data.knock_resistance
						}
					}
				}
			}
		}
	}
}