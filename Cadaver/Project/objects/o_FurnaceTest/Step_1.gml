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

//smelt
var smelt = 3

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
				if(fuel + 5 <= fuel_max)
				{
					fuel_timer[i]++
			
					if(fuel_timer[i] > struct.burn_time)
					{
						fuel_timer[i] = 0
					
						remove_item_slot(1, i, 0)
					
						fuel += 5
					}
				}
				else
				{
					fuel_timer[i] = 0	
				}
			}
		}
	}
}

//item in smelt slot
if(inv[3, 0] != 0)
{
	if(fuel >= 5)
	{
		fuel -= 0.05
	
		for(var j = 0; j < array_length(smelt_recipes); j++)
		{
			if(inv[3, 0].item == smelt_recipes[j].cost)
			{
				smelt_timer++
			
				if(smelt_timer > 100)
				{
					smelt_timer = 0
				
					remove_item_slot(1, 3, 0)
				
					set_item_slot(smelt_recipes[j].ret, 1, 4, 0)				
				}
			
				break
			}
		}
	}
}
else
{
	smelt_timer = 0	
}