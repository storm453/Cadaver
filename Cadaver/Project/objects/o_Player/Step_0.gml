z = -bbox_bottom

rotation = lerp(rotation, 90, 0.1)

//all logic involving attacking and item types for hotbar item
if(global.hotbar_sel_item != 0)
{
	var hotbar_item_data = global.items_list[global.hotbar_sel_item.item].item_data

	if(hotbar_item_data.item_type == item_types.melee)
	{
		if(attack_cooldown <= 0)
		{
			if(attack)
			{
				gave_item = false
				dealt_damage = false
				attack_cooldown = attack_cooldown_set

				rotation = -90

				instance_create_layer(x, y,  "Instances", o_Swing)

				image_index = 0

				state = player_state.attack
			}
		}
	}

	if(hotbar_item_data.item_type == item_types.tool)
	{
		var selected = instance_position(mouse_x, mouse_y, o_Harvestable)

		if(selected != -4) 
		{
			if(mouse_check_button_pressed(mb_left))
			{
				rotation = -90

				var sel_x = selected.x + (sprite_get_width(selected.sprite_index) / 4)
				var sel_y = selected.y + (sprite_get_height(selected.sprite_index) / 2)

				selected.hp--

				if(selected.hp <= 0)
				{
					instance_destroy(selected)

					repeat(irandom(8)) create_drop(sel_x, sel_y, choose(items.wood, items.plants, items.stone), 5)
				}
			}
		}	
	}
}

//check list movable if player should be able to move in this gui state
var move = true

for(var i = 0; i < ds_list_size(list_movable); i++)
{
	if(global.current_gui == list_movable[|i])
	{
		move = false
	}
}

if(!move) exit;

if(hp <= 0) state = player_state.dead

if(state == player_state.dead)
{
	if(keyboard_check_pressed(vk_space))
	{
		var loot = instance_create_layer(x, y, "Instances", o_Storage)

		for(var i = 0; i < o_PlayerInventory.inv_data.slots_x; i++)
		{
			for(var j = 0; j < o_PlayerInventory.inv_data.slots_y; j++)
			{
				if(o_PlayerInventory.inv[i,j] != 0)
				{
					add_item(loot.inv, loot.inv_data, o_PlayerInventory.inv[i,j].item, o_PlayerInventory.inv[i,j].amt)
					o_PlayerInventory.inv[i,j] = 0
				}
			}
		}

		x = spawn_x
		y = spawn_y

		state = player_state.idle
		
		hp = 100
		energy = 100
	}
}

if(state = player_state.idle)
{
	input()
	movement()
	player_animation()
	
	if(vec_length(velocity) > walk_speed / 2) 
	{
		if(energy >= 33)
		{
			if(!shift)
			{
				state = player_state.walk
			}
			else
			{
				state = player_state.run	
			}
		}
		else
		{
			state = player_state.walk	
		}
	}
}

if(state == player_state.walk)
{
	if(energy_time mod 100 == 0) energy -= 0.2
	
	input()
	movement()
	player_animation()
	
	if(vec_length(velocity) < walk_speed / 2) 
	{
		state = player_state.idle
	}
	
	if(shift) state = player_state.run
}

if(state == player_state.run)
{
	if(energy_time mod 50 == 0) energy -= 0.5
	
	input()
	movement(2)
	player_animation()
	
	if(vec_length(velocity) < walk_speed / 2) 
	{
		state = player_state.idle
	}
	
	if(!shift) state = player_state.walk
	
	if(energy <= 33) state = player_state.walk
}

if(state == player_state.attack)
{
	input()
	movement()
	player_animation()

	if(image_index >= sprite_get_number(s_PlayerAttack))
	{
		state = player_state.idle
	}

	rec_x = x + 10 * image_xscale
	rec_y = y - sprite_height

	var attack_rec = collision_rectangle(rec_x, rec_y, rec_x + attack_range * image_xscale, rec_y + attack_range, o_WorldParent, false, true)

	for(var i = 0; i < array_length_1d(resource_drops); i++)
	{
		if(attack_rec != noone)
		{
			//IF NOT -4 GIVE RESOURCES BECAUSE ITS RESOURCE DROPS
			if(attack_rec.object_index == resource_drops[i].object)
			{
				if(!gave_item)
				{
					gave_item = true

					var drops_array = resource_drops[i].all_drops

					for(var j = 0; j < array_length_1d(drops_array); j++)
					{
						var item = 0
						var compare_item = 0

						if(global.hotbar_sel_item != 0) compare_item = global.hotbar_sel_item.item

						if(compare_item == drops_array[j].item) 
						{
							item = 1
						}

						if(item)
						{
							//you are using an item that exists, gets drops from there
							var item_drops = drops_array[j].drops

							for(var k = 0; k < array_length_1d(item_drops); k++)
							{
								if(random(1) < item_drops[k].chnce)
								{
									var drop_amt = irandom_range(item_drops[k].amt_min, item_drops[k].amt_max)

									add_item(o_PlayerInventory.inv, o_PlayerInventory.inv_data, item_drops[k].uid, drop_amt)
								}
							}
						}
					}
				}
			}
		}
	}

	var attack_list = ds_list_create()
	
	var attack_rec = collision_rectangle_list(rec_x, rec_y, rec_x + attack_range * image_xscale, rec_y + attack_range, o_WorldParent, false, true, attack_list, true)

	var sweep = 0
	
	if(global.hotbar_sel_item != 0)
	{
		if(global.items_list[global.hotbar_sel_item.item].item_data.sweep) sweep = 1
	}

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

if(state == player_state.dead)
{
	player_animation()
}

attack_cooldown--