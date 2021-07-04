randomize()

spawn_chance = irandom_range(0.2, 0.5)

for(var i = 0; i < slots_x; i++)
{
	for(var j = 0; j < slots_y; j++)
	{	
		if(chance(0.9))
		{
			var uid = irandom_range(irandom_range(5,15), (irandom(array_length_1d(o_InventoryBase.items_list) - irandom_range(5, 15))))
			
			inv[i, j] = array
			(
				uid,
				irandom_range(0,o_InventoryBase.items_list[uid].stack)
			)
		}
	}
}