event_inherited()

for(var i = 0; i < array_length(inv); i++)
{
	var slots_dx = fur_x + slot_from_top + (i * (slot_size + slot_spacing))
	var slots_dy = fur_y + slot_from_top + ((array_height(inv) - 1) * (slot_size + slot_spacing))
	
	var slot = inv[i, array_height(inv) - 1]
	
	if(slot != 0)
	{
		if(global.items_list[slot.item].item_data.burn_time > 0)
		{
			burn_timer++
		
			image_index = 1
		
			if(burn_timer > burn_time)
			{
				burn_timer = 0

				//item is found in bottom 5 slots
				remove_item_slot(inv, 1, i, array_height(inv) - 1)
			}

			//smelt items
			for(var i = 0; i < array_length(smelted); i++)
			{
				for(var j = 0; j < array_height(smelted); j++)
				{
					if(inv[i,j] != 0)
					{
						if(global.items_list[inv[i,j].item].item_data.smelt != 0)
						{
							smelted[i,j]++
							
							if(smelted[i,j] > 1200)
							{
								smelted[i,j] = 0
								
								add_item(inv, global.items_list[inv[i,j].item].item_data.smelt, 1)
								remove_item_slot(inv, 1, i, j)
							}
						}
						
					}
					else
					{
						smelted[i,j] = 0	
					}
				}
			}
			
			exit;
		}
	}
	else
	{
		//no fuel
		image_index = 0	
		
		for(var i = 0; i < array_length(smelted); i++)
		{
			for(var j = 0; j < array_height(smelted); j++)
			{
				if(smelted[i,j] > 0) smelted[i,j] -= 1
			}
		}
	}
}