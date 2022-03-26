function create_inv_data(arg_slots_x, arg_slots_y, arg_sx, arg_sy, arg_draw_scale)
{
	return { slots_x: arg_slots_x, slots_y: arg_slots_y, ix : arg_sx, iy : arg_sy, slot_size : 16, draw_scale: arg_draw_scale }
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

function add_item(arg_inv_obj, arg_item_id, arg_amount)
{
	var found_item = false
	
	var i = 0;
	var j = 0;
	
	for (var k = 0; k < arg_inv_obj.inv_data.slots_x * arg_inv_obj.inv_data.slots_y; k++) 
	{
		var index = arg_inv_obj.inv[i, j]
			
		//check if the slot is empty
		if(index != 0)
		{
			//found an item with the id given as an arg
			if(index.item == arg_item_id)
			{
				found_item = true
				arg_inv_obj.inv[i,j].amt += arg_amount
				
				//@HACK
				o_PlayerUI.add_item_notif(global.items_list[arg_item_id].name + " x" + string(arg_amount), 0, 2)
					
				break;
			}
		}
			
		i++;
		
		if (i >= arg_inv_obj.inv_data.slots_x) 
		{
		    j++;
		    i = 0;
		}	 
	}	
	
	i = 0;
	j = 0;
	
	for (var k = 0; k < arg_inv_obj.inv_data.slots_x * arg_inv_obj.inv_data.slots_y; k++) 
	{
		var index = arg_inv_obj.inv[i, j]

		if(!found_item)
		{
			//find free slot
			if(index == 0)
			{
				arg_inv_obj.inv[i, j] =
				{
					item: arg_item_id,
					amt: arg_amount
				}
				
				o_PlayerUI.add_item_notif(global.items_list[arg_item_id].name + " x" + string(arg_amount), 0, 2)
				
				found_item = true
				break;
			}
		}
			
		i++;
		
		if (i >= arg_inv_obj.inv_data.slots_x) 
		{
		    j++;
		    i = 0;
		}	 
	}		
}

function remove_item(inv_obj, arg_item_id, arg_amount)
{
	found_item = false
	removed_amt = 0
	
	for(var j = 0; j < inv_obj.inv_data.slots_y; j++)
	{
		for(var i = 0; i < inv_obj.inv_data.slots_x; i++)
		{
			index = inv_obj.inv[i,j]
			
			if(removed_amt < arg_amount)
			{
				if(index != 0)
				{
					if(index.item == arg_item_id)
					{
						removed_amt += inv_obj.inv[i,j].amt
						inv_obj.inv[i,j].amt -= arg_amount
						
						if(inv_obj.inv[i,j].amt <= 0)
						{
							inv_obj.inv[i,j] = 0	
						}
					}
				}
			}
		}
	}
}

function check_item(inv_obj, arg_item_id, arg_amount)
{
	found_item = false
	found_amt = 0
	
	for(var j = 0; j < inv_obj.inv_data.slots_y; j++)
	{
		for(var i = 0; i < inv_obj.inv_data.slots_x; i++)
		{
			var index = inv_obj.inv[i,j]
			
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

function remove_item_slot(inv_obj, arg_amount, arg_slotx, arg_sloty)
{
	var index = inv_obj.inv[arg_slotx, arg_sloty]

	inv_obj.inv[arg_slotx, arg_sloty].amt -= arg_amount
	
	if(index.amt <= 0)
	{
		inv_obj.inv[arg_slotx, arg_sloty] = 0	
	}
}

function set_item_slot(inv_obj, arg_slotx, arg_sloty, arg_item, arg_amount)
{
	if(inv_obj.inv[arg_slotx, arg_sloty] == 0)
	{
		inv_obj.inv[arg_slotx, arg_sloty] = 
		{
			item: arg_item,
			amt: arg_amount
		}
	}
	else
	{
		if(inv_obj.inv[arg_slotx, arg_sloty].item == arg_item)
		{
			inv_obj.inv[arg_slotx, arg_sloty].amt += arg_amount
		}
	}
}

function inv_move(inv_obj)
{
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)
	
	var start_x = inv_obj.inv_data.ix
	var start_y = inv_obj.inv_data.iy

	var slot_scale = inv_obj.inv_data.draw_scale * inv_obj.inv_data.slot_size

	for(var i = 0; i < inv_obj.inv_data.slots_x; i++)
	{
		for(var j = 0; j < inv_obj.inv_data.slots_y; j++)
		{	
	        if(point_in_rectangle(mx, my, start_x + (i * slot_scale), start_y + (j * slot_scale), start_x + (i * slot_scale) + slot_scale, start_y + (j * slot_scale) + slot_scale))
			{
				si = i
	            sj = j
				s_slot = inv_obj.inv[i,j]
			
				if(mouse_check_button_pressed(mb_left))
				{
					if(!keyboard_check(vk_shift))
					{
						if(global.current_gui != 0)
						{
							var old_hand = global.in_hand
			
							global.in_hand = inv_obj.inv[i, j]
					        inv_obj.inv[i, j] = old_hand

							if(global.in_hand != 0)
							{
								if(inv_obj.inv[i,j] != 0)
								{
									if(inv_obj.inv[i,j].item == global.in_hand.item)
									{
										inv_obj.inv[i,j].amt += 	global.in_hand.amt
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
					if(inv_obj.inv[i,j] != 0)
					{
						o_PlayerUI.sel_item = -1
						o_PlayerUI.item_window_name = global.items_list[inv_obj.inv[i, j].item].name
						
						global.info_sel_slot[0] = i
						global.info_sel_slot[1] = j
					}
				}
	        }  
	    }
	}	
}