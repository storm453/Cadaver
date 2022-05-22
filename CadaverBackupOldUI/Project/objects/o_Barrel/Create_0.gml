z = 0

open = false
inv_data = create_inv_data(10, 5, 3)
inv = create_inventory(inv_data.slots_x, inv_data.slots_y)

loot_array = array_create()

loot_array[0] = { item: items.plastic, amt: array(1, 3), chnc: 0.06 } 
loot_array[1] = { item: items.fuel, amt: array(1, 13), chnc: 0.05 } 
loot_array[2] = { item: items.mechanicalparts, amt: array(2, 4), chnc: 0.02 } 
	
//add loot
for(var i = 0; i < inv_data.slots_x; i++)
{
	for(var j = 0; j < inv_data.slots_y; j++)
	{
		for(var k = 0; k < array_length_1d(loot_array); k++)
		{
			if(chance(loot_array[k].chnc))
			{
				randomize()
				
				var random_amt = irandom_range(loot_array[k].amt[0], loot_array[k].amt[1])
				
				array_set(inv[i], j, { item: loot_array[k].item, amt : random_amt } )
			}
		}
	}
}

block_data = create_multiblock(gui.LOOT, inv, inv_data, inv, inv_data)

loot_width = inv_data.slots_x * global.slot_size * inv_data.draw_scale
loot_height = inv_data.slots_y * global.slot_size * inv_data.draw_scale
var inv_title_height = string_height_font("Title", ft_Title) + pad * 2

inv_x = display_get_gui_width() / 2 - loot_width / 2
inv_y = display_get_gui_height() - inv_height - loot_height - inv_title_height  - pad

function render()
{
	draw_self();
}

function render_shadow()
{
	draw_sprite_ext(sprite_index, 0, x, y, 0.5, 0.8, 270, c_blue, 0.2 * (- o_GUI.day_factor / 2 + 0.5));	
}

ds_list_add(o_RenderManager.entities, self)