//everything that needs to run when not opne put here

//open furnace
var distance = distance_to_object(o_Player)

if(distance < 10)
{
	if(keyboard_check_pressed(ord("E")))
	{
		open = true	
		global.current_gui = gui.LOOT
	}
}

if(distance > 10) open = false

//sprites
if(on)
{
	sprite_index = s_furnace_on	
}
else
{
	sprite_index = s_furnace_off	
}

//check if fuel
for(var i = 0; i < 3; i++)
{
	if(inv[i, 0] == 0)
	{
		fuel_timer[i] = 0
	}
	else
	{
		if(variable_struct_exists(o_InventoryBase.items_list[inv[i, 0].item], "item_data"))
		{
			var struct = variable_struct_get(o_InventoryBase.items_list[inv[i, 0].item], "item_data")

			if(struct.burn_time  != 0)
			{
				fuel_timer[i]++
			
				if(fuel_timer[i] > struct.burn_time)
				{
					fuel_timer[i] = 0
					
					remove_item_slot(1, i, 0)
					
					fuel += 5
				}
			}
		}
	}
}