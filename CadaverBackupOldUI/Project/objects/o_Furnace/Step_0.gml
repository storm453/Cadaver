z = -bbox_bottom

//if there is an item in fuel slot
if(fuel_inv[0, 0] != 0)
{
	burn_timer++

	if(burn_timer >= global.items_list[fuel_inv[0, 0].item].item_data.burn_time)
	{	
		burn_timer = 0

		if(fuel_inv[0, 0].amt == 1) on = false

		remove_item_slot(fuel_inv, fuel_inv_data, 1, 0, 0)
	}
}
else
{
	on = false
}

//smelting
if(on)
{
	for(var i = 0; i < smelt_inv_data.slots_x; i++)
	{
		if(smelt_inv[i, 0] != 0)
		{
			if(global.items_list[smelt_inv[i, 0].item].item_data.smelt != 0)
			{
				smelted[i]++
			}
		}
	}
	for(var j = 0; j < array_length_1d(smelted); j++)
	{
		if(smelted[j] > 300)
		{
			smelted[j] = 0
		
			add_item(stored_inv, stored_inv_data, global.items_list[smelt_inv[j, 0].item].item_data.smelt, 1)
			remove_item_slot(smelt_inv, smelt_inv_data, 1, j, 0)	
		}
	}
}

queue_count(queue_list, crafted_inv, crafted_inv_data)