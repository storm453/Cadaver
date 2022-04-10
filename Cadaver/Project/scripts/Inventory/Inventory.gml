function create_inv_data(arg_slots_x, arg_slots_y, arg_draw_scale)
{
	return { slots_x: arg_slots_x, slots_y: arg_slots_y, slot_space: arg_draw_scale * global.slot_size, draw_scale: arg_draw_scale }
}

function create_inventory(slots_x, slots_y)
{
	var inv = 0;
	
	for(var i = 0; i < slots_x; i++)
	{
		for(var j = 0; j < slots_y; j++)
		{
			inv[i, j] = 0
		}
	}
	
	return inv;
}

function add_item(arg_inv, arg_inv_data, arg_item_id, arg_amount)
{
	var found_item = false
	
	var i = 0;
	var j = 0;

	for (var k = 0; k < arg_inv_data.slots_x * arg_inv_data.slots_y; k++) 
	{
		var index = arg_inv[i, j]
			
		//check if the slot is empty
		if(index != 0)
		{
			//found an item with the id given as an arg
			if(index.item == arg_item_id)
			{
				found_item = true
				arg_inv[i,j].amt += arg_amount
				
				//@HACK
				if(arg_inv == o_PlayerInventory.inv)
				{
					o_PlayerUI.add_item_notif(global.items_list[arg_item_id].name + " x" + string(arg_amount), 0, 2)
				}	

				break;
			}
		}
			
		i++;
		
		if (i >= arg_inv_data.slots_x) 
		{
		    j++;
		    i = 0;
		}	 
	}	
	
	i = 0;
	j = 0;
	
	for (var k = 0; k < arg_inv_data.slots_x * arg_inv_data.slots_y; k++) 
	{
		var index = arg_inv[i, j]

		if(!found_item)
		{
			//find free slot
			if(index == 0)
			{
				array_set(arg_inv[i], j, { item: arg_item_id, amt: arg_amount } )

				if(arg_inv == o_PlayerInventory.inv)
				{
					o_PlayerUI.add_item_notif(global.items_list[arg_item_id].name + " x" + string(arg_amount), 0, 2)
				}

				found_item = true
				break;
			}
		}
			
		i++;
		
		if (i >= arg_inv_data.slots_x) 
		{
		    j++;
		    i = 0;
		}	 
	}		
}

function remove_item(arg_inv, arg_inv_data, arg_item_id, arg_amount)
{
	found_item = false
	removed_amt = 0
	
	for(var j = 0; j < arg_inv_data.slots_y; j++)
	{
		for(var i = 0; i < arg_inv_data.slots_x; i++)
		{
			index = arg_inv[i,j]
			
			if(removed_amt < arg_amount)
			{
				if(index != 0)
				{
					if(index.item == arg_item_id)
					{
						removed_amt += arg_inv[i,j].amt
						arg_inv[i,j].amt -= arg_amount
						
						if(arg_inv[i,j].amt <= 0)
						{
							array_set(arg_inv[i], j, 0)
						}
					}
				}
			}
		}
	}
}

function check_item(arg_inv, arg_inv_data, arg_item_id, arg_amount)
{
	found_item = false
	found_amt = 0
	
	for(var j = 0; j < arg_inv_data.slots_y; j++)
	{
		for(var i = 0; i < arg_inv_data.slots_x; i++)
		{
			var index = arg_inv[i,j]
			
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

function remove_item_slot(arg_inv, arg_inv_data, arg_amount, arg_slotx, arg_sloty)
{
	var index = arg_inv[arg_slotx, arg_sloty]

	arg_inv[arg_slotx, arg_sloty].amt -= arg_amount
	
	if(index.amt <= 0)
	{
		array_set(arg_inv[arg_slotx], arg_sloty, 0)	
	}
}

function set_item_slot(arg_inv, arg_slotx, arg_sloty, arg_item, arg_amount)
{
	if(arg_inv[arg_slotx, arg_sloty] == 0)
	{
		array_set(arg_inv[arg_slotx], arg_sloty, { item: arg_item, amt: arg_amount } )
	}
	else
	{
		if(arg_inv[arg_slotx, arg_sloty].item == arg_item)
		{
			arg_inv[arg_slotx, arg_sloty].amt += arg_amount
		}
	}
}

function inv_move(arg_inv, arg_inv_data, arg_x, arg_y, arg_scale = 1)
{
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)

	var slot_scale = arg_inv_data.slot_space
	
	if(arg_scale != 1) slot_scale = arg_scale

	for(var i = 0; i < arg_inv_data.slots_x; i++)
	{
		for(var j = 0; j < arg_inv_data.slots_y; j++)
		{	
	        if(point_in_rectangle(mx, my, arg_x + (i * slot_scale), arg_y + (j * slot_scale), arg_x + (i * slot_scale) + slot_scale, arg_y + (j * slot_scale) + slot_scale))
			{
				si = i
	            sj = j
				s_slot = arg_inv[i,j]
			
				if(mouse_check_button_pressed(mb_left))
				{
					if(!keyboard_check(vk_shift))
					{
						if(global.current_gui != 0)
						{
							var old_hand = global.in_hand
			
							global.in_hand = arg_inv[i, j]
							array_set(arg_inv[i], j, old_hand)

							if(global.in_hand != 0)
							{
								if(arg_inv[i,j] != 0)
								{
									if(arg_inv[i,j].item == global.in_hand.item)
									{
										arg_inv[i,j].amt += global.in_hand.amt
										global.in_hand = 0 
									}
								}
							}
						}
					}
				}

				//Right clicking to select an item for info
				if(mouse_check_button_pressed(mb_right))
				{
					if(arg_inv[i,j] != 0)
					{
						o_PlayerUI.sel_item = -1
						o_PlayerUI.item_window_name = global.items_list[arg_inv[i, j].item].name
						
						global.info_sel_slot[0] = i
						global.info_sel_slot[1] = j
					}
				}
	        }  
	    }
	}	
}

function get_item_amount(arg_inv, arg_inv_data, arg_item)
{
	var amount = 0

	for(var j = 0; j < arg_inv_data.slots_y; j++)
	{
		for(var i = 0; i < arg_inv_data.slots_x; i++)
		{
			if(arg_inv[i,j] != 0)
			{
				if(arg_inv[i,j].item == arg_item)
				{
					amount += arg_inv[i,j].amt
				}
			}
		}
	}

	return amount

}