function create_inv_data(arg_slots_x, arg_slots_y, arg_draw_scale)
{
	return { slots_x: arg_slots_x, slots_y: arg_slots_y, slot_space: arg_draw_scale * slot_size, draw_scale: arg_draw_scale }
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

function inv_move_new(arg_x, arg_y, arg_inv, arg_inv_data, arg_gap_size, shift = 0)
{
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)
	
	for(var i = 0; i < arg_inv_data.slots_x; i++)
	{
		var inv_i = i + shift
		
		for(var j = 0; j < arg_inv_data.slots_y; j++)
		{
			var rec_x = arg_x + (i * (slot_size * inv_scale + slot_gap))
			var rec_y = arg_y + (j * (slot_size * inv_scale + slot_gap))

			if(point_in_rectangle(mx, my, rec_x, rec_y, rec_x + slot_size * inv_scale, rec_y + slot_size * inv_scale))
			{
				//picking up, adding to a stack
				if(mouse_check_button_pressed(mb_left))
				{
					var old_hand = global.in_hand
			
					global.in_hand = arg_inv[inv_i, j]
					array_set(arg_inv[inv_i], j, old_hand)

					if(global.in_hand != 0)
					{
						if(arg_inv[inv_i,j] != 0)
						{
							if(arg_inv[inv_i,j].item == global.in_hand.item)
							{
								arg_inv[inv_i,j].amt += global.in_hand.amt
								global.in_hand = 0 
							}
						}
					}
				}
				
				//splitting
				if(mouse_check_button_pressed(mb_right))
				{
					if(global.in_hand == 0)
					{
						//hand is empty
						var take_amt = round(arg_inv[inv_i,j].amt / 2)
						var leave_amt = arg_inv[inv_i,j].amt - take_amt
						
						global.in_hand = { item: arg_inv[inv_i,j].item, amt: take_amt }
						
						arg_inv[inv_i,j].amt = leave_amt
					}
				}
			}
		}
	}
}

function draw_item(arg_inv, i, j, arg_x, arg_y, alpha, inv_i = i)
{
	if(arg_inv[inv_i,j] != 0)
	{
		var item = arg_inv[inv_i,j]
		var item_offset = ((slot_size * inv_scale) - (16 * inv_scale)) / 2

		var item_half = (sprite_get_width(s_Items) / 2) * inv_scale

		draw_sprite_ext(s_Items, item.item, arg_x + (i * (slot_size * inv_scale + slot_gap)) + item_offset + item_half, arg_y + (j * (slot_size * inv_scale + slot_gap)) + item_offset + item_half, inv_scale, inv_scale, 0, c_white, alpha)
				
		if(item.amt > 1)
		{
			var amt_width = string_width(string(item.amt))
			draw_set_alpha(alpha)
			draw_set_color(c_black)
			ui_draw_string(arg_x + (i * (slot_size * inv_scale + slot_gap)) + amt_width / 4, arg_y + (j * (slot_size * inv_scale + slot_gap)), string(item.amt), ft_Default)
			draw_set_color(c_white)
			ui_draw_string(arg_x + (i * (slot_size * inv_scale + slot_gap)) + amt_width / 4, arg_y + (j * (slot_size * inv_scale + slot_gap)), string(item.amt), ft_Default)
		}
	}	
}

function draw_inventory(arg_inv, arg_inv_data, arg_x, arg_y, c, slot_a, item_a, inv_check = true, draw_check = true)
{
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)

	for(var i = 0; i < arg_inv_data.slots_x; i++)
	{
		for(var j = 0; j < arg_inv_data.slots_y; j++)
		{
			if(draw_check)
			{
				var color = c

				var rec_x = arg_x + (i * (slot_size * inv_scale + slot_gap))
				var rec_y = arg_y + (j * (slot_size * inv_scale + slot_gap))

				if(point_in_rectangle(mx, my, rec_x, rec_y, rec_x + slot_size * inv_scale, rec_y + slot_size * inv_scale))
				{
					color = c_ltgray
				}
				
				ui_draw_rectangle(arg_x + (i * (slot_size * inv_scale + slot_gap)), arg_y + (j * (slot_size * inv_scale + slot_gap)), slot_size * inv_scale, slot_size * inv_scale, color, slot_a, false)
			
				draw_item(arg_inv, i, j, arg_x, arg_y, item_a)
			}

			if(inv_check) 
			{
				inv_move_new(arg_x, arg_y, arg_inv, arg_inv_data, slot_gap)
			}
		}
	}
}

function draw_inventory_custom(arg_inv, arg_slots_x, arg_slots_y, arg_x, arg_y, c, slot_a, item_a, check)
{
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)

	for(var i = 0; i < arg_slots_x; i++)
	{
		for(var j = 0; j < arg_slots_y; j++)
		{
			if(check)
			{
				var color = c

				var rec_x = arg_x + (i * (slot_size * inv_scale + slot_gap))
				var rec_y = arg_y + (j * (slot_size * inv_scale + slot_gap))

				if(point_in_rectangle(mx, my, rec_x, rec_y, rec_x + slot_size * inv_scale, rec_y + slot_size * inv_scale))
				{
					color = c_ltgray
				}

				ui_draw_rectangle(arg_x + (i * (slot_size * inv_scale + slot_gap)), arg_y + (j * (slot_size * inv_scale + slot_gap)), slot_size * inv_scale, slot_size * inv_scale, color, slot_a, false)
			
				draw_item(arg_inv, i, j, arg_x, arg_y, 1)
			}
		}
	}	
	
	if(check) 
	{
		var _data = create_inv_data(2, 1, 1)
			
		inv_move_new(arg_x, arg_y, arg_inv, _data, slot_gap)
	}
}

function add_item_notif(message, spriteindex, timer, arg_type)
{
	ds_list_add(o_PlayerUI.item_log, { msg : message, spr_index : spriteindex , time : timer , type : arg_type, cur_y: 0 } )		
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
					var str = "+ " + string(global.items_list[arg_item_id].name) + " x" + string(arg_amount)
					
					add_item_notif(str, 0, 3, 1)
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
					var str = "+ " + string(global.items_list[arg_item_id].name) + " x" + string(arg_amount)
					
					add_item_notif(str, 0, 3, 1)
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
	
	var str = "- " + string(global.items_list[arg_item_id].name) + " x" + string(arg_amount)
					
	add_item_notif(str, 0, 6, 0)
	
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
							
							if(arg_inv == o_PlayerInventory.inv)
							{
								
							}
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
					else
					{
						//shift click! move item to player inv
						for(var p = 0; p < o_PlayerInventory.inv_data.slots_y; p++)
						{
							for(var l = 0; l < o_PlayerInventory.inv_data.slots_x; l++)
							{
								if(o_PlayerInventory.inv[l,p] == 0)
								{
									//free slot!!!
									array_set(o_PlayerInventory.inv[l], p, arg_inv[i,j])
									array_set(arg_inv[i], j, 0)
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

function recipe_req(item_id, item_mat)
{
	return { item: item_id, amt: item_mat }	
}

function recipe(arg_item, requirements, amount_to_craft)
{
	return { item: arg_item, req_arr: requirements, craft_amt: amount_to_craft }
}