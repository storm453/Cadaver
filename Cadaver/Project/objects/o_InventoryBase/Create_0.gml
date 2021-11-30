event_user(0);

inv = 0;
//in_hand = 0;

for(var i = 0; i < slots_x; i++)
{
	for(var j = 0; j < slots_y; j++)
	{
		inv[i, j] = 0;		
	}
}

function add_item(arg_item_id, arg_amount)
{
	var found_item = false
	
	var i = 0;
	var j = 0;
	
	for (var k = 0; k < slots_x * slots_y; k++) 
	{
		var index = inv[i, j]
			
		//check if the slot is empty
		if(index != 0)
		{
			//found an item with the id given as an arg
			if(index.item == arg_item_id)
			{
				found_item = true
				inv[i,j].amt += arg_amount
				
				//@HACK
				o_PlayerUI.add_item_notif(items_list[arg_item_id].name + " x" + string(arg_amount), 0, 2)
					
				break;
			}
		}
			
		i++;
		
		if (i >= slots_x) 
		{
		    j++;
		    i = 0;
		}	 
	}	
	
	i = 0;
	j = 0;
	
	for (var k = 0; k < slots_x * slots_y; k++) 
	{
		var index = inv[i, j]

		if(!found_item)
		{
			//find free slot
			if(index == 0)
			{
				inv[i, j] =
				{
					item: arg_item_id,
					amt: arg_amount
				}
				
				o_PlayerUI.add_item_notif(items_list[arg_item_id].name + " x" + string(arg_amount), 0, 2)
				
				found_item = true
				break;
			}
		}
			
		i++;
		
		if (i >= slots_x) 
		{
		    j++;
		    i = 0;
		}	 
	}		
}

function remove_item(arg_item_id, arg_amount)
{
	found_item = false
	removed_amt = 0
	
	for(var j = 0; j < slots_y; j++)
	{
		for(var i = 0; i < slots_x; i++)
		{
			index = inv[i,j]
			
			if(removed_amt < arg_amount)
			{
				if(index != 0)
				{
					if(index.item == arg_item_id)
					{
						removed_amt += inv[i,j].amt
						inv[i,j].amt -= arg_amount
						
						if(inv[i,j].amt <= 0)
						{
							inv[i,j] = 0	
						}
					}
				}
			}
		}
	}
}

function check_item(arg_item_id, arg_amount)
{
	found_item = false
	found_amt = 0
	
	for(var j = 0; j < slots_y; j++)
	{
		for(var i = 0; i < slots_x; i++)
		{
			var index = inv[i,j]
			
			if(index != 0)
			{
				if(index.item == arg_item_id)
				{
					found_amt += index.amt	
				}
			}
			
			if(found_amt >= arg_amount)
			{
				found_item = true
				return found_item
			}
		}
	}
	
	return found_item
}

event_user(1);