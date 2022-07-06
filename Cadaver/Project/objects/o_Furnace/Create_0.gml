z = 0

block_data = create_multiblock(gui.LOOT)

depth = -1

furn_data = create_inv_data(3, 1, 1)
furn = create_inventory(furn_data.slots_x, furn_data.slots_y)

fuel_slot = 0
ore_slot = 0

burned = 0

burn_time = 0

dw = player_inv_width
dh = 175

compl_w = 50

dx = display_get_gui_width() / 2 - dw / 2
dy = display_get_gui_height() - player_inv_height - dh

function render()
{
	draw_self();
}

ds_list_add(o_RenderManager.entities, self)