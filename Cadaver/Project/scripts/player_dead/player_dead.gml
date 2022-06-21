function player_dead()
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