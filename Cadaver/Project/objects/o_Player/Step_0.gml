z = -bbox_bottom

if(global.current_gui != gui.NONE) exit;

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
		state = player_state.run
	}
}

if(state == player_state.run)
{
	input()
	movement()
	player_animation()
	
	if(vec_length(velocity) < walk_speed / 2) 
	{
		state = player_state.idle
	}
}
if(state == player_state.dead)
{
	player_animation()
}

attack_cooldown--