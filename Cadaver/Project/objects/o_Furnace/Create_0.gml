z = 0

inv = create_inventory(5, 3)

#macro furn_height sprite_get_height(s_FurnaceInventory) * inv_scale

depth = -1

block_data = create_multiblock(gui.CONTAINER)

burn_timer = 0
burn_time = 120

fur_x = display_get_gui_width() / 2 - player_inv_width / 2
fur_y = display_get_gui_height() / 2 - player_inv_height / 2 + inv_offset - pad - furn_height

function render()
{
	draw_self();
}

smelted = 0

for(var i = 0; i < array_length(inv); i++)
{
	for(var j = 0; j < array_height(inv) - 1; j++)
	{
		smelted[i,j] = 0
	}
}

ds_list_add(o_RenderManager.entities, self)