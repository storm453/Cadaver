open = false

//position ui
var slots_width = slots_x * draw_scale * slot_size
var slots_height = slots_y * draw_scale * slot_size

start_x = display_get_gui_width() / 2 - slots_width / 2
start_y = display_get_gui_height() - o_PlayerInventory.player_inventory_height - o_PlayerInventory.shift - pad - slots_height - o_PlayerInventory.title_height
show_debug_message(start_y)

randomize()

spawn_chance = irandom_range(0.2, 0.5)

loot_table = array
(
	{ uid : 32, amt_min : 1, amt_max : 3, chnce: 11 },
	{ uid : 4, amt_min : 1, amt_max : 5, chnce: 13 },
	{ uid : 20, amt_min : 1, amt_max : 8, chnce: 13 },
	{ uid : 24, amt_min : 1, amt_max : 3, chnce: 15 },
	{ uid : 16, amt_min : 1, amt_max : 2, chnce: 15 },
	{ uid : 19, amt_min : 1, amt_max : 1, chnce: 4 }
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
				
				inv[i, j] =
				{
					item : index.uid,
					amt : irandom_range(index.amt_min, index.amt_max)
				}
			}
		}
	}
}