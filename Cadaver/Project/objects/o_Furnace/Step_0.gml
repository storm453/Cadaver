z = -bbox_bottom

if(fuel_slot != furn[0,0])
{
	//new item in fuel slot
	burned = 0	
}
if(ore_slot != furn[1,0])
{
	//new ore placed
	burn_time = 0	
}

fuel_slot = furn[0,0]
ore_slot  = furn[1,0]

//item in both fuel & ore
if(ore_slot != 0)
{
	if(fuel_slot != 0)
	{
		var recipe_result = global.items_list[ore_slot.item].item_data.smelt
		
		if(recipe_result != items.air)
		{
			var check = false
			
			if(furn[2,0] != 0)
			{
				if(furn[2,0].item == recipe_result)
				{
					check = true
				}
			}
			else
			{
				check = true	
			}
			
			if(check)
			{
				//smelt items
				burn_time++
		
				if(round(burn_time) > 120)
				{
					burn_time = 0
					burned++
			
					show_debug_message(global.items_list[fuel_slot.item].item_data.burn_time)
			
					if(burned >= global.items_list[fuel_slot.item].item_data.burn_time)
					{
						burned = 0
				
						remove_item_slot(furn, furn_data, 1, 0, 0)
					}
			
					remove_item_slot(furn, furn_data, 1, 1, 0)
			
					set_item_slot(furn, 2, 0, recipe_result, 1)
				}
			}
			else
			{
				burn_time = 0	
			}
		}
	}
	else
	{
		burn_time = 0
	}
}
else
{
	burn_time = 0	
}