z = -bbox_bottom

//milling
if(to_saw != saw[0,0])
{
	cut = 0	
}

to_saw = saw[0,0]

if(to_saw != 0)
{
	if(global.items_list[to_saw.item].item_data.mill != 0)
	{
		var free = 0
		
		if(saw[1,0] == 0) 
		{
			free = true
		}
		if(saw[1,0] != 0) 
		{
			if(saw[1,0].item == items.wood) free = true
		}
		
		if(free)
		{
			cut++
		
			if(cut >= 180)
			{
				cut = 0
			
				set_item_slot(saw, 1, 0, items.wood, global.items_list[to_saw.item].item_data.mill)
				remove_item_slot(saw, saw_data, 1, 0, 0)
			}
		}
	}
}
else
{
	cut = 0
}