function create_inventory(slots_x, slots_y)
{
	for(var i = 0; i < slots_x; i++)
	{
		for(var j = 0; j < slots_y; j++)
		{
			inv[i, j] = 0
		}
	}
	
	return inv
}

function inv_click_logic(arg_i = i, arg_j = j)
{
	if(mouse_check_button_pressed(mb_left))
	{
		var old_hand = global.in_hand
						
		global.in_hand = inv[arg_i, arg_j]
		array_set(inv[arg_i], arg_j, old_hand)

		if(global.in_hand != 0)
		{
			if(inv[arg_i,arg_j] != 0)
			{
				if(inv[arg_i,arg_j].item == global.in_hand.item)
				{
					inv[arg_i,arg_j].amt += global.in_hand.amt
					global.in_hand = 0 
				}
			}
		}
	}	
	if(mouse_check_button_pressed(mb_right))
	{
		if(inv[arg_i, arg_j] != 0)
		{
			if(inv[arg_i, arg_j].amt > 1)
			{
				var split = floor(inv[arg_i, arg_j].amt / 2)
				var split_leave = inv[arg_i, arg_j].amt - split
		
				global.in_hand = { item: inv[arg_i, arg_j].item, amt: split }
			
				inv[arg_i, arg_j].amt = split_leave
			}
		}
	}
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
						if(arg_inv[inv_i,j].amt > 1)
						{
							//hand is empty
							//var take_amt = floor(arg_inv[inv_i,j].amt / 2)
							//var leave_amt = arg_inv[inv_i,j].amt - take_amt
						
							//global.in_hand = { item: arg_inv[inv_i,j].item, amt: take_amt }
						
							//var temp_slot = { item: arg_inv[inv_i,j].item, amt: leave_amt }
							
							//array_set(arg_inv[inv_i], j, 0)
							////array_set(arg_inv[inv_i], j, temp_slot)
						}
					}
				}
			}
		}
	}
}

function draw_item(arg_inv, i, j, arg_x, arg_y, draw_count = 1)
{
	if(arg_inv[i,j] != 0)
	{
		var item = arg_inv[i,j]
		var item_offset = 16 * inv_scale / 2

		draw_sprite_ext(s_Items, item.item, arg_x + item_offset, arg_y + item_offset, inv_scale, inv_scale, 0, c_white, 1)
		
		if(draw_count)
		{
			if(item.amt > 1)
			{
				draw_set_halign(fa_left)
				draw_set_valign(fa_top)
				draw_set_color(0xc0f3fe)
				draw_set_font(ft_Medium)
			
				draw_text(arg_x + 4, arg_y + 4, item.amt)
			}
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

function add_item(arg_inv, arg_item_id, arg_amount)
{
	var found_item = false
	
	var i = 0;
	var j = 0;

	for (var k = 0; k < array_length(arg_inv) * array_height(arg_inv); k++) 
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
		
		if (i >= array_length(arg_inv)) 
		{
		    j++;
		    i = 0;
		}	 
	}	
	
	i = 0;
	j = 0;
	
	for (var k = 0; k < array_length(arg_inv) * array_height(arg_inv); k++) 
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
		
		if (i >= array_length(arg_inv)) 
		{
		    j++;
		    i = 0;
		}	 
	}		
}

function remove_item(arg_inv, arg_item_id, arg_amount)
{
	found_item = false
	removed_amt = 0
	
	var str = "- " + string(global.items_list[arg_item_id].name) + " x" + string(arg_amount)
					
	add_item_notif(str, 0, 6, 0)
	
	for(var j = 0; j < array_height(arg_inv); j++)
	{
		for(var i = 0; i < array_length(arg_inv); i++)
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

function check_item(arg_inv, arg_item_id, arg_amount)
{
	found_item = false
	found_amt = 0
	
	for(var j = 0; j < array_height(arg_inv); j++)
	{
		for(var i = 0; i < array_length(arg_inv); i++)
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

function remove_item_slot(arg_inv, arg_amount, arg_slotx, arg_sloty)
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
			
				
	        }  
	    }
	}	
}

function get_item_amount(arg_inv, arg_item)
{
	var amount = 0

	for(var j = 0; j < array_height(arg_inv); j++)
	{
		for(var i = 0; i < array_length(arg_inv); i++)
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

function recipe(arg_item, requirements, amount_to_craft, station_req = stations.hands, craft_cat = 0)
{
	return { item: arg_item, req_arr: requirements, craft_amt: amount_to_craft, station_needed: station_req, crafting_category_index: craft_cat }
}