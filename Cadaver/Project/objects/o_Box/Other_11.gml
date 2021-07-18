open = false

randomize()

spawn_chance = irandom_range(0.2, 0.5)

loot_table = array
(
	{ uid : 32, amt_min : 1, amt_max : 3, chnce: 1 },
	{ uid : 4, amt_min : 1, amt_max : 5, chnce: 3 },
	{ uid : 20, amt_min : 1, amt_max : 8, chnce: 3 },
	{ uid : 24, amt_min : 1, amt_max : 3, chnce: 5 },
	{ uid : 16, amt_min : 1, amt_max : 2, chnce: 5 }
)

for(var i = 0; i < slots_x; i++)
{
	for(var j = 0; j < slots_y; j++)
	{	
		for(var e = 0; e < array_length_1d(loot_table); e++)
		{
			var index = loot_table[e]
			var slot_chance = index.chnce / 100

			if(chance(slot_chance))
			{
				randomize()
				
				inv[i, j] = array
				(
					index.uid,
					irandom_range(index.amt_min, index.amt_max)
				)
			}
		}
	}
}