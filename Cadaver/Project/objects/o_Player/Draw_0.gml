draw_self()

anim += 0.2

if(global.current_gui == 0)
{
	if(attack)
	{
		if(attack_cooldown <= 0)
		{
			gave_item = false
			attack_cooldown = attack_cooldown_set
		}
	}

	if(attack_cooldown > attack_duration)
	{
		rec_x = x + 10 * image_xscale
		
		var attack_rec = collision_rectangle(rec_x, y, rec_x + attack_range * image_xscale, y + attack_range, o_Tree01, false, true)
	
		ui_draw_rectangle(rec_x, y, attack_range * image_xscale, attack_range, c_red, 1, true)
		
		for(var i = 0; i < array_length_1d(resource_drops); i++)
		{
			if(attack_rec != -4)
			{
				if(attack_rec.object_index == resource_drops[i].object)
				{
					if(!gave_item)
					{
						gave_item = true
			
						var index = resource_drops[i]
				
						for(var j = 0; j < array_length_1d(resource_drops[i].drops); j++)
						{
							o_PlayerInventory.add_item(index.drops[j].uid, index.drops[j].amt)
						}
					}
				}
			}
		}
	}
}